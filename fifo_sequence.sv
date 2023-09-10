class fifo_sequence extends uvm_sequence #(fifo_transaction);
  `uvm_object_utils(fifo_sequence) //factory registration
  
  function new(string name = "fifo_sequence");
    super.new(name);
  endfunction
  



endclass
