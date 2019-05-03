`ifndef APB_MASTER_WRITE_ALL_SEQ_SV
 `define APB_MASTER_WRITE_ALL_SEQ_SV

// sequence for writing to all valid addresses
class apb_master_write_all_seq extends apb_master_base_seq;

   bit data_is_rand = 1; // 1 = data will be randomly chosen for every write
   // 0 = used data from "data_to_write" field
   bit [WDATA_WIDTH - 1 : 0] data_to_write;
   rand bit [WDATA_WIDTH - 1 : 0] data;

   `uvm_object_utils(apb_master_write_all_seq)

   function new(string name = "apb_master_write_all_seq");
      super.new(name);
   endfunction : new

   virtual task body();
      bit [ADDR_WIDTH - 1 : 0] end_addr, curr_addr;

      // write to all addresses in all slaves
      foreach (p_sequencer.cfg.slave_cfg_queue[i]) begin
         curr_addr = p_sequencer.cfg.slave_cfg_queue[i].start_address;
         end_addr  = p_sequencer.cfg.slave_cfg_queue[i].end_address;
         while (curr_addr != end_addr) begin
            if (data_is_rand) begin
               assert(this.randomize());
            end
            else begin
               data = data_to_write;
            end

            `uvm_do_with(req, {
                               req.addr  == curr_addr;
                               req.wdata == data;
                               req.dir   == APB_WRITE;})
            curr_addr++;
         end

      end


   endtask : body

endclass : apb_master_write_all_seq

`endif
