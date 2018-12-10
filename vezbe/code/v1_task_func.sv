module task_func;

   task example_task (input logic x, inout int y);
      $display("example_task: x = %0d, y = %0d", x, y);
      y += x;
      #5;
      // ...
   endtask : example_task

   task example_task1 (a, b, output integer c, d);
      // a i b su input logic
      // c i d su output integer
      // ...
      $display("example_task1: a = %0d, b = %0d, c = %0d, d = %0d", a, b, c, d);
      c = a;
      d = b;
   endtask

   function void example_func (int x, int y = 5);
      $display("example_func: x = %0d, y = %0d", x, y);
      // #5ns; nije moguce u funkciji
      // ...
   endfunction

   function int example_func1 ();
      // ...
      return 4;
   endfunction : example_func1

   initial begin
      int x0, x1;
      integer y0, y1;

      // primeri poziva
      example_task(5, x0);
      $display("nakon poziva example_task (%0t): x0 = %0d", $time, x0);

      example_task1(.a(4), .c(y0), .b(x1), .d(y1));
      $display("nakon poziva example_task1 (%0t): y0 = %0d, y1 = %0d", $time, y0, y1);

      example_func(3);
      x0 = example_func1();
      void'(example_func1()); // ignorisati povratnu vrednost
   end

   // Rezultat izvrsavanja:
   //
   // example_task: x = 1, y = 0
   // nakon poziva example_task (5): x0 = 1
   // example_task1: a = 0, b = 0, c = x, d = x
   // nakon poziva example_task1 (5): y0 = 0, y1 = 0
   // example_func: x = 3, y = 5

endmodule : task_func
