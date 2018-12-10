`ifndef MEMORY_SV
 `define MEMORY_SV

module memory #(
                parameter ADDR_WIDTH = 2,
                parameter DATA_WIDTH = 8
                )
   (
    input logic                     clk,
    input logic                     rst,
    input logic [ADDR_WIDTH-1 : 0]  addr_i,
    input logic                     rw_i,
    input logic                     en_i,
    input logic [DATA_WIDTH-1 : 0]  data_i,
    output logic [DATA_WIDTH-1 : 0] data_o
    );

   logic [DATA_WIDTH-1 : 0]         mem [2**ADDR_WIDTH];

   always @(posedge clk or posedge rst) begin
      if(rst) begin
         for(int i = 0; i < 2**ADDR_WIDTH; i++) begin
            mem[i] = 0;
         end
      end
      else begin
         if(en_i) begin
            if(rw_i) begin
               mem[addr_i] <= data_i;
            end
            else begin
               data_o <= mem[addr_i];
            end
         end
      end
   end

endmodule : memory

`endif

