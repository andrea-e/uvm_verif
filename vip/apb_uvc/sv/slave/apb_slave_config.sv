`ifndef APB_SLAVE_CONFIG_SV
 `define APB_SLAVE_CONFIG_SV

class apb_slave_config extends uvm_object;

   uvm_active_passive_enum is_active = UVM_ACTIVE;

   bit has_checks                    = 1;
   bit has_coverage                  = 1;

   rand bit [ADDR_WIDTH - 1 : 0] start_address;
   rand bit [ADDR_WIDTH - 1 : 0] end_address;

   rand int unsigned psel_index;
   // create agent or just use cfg for address and psel purposes
   bit create_agent = 1;

   constraint addr_cst { start_address <= end_address; }
   constraint psel_cst { psel_index inside {[0 : SLV_NUM]};}

   `uvm_object_utils_begin(apb_slave_config)
      `uvm_field_enum(uvm_active_passive_enum, is_active, UVM_DEFAULT)
      `uvm_field_int(has_checks, UVM_DEFAULT)
      `uvm_field_int(has_coverage, UVM_DEFAULT)
      `uvm_field_int(start_address, UVM_DEFAULT)
      `uvm_field_int(end_address, UVM_DEFAULT)
      `uvm_field_int(psel_index, UVM_DEFAULT)
      `uvm_field_int(create_agent, UVM_DEFAULT)
   `uvm_object_utils_end

	 function new(string name = "apb_slave_config");
		  super.new(name);
	 endfunction : new

   // checks to see if an address is in the configured range
   function bit check_address_range(bit [ADDR_WIDTH - 1 : 0] addr);
      return (!((start_address > addr) || (end_address < addr)));
   endfunction : check_address_range

   // checks to see if current psel index is for this slave
   function bit check_psel_index(logic [SLV_NUM - 1 : 0] psel);
      for (int i = 0; i < SLV_NUM; i++) begin
         if((psel[i] == 1) && (psel_index == (i + 1)))
           return 1;
      end
      return 0;
   endfunction : check_psel_index

endclass : apb_slave_config

`endif
