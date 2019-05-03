`ifndef RESET_BASE_SEQ_SV
 `define RESET_BASE_SEQ_SV

class reset_base_seq extends uvm_sequence #(reset_seq_item, reset_seq_item);

   `uvm_object_utils(reset_base_seq)

   function new(string name = "reset_base_seq");
      super.new(name);
   endfunction : new

endclass : reset_base_seq

`endif

