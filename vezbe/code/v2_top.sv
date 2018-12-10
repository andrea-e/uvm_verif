`ifndef TOP_SV
`define TOP_SV

`include "v2_memory.sv"
`include "v2_memory_if.sv"
`include "v2_memory_pkg.sv"

module top;

   import memory_pkg::*;

   bit clk;
   bit rst;

   memory_if mem_if(clk, rst);

   memory DUT (
               .clk    (clk),
               .rst    (rst),
               .addr_i (mem_if.addr),
               .rw_i   (mem_if.rw),
               .en_i   (mem_if.en),
               .data_i (mem_if.data_i),
               .data_o (mem_if.data_o)
               );

   driver drv = new(mem_if);

   initial begin
      clk = 0;
      rst = 1;
      #5 rst =0;
      #500 $finish();
   end

   always #5 clk = ~clk;

   initial drv.run();

endmodule : top

`endif
