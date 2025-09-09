// 7-Segment Display Decoder in Verilog
// Maps 4-bit hexadecimal input to 7 segment control outputs.

module seven_segment_display (
  input  [3:0] i_nibble,     // 4-bit input (0–F)
  output reg [6:0] o_segments // 7-bit segment output (a–g)
);

  always @(*) begin
    case (i_nibble)
      4'h0: o_segments = 7'b0000001; // 0
      4'h1: o_segments = 7'b1001111; // 1
      4'h2: o_segments = 7'b0010010; // 2
      4'h3: o_segments = 7'b0000110; // 3
      4'h4: o_segments = 7'b1001100; // 4
      4'h5: o_segments = 7'b0100100; // 5
      4'h6: o_segments = 7'b0100000; // 6
      4'h7: o_segments = 7'b0001111; // 7
      4'h8: o_segments = 7'b0000000; // 8
      4'h9: o_segments = 7'b0000100; // 9
      4'hA: o_segments = 7'b0000010; // A
      4'hB: o_segments = 7'b1100000; // b
      4'hC: o_segments = 7'b0110001; // C
      4'hD: o_segments = 7'b1000010; // d
      4'hE: o_segments = 7'b0110000; // E
      4'hF: o_segments = 7'b0111000; // F
      default: o_segments = 7'b1111111; // All off
    endcase
  end

endmodule
