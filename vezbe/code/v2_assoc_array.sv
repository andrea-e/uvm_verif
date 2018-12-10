module assoc_array;

   int example_array[int];
   int idx;

   initial begin
      // dodeli vrednosti pojedinim elementima
      idx = 2;
      repeat(5) begin
         example_array[idx] = idx;
         idx *= 5;
      end
      $display("example_array = %p", example_array);

      // prodi kroz sve elemente
      foreach (example_array[i]) begin
         $display(example_array[i]);
      end

      // primeri upotrebe metoda
      if(example_array.exists(3)) begin
         // telo se nece izvrsiti
         // jer ne postoji element sa indeksom 3
         $display("Nece se ispisati.");
      end
      if(example_array.first(idx)) begin
         // telo ce se izvrsiti, a idx dobija vrednost 2
         $display("Primer metode first: idx = %0d", idx);
      end
   end

   // Rezultat izvrsavanja:
   //
   // example_array = '{2:2, 10:10, 50:50, 250:250, 1250:1250 }
   //           2
   //          10
   //          50
   //         250
   //        1250
   // Primer metode first: idx = 2

endmodule : assoc_array
