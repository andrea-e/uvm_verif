`ifndef UART_SEQ_ITEM_SV
 `define UART_SEQ_ITEM_SV

typedef enum bit {GOOD_PARITY, BAD_PARITY} parity_e;
parameter PAYLOAD_WIDTH = 8;
parameter STOP_WIDTH = 8;
parameter ERR_WIDTH = 8;

class uart_seq_item extends uvm_sequence_item;

   rand bit start_bit;
   rand bit [PAYLOAD_WIDTH-1:0] payload;
   bit       parity;
   rand bit [STOP_WIDTH-1:0] stop_bits;
   rand bit [ERR_WIDTH-1:0] error_bits;
   rand parity_e  parity_type;
   rand int unsigned delay;

   // ogranicenja
   constraint c_delay       {delay < 20;}
   constraint c_start_bit   {start_bit == 0;}
   constraint c_stop_bits   {stop_bits == '1;}
   constraint c_parity_type {parity_type == GOOD_PARITY;}
   constraint c_error_bits  {error_bits == 0;}

   // UVM factory registracija
   `uvm_object_utils_begin(uart_seq_item)
      `uvm_field_int(start_bit, UVM_DEFAULT)
      `uvm_field_int(payload, UVM_DEFAULT)
      `uvm_field_int(parity, UVM_DEFAULT)
      `uvm_field_int(stop_bits, UVM_DEFAULT)
      `uvm_field_int(error_bits, UVM_DEFAULT)
      `uvm_field_enum(parity_e,parity_type, UVM_DEFAULT)
      `uvm_field_int(delay, UVM_DEFAULT)
   `uvm_object_utils_end

   // konstruktor
   function new(string name = "uart_seq_item");
      super.new(name);
   endfunction

   // metoda za racunanje parnosti
   function bit calc_parity(int unsigned num_of_data_bits = 8, bit[1:0] parity_mode = 0);
      bit    parity;

      if (num_of_data_bits == 6)
        parity = ^payload[5:0];
      else if (num_of_data_bits == 7)
        parity = ^payload[6:0];
      else
        parity = ^payload;

      case(parity_mode[0])
        0: parity = ~parity;
        1: parity = parity;
      endcase

      case(parity_mode[1])
        0: parity = parity;
        1: parity = ~parity_mode[0];
      endcase

      if (parity_type == BAD_PARITY)
        return ~parity;
      else
        return parity;
   endfunction

   // parnost se racuna posle randomizacije, na osnovu dodeljenih vrednosti
   function void post_randomize();
      parity = calc_parity();
   endfunction : post_randomize

endclass

`endif
