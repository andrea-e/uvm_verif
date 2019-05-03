`ifndef APB_SLAVE_BASE_SEQ_SV
 `define APB_SLAVE_BASE_SEQ_SV

class apb_slave_base_seq extends uvm_sequence #(apb_transaction, apb_transaction);

   `uvm_object_utils(apb_slave_base_seq)

	 function new(string name = "apb_slave_base_seq");
		  super.new(name);
	 endfunction : new

endclass : apb_slave_base_seq

`endif
