`ifndef APB_IF_SV
 `define APB_IF_SV

interface apb_if (input logic pclk, input logic presetn);

   parameter ADDR_WIDTH  = 32;
   parameter RDATA_WIDTH = 32;
   parameter WDATA_WIDTH = 32;
   parameter SLV_NUM = 15;

   // master
   logic [ADDR_WIDTH - 1 : 0]  paddr;
   logic [SLV_NUM - 1 : 0]     psel;
   logic                       penable;
   logic                       pwrite;
   logic [WDATA_WIDTH - 1 : 0] pwdata;

   // slave
   logic                       pready;
   logic [RDATA_WIDTH - 1 : 0] prdata;
   logic                       pslverr;

   // control
   bit                         has_checks = 1;
   bit                         has_coverage = 1;

   // TODO : coverage and assertions go here...

endinterface : apb_if

`endif
