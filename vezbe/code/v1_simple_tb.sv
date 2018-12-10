module simple_tb;

  logic clk;
  logic rst;
  logic ce;
  logic up;
  logic [3 : 0] data;

  counter cnt_inst (clk, rst, ce, up, data);

  function void compare_values(logic [3:0] expected, logic [3 : 0] received);
    if(expected !== received) begin
      $error("Error in comparison: expected %0h, received %0h\n", expected, received);
    end
    else begin
      $display("Successful comparison at time %0t with value %0h", $time, expected);
    end
  endfunction : compare_values

  initial begin
    $display("Starting simulation...");
    #500ns;
    $finish;
  end

  initial begin
    repeat(3) @(posedge clk iff !rst);
    compare_values('he, data);
  end

  initial begin
    clk <= 0;
    rst <= 1;
    up <= 0;
    ce <= 1;
    #50ns rst <= 0;
  end

  always begin
    #5ns clk <= ~clk;
  end

  final begin
    $display("Ending simulation at time %0t", $time);
  end

endmodule : simple_tb
