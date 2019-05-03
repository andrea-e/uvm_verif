`ifndef I2C_SLAVE_DRIVER_SV
 `define I2C_SLAVE_DRIVER_SV

class i2c_slave_driver extends uvm_driver #(i2c_transaction, i2c_transaction);

   virtual i2c_if vif;

   i2c_slave_config cfg;

   `uvm_component_utils_begin(i2c_slave_driver)
      `uvm_field_object(cfg, UVM_DEFAULT | UVM_REFERENCE)
   `uvm_component_utils_end

	 function new(string name = "i2c_slave_driver", uvm_component parent = null);
		  super.new(name, parent);
	 endfunction : new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db#(i2c_slave_config)::get(this, "", "i2c_slave_config", cfg))
        `uvm_fatal("NO_CFG",{"Config object must be set for: ",get_full_name(),".cfg"})
   endfunction: build_phase

   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      if(!uvm_config_db#(virtual i2c_if)::get(this, "", "i2c_if", vif))
        `uvm_fatal("NO_IF",{"virtual interface must be set for: ",get_full_name(),".vif"})
   endfunction : connect_phase

   extern virtual task main_phase(uvm_phase phase);
   extern virtual task reset();
   extern virtual task drive_tr(i2c_transaction tr);

endclass : i2c_slave_driver

task i2c_slave_driver::main_phase(uvm_phase phase);
   bit got_item = 0;
   reset(); // init.
   forever begin
      fork
         @(posedge vif.rst); // reset is active low
         forever begin
            seq_item_port.get_next_item(req);
            got_item = 1;
            drive_tr(req);
            seq_item_port.item_done();
            got_item = 0;
         end
      join_any
      disable fork;
      if(got_item) seq_item_port.item_done();
      reset();
   end
endtask : main_phase

task i2c_slave_driver::reset();
   `uvm_info(get_type_name(), "Reset observed", UVM_MEDIUM)
   vif.scl <= 1'b1;
   vif.sda <= 1'b1;
   @(negedge vif.rst); // reset dropped
endtask : reset

task i2c_slave_driver::drive_tr (i2c_transaction tr);

   // wait for the master to initiate the transaction
	 @(negedge vif.sda_wire iff vif.scl_wire === 1'b1); // start condition

   // address
   tr.addr = 0;
   repeat(ADDR_WIDTH) begin
      @(posedge vif.scl_wire);
      #1;
      tr.addr = {tr.addr[ADDR_WIDTH - 2 : 0], vif.sda_wire};
   end

   // read / write bit
   @(posedge vif.scl_wire);
   #1;
   tr.dir = i2c_direction_enum'(vif.sda_wire);

   // drive addr ack / nack
   @(posedge vif.scl_wire);
   vif.sda = tr.addr_ack;

   // recieved ack - continue
   if(tr.addr_ack == I2C_ACK) begin
      if(tr.dir == I2C_WRITE) begin
         // data
         repeat(DATA_WIDTH) begin
            @(posedge vif.scl_wire);
            #1;
            tr.data = {tr.data[DATA_WIDTH - 2 : 0], vif.sda_wire};
         end
         // drive data ack / nack
         @(posedge vif.scl_wire);
         vif.sda <= tr.data_ack;
      end
      else begin // READ
         // drive data - msb first
         for(int i = DATA_WIDTH; i > 0; --i) begin
            @(posedge vif.scl_wire);
            vif.sda <= tr.data[i-1];
         end

         // read data ack / nack
         @(posedge vif.scl_wire);
         #1;
         if(vif.sda_wire === 1'b0) tr.data_ack = I2C_ACK;
         else tr.data_ack = I2C_NACK;
      end
   end

   `uvm_info(get_type_name(), $sformatf("i2c Finished Driving tr \n%s", tr.sprint()), UVM_HIGH)

endtask : drive_tr

`endif
