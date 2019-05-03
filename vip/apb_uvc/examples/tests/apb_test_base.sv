`ifndef APB_TEST_BASE_SV
 `define APB_TEST_BASE_SV

class apb_test_base extends uvm_test;

   `uvm_component_utils (apb_test_base)

   apb_env env;

   function new(string name = "apb_test_base", uvm_component parent = null);
      super.new(name, parent);
   endfunction : new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      env = apb_env::type_id::create("env", this);
   endfunction : build_phase

   function void end_of_elaboration_phase(uvm_phase phase);
      super.end_of_elaboration_phase(phase);
      uvm_top.print_topology();
   endfunction : end_of_elaboration_phase

endclass : apb_test_base

`endif
