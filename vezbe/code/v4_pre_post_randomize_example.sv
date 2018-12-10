class transaction;

   rand bit [1 : 0] addr;
   rand bit [7 : 0] data;

   function void display_transaction();
      $display("\taddr = %0h", this.addr);
      $display("\tdata = %0h", this.data);
   endfunction : display_transaction

   function void pre_randomize();
      $display("transaction pre_randomize:");
      this.display_transaction();
   endfunction : pre_randomize

   function void post_randomize();
      $display("transaction post_randomize:");
      this.display_transaction();
   endfunction : post_randomize

endclass : transaction

module top;
   transaction tr;

   initial begin
      tr = new;
      assert(tr.randomize());
   end

   // Rezultat izvrsavanja:
   //
   // transaction pre_randomize:
   //   addr = 0
   //   data = 0
   // transaction post_randomize:
   //   addr = 2
   //   data = 1d

endmodule : top
