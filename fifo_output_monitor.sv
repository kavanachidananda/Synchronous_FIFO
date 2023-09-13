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
      if(vif.out_m_mp.output_mcb.i_wren == 1 && vif.out_m_mp.output_mcb.i_rden == 0)begin
        $display("\nWrite enable is high");
        req.o_rddata = vif.out_m_mp.output_mcb.o_rddata;
        req.o_full = vif.out_m_mp.output_mcb.o_full;
        req.o_alm_full = vif.out_m_mp.output_mcb.o_alm_full;
        req.o_empty = vif.out_m_mp.output_mcb.o_empty;
        req.o_alm_empty = vif.out_m_mp.output_mcb.o_alm_empty
        ap.write(req);
      end   
      if(vif.out_m_mp.output_mcb.i_wren == 0 && vif.out_m_mp.output_mcb.i_rden == 1)begin
        $display("\n Read enable is high");
        req.o_rddata = vif.out_m_mp.output_mcb.o_rddata; 
        req.o_full = vif.out_m_mp.output_mcb.o_full;
        req.o_alm_full = vif.out_m_mp.output_mcb.o_alm_full;
        req.o_empty = vif.out_m_mp.output_mcb.o_empty;
        req.o_alm_empty = vif.out_m_mp.output_mcb.o_alm_empty;
        ap.write(req);
      end   
      if(vif.in_m_mp.input_mcb.i_wren == 1 && vif.in_m_mp.input_mcb.i_rden == 1)begin
        $display("\nBoth Read and write Enable High");
        req.o_rddata = vif.out_m_mp.output_mcb.o_rddata; 
        req.o_full = vif.out_m_mp.output_mcb.o_full;
        req.o_alm_full = vif.out_m_mp.output_mcb.o_alm_full;
        req.o_empty = vif.out_m_mp.output_mcb.o_empty;
        req.o_alm_empty = vif.out_m_mp.output_mcb.o_alm_empty;
        ap.write(req);
      end 
      if(vif.in_m_mp.input_mcb.i_wren == 0 && vif.in_m_mp.input_mcb.i_rden == 0)begin
        $display("\n No write and read operation");
        req.o_rddata = vif.out_m_mp.output_mcb.o_rddata; 
        req.o_full = vif.out_m_mp.output_mcb.o_full;
        req.o_alm_full = vif.out_m_mp.output_mcb.o_alm_full;
        req.o_empty = vif.out_m_mp.output_mcb.o_empty;
        req.o_alm_empty = vif.out_m_mp.output_mcb.o_alm_empty;
        ap.write(req);
      end    
    end
     endtask : run_phase
     endclass : fifo_output_monitor
 
