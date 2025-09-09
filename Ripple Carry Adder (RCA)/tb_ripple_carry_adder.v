// Testbench for Ripple Carry Adder in Verilog
// Exhaustively tests all input combinations for a small N.

`timescale 1ns/1ps

module tb_ripple_carry_adder;
  parameter N = 3;
  reg [N-1:0] r_A, r_B;
  reg         r_Cin;
  wire [N-1:0] w_Sum;
  wire         w_Cout;

  ripple_carry_adder #(N) UUT (
    .i_A(r_A),
    .i_B(r_B),
    .i_Cin(r_Cin),
    .o_Sum(w_Sum),
    .o_Cout(w_Cout)
  );

  integer a, b;
  initial begin
    $display(" A   B   Cin | Sum  Cout");
    $display("-------------------------");
    for (a = 0; a < 2**N; a = a + 1) begin
      for (b = 0; b < 2**N; b = b + 1) begin
        for (r_Cin = 0; r_Cin <= 1; r_Cin = r_Cin + 1) begin
          r_A = a; r_B = b;
          #10;
          $display("%b %b  %b  | %b   %b", r_A, r_B, r_Cin, w_Sum, w_Cout);
        end
      end
    end
    $finish;
  end
endmodule
