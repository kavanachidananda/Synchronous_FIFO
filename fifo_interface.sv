interface fifo_intf(input clk,rstn);
  parameter DATA_W   = 128;    // Data width
  parameter DEPTH    = 1024;    // Depth of FIFO
  parameter UPP_TH   = 4;       // Upper threshold to generate Almost-full
  parameter LOW_TH   = 2 ;       // Lower threshold to generate Almost-empty

  logic i_wren,i_rden,o_full,o_empty,o_alm_full,o_alm_empty;
  logic  [DATA_W - 1 : 0] i_wrdata;
  logic  [DATA_W - 1 : 0] o_rddata;
endinterface : fifo_intf 

//driver clocking block
clocking dcb @(posedge clk)
  default input #1 output #1;
  output  i_wrdata;
  output i_wren,i_rden;
  input o_rddata;
  input o_full,o_empty,o_alm_full,o_alm_empty;
endclocking : dcb

//input monitor clocking block
clocking input_mcb @(posedge clk)
  default input #1 output #1;
  input  i_wrdata;
  input i_wren,i_rden;
endclocking : input_mcb

//output monitor clocking block
clocking output_mcb @(posedge clk)
  default input #1 output #1;
  input  o_rddata;
  input o_full,o_empty,o_alm_full,o_alm_empty;
endclocking : output_mcb

//declare modport
modport d_mp (input clk, rstn, clocking dcb);
modport in_m_mp (input clk, rstn, clocking input_mcb);
modport out_m_mp (input clk, rstn, clocking output_mcb);

  endinterface
