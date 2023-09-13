class fifo_scoreboard extends uvm_scoreboard;
  fifo_transaction req;
  uvm_analysis_imp#(fifo_transaction, fifo_scoreboard) ap;
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
      end
      if(count>=1020 && count!=1024) begin
         req.o_alm_full=1;
         $display("FIFO is ALMOST FULL);
      end
    else if (req.i_rden == 1 && req.i_wren == 0)begin
      if(queue.size() >= 1)begin
        data = queue.pop_front();
        count = count - 1;
        `uvm_info("Read Data", $sformatf("data: %0d o_rddata: %0d count: %0d o_empty: %0b",data, req.o_rddata, count, req.empty), UVM_LOW);
        if(count==0)begin
        req.o_empty == 1;
          $display("FIFO is EMPTY);
      end
       if(count<=2 && count!=0) begin
         req.o_alm_empty=1;
         $display("FIFO is ALMOST EMPTY);
      end
        if(data == req.o_rddata)begin
          $display("-------- 		Pass! 		--------");
        end
        else begin
          $display("--------		Fail!		--------");
          $display("--------		Check empty	--------");
        end
      end
    end
  endfunction
endclass
endclass : fifo_scoreboard
