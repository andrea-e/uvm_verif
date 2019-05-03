`ifndef I2C_PKG_SV
 `define I2C_PKG_SV

package i2c_pkg;

   parameter int ADDR_WIDTH = 7;
   parameter int DATA_WIDTH = 8;

   typedef class i2c_transaction;
   typedef class i2c_master_config;
   typedef class i2c_master_driver;
   typedef class i2c_master_agent;
   typedef class i2c_slave_config;
   typedef class i2c_slave_driver;
   typedef class i2c_slave_agent;
   typedef class i2c_config;
   typedef class i2c_monitor;
   typedef class i2c_env;

   import uvm_pkg::*;
 `include "uvm_macros.svh"

 `include "i2c_types.sv"

 `include "master/i2c_master_config.sv"
 `include "master/i2c_master_driver.sv"
 `include "master/i2c_master_agent.sv"
 `include "master/sequences/i2c_master_seq_lib.sv"

 `include "slave/i2c_slave_config.sv"
 `include "slave/i2c_slave_driver.sv"
 `include "slave/i2c_slave_agent.sv"
 `include "slave/sequences/i2c_slave_seq_lib.sv"

 `include "i2c_transaction.sv"
 `include "i2c_config.sv"
 `include "i2c_monitor.sv"
 `include "i2c_env.sv"

endpackage: i2c_pkg

 `include "i2c_if.sv"

`endif
