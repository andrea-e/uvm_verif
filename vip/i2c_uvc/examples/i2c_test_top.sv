`ifndef I2C_TEST_TOP_SV
 `define I2C_TEST_TOP_SV

module i2c_test_top;

   import uvm_pkg::*;
 `include "uvm_macros.svh"

   import i2c_pkg::*;

 `include "i2c_test_lib.sv"

 `include "dut.sv"

   logic clock;
   logic reset;

   i2c_if i2c_vif(clock, reset);

   dut #(  .ADDR_WIDTH(7),
           .DATA_WIDTH(8)
           ) dut_inst (
                       .clk    (clock),
                       .rst    (reset),
                       .scl    (i2c_vif.scl),
                       .sda    (i2c_vif.sda)
                       );

   initial begin
      uvm_config_db#(virtual i2c_if)::set(null,"uvm_test_top.*","i2c_if", i2c_vif);
      run_test();
   end

   initial begin
      clock <= 1'b0;
      reset <= 1'b1;
      #50 reset <= 1'b0;
   end

   always #5 clock = ~clock;

endmodule : i2c_test_top

`endif
