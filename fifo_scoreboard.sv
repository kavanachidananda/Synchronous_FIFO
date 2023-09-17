

class fifo_scoreboard extends uvm_scoreboard;
  uvm_analysis_imp#(fifo_transaction, fifo_scoreboard) ap1;

  `uvm_component_utils(fifo_scoreboard)

  function new(string name = "fifo_scoreboard", uvm_component parent);
    super.new(name, parent);
    ap1 = new("ap1", this);

  endfunction

   virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

bit [DATA_W - 1 : 0] queue[$];
 int count;
 bit check_full;
  bit check_empty;
  bit check_almost_full;
  bit check_almost_empty;
  int temp_count;
  
  
  function void write(input fifo_transaction req1);
    bit [127:0] data;
    
    if ((req1.i_wren == 1) && (req1.i_rden == 0))
     		  begin
      				queue.push_back(req1.i_wrdata);
      				count = count + 1;
 `uvm_info("Write enable is high and Read enable is low", $sformatf("i_wren: %0b i_rden: %0b i_wrdata: %0d count: %0d o_full: %0b o_empty: %0b o_alm_full: %0b o_alm_empty: %0b",req1.i_wren, req1.i_rden,req1.i_wrdata, count, req1.o_full,req1.o_empty,req1.o_alm_full,req1.o_alm_empty), UVM_LOW);
                
                
                 if(count==0)
       					 check_empty = 1;
                       
          			 if(req1.o_empty==1 && check_empty==1)
            			$display("FIFO EMPTY TEST CASE PASS");
         			else
          				 $display("FIFO EMPTY TEST CASE FAIL");
      
        			if(count<=LOW_TH && count!=0)
        				 check_almost_empty=1;
                       
          			if(req1.o_alm_empty==1 && check_almost_empty==1)
                      $display("FIFO ALMOST EMPTY TEST CASE PASS");
          			else
                      $display("FIFO ALMOST EMPTY TEST CASE FAIL");
                
                
                
                
                if(count>=(DEPTH-UPP_TH) && count<DEPTH)
       					  check_almost_full=1;
                
                if((req1.o_alm_full==1) && (check_almost_full==1))
                        $display("FIFO ALMOST FULL TEST CASE PASS");
         	    else
                        $display("FIFO ALMOST FULL TEST CASE FAIL"); 
                      
                
                if(count==DEPTH) 
      					 check_full = 1;
                if((req1.o_full==1) && (check_full==1))
       					 $display("FIFO FULL TEST CASE PASS");
      			else
      					 $display("FIFO FULL TEST CASE FAIL");
   				
     	      end
        
        
      else if (req1.i_rden == 1 && req1.i_wren == 0)
        begin
     		 if(queue.size() >= 1)
                begin
                  $display("Queue:%0p",queue);
       			data = queue.pop_front();
       			count = count - 1;
        `uvm_info("Write enable is low and Read enable is high", $sformatf("i_wren: %0b i_rden: %0b i_wrdata: %0d o_rddata: %0d data :%0d count: %0d o_full: %0b o_empty: %0b o_alm_full: %0b o_alm_empty: %0b",req1.i_wren, req1.i_rden,req1.i_wrdata,req1.o_rddata,data ,count, req1.o_full,req1.o_empty,req1.o_alm_full,req1.o_alm_empty), UVM_LOW);
      
                  $display("POPPED DATA: %0d",data);
                	 if(count==0)
       					 check_empty = 1;
                       
          			 if(req1.o_empty==1 && check_empty==1)
            			$display("FIFO EMPTY TEST CASE PASS");
         			else
          				 $display("FIFO EMPTY TEST CASE FAIL");
      
        			if(count<=LOW_TH && count!=0)
        				 check_almost_empty=1;
                       
          			if(req1.o_alm_empty==1 && check_almost_empty==1)
                      $display("FIFO ALMOST EMPTY TEST CASE PASS");
          			else
                      $display("FIFO ALMOST EMPTY TEST CASE FAIL");
                  
                  
                  
                  
                	  if(count>=(DEPTH-UPP_TH) && count<DEPTH)
       					  check_almost_full=1;
                
              		  if((req1.o_alm_full==1) && (check_almost_full==1))
                        $display("FIFO ALMOST FULL TEST CASE PASS");
         	   		 else
                        $display("FIFO ALMOST FULL TEST CASE FAIL"); 
                      
                
             		   if(count==DEPTH) 
      					 check_full = 1;
               			 if((req1.o_full==1) && (check_full==1))
       					 $display("FIFO FULL TEST CASE PASS");
      					else
      					 $display("FIFO FULL TEST CASE FAIL");
                  
                  
                  
        
       				 if(data == req1.o_rddata)
          				$display("INPUT DATA and OUTPUT DATA MATCH");
       				 else 
         				 $display("INPUT DATA and OUTPUT DATA MISMATCH");
     			   end
     
  			else
    			begin
      					check_empty = 1;
     					 if(req1.o_empty==1 && check_empty==1)
            					$display("FIFO EMPTY TEST CASE PASS");
         				 else
             					$display("FIFO EMPTY TEST CASE FAIL");
   				 end
   		 end
    
    
    
    else if (req1.i_rden == 1 && req1.i_wren == 1)begin
      
            temp_count=count;
            queue.push_back(req1.i_wrdata);
            count = count + 1;
             
    		  if(queue.size() >= 'd1)begin
                data = queue.pop_front();
                count = count - 1; end
      
       `uvm_info("Write and Read enable is high",  $sformatf("i_wren: %0b i_rden: %0b i_wrdata: %0d o_rddata: %0d count: %0d o_full: %0b o_empty: %0b o_alm_full: %0b o_alm_empty: %0b",req1.i_wren, req1.i_rden,req1.i_wrdata,req1.o_rddata, count, req1.o_full,req1.o_empty,req1.o_alm_full,req1.o_alm_empty), UVM_LOW);
     		 if(count==temp_count)
      		  	 $display("Simulataneous write and read test pass");
      		  else 
        		  $display("Simulataneous write and read test fail");
    end
      
      
    
    else if (req1.i_rden == 0 && req1.i_wren == 0)
      begin
       `uvm_info("No write and read operation",  $sformatf("i_wren: %0b i_rden: %0b i_wrdata: %0d o_rddata: %0d count: %0d o_full: %0b o_empty: %0b o_alm_full: %0b o_alm_empty: %0b",req1.i_wren, req1.i_rden,req1.i_wrdata,req1.o_rddata, count, req1.o_full,req1.o_empty,req1.o_alm_full,req1.o_alm_empty), UVM_LOW);
    		  if(!(req1.i_wrdata))
      				  $display("No write operation");
  		    else if (!(req1.o_rddata))
   				     $display("No read operation");
      end
    
      	
  endfunction
      
endclass : fifo_scoreboard
