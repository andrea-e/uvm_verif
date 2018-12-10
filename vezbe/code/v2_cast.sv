module cast;

   typedef enum { red, green, blue, yellow, white, black } Colors;
   Colors col;

   initial begin
      // dynamic
      if (!$cast(col, 2 + 3)) // col = black
        $error("Invalid cast");
      $display("Vrednost col = %s", col.name);

      if (!$cast(col, 2 + 8)) // 10: invalid cast
        $error("Invalid cast");
      $display("Vrednost col = %s", col.name); // vrednost ostaje nepromenjena

      // static
      // compile-time cast
      // uvek je uspesan u toku izvrsavanja i nema mogucnost
      // provere greske ukoliko zadata vrednost lezi van
      // opsega enum-a
      col = Colors'(2 + 1);
      $display("Vrednost col = %s", col.name);

      col = Colors'(2 + 8);
      $display("Vrednost col = %s", col.name);
   end

   // Rezultat izvrsavanja:
   //
   // Vrednost col = black
   // ** Error: Invalid cast
   //    Time: 0 ps  Scope: cast File: v2_cast.sv Line: 13
   // Vrednost col = black
   // Vrednost col = yellow
   // Vrednost col =

endmodule : cast
