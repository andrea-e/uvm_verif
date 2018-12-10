interface memory_if(input clk, input rst);

   logic [1 : 0]   addr;
   logic           rw;
   logic           en;
   logic [7 : 0]   data_i;
   logic [7 : 0]   data_o;

endinterface : memory_if

// instanciranje u modulu
module top;

   bit clk;
   bit rst;

   memory_if mem_if(clk, rst);

   // ...

endmodule : top
