module fork_join_example;
   initial begin
      $display("Before fork..join at %0t", $time);
      fork

         #15 $display("1st example at %0t", $time); // posebna nit

         #5 $display("2nd example at %0t", $time); // posebna nit

         // jedna posebna nit u begin..end bloku
         begin
            $display("3rd example at %0t", $time);
            #10
              $display("4th example at %0t", $time);
         end

      join
      // nastavak izvrsavanja
      $display("After fork..join at %0t", $time);
   end

   // Rezultat izvrsavanja:
   //
   // Before fork..join at 0
   // 3rd example at 0
   // 2nd example at 5
   // 4th example at 10
   // 1st example at 15
   // After fork..join at 15

endmodule : fork_join_example
