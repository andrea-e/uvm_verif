`ifndef RESET_SEQ_ITEM_SV
 `define RESET_SEQ_ITEM_SV

class reset_seq_item extends uvm_sequence_item;

   // delay before asserting reset (#clk cycles)
   rand int unsigned transmit_delay;
   // duration of reset (#clk cycles)
   rand int unsigned duration;

   constraint c_transmit_delay { transmit_delay <= 10; }
   constraint c_duration { duration inside {[0:5]}; }

   `uvm_object_utils_begin(reset_seq_item)
      `uvm_field_int(transmit_delay, UVM_DEFAULT)
      `uvm_field_int(duration, UVM_DEFAULT)
   `uvm_object_utils_end

   function new (string name = "reset_seq_item");
      super.new(name);
   endfunction : new

endclass : reset_seq_item

`endif
