class fifo_sequence extends uvm_sequence #(fifo_transaction);
  `uvm_object_utils(fifo_sequence) //factory registration
   fifo_sequence_item req;
  function new(string name = "fifo_sequence");
    super.new(name);
  endfunction
  
virtual task body();
  `uvm_info(get_type_name(), $sformatf("******** Generate 100 Write REQs ********"), UVM_LOW)
  repeat(100) begin
     req = fifo_sequence_item::type_id::create("req");  //creating sequence_item
    wait_for_grant(); // these steps can be repalced by start_item and finifh_item
     assert(req.randomize()with {i_wren==1;});
     send_request(req);
     wait_for_item_done();
     get_respose(rsp);
    end
  
  `uvm_info(get_type_name(), $sformatf("******** Generate 100 Read REQs ********"), UVM_LOW)
  repeat(100) begin
     req = fifo_sequence_item::type_id::create("req");  //creating sequence_item
     wait_for_grant();
     assert(req.randomize()with {i_rden==1;});
     send_request(req);
     wait_for_item_done();
     get_respose(rsp);
    end
  
  `uvm_info(get_type_name(), $sformatf("******** Generate Random REQs ********"), UVM_LOW)
  repeat(100) begin
     req = fifo_sequence_item::type_id::create("req");  //creating sequence_item
     wait_for_grant();
     assert(req.randomize());
     send_request(req);
     wait_for_item_done();
     get_respose(rsp);
    end
endtask
endclass : fifo_sequence
