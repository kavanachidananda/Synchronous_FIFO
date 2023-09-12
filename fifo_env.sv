`include "fifo_active_agent.sv"
`include "fifo_scoreboard.sv"
 class fifo_env extends uvm_env;
  fifo_agent agt;
  fifo_scoreboard scb;
   `uvm_component_utils(fifo_env)
  
   function new(string name = "fifo_env", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agt = fifo_active_agent::type_id::create("agt", this);
    scb = fifo_scoreboard::type_id::create("scb", this);
  endfunction
  
  virtual function void connect_phase(uvm_phase phase);
   agt.mon.ap.connect(scb.ap);
  endfunction
  
endclass
endclass : fifo_env
