class new_transaction extends transaction;

   bit [7 : 0] data_o;
   bit         rw;
   bit         en;

   function void display_transaction();
      super.display_transaction();
      $display("\tdata_o = %0h", this.data_o);
      $display("\trw = %0h", this.rw);
      $display("\ten = %0h", this.en);
   endfunction : display_transaction

endclass : new_transaction
