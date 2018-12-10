module fixed_size_arrays;

   int x[4] = '{1, 2, 3, 4};
   int y[4] = '{5, 6, 7, 8};

   initial begin
      if(x == y)
        $display("Nizovi su jednaki");
      else
        $display("Nizovi nisu jednaki");
      y = x;
      // y poprima vrednosti x niza
      y[0] = 0; // promena prvog elementa
      // poredjenje dela niza
      if(x[1:2] == y[1:2])
        $display("Elementi 1 i 2 su jednaki");
      else
        $display("Elementi 1 i 2 nisu jednaki");
   end

   // Rezultat izvrsavanja:
   //
   // Nizovi nisu jednaki
   // Elementi 1 i 2 su jednaki

endmodule : fixed_size_arrays
