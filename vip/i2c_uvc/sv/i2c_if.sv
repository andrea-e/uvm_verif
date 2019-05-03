`ifndef I2C_IF_SV
 `define I2C_IF_SV

interface i2c_if(input logic clk, input logic rst);

   // connected to DUT
   wire sda_wire;
   wire scl_wire;

   // driven by uvc
   logic sda;
   logic scl;

   assign sda_wire = sda;
   assign scl_wire = scl;

   bit   has_checks = 1;
   bit   has_coverage = 1;

   // TODO : coverage and assertions go here...

endinterface : i2c_if

`endif
