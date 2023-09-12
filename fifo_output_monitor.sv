class fifo_output_monitor extends uvm_monitor;
  virtual fifo_intf vif;
  fifo_transaction req;
   uvm_analysis_port#(fifo_transaction) ap;
   `uvm_component_utils(fifo_output_monitor)
  
   function new(string name = "fifo_output_monitor", uvm_component parent);
    super.new(name, parent);
      ap = new("ap", this);
  endfunction
