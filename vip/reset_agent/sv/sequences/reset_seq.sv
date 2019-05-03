`ifndef RESET_SEQ_SV
 `define RESET_SEQ_SV

class reset_seq extends reset_base_seq;

   // delay before asserting reset (#clk cycles)
   rand int unsigned transmit_del;
   // duration of reset (#clk cycles)
   rand int unsigned duration_time;

   `uvm_object_utils(reset_seq)

   constraint c_transmit_delay { transmit_del <= 10; }
   constraint c_duration_time { duration_time inside {[1:5]}; }

   function new(string name = "reset_seq");
      super.new(name);
   endfunction : new

   virtual task body();
      `uvm_do_with(req, { req.duration == duration_time;
                          req.transmit_delay == transmit_del; } )
   endtask : body

endclass : reset_seq

`endif
