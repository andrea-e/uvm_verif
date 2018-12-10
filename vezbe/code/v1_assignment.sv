module assignment;

   logic a, b, c, d, e, f;

   initial begin
      a = #10 1'b1; // a postaje 1 u vremenu 10
      b = #20 1'b0; // b postaje 0 u vremenu 30
      c = #40 1'b1; // c postaje 1 u vremenu 70
   end

   initial begin
      d <= #10 1'b1; // d postaje 1 u vremenu 10
      e <= #20 1'b0; // e postaje 0 u vremenu 20
      f <= #40 1'b1; // f postaje 1 u vremenu 40
   end

   always @(a, b, c, d, e, f) begin
      $display("Vreme %0t:", $time);
      $write("\ta = %0d,", a);
      $write("\tb = %0d,", b);
      $write("\tc = %0d,", c);
      $write("\td = %0d,", d);
      $write("\te = %0d,", e);
      $write("\tf = %0d\n", f);
   end

   // Rezultat izvrsavanja:
   //
   // Vreme 10:
   //   a = 1,	b = x,	c = x,	d = x,	e = x,	f = x
   // Vreme 10:
   // 	a = 1,	b = x,	c = x,	d = 1,	e = x,	f = x
   // Vreme 20:
   // 	a = 1,	b = x,	c = x,	d = 1,	e = 0,	f = x
   // Vreme 30:
   // 	a = 1,	b = 0,	c = x,	d = 1,	e = 0,	f = x
   // Vreme 40:
   // 	a = 1,	b = 0,	c = x,	d = 1,	e = 0,	f = 1
   // Vreme 70:
   // 	a = 1,	b = 0,	c = 1,	d = 1,	e = 0,	f = 1

endmodule : assignment
