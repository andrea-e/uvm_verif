`ifndef TEST_SIMPLE_SV
 `define TEST_SIMPLE_SV

class test_simple extends uvm_test;

   `uvm_component_utils(test_simple)

   function new(string name = "test_simple", uvm_component parent = null);
      super.new(name,parent);
   endfunction : new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      // ...
   endfunction : build_phase

   task main_phase(uvm_phase phase);
      super.main_phase(phase);
      `uvm_info(get_type_name(), "Starting main phase...", UVM_HIGH)
      // ...
   endtask : main_phase

endclass : test_simple

`endif
