`ifndef CALC_VERIF_PKG_SV
 `define CALC_VERIF_PKG_SV

package calc_verif_pkg;

   import uvm_pkg::*;      // import the UVM library
 `include "uvm_macros.svh" // Include the UVM macros

 `include "v10_calc_config.sv"

 `include "v10_calc_seq_item.sv"
 `include "v10_calc_driver.sv"
 `include "v10_calc_sequencer.sv"
 `include "v10_calc_monitor.sv"
 `include "v10_calc_agent.sv"

 `include "v10_calc_scoreboard.sv"
 `include "v10_calc_env.sv"

 `include "sequences/v10_calc_seq_lib.sv"
 `include "tests/v10_test_lib.sv"

endpackage : calc_verif_pkg

 `include "calc_if.sv"

`endif
