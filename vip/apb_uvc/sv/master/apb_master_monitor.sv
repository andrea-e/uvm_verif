`ifndef APB_MASTER_MONITOR_SV
 `define APB_MASTER_MONITOR_SV

class apb_master_monitor extends uvm_monitor;

   virtual apb_if vif;

   apb_config cfg;

   uvm_analysis_port #(apb_transaction) item_collected_port;

   int unsigned num_transactions = 0;

   apb_transaction tr_collected;

   `uvm_component_utils_begin(apb_master_monitor)
      `uvm_field_object(cfg, UVM_DEFAULT | UVM_REFERENCE)
   `uvm_component_utils_end

   covergroup cg_apb_master;
      // cover direction - read or write
      cp_direction : coverpoint tr_collected.dir {
         bins write = {APB_WRITE};
         bins read  = {APB_READ};
      }
      // cover delay - zero or more
      cp_delay : coverpoint tr_collected.delay {
         bins zero = {0};
         bins other = default;
      }
      // TODO : add others
   endgroup : cg_apb_master;

	 function new(string name = "apb_master_monitor", uvm_component parent = null);
		  super.new(name, parent);
      item_collected_port = new("item_collected_port", this);
      cg_apb_master = new();
	 endfunction : new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db#(apb_config)::get(this, "", "apb_config", cfg))
        `uvm_fatal("NO_CFG",{"Config object must be set for: ",get_full_name(),".cfg"})
   endfunction: build_phase

   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      if(!uvm_config_db#(virtual apb_if)::get(this, "", "apb_if", vif))
        `uvm_fatal("NO_IF",{"virtual interface must be set for: ",get_full_name(),".vif"})
   endfunction : connect_phase

   extern virtual task main_phase(uvm_phase phase);
   extern virtual task collect_transactions();
   extern virtual function void report_phase(uvm_phase phase);

endclass : apb_master_monitor

task apb_master_monitor::main_phase(uvm_phase phase);
   forever begin
      @(posedge vif.presetn); // reset dropped
      `uvm_info(get_type_name(), "Reset dropped", UVM_MEDIUM)

      fork
         collect_transactions(); // thread killed at reset
         @(negedge vif.presetn); // reset is active low
      join_any
      disable fork;
   end
endtask : main_phase

task apb_master_monitor::collect_transactions();
   forever begin
      tr_collected = apb_transaction::type_id::create("tr_collected");

      // wait for valid transaction
      @(posedge vif.pclk iff (vif.psel != 0));
      tr_collected.addr = vif.paddr;
      tr_collected.dir = apb_direction_enum'(vif.pwrite);
      if(tr_collected.dir == APB_WRITE)
        tr_collected.wdata = vif.pwdata;

      @(posedge vif.pclk); // enable
      @(posedge vif.pclk); // ready
      while (vif.pready !== 1'b1) begin
         @(posedge vif.pclk);
         tr_collected.delay++;
      end
      if(tr_collected.dir == APB_READ) begin
         tr_collected.rdata = vif.prdata;
         tr_collected.error = vif.pslverr;
      end

      item_collected_port.write(tr_collected);
      if(cfg.has_coverage == 1) begin
         cg_apb_master.sample();
      end
      `uvm_info(get_type_name(), $sformatf("Tr collected :\n%s", tr_collected.sprint()), UVM_MEDIUM)
      num_transactions++;
   end // forever
endtask : collect_transactions

function void apb_master_monitor::report_phase(uvm_phase phase);
   `uvm_info(get_type_name(), $sformatf("Report: APB monitor collected %0d transfers", num_transactions), UVM_LOW);
endfunction : report_phase


`endif
