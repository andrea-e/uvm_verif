`ifndef DUT_SV
 `define DUT_SV

module dut#(
            parameter ADDR_WIDTH = 7,
            parameter DATA_WIDTH = 8
            )
   (
    input logic clk,
    input logic rst,
    ref logic   sda,
    ref logic   scl
    );
endmodule : dut

`endif
