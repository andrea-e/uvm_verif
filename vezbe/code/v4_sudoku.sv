class Sudoku;

   bit unsigned [3:0] init[9][9];
   rand bit[3:0] box[9][9];

   // vrednost brojeva je izmedju 1 i 9
   constraint box_c { /* TODO */ }

   // kvadrati u jednom redu moraju imati jedinstvene vrednosti
   constraint row_c { /* TODO */ }

   // kvadrati u jednoj koloni moraju imati jedinstvene vrednosti
   constraint column_c { /* TODO */ }

   // unutar svakog kvadrata moraju biti jedinstvene vrednosti
   constraint block_c { /* TODO */ }

   // ukoliko je zadata pocetna konfiguracija, ona mora biti ispostovana
   // broj je zadat ukoliko je init[red][kolona] != 0
   constraint init_c { /* TODO */ }

   function int solve_puzzle(bit[3:0] init[9][9]);
      this.init = init;
      return this.randomize();
   endfunction: solve_puzzle

   function string sprint();
      string s = { {3{"+", {3{"-"}} }}, "+\n"};
      for(int i = 0; i < 9; i++) begin
         s = { s, "|" };
         for (int j = 0; j < 9; j++) begin
            s = {s, $psprintf("%1d", box[i][j])};
            if (j % 3 == 2)
              s = {s, "|"};
            if (j == 8)
              s = {s, "\n"};
         end
         if (i % 3 == 2)
           s = {s, {{3{"+", {3{"-"}}}}, "+\n"}};
      end
      return s;
   endfunction : sprint

endclass: Sudoku

module top;

   bit[3:0] init[9][9];
   Sudoku s;

   initial begin
      // neupisana polja = 0
      init = '{'{ 0,2,3, 4,0,6, 7,8,0 },
               '{ 4,0,6, 7,0,9, 1,0,3 },
               '{ 7,8,0, 0,2,0, 0,5,6 },

               '{ 2,3,0, 0,6,0, 0,9,1 },
               '{ 0,0,7, 8,0,1, 2,0,0 },
               '{ 8,9,0, 0,3,0, 0,6,7 },

               '{ 3,4,0, 0,7,0, 0,1,2 },
               '{ 6,0,8, 9,0,2, 3,0,5 },
               '{ 0,1,2, 3,0,5, 6,7,0 }};
      s = new;
      if (s.solve_puzzle(init)) begin
         $display("Resenje je\n%s", s.sprint);
      end else begin
         $display("Nije moguce resiti problem");
      end
   end

endmodule: top
