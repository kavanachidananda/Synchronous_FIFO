class fifo_sequence extends uvm_sequence #(fifo_transaction);
  `uvm_object_utils(fifo_sequence) //factory registration
   fifo_transaction req;
  function new(string name = "fifo_sequence"); 
    super.new(name);
  endfunction
  
virtual task body();
   `uvm_info(get_type_name(), $sformatf("******** Generate Write REQs ********"), UVM_LOW)
  repeat(5) begin
    req = fifo_transaction::type_id::create("req");  //creating sequence_item
    start_item(req);
    assert(req.randomize()with {req.i_wren==1; req.i_rden==0;});
    finish_item(req);
    `uvm_info(" SEQUENCE : Write enable is high and Read enable is low", $sformatf("i_wren: %0b i_rden: %0b i_wrdata: %0d  ",req.i_wren, req.i_rden,req.i_wrdata), UVM_LOW);
    end
   `uvm_info(get_type_name(), $sformatf("******** Generate Read REQs ********"), UVM_LOW)
  repeat(5) begin
     req = fifo_transaction::type_id::create("req");  //creating sequence_item
    start_item(req);
      assert(req.randomize()with {i_wren==0; i_rden==1;});
    finish_item(req);
    end

   `uvm_info(get_type_name(), $sformatf("******** Idle condition ********"), UVM_LOW)
  repeat(1) begin
     req = fifo_transaction::type_id::create("req");  //creating sequence_item
    start_item(req);
    assert(req.randomize()with {req.i_rden==0 ; req.i_wren==0;});
    finish_item(req);
    end

  `uvm_info(get_type_name(), $sformatf("******** Generate Alternate read and write ********"), UVM_LOW)
  for(int i=0;i<6;i++) begin
     req = fifo_transaction::type_id::create("req");  //creating sequence_item
    start_item(req);
    assert(req.randomize()with {req.i_rden==0 ; req.i_wren==1;}); //write
    finish_item(req);
     start_item(req);
    assert(req.randomize()with {req.i_rden==1 ; req.i_wren==0;}); //read
    finish_item(req);
    end

  `uvm_info(get_type_name(), $sformatf("******** Simultaneous read and write ********"), UVM_LOW)
  for(int i=0;i<4;i++) begin
     req = fifo_transaction::type_id::create("req");  //creating sequence_item
    start_item(req);
    assert(req.randomize()with {req.i_rden==1 ; req.i_wren==1;}); 
    finish_item(req);
    end

   `uvm_info(get_type_name(), $sformatf("******** Generate Random req's ********"), UVM_LOW)
  for(int i=0;i<10;i++) begin
     req = fifo_transaction::type_id::create("req");  //creating sequence_item
    start_item(req);
    assert(req.randomize());
    finish_item(req);
    end 
endtask
endclass 




 

                                       


                                         
                                                                              
                                       
                                       


                                       
                                       
                                       
                                      
                                      
