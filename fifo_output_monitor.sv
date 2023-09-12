class fifo_output_monitor extends uvm_monitor;
   virtual fifo_intf vif;
  f_sequence_item item_got;
  uvm_analysis_port#(f_sequence_item) item_got_port;
  `uvm_component_utils(f_monitor)
  
  function new(string name = "f_monitor", uvm_component parent);
    super.new(name, parent);
    item_got_port = new("item_got_port", this);
  endfunction
