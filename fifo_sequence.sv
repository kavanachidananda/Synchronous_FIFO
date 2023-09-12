//continuous write
class fifo_test_write extends uvm_sequence #(fifo_transaction);
  `uvm_object_utils(fifo_test_write) //factory registration
   fifo_transaction req;
  function new(string name = "fifo_test_write"); 
    super.new(name);
  endfunction
  
 task body();
   `uvm_info(get_type_name(), $sformatf("******** Generate 1024 Write REQs ********"), UVM_LOW)
   repeat(DEPTH) begin
     req = fifo_transaction::type_id::create("req");  //creating sequence_item
    start_item(req);
    assert(req.randomize()with {req.i_wren==1; req.i_rden==0;});
    finish_item(req);
    end
endtask
endclass :  fifo_test_write

//continuous read

class fifo_test_read extends uvm_sequence #(fifo_transaction);
  `uvm_object_utils( fifo_test_read) //factory registration
   fifo_transaction req;
  function new(string name = " fifo_test_read"); 
    super.new(name);
  endfunction
  task body();
    `uvm_info(get_type_name(), $sformatf("******** Generate 1024 Read REQs ********"), UVM_LOW)
    repeat(DEPTH) begin
     req = fifo_transaction::type_id::create("req");  //creating sequence_item
    start_item(req);
    assert(req.randomize()with {i_wren==0; i_rden==1;});
    finish_item(req);
    end
  endtask
endclass : fifo_test_read

//No write and No read

class fifo_test_idle extends uvm_sequence #(fifo_transaction);
  `uvm_object_utils(fifo_test_idle) //factory registration
   fifo_transaction req;
  function new(string name = "fifo_test_idle"); 
    super.new(name);
  endfunction
 `uvm_info(get_type_name(), $sformatf("******** Idle condition ********), UVM_LOW)
  repeat(10) begin
     req = fifo_transaction::type_id::create("req");  //creating sequence_item
    start_item(req);
    assert(req.randomize()with {i_rden==0 && i_wren==0;}););
    finish_item(req);
    end
endtask
endclass :  fifo_test_idle

// Alternate write and read

class fifo_test_alternate extends uvm_sequence #(fifo_transaction);
  `uvm_object_utils(fifo_test_alternate) //factory registration
   fifo_transaction req;
  function new(string name = "fifo_test_alternate"); 
    super.new(name);
  endfunction
  `uvm_info(get_type_name(), $sformatf("******** Generate Alternate read and write ********), UVM_LOW)
  for(int i=0;i<100;i++) begin
     req = fifo_transaction::type_id::create("req");  //creating sequence_item
    start_item(req);
    assert(req.randomize()with {i_rden==0 && i_wren==1;});); //write
    finish_item(req);
     start_item(req);
    assert(req.randomize()with {i_rden==1 && i_wren==0;});); //read
    finish_item(req);
    end
endtask
endclass :  fifo_test_alternate

 //simultaneous read and write
                                       
class fifo_test_simultaneous extends uvm_sequence #(fifo_transaction);
  `uvm_object_utils(fifo_test_simultaneous) //factory registration
   fifo_transaction req;
  function new(string name = "fifo_test_alternate"); 
    super.new(name);
  endfunction
  `uvm_info(get_type_name(), $sformatf("******** Simultaneous read and write ********), UVM_LOW)
  for(int i=0;i<100;i++) begin
     req = fifo_transaction::type_id::create("req");  //creating sequence_item
    start_item(req);
    assert(req.randomize()with {i_rden==1 && i_wren==1;});); 
    finish_item(req);
    end
endtask
endclass :  fifo_test_simultaneous

                                       
                                       
                                      
                                      
