// Full Adder in Verilog
// Adds 3 input bits: A, B, and Carry-In
// Outputs: SUM and Carry-Out
// Logic:
//   SUM   = A ^ B ^ Cin
//   CARRY = (A & B) | (Cin & (A ^ B))

module full_adder (
   input  wire i_bit1,   // First input
   input  wire i_bit2,   // Second input
   input  wire i_carry,  // Carry-in
   output wire o_sum,    // Sum output
   output wire o_carry   // Carry output
);

  // Internal wires for clarity
  wire w_WIRE_1, w_WIRE_2, w_WIRE_3;

  // Step 1: Partial sum
  assign w_WIRE_1 = i_bit1 ^ i_bit2;

  // Step 2: Carry terms
  assign w_WIRE_2 = w_WIRE_1 & i_carry;
  assign w_WIRE_3 = i_bit1 & i_bit2;

  // Final outputs
  assign o_sum   = w_WIRE_1 ^ i_carry;
  assign o_carry = w_WIRE_2 | w_WIRE_3;

  // Alternative compact form:
  // assign o_sum   = i_bit1 ^ i_bit2 ^ i_carry;
  // assign o_carry = (i_bit1 & i_bit2) | (i_carry & (i_bit1 ^ i_bit2));

endmodule
