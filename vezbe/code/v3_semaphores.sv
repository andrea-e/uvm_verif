module semaphore_example;

   semaphore sem;

   task sem_example();
      sem.get();
      $display("Got sem at %0t", $time);
      #50;
      sem.put();
   endtask

   initial begin
      sem = new(1);
      fork
         sem_example();
         sem_example();
         sem_example();
      join
   end

   // Rezultaat izvrsavanja:
   //
   // Got sem at 0
   // Got sem at 50
   // Got sem at 100

endmodule : semaphore_example
