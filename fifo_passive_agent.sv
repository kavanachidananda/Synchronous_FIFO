`include "fifo_output_monitor.sv"

class fifo_passive_agent extends uvm_agent;
  fifo_output_monitor o_mon;
  'uvm_component_utils(fifo_passive_agent)

  function new(string name = "fifo_passive_agent", uvm_component parent);
    super.new(name, parent);
  endfunction

  
endclass : fifo_passive_agent
