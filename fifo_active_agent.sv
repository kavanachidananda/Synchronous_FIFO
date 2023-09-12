class fifo_active_agent extends uvm_agent;
  fifo_sequencer seqr;
  fifo_driver dri;
  fifo_input_monitor mon;
  `uvm_component_utils(fifo_active_agent)
  
  function new(string name = "fifo_active_agent", uvm_component parent);
    super.new(name, parent);
  endfunction

    virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(get_is_active() == UVM_ACTIVE) begin
      seqr = f_sequencer::type_id::create("seqr", this);
      dri = f_driver::type_id::create("dri", this);
    end
    mon = f_monitor::type_id::create("mon", this);
  endfunction
  
  virtual function void connect_phase(uvm_phase phase);
    if(get_is_active() == UVM_ACTIVE)
      dri.seq_item_port.connect(seqr.seq_item_export);
  endfunction
    
endclass : fifo_agent
