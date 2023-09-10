class fifo_driver extends uvm_driver #(fifo_transaction);
 virtual fifo_interface vif;
  fifo_transaction req;
  
endclass : fifo_driver
