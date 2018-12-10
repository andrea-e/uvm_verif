module array_methods;

   int example[$] = {1, 15, 6, 3};
   int res [$];
   int x;

   initial begin
      // nadji sve elemente manje od 10
      res = example.find(x) with (x < 10); // res dobija 1, 6, 3
      $display("Elementi manji od 10 su: %p", res);

      // nadji najmanji element
      res = example.min; // res dobija 1
      $display("Najmanji element je: %p", res);

      // sortiranje niza
      example.sort; // example postaje {1, 3, 6, 15}
      $display("Sortiran niz: %p", example);

      // sumiranje
      x = example.sum; // x = 1 + 3 + 6 + 15
      $display("Suma elemenata niza: %0d", x);

      // xor - ovanje
      x = example.xor with (item + 2); // x = 3 ^ 5 ^ 8 ^ 17
      $display("Xor elemenata niza: %0d", x);
   end

   // Rezultat izvrsavanja:
   //
   // Elementi manji od 10 su: '{1, 6, 3}
   // Najmanji element je: '{1}
   // Sortiran niz: '{1, 3, 6, 15}
   // Suma elemenata niza: 25
   // Xor elemenata niza: 31

endmodule : array_methods
