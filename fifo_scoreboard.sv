class fifo_scoreboard extends uvm_scoreboard;
  uvm_analysis_imp#(fifo_transaction, fifo_scoreboard) ap;
  `uvm_component_utils(fifo_scoreboard)

  function new(string name = "fifo_scoreboard", uvm_component parent);
    super.new(name, parent);
    ap = new("analysis_port", this);
  endfunction

   virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction
   
endclass : fifo_scoreboard
