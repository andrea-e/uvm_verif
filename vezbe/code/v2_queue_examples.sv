module queue_examples;

   int x = 2;
   int y = 2;

   int q1[$] = {2, 4, 8};
   int q2[$] = {2, 4, 8};

   initial begin

      $display("Inicijalno stanje reda q1: %p", q1);

      q1 = {q1, 10};
      q1 = {3, q1};
      q1 = {q1[0 : x-1], 5, q1[x : $]};
      $display("Posle ubacivanja elemenata u q1: %p", q1);

      x = q1[0];
      $display("x dobija vrednost %0d", x);
      q1 = q1[1 : $];
      $display("Posle brisanja elemenata iz q1: %p", q1);

      x = q1[$];
      $display("x dobija vrednost %0d", x);
      q1 = q1[0:$-1];
      $display("Posle brisanja elemenata iz q1: %p", q1);

      q1 = {};
      $display("Posle brisanja celog reda q1: %p", q1);

      // -------------------------------------------------

      $display("Inicijalno stanje reda q2: %p", q2);

      q2.push_back(10);
      q2.push_front(3);
      q2.insert(y, 5);
      $display("Posle ubacivanja elemenata u q2: %p", q2);

      y = q2.pop_front();
      $display("y dobija vrednost %0d", y);
      $display("Posle brisanja elemenata iz q2: %p", q2);

      y = q2.pop_back();
      $display("y dobija vrednost %0d", y);
      $display("Posle brisanja elemenata iz q2: %p", q2);

      q2.delete();
      $display("Posle brisanja celog reda q2: %p", q2);
   end

endmodule : queue_examples
