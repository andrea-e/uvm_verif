`ifndef APB_MASTER_SEQUENCER_SV
 `define APB_MASTER_SEQUENCER_SV

class apb_master_sequencer extends uvm_sequencer #(apb_transaction, apb_transaction);

   apb_config cfg;

   `uvm_component_utils_begin(apb_master_sequencer)
      `uvm_field_object(cfg, UVM_DEFAULT | UVM_REFERENCE)
   `uvm_component_utils_end

	 function new(string name = "apb_master_sequencer", uvm_component parent = null);
		  super.new(name, parent);
	 endfunction : new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db#(apb_config)::get(this, "", "apb_config", cfg))
        `uvm_fatal("NO_CFG",{"Config object must be set for: ",get_full_name(),".cfg"})
   endfunction: build_phase

endclass : apb_master_sequencer

`endif
