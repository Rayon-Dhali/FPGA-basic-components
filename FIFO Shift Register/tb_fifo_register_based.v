// Testbench for Register-Based FIFO in Verilog
// Writes past capacity to test full flag, then reads all to test empty flag.

`timescale 1ns/1ps
module tb_fifo_register_based;
  parameter W = 4;
  parameter DEPTH = 4;

  reg clk = 0, rst = 1;
  reg wr_en = 0, rd_en = 0;
  reg [W-1:0] din;
  wire [W-1:0] dout;
  wire full, empty;
  wire [$clog2(DEPTH+1)-1:0] fill_count;

  fifo_register_based #(.W(W), .DEPTH(DEPTH)) UUT (
    .clk(clk), .rst(rst), .wr_en(wr_en), .rd_en(rd_en), .din(din),
    .dout(dout), .full(full), .empty(empty), .fill_count(fill_count)
  );

  always #5 clk = ~clk;

  initial begin
    #12 rst = 0;
    $display("Time | wr_en rd_en din | full empty count dout");
    for (int i=1; i<=DEPTH+1; i++) begin
      wr_en = 1; din = i;
      #10;
      $display("%4d  |   %b     %b    %0d |   %b    %b     %0d    %0d",
        $time, wr_en, rd_en, din, full, empty, fill_count, dout);
    end
    wr_en = 0;
    for (int i=1; i<=DEPTH+1; i++) begin
      rd_en = 1;
      #10;
      $display("%4d  |   %b     %b    -- |   %b    %b     %0d    %0d",
        $time, wr_en, rd_en, full, empty, fill_count, dout);
    end
    $finish;
  end
endmodule
