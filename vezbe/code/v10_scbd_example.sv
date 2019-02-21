`uvm_analysis_imp_decl(_rcvd_pkt)
`uvm_analysis_imp_decl(_sent_pkt)

class Scoreboard extends uvm_scoreboard;

   `uvm_component_utils(Scoreboard)

   Packet exp_que[$];

   uvm_analysis_imp_rcvd_pkt #(Packet,Scoreboard) Rcvr2Sb_port;
   uvm_analysis_imp_sent_pkt #(Packet,Scoreboard) Drvr2Sb_port;

   function new(string name = "Scoreboard", uvm_component parent = null);
      super.new(name, parent);
      Rcvr2Sb_port = new("Rcvr2Sb", this);
      Drvr2Sb_port = new("Drvr2Sb", this);
   endfunction : new

   function void write_rcvd_pkt(input Packet pkt);
      Packet exp_pkt;

      asrt_exp_queue_not_empty : assert (exp_que.size()) begin
         exp_pkt = exp_que.pop_front();
         asrt_pkt_compare : assert (pkt.compare(exp_pkt))
           `uvm_info(get_type_name(), "Sent packet and received packet matched", UVM_MEDIUM);
            else
              `uvm_error(get_type_name(), "Sent packet and received packet mismatched");
      end
         else begin
            `uvm_error(get_type_name(), "No more packets to in the queue to compare");
         end
   endfunction : write_rcvd_pkt

   function void write_sent_pkt(input Packet pkt);
      exp_que.push_back(pkt);
   endfunction : write_sent_pkt

   function void report_phase(uvm_phase phase);
      `uvm_info(get_type_name(), $psprintf("Scoreboard Report \n", this.sprint()), UVM_LOW);
   endfunction : report_phase

endclass : Scoreboard
