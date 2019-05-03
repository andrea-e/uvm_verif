`ifndef I2C_SLAVE_SIMPLE_SEQ_SV
 `define I2C_SLAVE_SIMPLE_SEQ_SV

class i2c_slave_simple_seq extends i2c_slave_base_seq;

   `uvm_object_utils(i2c_slave_simple_seq)

	 function new(string name = "i2c_slave_simple_seq");
		  super.new(name);
	 endfunction : new

   virtual task body();
      forever begin
         `uvm_do(req)
      end
   endtask

endclass : i2c_slave_simple_seq

`endif
