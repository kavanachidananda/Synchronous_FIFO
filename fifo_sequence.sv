 parameter DATA_W   = 128;    // Data width
  parameter DEPTH    = 1024;    // Depth of FIFO
  parameter UPP_TH   = 4;       // Upper threshold to generate Almost-full
  parameter LOW_TH   = 2 ;       // Lower threshold to generate Almost-empty

class fifo_test_write extends uvm_sequence #(fifo_transaction);
  `uvm_object_utils(fifo_test_write) //factory registration
   fifo_transaction req;
  function new(string name = "fifo_test_write"); 
    super.new(name);
  endfunction
  
virtual task body();
   `uvm_info(get_type_name(), $sformatf("******** Generate 1024 Write REQs ********"), UVM_LOW)
   repeat(DEPTH) begin
    req = fifo_transaction::type_id::create("req");  //creating sequence_item
    start_item(req);
    assert(req.randomize()with {req.i_wren==1; req.i_rden==0;});
    finish_item(req);
    end

   `uvm_info(get_type_name(), $sformatf("******** Generate 1024 Read REQs ********"), UVM_LOW)
    repeat(DEPTH) begin
     req = fifo_transaction::type_id::create("req");  //creating sequence_item
    start_item(req);
      assert(req.randomize()with {req.i_wren==0; req.i_rden==1;});
    finish_item(req);
    end

   `uvm_info(get_type_name(), $sformatf("******** Idle condition ********"), UVM_LOW)
  repeat(10) begin
     req = fifo_transaction::type_id::create("req");  //creating sequence_item
    start_item(req);
    assert(req.randomize()with {req.i_rden==0 ; req.i_wren==0;}););
    finish_item(req);
    end

   `uvm_info(get_type_name(), $sformatf("******** Generate Alternate read and write ********"), UVM_LOW)
  for(int i=0;i<100;i++) begin
     req = fifo_transaction::type_id::create("req");  //creating sequence_item
    start_item(req);
    assert(req.randomize()with {req.i_rden==0 ; req.i_wren==1;});); //write
    finish_item(req);
     start_item(req);
    assert(req.randomize()with {req.i_rden==1 ; req.i_wren==0;});); //read
    finish_item(req);
    end

  `uvm_info(get_type_name(), $sformatf("******** Simultaneous read and write ********"), UVM_LOW)
  for(int i=0;i<100;i++) begin
     req = fifo_transaction::type_id::create("req");  //creating sequence_item
    start_item(req);
    assert(req.randomize()with {req.i_rden==1 ; req.i_wren==1;});); 
    finish_item(req);
    end

   `uvm_info(get_type_name(), $sformatf("******** Generate Random req's ********"), UVM_LOW)
  for(int i=0;i<100;i++) begin
     req = fifo_transaction::type_id::create("req");  //creating sequence_item
    start_item(req);
    assert(req.randomize());
    finish_item(req);
    end
endtask
endclass :  fifo_test_write





 

                                       


                                         
                                                                              
                                       
                                       


                                       
                                       
                                       
                                      
                                      
