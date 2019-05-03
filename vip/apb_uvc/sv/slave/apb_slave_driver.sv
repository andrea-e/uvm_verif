`ifndef APB_SLAVE_DRIVER_SV
 `define APB_SLAVE_DRIVER_SV

class apb_slave_driver extends uvm_driver #(apb_transaction, apb_transaction);

   virtual apb_if vif;

   apb_slave_config cfg;

   `uvm_component_utils_begin(apb_slave_driver)
      `uvm_field_object(cfg, UVM_DEFAULT | UVM_REFERENCE)
   `uvm_component_utils_end

	 function new(string name = "apb_slave_driver", uvm_component parent = null);
		  super.new(name, parent);
	 endfunction : new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db#(apb_slave_config)::get(this, "", "apb_slave_config", cfg))
        `uvm_fatal("NO_CFG",{"Config object must be set for: ",get_full_name(),".cfg"})
   endfunction: build_phase

   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      if(!uvm_config_db#(virtual apb_if)::get(this, "", "apb_if", vif))
        `uvm_fatal("NO_IF",{"virtual interface must be set for: ",get_full_name(),".vif"})
   endfunction : connect_phase

   extern virtual task main_phase(uvm_phase phase);
   extern virtual task reset();
   extern virtual task drive_tr (apb_transaction tr);

endclass : apb_slave_driver

task apb_slave_driver::main_phase(uvm_phase phase);
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

task apb_slave_driver::reset();
   `uvm_info(get_type_name(), "Reset observed", UVM_MEDIUM)
   vif.prdata  <= {WDATA_WIDTH {1'bZ}};
   vif.pready  <= 1'b0;
   vif.pslverr <= 1'b0;
   @(posedge vif.presetn); // reset dropped
endtask : reset

task apb_slave_driver::drive_tr (apb_transaction tr);

   // wait for the master to initiate the transaction
   @(posedge vif.pclk iff (vif.penable && cfg.check_psel_index(vif.psel)));

   tr.dir = apb_direction_enum'(vif.pwrite);

   // delay
   if (tr.delay > 0) begin
      repeat(tr.delay) @(posedge vif.pclk);
   end
   // respond
   vif.pslverr <= tr.error;
   vif.pready <= 1'b1;
   if (tr.dir == APB_READ)
     vif.prdata <= tr.rdata;
   @(posedge vif.pclk);
   vif.prdata <= {WDATA_WIDTH {1'bZ}};
   vif.pready <= 1'b0;

   `uvm_info(get_type_name(), $sformatf("APB Finished Driving tr \n%s", tr.sprint()), UVM_HIGH)
endtask : drive_tr

`endif
