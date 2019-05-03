`ifndef APB_SLAVE_AGENT_SV
 `define APB_SLAVE_AGENT_SV

class apb_slave_agent extends uvm_agent;

   apb_slave_config       cfg;

   apb_slave_driver       drv;
   apb_slave_sequencer    seqr;
   apb_slave_monitor      mon;

   `uvm_component_utils_begin(apb_slave_agent)
      `uvm_field_object(cfg, UVM_DEFAULT | UVM_REFERENCE)
   `uvm_component_utils_end

	 function new(string name = "apb_slave_agent", uvm_component parent = null);
		  super.new(name, parent);
	 endfunction : new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);

      if(!uvm_config_db#(apb_slave_config)::get(this, "", "apb_slave_config", cfg))
        `uvm_fatal("NO_CFG",{"Config object must be set for: ",get_full_name(),".cfg"})

      if(cfg.is_active == UVM_ACTIVE) begin
         seqr = apb_slave_sequencer::type_id::create("seqr", this);
         drv = apb_slave_driver::type_id::create("drv", this);
      end
      mon = apb_slave_monitor::type_id::create("mon", this);
   endfunction : build_phase

   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      if(cfg.is_active == UVM_ACTIVE) begin
         drv.seq_item_port.connect(seqr.seq_item_export);
      end
   endfunction : connect_phase

endclass : apb_slave_agent

`endif
