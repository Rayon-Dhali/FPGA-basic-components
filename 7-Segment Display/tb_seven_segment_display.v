// Testbench for 7-Segment Display Decoder in Verilog
// Iterates through all input values and prints output.

`timescale 1ns/1ps

module tb_seven_segment_display;
  reg [3:0] r_nibble = 4'b0000;
  wire [6:0] w_segments;

  seven_segment_display dut (
    .i_nibble(r_nibble),
    .o_segments(w_segments)
  );

  initial begin
    $display("Nibble | Segments(a-g)");
    $display("----------------------");
    for (integer i = 0; i < 16; i = i + 1) begin
      r_nibble = i;
      #10;
      $display("   %h   |  %b", r_nibble, w_segments);
    end
    $finish;
  end
endmodule
