`ifndef APB_MASTER_DRIVER_SV
 `define APB_MASTER_DRIVER_SV

class apb_master_driver extends uvm_driver #(apb_transaction, apb_transaction);

   virtual apb_if vif;

   apb_config cfg;

   `uvm_component_utils_begin(apb_master_driver)
      `uvm_field_object(cfg, UVM_DEFAULT | UVM_REFERENCE)
   `uvm_component_utils_end

	 function new(string name = "apb_master_driver", uvm_component parent = null);
		  super.new(name, parent);
	 endfunction : new

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db#(apb_config)::get(this, "*", "apb_config", cfg))
        `uvm_fatal("NO_CFG",{"Config object must be set for: ",get_full_name(),".cfg"})
   endfunction: build_phase

   virtual function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      if(!uvm_config_db#(virtual apb_if)::get(this, "", "apb_if", vif))
        `uvm_fatal("NO_IF",{"virtual interface must be set for: ",get_full_name(),".vif"})
   endfunction : connect_phase

   extern virtual task main_phase(uvm_phase phase);
   extern virtual task reset();
   extern virtual task drive_tr (apb_transaction tr);

endclass : apb_master_driver

task apb_master_driver::main_phase(uvm_phase phase);
   bit got_item = 0;
   reset(); // init.
   forever begin
      fork
         forever begin
            seq_item_port.get_next_item(req);
            got_item = 1;
            drive_tr(req);
            seq_item_port.item_done();
            got_item = 0;
         end
         @(negedge vif.presetn); // reset is active low
      join_any
      disable fork;
      if(got_item) seq_item_port.item_done();
      reset();
   end
endtask : main_phase

task apb_master_driver::reset();
   `uvm_info(get_type_name(), "Reset observed", UVM_MEDIUM)
   vif.paddr     <= {ADDR_WIDTH {1'b0}};
   vif.pwdata    <= {WDATA_WIDTH {1'b0}};
   vif.pwrite    <= 1'b0;
   vif.psel      <= {SLV_NUM {1'b0}};
   vif.penable   <= 1'b0;
   @(posedge vif.presetn); // reset dropped
endtask : reset

task apb_master_driver::drive_tr (apb_transaction tr);
   int unsigned slave_index;

   // delay
   @(posedge vif.pclk);
   if (tr.delay > 0) begin
      repeat(tr.delay) @(posedge vif.pclk);
   end

   // address phase
   slave_index = cfg.get_slave_psel_by_addr(tr.addr);
   if(slave_index == 0) begin
      `uvm_warning(get_type_name(), "No slave with choosed address")
      return;
   end
   vif.paddr <= tr.addr;
   vif.psel <= (1 << (slave_index - 1));
   vif.penable <= 0;
   vif.pwrite <= apb_direction_enum'(tr.dir);
   if (tr.dir == APB_WRITE) begin
      vif.pwdata <= tr.wdata;
   end

   // data phase
   @(posedge vif.pclk);
   vif.penable <= 1;
   @(posedge vif.pclk iff vif.pready);
   tr.error = vif.pslverr;
   if (tr.dir == APB_READ) begin
      tr.rdata = vif.prdata;
   end
   vif.penable <= 0;
   vif.psel    <= 0;

   `uvm_info(get_type_name(), $sformatf("APB Finished Driving tr \n%s", tr.sprint()), UVM_HIGH)
endtask : drive_tr

`endif
