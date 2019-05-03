`ifndef APB_TEST_TOP_SV
 `define APB_TEST_TOP_SV

module apb_test_top;

   import uvm_pkg::*;
 `include "uvm_macros.svh"

   import apb_pkg::*;

 `include "apb_test_lib.sv"

 `include "dut.sv"

   logic clock;
   logic reset;

   apb_if apb_vif(clock, reset);

   dut #(  .ADDR_WIDTH(32),
           .RDATA_WIDTH(32),
           .WDATA_WIDTH(32),
           .SLV_NUM(15)
           ) dut_inst (
                       .paddr   (apb_vif.paddr  ),
                       .psel    (apb_vif.psel   ),
                       .penable (apb_vif.penable),
                       .pwrite  (apb_vif.pwrite ),
                       .pwdata  (apb_vif.pwdata ),
                       .pready  (apb_vif.pready ),
                       .prdata  (apb_vif.prdata ),
                       .pslverr (apb_vif.pslverr)
                       );

   initial begin
      uvm_config_db#(virtual apb_if)::set(null,"uvm_test_top.*","apb_if", apb_vif);
      run_test();
   end

   initial begin
      clock <= 1'b0;
      reset <= 1'b0;
      #50 reset <= 1'b1;
   end

   always #5 clock = ~clock;

endmodule : apb_test_top

`endif
