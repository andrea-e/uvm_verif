`ifndef I2C_MASTER_AGENT_SV
 `define I2C_MASTER_AGENT_SV

typedef uvm_sequencer #(i2c_transaction) i2c_master_sequencer;

class i2c_master_agent extends uvm_agent;

   i2c_master_config cfg;

   i2c_monitor          mon;
   i2c_master_driver    drv;
   i2c_master_sequencer seqr;

   `uvm_component_utils_begin(i2c_master_agent)
      `uvm_field_object(cfg, UVM_DEFAULT)
   `uvm_component_utils_end

   function new(string name = "i2c_master_agent", uvm_component parent);
      super.new(name, parent);
   endfunction : new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);

      if(!uvm_config_db#(i2c_master_config)::get(this, "", "i2c_master_config", cfg))
        `uvm_fatal("NO_CFG",{"Config object must be set for: ",get_full_name(),".cfg"})

      if(cfg.is_active == UVM_ACTIVE) begin
         seqr = i2c_master_sequencer::type_id::create("seqr", this);
         drv = i2c_master_driver::type_id::create("drv", this);
      end
      mon = i2c_monitor::type_id::create("mon", this);
   endfunction : build_phase

   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      if(cfg.is_active == UVM_ACTIVE) begin
         drv.seq_item_port.connect(seqr.seq_item_export);
      end
   endfunction : connect_phase

endclass : i2c_master_agent

`endif
