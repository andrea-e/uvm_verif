`ifndef I2C_TEST_BASE_SV
 `define I2C_TEST_BASE_SV

class i2c_test_base extends uvm_test;

   `uvm_component_utils (i2c_test_base)

   i2c_env env;

   function new(string name = "i2c_test_base", uvm_component parent = null);
      super.new(name, parent);
   endfunction : new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      env = i2c_env::type_id::create("env", this);
   endfunction : build_phase

   function void end_of_elaboration_phase(uvm_phase phase);
      super.end_of_elaboration_phase(phase);
      uvm_top.print_topology();
   endfunction : end_of_elaboration_phase

endclass : i2c_test_base

`endif
