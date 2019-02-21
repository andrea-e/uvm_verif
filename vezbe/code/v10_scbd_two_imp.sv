`uvm_analysis_imp_decl(_1)
`uvm_analysis_imp_decl(_2)

class calc_scoreboard extends uvm_scoreboard;

   uvm_analysis_imp_1#(calc_frame, calc_scoreboard) port_1;
   uvm_analysis_imp_2#(calc_frame, calc_scoreboard) port_2;

   function new(string name = "calc_scoreboard", uvm_component parent = null);
      super.new(name, parent);
      port_1 = new("port_1", this);
      port_2 = new("port_2", this);
   endfunction

   function void write_1(calc_frame t);
      // ...
   endfunction

   function void write_2(calc_frame t);
      // ...
   endfunction

endclass
