// Testbench for Half Adder in Verilog
// Generates inputs and observes outputs

`timescale 1ns/1ps

module tb_half_adder;

  reg  r_BIT1 = 0;  // Input stimulus A
  reg  r_BIT2 = 0;  // Input stimulus B
  wire w_SUM;       // Output: Sum
  wire w_CARRY;     // Output: Carry

  // Instantiate the DUT (Device Under Test)
  half_adder dut (
    .i_bit1(r_BIT1),
    .i_bit2(r_BIT2),
    .o_sum(w_SUM),
    .o_carry(w_CARRY)
  );

  initial begin
    // Apply test cases
    $display(" A B | SUM CARRY ");
    $display("---------------");

    r_BIT1 = 0; r_BIT2 = 0; #10;
    $display(" %b %b |  %b    %b", r_BIT1, r_BIT2, w_SUM, w_CARRY);

    r_BIT1 = 0; r_BIT2 = 1; #10;
    $display(" %b %b |  %b    %b", r_BIT1, r_BIT2, w_SUM, w_CARRY);

    r_BIT1 = 1; r_BIT2 = 0; #10;
    $display(" %b %b |  %b    %b", r_BIT1, r_BIT2, w_SUM, w_CARRY);

    r_BIT1 = 1; r_BIT2 = 1; #10;
    $display(" %b %b |  %b    %b", r_BIT1, r_BIT2, w_SUM, w_CARRY);

    $finish; // End simulation
  end

endmodule
