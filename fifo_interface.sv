interface intf;
  logic clk,rstn,i_wren,i_rden,o_full,o_empty,o_alm_full,o_alm_empty;
  logic  [DATA_W - 1 : 0] i_wrdata;
  logic  [DATA_W - 1 : 0] o_rddata;
endinterface : intf
