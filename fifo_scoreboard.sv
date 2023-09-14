class fifo_scoreboard extends uvm_scoreboard;
  fifo_transaction req;
  uvm_analysis_imp#(fifo_transaction, fifo_scoreboard) ap;
  //uvm_analysis_imp#(fifo_transaction, fifo_scoreboard) ap;
  `uvm_component_utils(fifo_scoreboard)

  function new(string name = "fifo_scoreboard", uvm_component parent);
    super.new(name, parent);
    ap = new("analysis_port", this);
  endfunction

   virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

   int queue[$];
   int count;
   bit check_full;
  bit check_empty;
  bit check_almost_full;
  bit check_almost_empty;
  int temp_count;
  function void write(input req);
    bit [127:0] data;
    if(req.i_wren == 1 && req.i_rden == 0)begin
      queue.push_back(req.i_wrdata);
      count = count + 1;
      `uvm_info("write Data", $sformatf("i_wren: %0b i_rden: %0b i_wrdata: %0d count: %0d o_full: %0b",req.i_wren, req.i_rden,req.i_wrdata, count, req.o_full), UVM_LOW);
      if(count==DEPTH)begin
        check_full == 1;
        if(req.o_full==check_full)
          $display("FIFO FULL TEST CASE PASS);
       else
         $display("FIFO FULL TEST CASE FAIL);
      end
        if(count>=req.UPP_TH && count!=DEPTH) begin
         check_almost_full=1;
          if(req.o_alm_full==check_almost_full)
            $display("FIFO FULL TEST CASE PASS");
          else
            $display("FIFO FULL TEST CASE FAIL");
      end
    else if (req.i_rden == 1 && req.i_wren == 0)begin
      if(queue.size() >= 1)begin
        data = queue.pop_front();
        count = count - 1;
        `uvm_info("Read Data", $sformatf("data: %0d o_rddata: %0d count: %0d o_empty: %0b",data, req.o_rddata, count, req.empty), UVM_LOW);
        if(count==0)begin
        check_empty == 1;
          if(req.o_empty==check_empty)
            $display("FIFO EMPTY TEST CASE PASS);
         else
         $display("FIFO EMPTY TEST CASE FAIL);
       end
         if(count<=req.LOW_TH && count!=0) begin
         check_almost_empty=1;
         if(req.o_alm_empty==check_almost_empty)
            $display("FIFO EMPTY TEST CASE PASS");
          else
            $display("FIFO EMPTY TEST CASE FAIL");
         end
         if(data == req.o_rddata)
          $display("INPUT DATA MATCH");
        else 
          $display("INPUT DATA MISMATCH");
      end
     end
  else
    begin
      check_empty == 1;
          if(req.o_empty==check_empty)
            $display("FIFO EMPTY TEST CASE PASS);
          else
             $display("FIFO EMPTY TEST CASE FAIL");
    end
  endfunction
endclass : fifo_scoreboard
