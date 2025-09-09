// Testbench for 2-to-1 MUX in Verilog
// Iterates through all inputs and prints results

`timescale 1ns/1ps

module tb_mux2to1;

  reg r_A, r_B, r_SEL;
  wire w_Z;

  // Instantiate the DUT
  mux2to1 dut (
    .i_A(r_A),
    .i_B(r_B),
    .i_sel(r_SEL),
    .o_Z(w_Z)
  );

  initial begin
    $display("A B SEL | Z");
    $display("--------|--");

    // Test all combinations
    r_A = 0; r_B = 0; r_SEL = 0; #10; $display("%b %b   %b  | %b", r_A, r_B, r_SEL, w_Z);
    r_SEL = 1; #10;       $display("%b %b   %b  | %b", r_A, r_B, r_SEL, w_Z);

    r_A = 0; r_B = 1; r_SEL = 0; #10; $display("%b %b   %b  | %b", r_A, r_B, r_SEL, w_Z);
    r_SEL = 1; #10;       $display("%b %b   %b  | %b", r_A, r_B, r_SEL, w_Z);

    r_A = 1; r_B = 0; r_SEL = 0; #10; $display("%b %b   %b  | %b", r_A, r_B, r_SEL, w_Z);
    r_SEL = 1; #10;       $display("%b %b   %b  | %b", r_A, r_B, r_SEL, w_Z);

    r_A = 1; r_B = 1; r_SEL = 0; #10; $display("%b %b   %b  | %b", r_A, r_B, r_SEL, w_Z);
    r_SEL = 1; #10;       $display("%b %b   %b  | %b", r_A, r_B, r_SEL, w_Z);

    $finish;
  end

endmodule
