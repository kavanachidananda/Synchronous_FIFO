module SYN_FIFO #(
  parameter DATA_W   = 128,     // Data width
  parameter DEPTH    = 1024,    // Depth of FIFO
  parameter UPP_TH   = 4,       // Upper threshold to generate Almost-full
  parameter LOW_TH   = 2        // Lower threshold to generate Almost-empty
)(
  input                   clk,         // Clock
  input                   rstn,        // Active-low Synchronous Reset
  input                   i_wren,      // Write Enable
  input  [DATA_W - 1 : 0] i_wrdata,    // Write-data
  output                  o_alm_full,  // Almost-full signal
  output                  o_full,      // Full signal
  input                   i_rden,      // Read Enable
  output [DATA_W - 1 : 0] o_rddata,    // Read-data
  output                  o_alm_empty, // Almost-empty signal
  output                  o_empty      // Empty signal
);


  
  reg [DATA_W - 1:0] fifo [0:DEPTH-1]; // FIFO storage
  reg [DATA_W - 1:0] o_rddata_reg;     // Output data register
  reg [10:0]          count;            // FIFO count
  wire                read_ptr_inc;     // Read pointer increment
  wire                write_ptr_inc;    // Write pointer increment

  // Almost-full and full conditions
  assign o_alm_full = (count >= DEPTH - UPP_TH && count!=DEPTH);
  assign o_full = (count == DEPTH);

  // Almost-empty and empty conditions
  assign o_alm_empty = (count <= LOW_TH && count!=0);
  assign o_empty = (count == 0);

  // Write pointer logic
  always @(posedge clk or negedge rstn) begin
    if (!rstn)
      count <= 0;
    else if (i_wren && !o_full)
      count <= count + 1;
  end

  // Read pointer logic
  always @(posedge clk or negedge rstn) begin
    if (!rstn)
      o_rddata_reg <= 0;
    else if (i_rden && !o_empty)
      o_rddata_reg <= fifo[count - 1];
  end

  // FIFO write logic
  always @(posedge clk or negedge rstn) begin
    if (!rstn)
      fifo <= '{DEFAULT:DATA_W{1'b0}};
    else if (i_wren && !o_full)
      fifo[write_ptr_inc ? count : count - 1] <= i_wrdata;
  end
 // FIFO read logic 
  always @(posedge clk or negedge rstn) begin
    if (!rstn)
      read_ptr_inc <= 1'b0;
    else if (i_rden && !o_empty)
      read_ptr_inc <= ~read_ptr_inc;
  end

  // Write and read pointers
  always @(posedge clk or negedge rstn) begin
    if (!rstn)
      write_ptr_inc <= 1'b0;
    else if (i_wren && !o_full)
      write_ptr_inc <= ~write_ptr_inc;
  end

  // Output data assignment
  always @(posedge clk) begin
    if (read_ptr_inc)
      o_rddata <= o_rddata_reg;
  end

endmodule
