`ifndef MEMORY_IF_SV
 `define MEMORY_IF_SV

interface memory_if(input clk, input rst);

   logic [1 : 0]   addr;
   logic           rw;
   logic           en;
   logic [7 : 0]   data_i;
   logic [7 : 0]   data_o;

endinterface : memory_if

`endif
