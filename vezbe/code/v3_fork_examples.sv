module fork_examples;

   bit a, b;

   initial begin
      a = 1'b0;
      b = 1'b0;
      repeat(5) begin
         #50 a = 1'b1;
         #50 b = 1'b1;
         #50 a = 1'b0;
         #50 a = 1'b1;
         #100 b = 1'b0;
      end
   end

   initial begin
      // example 1
      fork
         forever begin
            @(a);
            $display("Example 1: Observed a change in a, new value = %b at %0t", a, $time);
         end
         @(negedge b);
      join_any
      disable fork;
      $display("Exiting example 1 at %0t", $time);

      // example 2
      fork
         begin
            fork
               forever begin
                  @(a);
                  $display("Example 2: Observed a change in a, new value = %b at %0t", a, $time);
               end
               forever begin
                  @(b);
                  $display("Example 2: Observed a change in b, new value = %b at %0t", b, $time);
               end
            join_none
         end
         begin
            #300;
            $display("Example 2: After 300 at %0t", $time);
         end
      join
      $display("Exiting example 2 at %0t", $time);

      // example 3
      fork
         begin
            #100;
            $display("Example 3: After 100 at %0t", $time);
         end
         wait(a == b);
      join
      $display("Exiting example 3 at %0t", $time);

      // example 4 - which values of i will be displayed?
      for (int i = 0; i < 3; i++) begin
         fork
            $display("Example 4: i = %0d at %0t", i, $time);
         join_none
      end
      $display("Exiting example 4 at %0t", $time);

      #200; // some delay

      // example 5 - which threads will be killed?
      disable fork;
      $display("Exiting example 5 at %0t", $time);
   end

endmodule : fork_examples
