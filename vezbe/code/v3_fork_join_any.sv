module fork_join_any_example;

   initial begin
      $display("Before fork join_any at %0t", $time);
      fork
         #15 $display("1st example at %0t", $time);
         #5 $display("2nd example at %0t", $time);
         begin
            $display("3rd example at %0t", $time);
            #10;
            $display("4th example at %0t", $time);
         end
      join_any
      $display("After fork join_any at %0t", $time);
   end

   // Rezultat izvrsavanja:
   //
   // Before fork join_any at 0
   // 3rd example at 0
   // 2nd example at 5
   // After fork join_any at 5
   // 4th example at 10
   // 1st example at 15

endmodule : fork_join_any_example
