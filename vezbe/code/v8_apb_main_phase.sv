task main_phase(uvm_phase phase);

   apb_transfer trans_collected, trans_clone;
   trans_collected = apb_transfer::type_id::create("trans_collected");

   forever begin

      @(posedge vif.pclock iff (vif.psel != 0));
      trans_collected.addr = vif.paddr;
      case (vif.prwd)
        1'b0 : trans_collected.direction = APB_READ;
        1'b1 : trans_collected.direction = APB_WRITE;
      endcase

      @(posedge vif.pclock);
      if(trans_collected.direction == APB_READ)
        trans_collected.data = vif.prdata;
      if (trans_collected.direction == APB_WRITE)
        trans_collected.data = vif.pwdata;

      @(posedge vif.pclock);
      if(trans_collected.direction == APB_READ) begin
         if(vif.pready != 1'b1)
           @(posedge vif.pclock);
         trans_collected.data = vif.prdata;
      end

      $cast(trans_clone, trans_collected.clone());
      item_collected_port.write(trans_clone);
   end

endtask
