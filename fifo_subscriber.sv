class fifo_subscriber extends uvm_subscriber #(fifo_transaction);
  uvm_analysis_imp #(fifo_transaction, fifo_subscriber) cov_ap;
    `uvm_component_utils(fifo_subscriber)
    fifo_transaction req1;
    covergroup cgrp;
    
cover_point_wren: coverpoint req1.i_wren ; // Explicitly creates 2 bins for 0 and 1
cover_point_rden: coverpoint req1.i_rden; // Explicitly creates 2 bins for 0 and 1
cross_wrXrd: cross cover_point_wren,cover_point_rden; // Explicitly creates 4 bins for 00,01,10 and 11.
cover_point_full: coverpoint req1.o_full; // Explicitly creates 2 bins for 0 and 1
cover_point_almost_full: coverpoint req1.o_alm_full; // Explicitly creates 2 bins for 0 and 1
cover_point_empty: coverpoint req1.o_empty; //Explicitly creates 2 bins for 0 and 1
cover_point_almost_empty: coverpoint req1.o_alm_empty; // Explicitly creates 2 bins for 0 and 1
cross_fullXempty: cross cover_point_full,cover_point_empty;      cross_almfullXalmempty: cross cover_point_almost_full,cover_point_almost_empty;
    endgroup
       
  function new(string name= "fifo_subscriber", uvm_component parent);
        super.new(name, parent);
      cov_ap = new("cov_ap",this);
    req1=fifo_transaction::type_id::create("req1");
        cgrp = new();
    endfunction

  function void write(fifo_transaction t);
       req1=t;
    cgrp.sample();
    $display("coverage=%0d",cgrp.get_coverage());
    endfunction

endclass: fifo_subscriber



