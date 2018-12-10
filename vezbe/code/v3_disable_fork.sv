module disable_fork_example;

   initial begin
      fork
         #15 $display("1st example at %0t", $time);
      join_none
      $display("After fork join_none at %0t", $time);

      fork
         #5 $display("2nd example at %0t", $time);
         begin
            $display("3rd example at %0t", $time);
            #10;
            $display("4th example at %0t", $time);
         end
      join_any
      $display("After fork join_any at %0t", $time);

      disable fork;
      $display("After disable fork at %0t", $time);
   end

   // Rezultat izvrsavanja:
   //
   // After fork join_none at 0
   // 3rd example at 0
   // 2nd example at 5
   // After fork join_any at 5
   // After disable fork at 5

endmodule : disable_fork_example
