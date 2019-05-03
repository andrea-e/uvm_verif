`ifndef I2C_TRANSACTION_SV
 `define I2C_TRANSACTION_SV

class i2c_transaction extends uvm_sequence_item;

   rand i2c_direction_enum       dir;
   rand bit [ADDR_WIDTH - 1 : 0] addr;
   rand i2c_ack_enum             addr_ack;
   rand bit [DATA_WIDTH - 1 : 0] data;
   rand i2c_ack_enum             data_ack;

   // timings (#clk cycles)
   rand int unsigned scl_period;    // SCL period
   rand int unsigned start_hold;    // start hold time before SCL toggle
   rand int unsigned stop_setup;    // setup time from SCL posedge to SDA assert
   rand int unsigned delay;         // time between stop and start conditions

   constraint timing_constraint {
      scl_period  inside {[1 : 20]};
      scl_period % 4 == 0;
      start_hold  inside {[1 : 10]};
      stop_setup  inside {[1 : 10]};
      delay       inside {[1 : 10]};
   }
   constraint ack_constraint {
    	addr_ack dist {I2C_ACK := 8, I2C_NACK := 2};
    	data_ack dist {I2C_ACK := 8, I2C_NACK := 2};
   }

   `uvm_object_utils_begin (i2c_transaction)
      `uvm_field_enum (i2c_direction_enum, dir,      UVM_DEFAULT)
    	`uvm_field_enum (i2c_ack_enum,       data_ack, UVM_DEFAULT)
     	`uvm_field_enum (i2c_ack_enum,       addr_ack, UVM_DEFAULT)
      `uvm_field_int  (addr,       UVM_DEFAULT)
      `uvm_field_int  (data,       UVM_DEFAULT)
      `uvm_field_int  (scl_period, UVM_DEFAULT)
      `uvm_field_int  (start_hold, UVM_DEFAULT)
      `uvm_field_int  (stop_setup, UVM_DEFAULT)
      `uvm_field_int  (delay,      UVM_DEFAULT)
   `uvm_object_utils_end

   function new(string name = "i2c_transaction");
      super.new(name);
   endfunction : new

endclass : i2c_transaction

`endif
