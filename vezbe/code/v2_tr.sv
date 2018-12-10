`ifndef TRANSACTION_SV
 `define TRANSACTION_SV

class transaction;

   bit [1 : 0] addr;
   bit [7 : 0] data_i;

   function void display_transaction();
      $display("\taddr = %0h", this.addr);
      $display("\tdata_i = %0h", this.data_i);
   endfunction : display_transaction

endclass : transaction

class newTransaction extends transaction;

   bit [7 : 0] data_o;
   bit         rw;
   bit         en;

   function void display_transaction();
      super.display_transaction();
      $display("\tdata_o = %0h", this.data_o);
      $display("\trw = %0h", this.rw);
      $display("\ten = %0h", this.en);
   endfunction : display_transaction

endclass : newTransaction

`endif
