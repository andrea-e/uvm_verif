`ifndef DUT_SV
 `define DUT_SV

module dut#(
            parameter ADDR_WIDTH  = 32,
            parameter RDATA_WIDTH = 32,
            parameter WDATA_WIDTH = 32,
            parameter SLV_NUM = 15
            )
   (
    ref logic [ADDR_WIDTH - 1 : 0]  paddr,
    ref logic [SLV_NUM - 1 : 0]     psel,
    ref logic                       penable,
    ref logic                       pwrite,
    ref logic [WDATA_WIDTH - 1 : 0] pwdata,
    ref logic                       pready,
    ref logic [RDATA_WIDTH - 1 : 0] prdata,
    ref logic                       pslverr
    );
endmodule : dut

`endif
