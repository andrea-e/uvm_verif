`ifndef APB_TRANSACTION_SV
 `define APB_TRANSACTION_SV

class apb_transaction extends uvm_sequence_item;

   rand bit [ADDR_WIDTH - 1 : 0]  addr;
   rand apb_direction_enum        dir;
   rand bit [RDATA_WIDTH - 1 : 0] rdata;
   rand bit [WDATA_WIDTH - 1 : 0] wdata;
   rand int unsigned              delay = 0;
   bit                            error;

   constraint c_delay { delay <= 10 ; }

   `uvm_object_utils_begin(apb_transaction)
      `uvm_field_int(addr, UVM_DEFAULT)
      `uvm_field_enum(apb_direction_enum, dir, UVM_DEFAULT)
      `uvm_field_int(rdata, UVM_DEFAULT)
      `uvm_field_int(wdata, UVM_DEFAULT)
      `uvm_field_int(delay, UVM_DEFAULT)
      `uvm_field_int(error, UVM_DEFAULT)
   `uvm_object_utils_end

   function new(string name = "apb_transaction");
      super.new(name);
   endfunction : new

endclass : apb_transaction

`endif
