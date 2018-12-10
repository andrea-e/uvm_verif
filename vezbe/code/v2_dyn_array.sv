module dyn_array;

   // deklaracija
   int dyn_example[];

   initial begin

      // alokacija memorije
      dyn_example = new[3]; // 3 elementa

      // inicijalizacija
      foreach (dyn_example[i])
        dyn_example[i] = i;
      $display("dyn_example = %p", dyn_example);

      // dodavanje elemenata
      // 5 elemenata (3 postojeca + 2 nova)
      dyn_example = new[5](dyn_example);
      $display("dyn_example = %p", dyn_example);

      // 100 elemenata (prethodne vrednosti su izgubljene)
      dyn_example = new[100];
      $display("dyn_example = %p", dyn_example);

      // brisanje niza
      dyn_example.delete();
      $display("dyn_example = %p", dyn_example);
   end

   // Rezultat izvrsavanja:
   //
   // dyn_example = '{0, 1, 2}
   // dyn_example = '{0, 1, 2, 0, 0}
   // dyn_example = '{0, 0, ..., 0}
   // dyn_example = '{}

endmodule : dyn_array
