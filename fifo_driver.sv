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
    vif.d_mcb.d_cb.wr <= 'b0;
    vif.d_mp.d_cb.rd <= 'b0;
    vif.d_mp.d_cb.data_in <= 'b0;
   endtask
endclass : fifo_driver
