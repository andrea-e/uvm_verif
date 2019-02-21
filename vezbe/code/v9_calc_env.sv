`ifndef CALC_ENV_SV
 `define CALC_ENV_SV

class calc_env extends uvm_env;

   calc_agent agent;

   `uvm_component_utils (calc_env)

   function new(string name = "calc_env", uvm_component parent = null);
      super.new(name,parent);
   endfunction

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      agent = calc_agent::type_id::create("agent", this);
   endfunction : build_phase

endclass : calc_env

`endif
