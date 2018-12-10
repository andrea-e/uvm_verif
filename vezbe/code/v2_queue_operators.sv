module queue_operators;

   int x = 2;

   // deklaracija
   int q1[$] = {2, 4, 8}; // i inicijalizacija

   initial begin
      // ubacivanje elemenata

      q1 = {q1, 10}; // na kraj reda
      q1 = {3, q1};  // na pocetak reda
      q1 = {q1[0 : x-1], 5, q1[x : $]}; // ubacuje 5 poziciju x
      $display("q1 = %p", q1);

      // brisanje elemenata

      x = q1[0]; // x dobija vrednost prvog el.
      q1 = q1[1 : $]; // brise prvi element
      $display("q1 = %p", q1);

      // x dobija vrednost poslednjeg elementa
      x = q1[$];
      // brise poslednji element
      q1 = q1[0:$-1];
      $display("q1 = %p", q1);

      q1 = {}; // brise ceo red
      $display("q1 = %p", q1);
   end

   // Rezultat izvrsavanja:
   //
   // q1 = '{3, 2, 5, 4, 8, 10}
   // q1 = '{2, 5, 4, 8, 10}
   // q1 = '{2, 5, 4, 8}
   // q1 = '{}

endmodule : queue_operators
