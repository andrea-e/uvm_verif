module simple_event_example;

   event e1;

   initial begin
      #50;
      $display("Triggering event at %0t", $time);
      -> e1;
   end

   initial begin
      $display("Waiting for event at %0t", $time);
      @(e1);
      $display("Event observed at %0t", $time);
   end

   // Rezultat izvrsavanja:
   //
   // Waiting for event at 0
   // Triggering event at 50
   // Event observed at 50

endmodule : simple_event_example
