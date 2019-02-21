class unidir_driver extends uvm_driver #(unidir_seq_item);

   `uvm_component_utils(unidir_driver)

   virtual unidir_if vif;

   function new(string name = "unidir_driver", uvm_component parent = null);
      super.new(name, parent);
   endfunction

   task main_phase(uvm_phase phase);
      int top_idx = 0;
      // pocetno stanje
      vif.frame <= 0;
      vif.data <= 0;

      forever begin
         seq_item_port.get_next_item(req); // zahtev za transakcijom
         repeat(req.delay) begin // kasnjenje izmedju paketa
            @(posedge vif.clk);
         end

         vif.frame <= 1; // pocetak slanja
         for(int i = 0; i < 8; i++) begin // slanje podataka
            @(posedge vif.clk);
            vif.data <= req.data[3:0];
            req.data = req.data >> 4;
         end

         vif.frame <= 0; // kraj slanja
         seq_item_port.item_done(); // transakcija je zavrsena
      end
   endtask: run

endclass: unidir_driver


// generisanje transakcija u petlji
class unidir_tx_seq extends uvm_sequence #(unidir_seq_item);

   `uvm_object_utils(unidir_tx_seq)

   // unidir sequence_item
   unidir_seq_item req;

   // kontrola za broj transakcija
   rand int no_reqs = 10;

   function new(string name = "unidir_tx_seq");
      super.new(name);
   endfunction

   task body();
      req = unidir_seq_item::type_id::create("req");
      repeat(no_reqs) begin
         start_item(req);
         assert(req.randomize());
         finish_item(req);
      end
   endtask: body

endclass: unidir_tx_seq
