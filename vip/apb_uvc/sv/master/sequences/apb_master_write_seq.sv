`ifndef APB_MASTER_WRITE_SEQ_SV
 `define APB_MASTER_WRITE_SEQ_SV

// sequence for writing to one address
class apb_master_write_seq extends apb_master_base_seq;

   rand int unsigned delay; // transaction delay
   rand bit [ADDR_WIDTH - 1 : 0] addr; // address to write
   rand bit [WDATA_WIDTH - 1 : 0] data; // data to write

   constraint delay_cst { delay inside {[1 : 10]};}

   `uvm_object_utils(apb_master_write_seq)

   function new(string name = "apb_master_write_seq");
      super.new(name);
   endfunction : new

   virtual task body();
      `uvm_do_with(   req, {
                            req.addr == addr;
                            req.dir == APB_WRITE;
                            req.wdata == data;
                            req.delay == delay;})
   endtask : body

endclass : apb_master_write_seq

`endif
