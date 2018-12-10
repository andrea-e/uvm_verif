module queue_methods;

   int x = 2;

   // deklaracija
   int q2[$] = {2, 4, 8}; // i inicijalizacija

   initial begin
      // ubacivanje elemenata

      q2.push_back(10); // na kraj reda
      q2.push_front(3);  // na pocetak reda
      q2.insert(x, 5); // ubacuje 5 poziciju x
      $display("q2 = %p", q2);

      // brisanje elemenata

      // prvi element se uklanja iz reda i
      // x dobija njegovu vrednost
      x = q2.pop_front();
      $display("q2 = %p", q2);

      // poslednji element se uklanja iz reda i
      // x dobija njegovu vrednost
      x = q2.pop_back();
      $display("q2 = %p", q2);

      q2.delete(); // brise ceo red
      $display("q2 = %p", q2);
   end

   // Rezultat izvrsavanja:
   //
   // q2 = '{3, 2, 5, 4, 8, 10}
   // q2 = '{2, 5, 4, 8, 10}
   // q2 = '{2, 5, 4, 8}
   // q2 = '{}

endmodule : queue_methods
