import uvm_pkg::*;
`include "uvm_macros.svh"
`include "fifo_interface.sv"
`include "fifo_test.sv"



module fifo_top;
  bit clk;
  bit rstn;
  
  always #5 clk = ~clk;
  
  initial begin
    clk = 1;
    rstn = 0;
   #5;
    rstn = 1;
  end
  
  fifo_intf intf(clk, rstn);
  
  my_fifo dut(.clk(intf.clk),
               .rstn(intf.rstn),
               .i_wrdata(intf.i_wrdata),
               .i_wren(intf.i_wren),
               .i_rden(intf.i_rden),
               .o_full(intf.o_full),
               .o_empty(intf.o_empty),
               .o_rddata(intf.o_rddata),
               .o_alm_full(intf.o_alm_full),
               .o_alm_empty(intf.o_alm_empty));
  
  initial begin
    uvm_config_db#(virtual fifo_intf)::set(null, "", "vif",intff);
    $dumpfile("dump.vcd"); 
    $dumpvars;
    run_test("fifo_test");
  end
  
endmodule
