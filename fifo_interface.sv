interface fifo_intf(input clk,rstn);
  logic i_wren,i_rden,o_full,o_empty,o_alm_full,o_alm_empty;
  logic  [DATA_W - 1 : 0] i_wrdata;
  logic  [DATA_W - 1 : 0] o_rddata;
endinterface : intf

//driver clocking block
clocking dcb @(posedge clk)
  input  i_wrdata;
  input i_wren,i_rden;
  output o_rddata;
  output o_full,o_empty,o_alm_full,o_alm_empty;
endclocking : dcb

//monitor clocking block
clocking mcb @(posedge clk)
  output i_wrdata;
  output i_wren,i_rden;
  input  o_rddata;
  input o_full,o_empty,o_alm_full,o_alm_empty;
endclocking : mcb

//declare modport
modport d_mp (input clk, rstn, clocking dcb);
  modport m_mp (input clk, rstn, clocking mcb);


