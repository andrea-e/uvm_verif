`ifndef APB_CONFIG_SV
 `define APB_CONFIG_SV

class apb_config extends uvm_object;

   int unsigned num_of_slaves; // total number of slaves (DUT or agents)
   int unsigned num_of_slave_agents; // number of UVM slave agents
   bit          has_master;

   apb_slave_config slave_cfg_queue[$];
   apb_master_config master_cfg;

   bit          has_pslverr = 1;
   bit          has_checks = 1;
   bit          has_coverage = 1;

   `uvm_object_utils_begin(apb_config)
      `uvm_field_int(num_of_slaves, UVM_DEFAULT)
      `uvm_field_int(num_of_slave_agents, UVM_DEFAULT)
      `uvm_field_int(has_master, UVM_DEFAULT)
      `uvm_field_queue_object(slave_cfg_queue, UVM_DEFAULT)
      `uvm_field_object(master_cfg, UVM_DEFAULT)
      `uvm_field_int(has_pslverr, UVM_DEFAULT)
      `uvm_field_int(has_checks, UVM_DEFAULT)
      `uvm_field_int(has_coverage, UVM_DEFAULT)
   `uvm_object_utils_end

   function new(string name = "apb_config");
      super.new(name);
   endfunction : new

   extern function void add_slave( bit [ADDR_WIDTH - 1 : 0] start_addr,
                                   bit [ADDR_WIDTH - 1 : 0] end_addr,
                                   int unsigned             psel_indx,
                                   bit                      create_agent = 1,
                                   uvm_active_passive_enum is_active = UVM_ACTIVE);
   extern function void add_master(uvm_active_passive_enum is_active = UVM_ACTIVE);
   extern function int unsigned get_slave_psel_by_addr(bit [ADDR_WIDTH - 1 : 0] addr);

endclass : apb_config

function void apb_config::add_slave(bit [ADDR_WIDTH - 1 : 0] start_addr,
                                    bit [ADDR_WIDTH - 1 : 0] end_addr,
                                    int unsigned             psel_indx,
                                    bit                      create_agent = 1,
                                    uvm_active_passive_enum is_active = UVM_ACTIVE);
   apb_slave_config tmp_cfg;
   ++num_of_slaves;
   if(create_agent == 1) ++num_of_slave_agents;
   tmp_cfg = apb_slave_config::type_id::create("slave_cfg");
   tmp_cfg.start_address = start_addr;
   tmp_cfg.end_address = end_addr;
   tmp_cfg.psel_index = psel_indx;
   tmp_cfg.create_agent = create_agent;
   tmp_cfg.is_active = is_active;
   tmp_cfg.has_checks = has_checks;
   tmp_cfg.has_coverage = has_coverage;
   slave_cfg_queue.push_back(tmp_cfg);
endfunction : add_slave

function void apb_config::add_master(uvm_active_passive_enum is_active = UVM_ACTIVE);
   has_master = 1;
   master_cfg = apb_master_config::type_id::create("master_cfg");
   master_cfg.is_active = is_active;
   master_cfg.has_checks = has_checks;
   master_cfg.has_coverage = has_coverage;
endfunction : add_master

function int unsigned apb_config::get_slave_psel_by_addr(bit [ADDR_WIDTH - 1 : 0] addr);
   for (int i = 0; i < slave_cfg_queue.size(); i++)
     if(slave_cfg_queue[i].check_address_range(addr)) begin
        return slave_cfg_queue[i].psel_index;
     end
   return 0;
endfunction : get_slave_psel_by_addr

// default configuration - one master, no slaves
class default_apb_config extends apb_config;

   `uvm_object_utils(default_apb_config)

   function new(string name = "default_apb_config");
      super.new(name);
      add_master(UVM_ACTIVE);
      add_slave(0, 2**ADDR_WIDTH - 1, 1, 1, UVM_ACTIVE); // TODO : remove after debug
   endfunction : new

endclass : default_apb_config

`endif
