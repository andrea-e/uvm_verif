class transaction;

   rand bit [1 : 0] addr;
   rand bit [7 : 0] data;

   constraint data_range { data > 'ha5; }
   constraint addr_range { addr == 0; }

endclass : transaction

module top;

   transaction tr;

   initial begin
      tr = new;
      assert(tr.randomize()); // i data_range i addr_range ogranicenja su aktivna
      $display("addr = %0h, data = %0h", tr.addr, tr.data);

      tr.constraint_mode(0); // iskljucivanje svih ogranicenja
      assert(tr.randomize()); // nema aktivnih ogranicenja
      $display("addr = %0h, data = %0h", tr.addr, tr.data);

      tr.data_range.constraint_mode(1); // ukljucivanje jednog ogranicenja
      assert(tr.randomize()); // data_range je aktivno, dok addr_range nije
      $display("addr = %0h, data = %0h", tr.addr, tr.data);
   end

   // Rezultat izvrsavanja:
   //
   // addr = 0, data = c7
   // addr = 3, data = 19
   // addr = 2, data = f0

endmodule : top
