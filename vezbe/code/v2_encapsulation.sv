// primer klase
class encapsulationExample;

   integer a = 5; // a je public
   local bit b = 1;
   protected int c;

   task displayExample();
      $display("a = %0d", a);
      $display("b = %0d", b);
      $display("c = %0d", c);
   endtask : displayExample

endclass : encapsulationExample

// primer upotrebe
module encapsulationUseExample;

   encapsulationExample example = new;

   initial begin
      example.displayExample(); // dozvoljeno; pristup preko metode klase
      $display("a = %0d", example.a); // dozvoljeno; pristup public polju
      // $display("b = %0d", example.b); // nije dozvoljeno; greska pri kompajliranju
   end

   // Rezultat izvrsavanja:
   //
   // a = 5
   // b = 1
   // c = 0
   // a = 5

endmodule : encapsulationUseExample
