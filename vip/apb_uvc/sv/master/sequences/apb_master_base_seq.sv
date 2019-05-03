`ifndef APB_MASTER_BASE_SEQ_SV
 `define APB_MASTER_BASE_SEQ_SV

class apb_master_base_seq extends uvm_sequence #(apb_transaction, apb_transaction);

   `uvm_declare_p_sequencer(apb_master_sequencer)
   `uvm_object_utils(apb_master_base_seq)

	 function new(string name = "apb_master_base_seq");
		  super.new(name);
	 endfunction : new

endclass : apb_master_base_seq

`endif
