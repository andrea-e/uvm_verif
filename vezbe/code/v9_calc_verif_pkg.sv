`ifndef CALC_VERIF_PKG_SV
 `define CALC_VERIF_PKG_SV

package calc_verif_pkg;

   import uvm_pkg::*;      // import the UVM library
 `include "uvm_macros.svh" // Include the UVM macros

 `include "v9_calc_config.sv"

 `include "v9_calc_seq_item.sv"
 `include "v9_calc_driver.sv"
 `include "v9_calc_sequencer.sv"
 `include "v9_calc_monitor.sv"
 `include "v9_calc_agent.sv"

 `include "v9_calc_env.sv"

 `include "sequences/v9_calc_seq_lib.sv"
 `include "tests/v9_test_lib.sv"

endpackage : calc_verif_pkg

 `include "calc_if.sv"

`endif
