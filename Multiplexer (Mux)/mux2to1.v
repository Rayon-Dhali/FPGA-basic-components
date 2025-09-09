// 2-to-1 Multiplexer in Verilog
// Selects between two input bits, based on sel

module mux2to1 (
  input  wire i_A,    // Input A
  input  wire i_B,    // Input B
  input  wire i_sel,  // Select: 0 → A, 1 → B
  output wire o_Z     // Output Z
);

  // Continuous assignment for combinational logic
  assign o_Z = i_sel ? i_B : i_A;

endmodule
