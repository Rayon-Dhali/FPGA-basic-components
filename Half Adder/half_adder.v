// Half Adder in Verilog
// Adds two 1-bit binary numbers
// Outputs: SUM (XOR), CARRY (AND)

module half_adder (
   input  wire i_bit1,   // First input bit
   input  wire i_bit2,   // Second input bit
   output wire o_sum,    // Sum output
   output wire o_carry   // Carry output
);

  // Logic equations
  assign o_sum   = i_bit1 ^ i_bit2;  // XOR for Sum
  assign o_carry = i_bit1 & i_bit2;  // AND for Carry

endmodule
