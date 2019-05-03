`ifndef I2C_MASTER_SIMPLE_SEQ_SV
 `define I2C_MASTER_SIMPLE_SEQ_SV

class i2c_master_simple_seq extends i2c_master_base_seq;

   rand int unsigned num_of_tr;

   constraint num_of_tr_cst { num_of_tr inside {[1 : 10]};}

   `uvm_object_utils(i2c_master_simple_seq)

   function new(string name = "i2c_master_simple_seq");
      super.new(name);
   endfunction : new

   virtual task body();
      repeat(num_of_tr) begin
         `uvm_do(req)
      end
   endtask : body

endclass : i2c_master_simple_seq

`endif
