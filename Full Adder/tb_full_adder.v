// Testbench for Full Adder in Verilog
// Applies all 8 input combinations and prints results.

`timescale 1ns/1ps

module tb_full_adder;

  reg  r_BIT1 = 0;   // Input A
  reg  r_BIT2 = 0;   // Input B
  reg  r_CIN  = 0;   // Carry-in
  wire w_SUM;        // Output: Sum
  wire w_CARRY;      // Output: Carry

  // Instantiate the DUT
  full_adder dut (
    .i_bit1(r_BIT1),
    .i_bit2(r_BIT2),
    .i_carry(r_CIN),
    .o_sum(w_SUM),
    .o_carry(w_CARRY)
  );

  integer i;

  initial begin
    $display(" A B Cin | SUM CARRY ");
    $display("---------------------");

    // Loop through all input combinations
    for (i = 0; i < 8; i = i + 1) begin
      {r_BIT1, r_BIT2, r_CIN} = i[2:0]; // Assign 3-bit value
      #10;
      $display(" %b %b  %b  |  %b    %b", r_BIT1, r_BIT2, r_CIN, w_SUM, w_CARRY);
    end

    $finish; // End simulation
  end

endmodule
