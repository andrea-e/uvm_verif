`ifndef APB_MASTER_READ_ALL_SEQ_SV
 `define APB_MASTER_READ_ALL_SEQ_SV

// sequence for reading from all valid addresses
class apb_master_read_all_seq extends apb_master_base_seq;

   `uvm_object_utils(apb_master_read_all_seq)

   function new(string name = "apb_master_read_all_seq");
      super.new(name);
   endfunction : new

   virtual task body();
      bit [ADDR_WIDTH - 1 : 0] end_addr, curr_addr;

      // read from all addresses in all slaves
      foreach (p_sequencer.cfg.slave_cfg_queue[i]) begin
         curr_addr = p_sequencer.cfg.slave_cfg_queue[i].start_address;
         end_addr  = p_sequencer.cfg.slave_cfg_queue[i].end_address;
         while (curr_addr != end_addr) begin
            `uvm_do_with(   req, {
                                  req.addr == curr_addr;
                                  req.dir  == APB_READ;})
            curr_addr++;
         end

      end

   endtask : body

endclass : apb_master_read_all_seq

`endif
