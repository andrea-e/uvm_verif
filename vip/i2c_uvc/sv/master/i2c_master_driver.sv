`ifndef I2C_MASTER_DRIVER_SV
 `define I2C_MASTER_DRIVER_SV

class i2c_master_driver extends uvm_driver #(i2c_transaction);

   virtual i2c_if vif;

   i2c_master_config cfg;

   `uvm_component_utils_begin(i2c_master_driver)
      `uvm_field_object(cfg, UVM_DEFAULT | UVM_REFERENCE)
   `uvm_component_utils_end

   function new(string name = "i2c_master_driver", uvm_component parent = null);
      super.new(name, parent);
   endfunction : new

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db#(i2c_master_config)::get(this, "*", "i2c_master_config", cfg))
        `uvm_fatal("NO_CFG",{"Config object must be set for: ",get_full_name(),".cfg"})
   endfunction: build_phase

   virtual function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      if(!uvm_config_db#(virtual i2c_if)::get(this, "", "i2c_if", vif))
        `uvm_fatal("NO_IF",{"virtual interface must be set for: ",get_full_name(),".vif"})
   endfunction : connect_phase

   extern virtual task main_phase(uvm_phase phase);
   extern virtual task reset();
   extern virtual task drive_transaction(i2c_transaction tr);
   extern virtual task drive_start(i2c_transaction tr);
   extern virtual task drive_stop(i2c_transaction tr);
   extern virtual task drive_bit(input logic bit_to_drive, input int unsigned scl_period);
   extern virtual task read_bit(output logic bit_read, input int unsigned scl_period);

endclass : i2c_master_driver

task i2c_master_driver::main_phase(uvm_phase phase);
   bit got_item = 0;
   reset(); // init
   forever begin
      fork
         @(posedge vif.rst);
         forever begin
            seq_item_port.get_next_item(req);
            got_item = 1;
            drive_start(req);
            drive_transaction(req);
            drive_stop(req);
            seq_item_port.item_done();
            got_item = 0;
         end
      join_any
      disable fork;
      if(got_item) seq_item_port.item_done();
      reset();
   end

endtask : main_phase

task i2c_master_driver::reset();
   `uvm_info(get_type_name(), "Reset observed", UVM_MEDIUM)
   vif.scl <= 1'b1;
   vif.sda <= 1'b1;
   @(negedge vif.rst); // reset dropped
endtask : reset

task i2c_master_driver::drive_start(i2c_transaction tr);

   @(posedge vif.clk); // sync

   vif.scl <= 1'b1;
   vif.sda <= 1'b0;

   repeat(tr.start_hold) @(posedge vif.clk);

   vif.scl <= 1'b1;
   repeat(tr.scl_period / 2) @(posedge vif.clk);
   vif.scl <= 1'b0;
   repeat(tr.scl_period / 4) @(posedge vif.clk);

endtask : drive_start

task i2c_master_driver::drive_stop(i2c_transaction tr);

   @(posedge vif.clk); // sync

   vif.sda <= 1'b0;

   repeat(tr.scl_period / 2) @(posedge vif.clk);
   vif.scl <= 1'b1;

   repeat(tr.stop_setup) @(posedge vif.clk);
   vif.sda <= 1'b1;

   repeat(tr.delay) @(posedge vif.clk);

endtask : drive_stop

task i2c_master_driver::drive_transaction(i2c_transaction tr);
   logic ack;

   // drive address (msb first)
   for(int i = ADDR_WIDTH; i > 0; --i) begin
      drive_bit(tr.addr[i-1], tr.scl_period);
   end

   // drive direction
   drive_bit(tr.dir, tr.scl_period);

   // get ack from slave
   read_bit(ack, tr.scl_period);
   if(ack === 1'b0) tr.addr_ack = I2C_ACK;
   else tr.addr_ack = I2C_NACK;

   // recieved ack - continue
   if(tr.addr_ack == 1'b0) begin
      if(tr.dir == I2C_WRITE) begin
         for(int i = DATA_WIDTH; i > 0; --i) begin
            drive_bit(tr.data[i - 1], tr.scl_period);
         end
         // get ack from slave
         read_bit(ack, tr.scl_period);
         if(ack === 1'b0) tr.data_ack = I2C_ACK;
         else tr.data_ack = I2C_NACK;
      end
      else begin // READ
         // get data - msb first
         for(int i = DATA_WIDTH; i > 0; --i) begin
            read_bit(tr.data[i-1], tr.scl_period);
         end

         // ack or nack
         drive_bit(tr.data_ack, tr.scl_period);
      end
   end

   `uvm_info(get_type_name(), $sformatf("I2C Finished Driving tr \n%s", tr.sprint()), UVM_HIGH)

endtask : drive_transaction

task i2c_master_driver::drive_bit(input logic bit_to_drive, input int unsigned scl_period);

   vif.sda <= bit_to_drive;
   repeat(scl_period / 4) @(posedge vif.clk);
   vif.scl <= 1'b1;
   repeat(scl_period / 2) @(posedge vif.clk);
   vif.scl <= 1'b0;
   repeat(scl_period / 4) @(posedge vif.clk);

endtask : drive_bit

task i2c_master_driver::read_bit(output logic bit_read, input int unsigned scl_period);

   vif.sda <= 1'bZ;
   repeat(scl_period / 4) @(posedge vif.clk);
   vif.scl <= 1'b1;
   repeat(scl_period / 4) @(posedge vif.clk);
   bit_read = vif.sda_wire;
   repeat(scl_period / 4) @(posedge vif.clk);
   vif.scl <= 1'b0;
   repeat(scl_period / 4) @(posedge vif.clk);

endtask : read_bit

`endif
