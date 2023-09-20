`include "fifo_active_agent.sv"
`include "fifo_scoreboard.sv"
`include "fifo_subscriber.sv"

 class fifo_env extends uvm_env;
  fifo_active_agent agt1;
  fifo_scoreboard scb;
   fifo_subscriber subscriber;
   `uvm_component_utils(fifo_env)
  
   function new(string name = "fifo_env", uvm_component parent);
    super.new(name, parent);
  endfunction
   
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agt1 = fifo_active_agent::type_id::create("agt1", this);
    scb = fifo_scoreboard::type_id::create("scb", this); 
    subscriber = fifo_subscriber::type_id::create("subscriber",this);
  endfunction
  
  virtual function void connect_phase(uvm_phase phase); 
   agt1.in_mon.ap1.connect(scb.ap1);
    agt1.in_mon.ap1.connect(subscriber.cov_ap);
  endfunction
  

endclass : fifo_env
