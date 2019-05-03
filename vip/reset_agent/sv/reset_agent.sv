`ifndef RESET_SEQ_ITEM_SV
 `define RESET_SEQ_ITEM_SV

typedef uvm_sequencer#(reset_seq_item) reset_sequencer;

class reset_agent extends uvm_agent;

   reset_config cfg;

   reset_sequencer seqr;
   reset_driver    drv;
   reset_monitor   mon;

   `uvm_component_utils_begin(reset_agent)
      `uvm_field_enum(uvm_active_passive_enum, is_active, UVM_DEFAULT)
   `uvm_component_utils_end

   function new (string name = "reset_agent", uvm_component parent = null);
      super.new(name, parent);
   endfunction : new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);

      if(!uvm_config_db#(reset_config)::get(this, "", "reset_config", cfg)) begin
         `uvm_info("NO_CFG", "Using default reset_config", UVM_LOW)
         cfg = reset_config::type_id::create("cfg");
         uvm_config_db#(reset_config)::set(this, "*", "reset_config", cfg);
      end

      if(cfg.is_active == UVM_ACTIVE) begin
         seqr = reset_sequencer::type_id::create("seqr", this);
         drv = reset_driver::type_id::create("drv", this);
      end

      mon = reset_monitor::type_id::create("mon", this);
   endfunction : build_phase

   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      if(cfg.is_active == UVM_ACTIVE) begin
         drv.seq_item_port.connect(seqr.seq_item_export);
      end
   endfunction : connect_phase

endclass : reset_agent

`endif
