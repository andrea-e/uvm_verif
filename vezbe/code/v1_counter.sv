module counter
  (input clk,
   input rst,
   input ce_i,
   input up_i,
   output logic [3:0] q_o);

  logic [3:0] count;

  always_ff @(posedge clk) begin
    if (rst) begin
      count <= 4'b0000;
    end
    else if(ce_i) begin
      if(up_i) begin
        count <= count + 1'b1;
      end
      else begin
        count <= count - 1'b1;
      end
    end
  end

  assign q_o = count;

endmodule : counter
