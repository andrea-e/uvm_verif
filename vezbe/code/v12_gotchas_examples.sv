import uvm_pkg::*;            // import the UVM library
`include "uvm_macros.svh"     // Include the UVM macros

// example transaction
class Transaction extends uvm_sequence_item;

   bit [1 : 0] addr;
   bit [7 : 0] data;

   `uvm_object_utils_begin(Transaction)
      `uvm_field_int(addr, UVM_DEFAULT)
      `uvm_field_int(data, UVM_DEFAULT)
   `uvm_object_utils_end

   constraint addr_data_constraint {
      addr == 5;
      5 < data < 10;
   }

   function new (string name = "Transaction");
      super.new(name);
   endfunction : new

endclass : Transaction

// test
class test extends uvm_test;

   `uvm_component_utils(test)

   bit [2 : 0] i;
   Transaction tr_queue[$];
   bit         e1, e2;

   function new(string name = "test", uvm_component parent = null);
      super.new(name, parent);
   endfunction : new

   // build phase - fill tr_queue with 10 random transactions
   function void build_phase(uvm_phase phase);
      Transaction tr;
      super.build_phase(phase);

      `uvm_info(get_type_name(), "Starting build phase ...", UVM_HIGH)
      tr = Transaction::type_id::create("tr");

      for(i = 0; i < 10; i++) begin
         tr.randomize();
         tr_queue.push_back(tr);
      end
   endfunction : build_phase

   task run_phase(uvm_phase phase);
      `uvm_info(get_type_name(), "Starting run phase ...", UVM_HIGH)
      phase.raise_objection(this);

      fork
         generate_random_events();
         display_tr();
      join_any;
      disable fork;

      phase.drop_objection(this);
   endtask : run_phase

   task generate_random_events();
      forever begin
         #($urandom_range(10,1)); // delay
         if($urandom_range(1)) begin
            `uvm_info(get_type_name(), "e1 changed...", UVM_HIGH)
            e1 = !e1;
         end
         else begin
            `uvm_info(get_type_name(), "e2 changed...", UVM_HIGH)
            e2 = !e2;
         end
      end
   endtask : generate_random_events

   task display_tr();
      Transaction tr;
      while(tr_queue.size()) begin
         @(e1 || e2);
         tr = tr_queue[i];
         `uvm_info(get_type_name(),
                   $sformatf("Transaction: \n%s", tr.sprint()),
                   UVM_HIGH)
      end
   endtask : display_tr

endclass : test

// top module
module top();

   initial begin
      run_test("test");
   end

endmodule : top
