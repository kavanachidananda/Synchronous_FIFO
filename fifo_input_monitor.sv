class fifo_output_monitor extends uvm_monitor;
  virtual fifo_intf vif;
  fifo_transaction req;
   uvm_analysis_port#(fifo_transaction) ap;
   `uvm_component_utils(fifo_output_monitor)
  
   function new(string name = "fifo_output_monitor", uvm_component parent);
    super.new(name, parent);
     ap = new("analysis_port", this);
  endfunction

   virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
     req = f_sequence_item::type_id::create("req");
      if(!uvm_config_db#(virtual fifo_intf)::get(this, "", "vif", vif))
      `uvm_fatal("Monitor: ", "No vif is found!")
  endfunction

   virtual task run_phase(uvm_phase phase);
    forever begin
      @(posedge vif.m_mp.clk)
      if(vif.m_mp.m_cb.wr == 1 && vif.in)begin
        $display("\nWR is high");
        req.i_wrdata = vif.m_mp.m_cb.i_wrdata;
        req.i_wren = ;
        req.i_rden = ;
        ap.write(req);
      end      
