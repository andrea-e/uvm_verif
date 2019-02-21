`ifndef CALC_ENV_SV
 `define CALC_ENV_SV

class calc_env extends uvm_env;

   calc_agent agent;
   calc_scoreboard scbd;

   `uvm_component_utils (calc_env)

   function new(string name = "calc_env", uvm_component parent = null);
      super.new(name,parent);
   endfunction

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      agent = calc_agent::type_id::create("agent", this);
      scbd = calc_scoreboard::type_id::create("scbd", this);
   endfunction : build_phase

   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      agent.mon.item_collected_port.connect(scbd.item_collected_imp);
   endfunction : connect_phase

endclass : calc_env

`endif
