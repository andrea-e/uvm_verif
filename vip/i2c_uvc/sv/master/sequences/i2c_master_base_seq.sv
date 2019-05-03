`ifndef I2C_MASTER_BASE_SEQ_SV
 `define I2C_MASTER_BASE_SEQ_SV

class i2c_master_base_seq extends uvm_sequence #(i2c_transaction);

   `uvm_object_utils(i2c_master_base_seq)

   function new(string name = "i2c_master_base_seq");
      super.new(name);
   endfunction: new

endclass: i2c_master_base_seq

`endif

