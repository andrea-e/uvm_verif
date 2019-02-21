import uvm_pkg::*;            // import the UVM library
`include "uvm_macros.svh"     // Include the UVM macros

// components
// uvm_component -> A -> A_ovr
class A extends uvm_component;

   `uvm_component_utils(A)

   function new (string name = "A", uvm_component parent = null);
      super.new(name, parent);
   endfunction : new

endclass : A

class A_ovr extends A;

   `uvm_component_utils(A_ovr)

   function new (string name = "A_ovr", uvm_component parent = null);
      super.new(name, parent);
   endfunction : new

endclass : A_ovr

// objects
// uvm_object -> B -> B_ovr
class B extends uvm_object;

   `uvm_object_utils(B)

   function new (string name = "B");
      super.new(name);
   endfunction : new

endclass : B

class B_ovr extends B;

   `uvm_object_utils(B_ovr)

   function new (string name = "B_ovr");
      super.new(name);
   endfunction : new

endclass : B_ovr

// environment using A and B
class environment extends uvm_env;

   `uvm_component_utils(environment)

   A a1;
   A a2;
   B b1;

   function new(string name="environment", uvm_component parent = null);
      super.new(name, parent);
   endfunction : new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      a1 = A::type_id::create("a1", this);
      a2 = A::type_id::create("a2", this);
      b1 = B::type_id::create("b1");
   endfunction : build_phase

   task run_phase(uvm_phase phase);
      `uvm_info(get_type_name(), "Env run_phase", UVM_LOW);
      `uvm_info(get_type_name(), $sformatf("Using component type for a1: %s", a1.get_type_name()), UVM_LOW)
      `uvm_info(get_type_name(), $sformatf("Using component type for a2: %s", a2.get_type_name()), UVM_LOW)
      `uvm_info(get_type_name(), $sformatf("Using object type for b1: %s", b1.get_type_name()), UVM_LOW)
   endtask : run_phase

endclass : environment

// test
class test extends uvm_test;

   `uvm_component_utils(test)

   environment env;

   function new(string name = "test", uvm_component parent = null);
      super.new(name, parent);
   endfunction : new

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      env = environment::type_id::create("env", this);

      `uvm_info(get_type_name(), "Example set_type_override", UVM_LOW);
      A::type_id::set_type_override(A_ovr::get_type(), 1);
      B::type_id::set_type_override(B_ovr::get_type(), 1);
   endfunction : build_phase

endclass : test

// top module
module top();
   initial begin
      run_test("test");
   end
endmodule : top
