class transaction;

   rand bit [1 : 0] addr;
   rand bit [7 : 0] data;

   function void display_transaction();
      $display("\taddr = %0h", this.addr);
      $display("\tdata = %0h", this.data);
   endfunction : display_transaction

endclass : transaction

module top;
   transaction tr;

   initial begin
      tr = new;
      $display("Initial");
      tr.display_transaction();
      assert(tr.randomize());
      $display("Randomize all");
      tr.display_transaction();
      assert(tr.randomize(data));
      $display("Randomize just data");
      tr.display_transaction();
   end

   // Rezultat izvrsavanja:
   //
   // Initial
   //   addr = 0
   //   data = 0
   // Randomize all
   //   addr = 2
   //   data = 1d
   // Randomize just data
   //   addr = 2
   //   data = 9a

endmodule : top
