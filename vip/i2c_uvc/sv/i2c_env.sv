`ifndef I2C_ENV_SV
 `define I2C_ENV_SV

class i2c_env extends uvm_env;

   i2c_slave_agent  slave;
   i2c_master_agent master;

   i2c_config cfg;

   `uvm_component_utils_begin(i2c_env)
      `uvm_field_object(cfg, UVM_DEFAULT)
   `uvm_component_utils_end

   function new(string name = "i2c_env", uvm_component parent = null);
      super.new(name, parent);
   endfunction : new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);

      if(!uvm_config_db#(i2c_config)::get(this, "", "i2c_config", cfg)) begin
         `uvm_info("NO_CFG", "Using default_i2c_config", UVM_LOW)
         i2c_config::type_id::set_type_override(default_i2c_config::get_type(), 1);
         cfg = i2c_config::type_id::create("cfg");
      end

      if(cfg.has_master) begin
         uvm_config_db#(i2c_master_config)::set(this, "master*", "i2c_master_config", cfg.master_cfg);
         uvm_config_db#(i2c_config)::set(this, "master.mon*", "i2c_config", cfg);
      end
      if(cfg.has_slave) begin
         uvm_config_db#(i2c_slave_config)::set(this, "slave*", "i2c_slave_config", cfg.slave_cfg);
         uvm_config_db#(i2c_config)::set(this, "slave.mon*", "i2c_config", cfg);
      end

      if(cfg.has_master) begin
         master = i2c_master_agent::type_id::create("master", this);
      end
      if(cfg.has_slave) begin
         slave = i2c_slave_agent::type_id::create("slave", this);
      end

   endfunction : build_phase

endclass : i2c_env

`endif
