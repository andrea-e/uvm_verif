module mailbox_example;

   mailbox mbox = new();
   int mssg, num;

   initial begin
      for(int i=0; i<5; i++) begin
         #10;
         $display("Sending message %0d at %0t", i, $time);
         mbox.put(i);
      end

      num = mbox.num();
      $display("%0d packets in the mailbox at %0t", num, $time);
   end

   initial begin
      for(int i=0; i<5; i++) begin
         #15;
         mbox.get(mssg);
         $display("Got message %0d at %0t", mssg, $time);
      end

      #20;
      $display("Sending message 6 at %0t", $time);
      mbox.put(6);
   end

   initial begin
      #100;
      mbox.get(mssg);
      $display("Got message %0d at %0t", mssg, $time);
      $finish;
   end

   // Rezultat izvrsavanja:
   //
   // Sending message 0 at 10
   // Got message 0 at 15
   // Sending message 1 at 20
   // Got message 1 at 30
   // Sending message 2 at 30
   // Sending message 3 at 40
   // Got message 2 at 45
   // Sending message 4 at 50
   // 2 packets in the mailbox at 50
   // Got message 3 at 60
   // Got message 4 at 75
   // Sending message 6 at 95
   // Got message 6 at 100

endmodule // mailbox_example
