class transaction;

   bit [1 : 0] addr;
   bit [7 : 0] data_i;

   function void display_transaction();
      $display("\taddr = %0h", this.addr);
      $display("\tdata_i = %0h", this.data_i);
   endfunction : display_transaction

endclass : transaction
