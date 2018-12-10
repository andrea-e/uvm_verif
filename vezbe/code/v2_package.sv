// in example1_pkg.sv
package example1_pkg;
   typedef enum {READ, WRITE} dir_e;
endpackage

// in example2_pkg.sv
package example2_pkg;
   typedef enum {FALSE, TRUE} bool_e;
endpackage

// in top.sv
`include "example1_pkg.sv"
`include "example2_pkg.sv"
module top;

   import example1_pkg::*;

   dir_e direction;
   example2_pkg::bool_e value;

endmodule : top
