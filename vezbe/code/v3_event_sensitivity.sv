module edge_sensitive_example;

   event e1, e2;

   initial begin
      $display("Thread 1 before trigger");
      -> e1;
      @e2;
      $display("Thread 1 after trigger");
   end

   initial begin
      $display("Thread 2 before trigger");
      -> e2;
      @e1;
      $display("Thread 2 after trigger");
   end

   // Rezultat izvrsavanja:
   //
   // Thread 1 before trigger
   // Thread 2 before trigger
   // Thread 1 after trigger

endmodule : edge_sensitive_example

module level_sensitive_example;

   event e1, e2;

   initial begin
      $display("Thread 1 before trigger");
      -> e1;
      wait(e2.triggered());
      $display("Thread 1 after trigger");
   end

   initial begin
      $display("Thread 2 before trigger");
      -> e2;
      wait(e1.triggered());
      $display("Thread 2 after trigger");
   end

   // Rezultat izvrsavanja:
   //
   // Thread 1 before trigger
   // Thread 2 before trigger
   // Thread 2 after trigger
   // Thread 1 after trigger

endmodule : level_sensitive_example
