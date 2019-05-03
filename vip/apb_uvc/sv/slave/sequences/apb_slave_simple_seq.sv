`ifndef APB_SLAVE_SIMPLE_SEQ_SV
 `define APB_SLAVE_SIMPLE_SEQ_SV

class apb_slave_simple_seq extends apb_slave_base_seq;

   `uvm_object_utils(apb_slave_simple_seq)

	 function new(string name = "apb_slave_simple_seq");
		  super.new(name);
	 endfunction : new

   virtual task body();
      forever begin
         `uvm_do(req)
      end
   endtask : body

endclass : apb_slave_simple_seq

`endif
