`ifndef RESET_MONITOR_SV
 `define RESET_MONITOR_SV

class reset_monitor extends uvm_monitor;

   virtual reset_if vif;

   reset_config cfg;

   uvm_analysis_port #(reset_seq_item) item_collected_port;

   int unsigned num_transactions = 0;

   reset_seq_item tr_collected;

   `uvm_component_utils_begin(reset_monitor)
      `uvm_field_object(cfg, UVM_DEFAULT | UVM_REFERENCE)
   `uvm_component_utils_end

   covergroup cg_reset;
      cp_duration : coverpoint tr_collected.duration {
         bins one_clk = {1};
         bins other  = default;
      }
   endgroup : cg_reset;

   function new(string name = "reset_monitor", uvm_component parent = null);
      super.new(name, parent);
      item_collected_port = new("item_collected_port", this);
      cg_reset = new();
   endfunction : new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db#(reset_config)::get(this, "", "reset_config", cfg))
        `uvm_fatal("NO_CFG",{"Config object must be set for: ",get_full_name(),".cfg"})
   endfunction: build_phase

   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      if(!uvm_config_db#(virtual reset_if)::get(this, "", "reset_if", vif))
        `uvm_fatal("NO_IF",{"virtual interface must be set for: ",get_full_name(),".vif"})
   endfunction : connect_phase

   extern virtual task main_phase(uvm_phase phase);
   extern virtual function void report_phase(uvm_phase phase);

endclass : reset_monitor

task reset_monitor::main_phase(uvm_phase phase);
   forever begin
      tr_collected = reset_seq_item::type_id::create("tr_collected");

      if(cfg.active_high) begin
         @(posedge vif.reset);
      end
      else begin
         @(negedge vif.reset);
      end
      `uvm_info(get_type_name(), "Reset observed", UVM_MEDIUM)

      tr_collected.duration = 1;
      fork
         // get duration
         forever begin
            @(posedge vif.clk) tr_collected.duration++;
         end
         // monitor reset dropped
         begin
            if(cfg.active_high) begin
               @(negedge vif.reset);
            end
            else begin
               @(posedge vif.reset);
            end
         end
      join_any
      disable fork;

      item_collected_port.write(tr_collected); // TLM
      // collect coverage if enabled
      if(cfg.has_coverage == 1) begin
         cg_reset.sample();
      end
      num_transactions++;

   end // forever begin
endtask : main_phase

function void reset_monitor::report_phase(uvm_phase phase);
   `uvm_info(get_type_name(), $sformatf("Report: reset monitor collected %0d transfers", num_transactions), UVM_LOW);
endfunction : report_phase

`endif
