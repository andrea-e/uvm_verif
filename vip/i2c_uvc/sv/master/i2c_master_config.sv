`ifndef I2C_MASTER_CONFIG_SV
 `define I2C_MASTER_CONFIG_SV

class i2c_master_config extends uvm_object;

   uvm_active_passive_enum is_active = UVM_ACTIVE;

   bit has_checks                    = 1;
   bit has_coverage                  = 1;

   `uvm_object_utils_begin(i2c_master_config)
      `uvm_field_enum(uvm_active_passive_enum, is_active, UVM_DEFAULT)
      `uvm_field_int(has_checks, UVM_DEFAULT)
      `uvm_field_int(has_coverage, UVM_DEFAULT)
   `uvm_object_utils_end

   function new(string name = "i2c_master_config");
      super.new(name);
   endfunction : new

endclass : i2c_master_config

`endif
