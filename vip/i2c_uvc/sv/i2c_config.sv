`ifndef I2C_CONFIG_SV
 `define I2C_CONFIG_SV

class i2c_config extends uvm_object;

   bit has_master;
   bit has_slave;

   i2c_slave_config  slave_cfg;
   i2c_master_config master_cfg;

   bit has_checks = 1;
   bit has_coverage = 1;

   `uvm_object_utils_begin(i2c_config)
      `uvm_field_int(has_master, UVM_DEFAULT)
      `uvm_field_int(has_slave, UVM_DEFAULT)
      `uvm_field_object(slave_cfg, UVM_DEFAULT)
      `uvm_field_object(master_cfg, UVM_DEFAULT)
      `uvm_field_int(has_checks, UVM_DEFAULT)
      `uvm_field_int(has_coverage, UVM_DEFAULT)
   `uvm_object_utils_end

   function new(string name = "i2c_config");
      super.new(name);
   endfunction : new

   extern function void add_slave(uvm_active_passive_enum is_active = UVM_ACTIVE);
   extern function void add_master(uvm_active_passive_enum is_active = UVM_ACTIVE);

endclass : i2c_config

// creates and configures a slave agent config and adds to a queue
function void i2c_config::add_slave(uvm_active_passive_enum is_active = UVM_ACTIVE);
   slave_cfg = i2c_slave_config::type_id::create("slave_cfg");
   has_slave = 1;
   slave_cfg.is_active = is_active;
   slave_cfg.has_checks = has_checks;
   slave_cfg.has_coverage = has_coverage;
endfunction : add_slave

// creates and configures a master agent configuration
function void i2c_config::add_master(uvm_active_passive_enum is_active = UVM_ACTIVE);
   master_cfg = i2c_master_config::type_id::create("master_cfg");
   has_master = 1;
   master_cfg.is_active = is_active;
   master_cfg.has_checks = has_checks;
   master_cfg.has_coverage = has_coverage;
endfunction : add_master

// default configuration - one master, no slaves
class default_i2c_config extends i2c_config;

   `uvm_object_utils(default_i2c_config)

   function new(string name = "default_i2c_config");
      super.new(name);
      add_master(UVM_ACTIVE);
      add_slave(UVM_ACTIVE); // TODO : remove after debug
   endfunction : new

endclass : default_i2c_config

`endif
