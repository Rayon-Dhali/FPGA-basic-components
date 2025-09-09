// Testbench for LFSR in Verilog
// Prints LFSR state after each clock cycle.

`timescale 1ns/1ps

module tb_lfsr;
  parameter N = 4;
  reg clk = 0;
  reg reset = 1;
  wire [N-1:0] q;

  // Instantiate the LFSR
  lfsr #(.N(N), .TAPS(4'b1001)) uut (
    .clk(clk),
    .reset(reset),
    .q(q)
  );

  // Clock generation
  always #5 clk = ~clk;

  initial begin
    #12 reset = 0;
    $display(" Cycle | LFSR State ");
    $display("------------------");
    repeat (10) begin
      @(posedge clk);
      $display("   %0d   | %b", $time/10, q);
    end
    $finish;
  end
endmodule
