`ifndef TEST_CALC_BASE_SV
 `define TEST_CALC_BASE_SV

class test_calc_base extends uvm_test;

   calc_env env;
   calc_config cfg;

   `uvm_component_utils(test_calc_base)

   function new(string name = "test_calc_base", uvm_component parent = null);
      super.new(name,parent);
   endfunction : new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      env = calc_env::type_id::create("env", this);
      cfg = calc_config::type_id::create("cfg");
      uvm_config_db#(calc_config)::set(this, "*", "calc_config", cfg);
   endfunction : build_phase

   function void end_of_elaboration_phase(uvm_phase phase);
      super.end_of_elaboration_phase(phase);
      uvm_top.print_topology();
   endfunction : end_of_elaboration_phase

endclass : test_calc_base

`endif
