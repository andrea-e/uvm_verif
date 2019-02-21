`ifndef CALC_SEQ_ITEM_SV
 `define CALC_SEQ_ITEM_SV

class calc_seq_item extends uvm_sequence_item;

	 /* TODO add fields and methods here */

   `uvm_object_utils_begin(calc_seq_item)
   `uvm_object_utils_end

   function new(string name = "calc_seq_item");
      super.new(name);
   endfunction

endclass : calc_seq_item

`endif
