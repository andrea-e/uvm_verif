`ifndef I2C_MONITOR_SV
 `define I2C_MONITOR_SV

class i2c_monitor extends uvm_monitor;

   virtual i2c_if vif;

   i2c_config cfg;

   uvm_analysis_port #(i2c_transaction) item_collected_port;

   int unsigned num_transactions = 0;

   i2c_transaction tr_collected;

   event        start_e;
   event        stop_e;

   `uvm_component_utils_begin(i2c_monitor)
      `uvm_field_object(cfg, UVM_DEFAULT | UVM_REFERENCE)
   `uvm_component_utils_end

   covergroup cg_i2c_monitor;
      // cover direction - read or write
      cp_direction : coverpoint tr_collected.dir {
         bins write = {I2C_WRITE};
         bins read  = {I2C_READ};
      }
      // cover address ack
      cp_addr_ack : coverpoint tr_collected.addr_ack {
         bins ack  = {I2C_ACK};
         bins nack = {I2C_NACK};
      }
      // cover data ack
      cp_data_ack : coverpoint tr_collected.data_ack {
         bins ack  = {I2C_ACK};
         bins nack = {I2C_NACK};
      }
      // TODO : add others
   endgroup : cg_i2c_monitor;

   function new(string name = "i2c_monitor", uvm_component parent = null);
      super.new(name, parent);
      item_collected_port = new("item_collected_port", this);
      cg_i2c_monitor = new();
   endfunction : new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db#(i2c_config)::get(this, "", "i2c_config", cfg))
        `uvm_fatal("NO_CFG",{"Config object must be set for: ",get_full_name(),".cfg"})
   endfunction: build_phase

   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      if(!uvm_config_db#(virtual i2c_if)::get(this, "", "i2c_if", vif))
        `uvm_fatal("NO_IF",{"virtual interface must be set for: ",get_full_name(),".vif"})
   endfunction : connect_phase

   extern virtual task start_condition(ref event start_e);
   extern virtual task stop_condition(ref event stop_e);
   extern virtual task main_phase(uvm_phase phase);
   extern virtual task collect_transactions();
   extern virtual function void report_phase(uvm_phase phase);

endclass : i2c_monitor

task i2c_monitor::main_phase(uvm_phase phase);
   forever begin

      @(negedge vif.rst);
      `uvm_info(get_type_name(), "Reset dropped", UVM_MEDIUM)

      fork
         @(posedge vif.rst); // reset is active high
         start_condition(start_e);
         stop_condition(stop_e);
         collect_transactions();
      join_any
      disable fork;

   end
endtask : main_phase

// trigger event when start
task i2c_monitor::start_condition(ref event start_e);
   forever begin
      wait(vif.sda_wire !== 1'bx); // don't trigger from an X to 0 transition
      @(negedge vif.sda_wire);
      if(vif.scl_wire === 1'b1) begin
         ->start_e;
      end
   end
endtask : start_condition

// trigger event when stop
task i2c_monitor::stop_condition(ref event stop_e);
   forever begin
      wait(vif.sda_wire !== 1'bx); // don't trigger from an X to 1 transition
      @(posedge vif.sda_wire);
      if(vif.scl_wire === 1'b1) begin
         ->stop_e;
      end
   end
endtask : stop_condition

// monitor i2c interface and collect transactions
task i2c_monitor::collect_transactions();
   forever begin
      wait(start_e.triggered);
      tr_collected = i2c_transaction::type_id::create("tr_collected", this);

      // address
      tr_collected.addr = 0;
      repeat(ADDR_WIDTH) begin
         @(posedge vif.scl_wire);
         #1;
         tr_collected.addr = {tr_collected.addr[ADDR_WIDTH - 2 : 0], vif.sda_wire};
      end

      // read / write bit
      @(posedge vif.scl_wire);
      #1;
      tr_collected.dir = i2c_direction_enum'(vif.sda_wire);

      // ack bit
      @(posedge vif.scl_wire);
      #1;
      if(vif.sda_wire === 1'b0) tr_collected.addr_ack = I2C_ACK;
      else tr_collected.addr_ack = I2C_NACK;
      if(cfg.has_checks) begin // check for NACK
	       asrt_addr_nack : assert (tr_collected.addr_ack == I2C_ACK)
	         else
	           `uvm_error(get_type_name(), $sformatf("Observed address NACK during %s", tr_collected.dir.name))
      end
      // only if ack
      if(tr_collected.addr_ack == I2C_ACK) begin
         // data
         repeat(DATA_WIDTH) begin
            @(posedge vif.scl_wire);
            #1;
            tr_collected.data = {tr_collected.data[DATA_WIDTH - 2 : 0], vif.sda_wire};
         end

         // ack bit
         @(posedge vif.scl_wire);
         #1;
         if(vif.sda_wire === 1'b0) tr_collected.data_ack = I2C_ACK;
         else tr_collected.data_ack = I2C_NACK;
         if(cfg.has_checks) begin // check for NACK
	          asrt_data_nack : assert (tr_collected.data_ack == I2C_ACK)
	            else
	              `uvm_error(get_type_name(), $sformatf("Observed data NACK during %s", tr_collected.dir.name))
         end
      end

      wait(stop_e.triggered);

      item_collected_port.write(tr_collected);
      if(cfg.has_coverage == 1) begin
         cg_i2c_monitor.sample();
      end
      `uvm_info(get_type_name(), $sformatf("Tr collected :\n%s", tr_collected.sprint()), UVM_MEDIUM)
      num_transactions++;
   end
endtask : collect_transactions

function void i2c_monitor::report_phase(uvm_phase phase);
   `uvm_info( get_type_name(),
              $sformatf("Report: I2C monitor collected: %0d transactions", num_transactions),
              UVM_LOW);
endfunction : report_phase

`endif
