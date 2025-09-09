// Register-Based FIFO in Verilog
// Synchronous FIFO with register array, head/tail pointers, count, full/empty flags.

module fifo_register_based #(
  parameter W = 8,       // Data width
  parameter DEPTH = 4    // FIFO depth
)(
  input  wire clk,
  input  wire rst,
  input  wire wr_en,
  input  wire rd_en,
  input  wire [W-1:0] din,
  output reg  [W-1:0] dout,
  output wire full,
  output wire empty,
  output reg  [$clog2(DEPTH+1)-1:0] fill_count
);

  reg [W-1:0] ram [0:DEPTH-1];
  reg [$clog2(DEPTH)-1:0] head = 0, tail = 0;

  assign full  = (fill_count == DEPTH);
  assign empty = (fill_count == 0);

  always @(posedge clk) begin
    if (rst) begin
      head <= 0; tail <= 0;
      fill_count <= 0;
      dout <= 0;
    end else begin
      if (wr_en && !full) begin
        ram[head] <= din;
        head <= head + 1;
        fill_count <= fill_count + 1;
      end
      if (rd_en && !empty) begin
        dout <= ram[tail];
        tail <= tail + 1;
        fill_count <= fill_count - 1;
      end
    end
  end
endmodule
