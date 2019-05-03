`ifndef RESET_CONFIG_SV
 `define RESET_CONFIG_SV

class reset_config extends uvm_object;

   // reset value at the start of simulation
   bit value_at_0 = 0;
   // 1 = reset is active high; 0 = active low
   bit active_high = 1;

   uvm_active_passive_enum is_active = UVM_ACTIVE;

   bit has_checks = 1;
   bit has_coverage = 1;

   `uvm_object_utils_begin(reset_config)
      `uvm_field_int(value_at_0, UVM_DEFAULT)
      `uvm_field_int(active_high, UVM_DEFAULT)
      `uvm_field_enum(uvm_active_passive_enum, is_active, UVM_DEFAULT)
      `uvm_field_int(has_checks, UVM_DEFAULT)
      `uvm_field_int(has_coverage, UVM_DEFAULT)
   `uvm_object_utils_end

   function new(string name = "reset_config");
      super.new(name);
   endfunction : new

endclass : reset_config

`endif
