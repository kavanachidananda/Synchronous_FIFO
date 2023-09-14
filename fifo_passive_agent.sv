`include "fifo_output_monitor.sv"

class fifo_passive_agent extends uvm_agent;
  fifo_output_monitor o_mon;
  `uvm_component_utils(fifo_passive_agent)

  function new(string name = "fifo_passive_agent", uvm_component parent);
    super.new(name, parent);
  endfunction

   virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
     o_mon = fifo_output_monitor::type_id::create("o_mon", this);
  endfunction
  
endclass : fifo_passive_agent
