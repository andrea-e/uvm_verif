`ifndef CALC_DRIVER_SV
 `define CALC_DRIVER_SV

class calc_driver extends uvm_driver#(calc_seq_item);

   `uvm_component_utils(calc_driver)

   function new(string name = "calc_driver", uvm_component parent = null);
      super.new(name,parent);
   endfunction

   task main_phase(uvm_phase phase);
      forever begin
         seq_item_port.get_next_item(req);
         `uvm_info(get_type_name(),
                   $sformatf("Driver sending...\n%s", req.sprint()),
                   UVM_HIGH)
         // do actual driving here
			   /* TODO */
         seq_item_port.item_done();
      end
   endtask : main_phase

endclass : calc_driver

`endif

