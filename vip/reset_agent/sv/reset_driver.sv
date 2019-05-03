`ifndef RESET_SEQ_ITEM_SV
 `define RESET_SEQ_ITEM_SV

class reset_driver extends uvm_driver #(reset_seq_item);

   virtual reset_if vif;

   reset_config cfg;

   `uvm_component_utils_begin(reset_driver)
      `uvm_field_object(cfg, UVM_DEFAULT | UVM_REFERENCE)
   `uvm_component_utils_end

   function new (string name = "reset_driver", uvm_component parent = null);
      super.new(name, parent);
   endfunction : new

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db#(reset_config)::get(this, "*", "reset_config", cfg))
        `uvm_fatal("NO_CFG",{"Config object must be set for: ",get_full_name(),".cfg"})
   endfunction: build_phase

   virtual function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      if(!uvm_config_db#(virtual reset_if)::get(this, "", "reset_if", vif))
        `uvm_fatal("NO_IF",{"virtual interface must be set for: ",get_full_name(),".vif"})
   endfunction : connect_phase

   extern virtual task main_phase(uvm_phase phase);
   extern virtual function void start_of_simulation_phase(uvm_phase phase);
   extern virtual task drive_tr (reset_seq_item tr);

endclass : reset_driver

function void reset_driver::start_of_simulation_phase(uvm_phase phase);
   super.start_of_simulation_phase(phase);
   vif.reset <= cfg.value_at_0;    // init reset
endfunction

task reset_driver::main_phase(uvm_phase phase);
   forever begin
      seq_item_port.get_next_item(req);
      drive_tr(req);
      seq_item_port.item_done();
   end
endtask : main_phase

task reset_driver::drive_tr (reset_seq_item tr);
   `uvm_info(  get_type_name(),
               $sformatf("Driving reset: delay %0d clocks duration of %0d clocks",
                         tr.transmit_delay, tr.duration),
               UVM_LOW)
   // delay
   if (tr.transmit_delay > 0) begin
      repeat(tr.transmit_delay) @(posedge vif.clk);
   end
   // start reset
   vif.reset <= cfg.active_high;
   // duration
   repeat(tr.duration) @(posedge vif.clk);
   // drop reset
   vif.reset <= ~cfg.active_high;
endtask : drive_tr

`endif
