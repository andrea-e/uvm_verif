`ifndef APB_MASTER_READ_AFTER_WRITE_SEQ_SV
 `define APB_MASTER_READ_AFTER_WRITE_SEQ_SV

// sequence for writing and reading from one address
class apb_master_read_after_write_seq extends apb_master_base_seq;

   rand int unsigned delay; // transaction delay
   rand bit [ADDR_WIDTH - 1 : 0] addr; // address to write/read

   constraint delay_cst { delay inside {[1 : 10]};}

   `uvm_object_utils(apb_master_read_after_write_seq)

   function new(string name = "apb_master_read_after_write_seq");
      super.new(name);
   endfunction : new

   virtual task body();
      // write
      `uvm_do_with( req,
                    {req.addr == addr;
                     req.dir == APB_READ;
                     req.delay == delay;})
      // read
      `uvm_do_with( req,
                    {req.addr == addr;
                     req.dir == APB_READ;
                     req.delay == delay;})
   endtask : body

endclass : apb_master_read_after_write_seq

`endif
