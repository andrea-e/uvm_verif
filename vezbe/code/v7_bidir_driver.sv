class bidir_driver extends uvm_driver #(bidir_seq_item);

   `uvm_component_utils(bidir_driver)

   virtual bidir_if vif;

   function new(string name = "bidir_driver", uvm_component parent = null);
      super.new(name, parent);
   endfunction

   task main_phase(uvm_phase phase);
      // pocetno stanje
      vif.valid <= 0;
      vif.rnw <= 1;
      // cekanje da se reset zavrsi
      @(posedge vif.resetn);

      forever begin
         seq_item_port.get_next_item(req); // zahtev za transakcijom

         repeat(req.delay) begin
            @(posedge vif.clk);
         end
         vif.valid <= 1;
         vif.addr <= req.addr;
         vif.rnw <= req.read_not_write;
         if(req.read_not_write == 0) begin
            vif.write_data <= req.write_data;
         end
         while(vif.ready != 1) begin
            @(posedge vif.clk);
         end

         // na kraju transakcije podesiti polja za odgovor
         if(req.read_not_write == 1) begin
            req.read_data = vif.read_data; // vratiti procitani podatak, ukoliko je u pitanju citanje
         end
         req.error = vif.error; // podesiti status
         vif.valid <= 0; // kraj slanja

         seq_item_port.item_done(); // transakcija je zavrsena
      end
   endtask

endclass

class bidir_seq extends uvm_sequence #(bidir_seq_item);

   `uvm_object_utils(bidir_seq)

   bidir_seq_item req;

   rand int limit = 40; // broj iteracija

   function new(string name = "bidir_seq");
      super.new(name);
   endfunction

   task body();
      req = bidir_seq_item::type_id::create("req");

      repeat(limit) begin
         start_item(req);
         // adresa je ogranicena na validan opseg
         assert(req.randomize() with {addr inside {[16'h0100:16'h1000]};});
         finish_item(req);
         // req pokazuje na objekat sa novim vrednostima podesenim u drajveru
         uvm_report_info("seq_body", req.convert2string());
      end
   endtask

endclass
