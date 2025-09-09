// Ripple Carry Adder in Verilog
// Adds two N-bit vectors plus carry-in using Full Adders chained.

module ripple_carry_adder #(parameter N = 4)(
  input  [N-1:0] i_A,      // First operand
  input  [N-1:0] i_B,      // Second operand
  input          i_Cin,    // Carry-in
  output [N-1:0] o_Sum,    // Resulting sum
  output         o_Cout    // Final carry-out
);
  wire [N:0] carry;        // Internal carry chain
  assign carry[0] = i_Cin;

  genvar i;
  generate
    for (i = 0; i < N; i = i + 1) begin : gen_adders
      full_adder fa (
        .i_bit1(i_A[i]),
        .i_bit2(i_B[i]),
        .i_carry(carry[i]),
        .o_sum(o_Sum[i]),
        .o_carry(carry[i+1])
      );
    end
  endgenerate

  assign o_Cout = carry[N];  // Output final carry
endmodule
