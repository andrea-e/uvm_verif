`ifndef CALC_VERIF_PKG_SV
 `define CALC_VERIF_PKG_SV

package calc_verif_pkg;

   import uvm_pkg::*;      // import the UVM library
 `include "uvm_macros.svh" // Include the UVM macros

 `include "tests/v5_test_simple.sv"

endpackage : calc_verif_pkg

 `include "calc_if.sv"

`endif
