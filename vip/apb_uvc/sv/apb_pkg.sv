`ifndef APB_PKG_SV
 `define APB_PKG_SV

package apb_pkg;

   parameter ADDR_WIDTH  = 32;
   parameter RDATA_WIDTH = 32;
   parameter WDATA_WIDTH = 32;
   parameter SLV_NUM = 15;


   typedef class apb_transaction;
   typedef class apb_master_config;
   typedef class apb_slave_config;
   typedef class apb_config;

   typedef class apb_slave_driver;
   typedef class apb_slave_sequencer;
   typedef class apb_slave_monitor;
   typedef class apb_slave_agent;

   typedef class apb_master_driver;
   typedef class apb_master_sequencer;
   typedef class apb_master_monitor;
   typedef class apb_master_agent;

   typedef class apb_env;

   import uvm_pkg::*;
 `include "uvm_macros.svh"

 `include "apb_types.sv"
 `include "apb_config.sv"

 `include "master/sequences/apb_master_seq_lib.sv"
 `include "master/apb_master_config.sv"
 `include "master/apb_master_driver.sv"
 `include "master/apb_master_monitor.sv"
 `include "master/apb_master_sequencer.sv"
 `include "master/apb_master_agent.sv"

 `include "slave/sequences/apb_slave_seq_lib.sv"
 `include "slave/apb_slave_config.sv"
 `include "slave/apb_slave_driver.sv"
 `include "slave/apb_slave_monitor.sv"
 `include "slave/apb_slave_sequencer.sv"
 `include "slave/apb_slave_agent.sv"

 `include "apb_env.sv"
 `include "apb_transaction.sv"

endpackage : apb_pkg

 `include "apb_if.sv"

`endif
