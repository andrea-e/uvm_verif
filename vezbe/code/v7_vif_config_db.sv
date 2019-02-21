module calc_verif_top;

   // ...

   // interface
   calc_if calc_vif(clk, rst);

   // DUT
   calc_top DUT(
                .c_clk        ( clk ),
                .reset        ( rst ),
                .out_data1    ( calc_vif.out_data1 ),
                .out_data2    ( calc_vif.out_data2 ),
                .out_data3    ( calc_vif.out_data3 ),
                .out_data4    ( calc_vif.out_data4 ),
                .out_resp1    ( calc_vif.out_resp1 ),
                .out_resp2    ( calc_vif.out_resp2 ),
                .out_resp3    ( calc_vif.out_resp3 ),
                .out_resp4    ( calc_vif.out_resp4 ),
                .req1_cmd_in  ( calc_vif.req1_cmd_in ),
                .req1_data_in ( calc_vif.req1_data_in ),
                .req2_cmd_in  ( calc_vif.req2_cmd_in ),
                .req2_data_in ( calc_vif.req2_data_in ),
                .req3_cmd_in  ( calc_vif.req3_cmd_in ),
                .req3_data_in ( calc_vif.req3_data_in ),
                .req4_cmd_in  ( calc_vif.req4_cmd_in ),
                .req4_data_in ( calc_vif.req4_data_in )
                );

   initial begin
      uvm_config_db#(virtual calc_if)::set(null, "*", "calc_if", calc_vif);
      run_test();
   end

   // ...

endmodule : calc_verif_top
