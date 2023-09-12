class fifo_driver extends uvm_driver #(fifo_transaction);
 virtual fifo_intf vif; //interface handle
  fifo_transaction req; //sequence_item handle
 
 `uvm_utils_component(fifo_driver)
 
 function new(string name = "fifo_driver", uvm_component parent);
    super.new(name, parent);
  endfunction

 // Build Phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
   if(!uvm_config_db#(virtual fifo_intf)::get(this, "", "vif", vif))
      `uvm_fatal("Driver: ", "No vif is found!")
  endfunction

// Run phase  
    virtual task run_phase(uvm_phase phase);
   if(vif.dcb.rstn==0)
    vif.d_mp.dcb.i_wren <= 'b0;
    vif.d_mp.dcb.i_rden <= 'b0;
    vif.d_mp.dcb.data_in <= 'b0;
   endtask
    forever begin
      seq_item_port.get_next_item(req);
     if(req.i_wren == 1)
        main_write(req.data_in);
     else if(req.i_rden == 1)
        main_read();
      seq_item_port.item_done();
    end
  endtask
endclass : fifo_driver
