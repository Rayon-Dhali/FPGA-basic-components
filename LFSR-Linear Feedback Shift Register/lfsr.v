// LFSR (Linear Feedback Shift Register) in Verilog
// Fibonacci-style: input bit = XOR of selected taps, shift right.

module lfsr #(
  parameter N = 4,
  parameter [N-1:0] TAPS = 4'b1001  // Tap positions (e.g., MSB and LSB)
)(
  input wire clk,
  input wire reset,             // Active-high synchronous reset
  output reg [N-1:0] q          // Current LFSR state
);

  integer i;
  reg feedback;

  always @(posedge clk) begin
    if (reset) begin
      q <= {N{1'b1}};  // Non-zero initial state
    end else begin
      feedback = 0;
      for (i = 0; i < N; i = i + 1)
        if (TAPS[i])
          feedback = feedback ^ q[i];
      q <= {feedback, q[N-1:1]};  // Shift right, insert feedback
    end
  end
endmodule
