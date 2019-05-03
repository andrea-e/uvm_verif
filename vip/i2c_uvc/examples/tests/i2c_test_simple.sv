`ifndef I2C_TEST_SIMPLE_SV
 `define I2C_TEST_SIMPLE_SV

class i2c_test_simple extends i2c_test_base;

   `uvm_component_utils (i2c_test_simple)

   i2c_master_simple_seq master_seq;
   i2c_slave_simple_seq slave_seq;

   function new(string name = "i2c_test_simple", uvm_component parent = null);
      super.new(name, parent);
   endfunction : new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      master_seq = i2c_master_simple_seq::type_id::create("master_seq");
      slave_seq = i2c_slave_simple_seq::type_id::create("slave_seq");
   endfunction : build_phase

   task main_phase(uvm_phase phase);
      assert(master_seq.randomize());

      phase.raise_objection(this);

      fork
         master_seq.start(env.master.seqr);
         slave_seq.start(env.slave.seqr);
      join_any

      phase.drop_objection(this);
   endtask : main_phase

endclass : i2c_test_simple

`endif
