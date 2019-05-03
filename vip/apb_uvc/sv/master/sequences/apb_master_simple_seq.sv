`ifndef APB_MASTER_SIMPLE_SEQ_SV
 `define APB_MASTER_SIMPLE_SEQ_SV

// simple sequence; random transactions
class apb_master_simple_seq extends apb_master_base_seq;

   rand int unsigned num_of_tr;

   constraint num_of_tr_cst { num_of_tr inside {[1 : 10]};}

   `uvm_object_utils(apb_master_simple_seq)

	 function new(string name = "apb_master_simple_seq");
		  super.new(name);
	 endfunction : new

   virtual task body();
      repeat(num_of_tr) begin
         `uvm_do(req)
      end
   endtask : body

endclass : apb_master_simple_seq

`endif
