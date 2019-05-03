`ifndef APB_TEST_SIMPLE_SV
 `define APB_TEST_SIMPLE_SV

class apb_test_simple extends apb_test_base;

   `uvm_component_utils (apb_test_simple)

   apb_master_simple_seq master_seq;
   apb_slave_simple_seq slave_seq;

   function new(string name = "apb_test_simple", uvm_component parent = null);
      super.new(name, parent);
   endfunction : new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      master_seq = apb_master_simple_seq::type_id::create("master_seq");
      slave_seq = apb_slave_simple_seq::type_id::create("slave_seq");
   endfunction : build_phase

   task main_phase(uvm_phase phase);
      assert(master_seq.randomize());

      phase.raise_objection(this);

      fork
         master_seq.start(env.master.seqr);
         slave_seq.start(env.slaves[0].seqr); // runs forever
      join_any

      phase.drop_objection(this);
   endtask : main_phase

endclass : apb_test_simple

`endif
