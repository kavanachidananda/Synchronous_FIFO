

class fifo_scoreboard extends uvm_scoreboard;
  uvm_analysis_imp#(fifo_transaction, fifo_scoreboard) ap1;
  uvm_analysis_imp#(fifo_transaction, fifo_scoreboard) ap2;
  `uvm_component_utils(fifo_scoreboard)

  function new(string name = "fifo_scoreboard", uvm_component parent);
    super.new(name, parent);
    ap1 = new("ap1", this);
    ap2 = new("ap2",this);
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
  function void write(input fifo_transaction req1);
    bit [127:0] data;
    if(req1.i_wren == 1 && req1.i_rden == 0)begin
      queue.push_back(req1.i_wrdata);
      count = count + 1;
      `uvm_info("write Data", $sformatf("i_wren: %0b i_rden: %0b i_wrdata: %0d count: %0d o_full: %0b",req1.i_wren, req1.i_rden,req1.i_wrdata, count, req1.o_full), UVM_LOW);
      if(count==DEPTH)begin
        check_full = 1;
        if(req1.o_full==check_full)
          $display("FIFO FULL TEST CASE PASS");
       else
         $display("FIFO FULL TEST CASE FAIL");
      end
      if(count>=(DEPTH-UPP_TH) && count!=DEPTH) begin
         check_almost_full=1;
        if(req1.o_alm_full==check_almost_full)
            $display("FIFO FULL TEST CASE PASS");
          else
            $display("FIFO FULL TEST CASE FAIL");
      end
      else if (req1.i_rden == 1 && req1.i_wren == 0)begin
      if(queue.size() >= 1)begin
        data = queue.pop_front();
        count = count - 1;
        `uvm_info("Read Data", $sformatf("data: %0d o_rddata: %0d count: %0d o_empty: %0b",data, req1.o_rddata, count, req1.o_empty), UVM_LOW);
        if(count==0)begin
        check_empty = 1;
          if(req1.o_empty==check_empty)
            $display("FIFO EMPTY TEST CASE PASS");
         else
           $display("FIFO EMPTY TEST CASE FAIL");
       end
        if(count<=LOW_TH && count!=0) begin
         check_almost_empty=1;
           if(req1.o_alm_empty==check_almost_empty)
            $display("FIFO EMPTY TEST CASE PASS");
          else
            $display("FIFO EMPTY TEST CASE FAIL");
         end
        if(data == req1.o_rddata)
          $display("INPUT DATA MATCH");
        else 
          $display("INPUT DATA MISMATCH");
      end
     end
  else
    begin
      check_empty = 1;
      if(req1.o_empty==check_empty)
            $display("FIFO EMPTY TEST CASE PASS");
          else
             $display("FIFO EMPTY TEST CASE FAIL");
    end
    end
  endfunction
      
endclass : fifo_scoreboard
