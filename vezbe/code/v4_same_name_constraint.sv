module top;

   transaction tr;
   bit [1 : 0] addr;
   bit [1 : 0] new_addr;

   initial begin
      tr = new;
      addr = 0;
      new_addr = 0;

      assert(tr.randomize() with { addr == addr; } ); // greska!
      assert(tr.randomize() with { addr == local::addr; } );
      assert(tr.randomize() with { addr == new_addr; } );
   end

endmodule : top
