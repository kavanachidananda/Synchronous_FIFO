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
   if(vif.dcb.rstn==0) //check for reset
    vif.d_mp.dcb.i_wren <= 0;
    vif.d_mp.dcb.i_rden <= 0;
    vif.d_mp.dcb.i_wrdata <= 0;
   endtask
    forever begin
      seq_item_port.get_next_item(req);
     if(req.i_wren == 1)
      write(req.i_wrdata);
     else if(req.i_rden == 1)
        read();
      seq_item_port.item_done();
    end
  endtask : run_phase

   virtual task write(input  [DATA_W - 1 : 0] i_wrdata);
    @(posedge vif.d_mp.clk)
    vif.d_mp.dcb.i_wren <= 1;
    vif.d_mp.dcb.i_wrdata <= i_wrdata;
    @(posedge vif.d_mp.clk)
   // vif.d_mp.dcb.i_wren <= 0;
  endtask : write
   
endclass : fifo_driver
