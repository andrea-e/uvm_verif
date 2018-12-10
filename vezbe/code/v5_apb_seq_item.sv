`ifndef APB_SEQ_ITEM_SV
 `define APB_SEQ_ITEM_SV

parameter ADDR_WIDTH  = 32;
parameter RDATA_WIDTH = 32;
parameter WDATA_WIDTH = 32;
typedef enum {
              APB_READ = 0,
              APB_WRITE = 1
              } apb_direction_enum;

class apb_seq_item extends uvm_sequence_item;

   // polja
   rand bit [ADDR_WIDTH - 1 : 0]  addr;
   rand apb_direction_enum        dir;
   rand bit [RDATA_WIDTH - 1 : 0] rdata;
   rand bit [WDATA_WIDTH - 1 : 0] wdata;
   rand int unsigned              delay = 0;
   bit       error;

   // ogranicenja
   constraint c_delay { delay <= 10 ; }

   // UVM factory registracija
   `uvm_object_utils_begin(apb_seq_item)
      `uvm_field_int(addr, UVM_DEFAULT)
      `uvm_field_enum(apb_direction_enum, dir, UVM_DEFAULT)
      `uvm_field_int(rdata, UVM_DEFAULT)
      `uvm_field_int(wdata, UVM_DEFAULT)
      `uvm_field_int(delay, UVM_DEFAULT)
      `uvm_field_int(error, UVM_DEFAULT)
   `uvm_object_utils_end

   // konstruktor
   function new(string name = "apb_seq_item");
      super.new(name);
   endfunction : new

endclass

`endif
