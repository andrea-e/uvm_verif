`ifndef APB_ENV_SV
 `define APB_ENV_SV

class apb_env extends uvm_env;

   apb_slave_agent  slaves[]; // can have more than one slave
   apb_master_agent master;

   apb_config cfg;

   `uvm_component_utils_begin(apb_env)
      `uvm_field_object(cfg, UVM_DEFAULT)
   `uvm_component_utils_end

	 function new(string name = "apb_env", uvm_component parent = null);
		  super.new(name, parent);
	 endfunction : new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);

      if(!uvm_config_db#(apb_config)::get(this, "", "apb_config", cfg)) begin
         `uvm_info("NO_CFG", "Using default_apb_config", UVM_LOW)
         apb_config::type_id::set_type_override(default_apb_config::get_type(), 1);
         cfg = apb_config::type_id::create("cfg");
      end

      if(cfg.has_master) begin
         uvm_config_db#(apb_config)::set(this, "master*", "apb_config", cfg);
      end
      foreach(cfg.slave_cfg_queue[i]) begin
         string sname;
         sname = $sformatf("slave[%0d]*", i);
         uvm_config_db#(apb_slave_config)::set(this, sname, "apb_slave_config", cfg.slave_cfg_queue[i]);
      end

      if(cfg.has_master) begin
         master = apb_master_agent::type_id::create("master",this);
      end
      if(cfg.num_of_slave_agents != 0) begin
         slaves = new[cfg.num_of_slave_agents];
         for(int i = 0; i < cfg.slave_cfg_queue.size(); i++) begin
            if(cfg.slave_cfg_queue[i].create_agent == 1) begin
               slaves[i] = apb_slave_agent::type_id::create($sformatf("slave[%0d]", i), this);
            end
         end
      end

   endfunction : build_phase

endclass : apb_env

`endif
