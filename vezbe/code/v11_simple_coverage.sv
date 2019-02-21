module simple_coverage();

   logic [7:0] data;
   logic [7:0] addr;
   logic       par;
   logic       rw;
   logic       en;

   // covergroup
   covergroup memory @ (posedge en);
      option.per_instance = 1;
      address : coverpoint addr {
         bins low  = {0,50};
         bins med  = {51,150};
         bins high = {151,255};
      }
      parity : coverpoint par {
         bins even = {0};
         bins odd  = {1};
      }
      read_write : coverpoint rw {
         bins read = {0};
         bins write = {1};
      }
   endgroup

   // instance of covergroup
   memory mem = new();

   // drive stimulus
   task drive (input [7:0] a, input [7:0] d, input r);
      #5;
      en   <= 1;
      addr <= a;
      rw   <= r;
      data <= d;
      par  <= ^d;
      #5;
      en   <= 0;
      rw   <= 0;
      data <= 0;
      par  <= 0;
      addr <= 0;
      rw   <= 0;
   endtask

   // stimulus generation
   initial begin
      en = 0;
      repeat (10) begin
         drive ($random, $random, $random);
      end
      #10 $finish;
   end

endmodule : simple_coverage
