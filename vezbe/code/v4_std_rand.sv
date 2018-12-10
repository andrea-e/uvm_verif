module std_randomize;

   bit [3:0] x;
   int       y;
   bit       err;

   initial begin
      err = !std::randomize(x, y);
      if(err)
        $display("Randomizacija nije uspesna. x = %0h, y = %0h", x, y);
      else
        $display("Randomizacija uspesna. x = %0h, y = %0h", x, y);
   end

endmodule
