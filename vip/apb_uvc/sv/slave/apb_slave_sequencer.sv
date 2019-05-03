`ifndef APB_SLAVE_SEQUENCER_SV
 `define APB_SLAVE_SEQUENCER_SV

class apb_slave_sequencer extends uvm_sequencer #(apb_transaction, apb_transaction);

   `uvm_component_utils (apb_slave_sequencer)

	 function new(string name = "apb_slave_sequencer", uvm_component parent = null);
		  super.new(name, parent);
	 endfunction : new

   // Note: equivalent to
   // typedef uvm_sequencer#(apb_transaction, apb_transaction) apb_slave_sequencer;

endclass : apb_slave_sequencer

`endif
