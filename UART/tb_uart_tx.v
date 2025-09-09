// Testbench for UART Transmitter in Verilog
// Drives one character and prints the serial line behavior

`timescale 1ns/1ps

module tb_uart_tx;
  parameter CLKS_PER_BIT = 10;
  reg clk = 0;
  reg reset = 1;
  reg tx_start = 0;
  reg [7:0] tx_data = 0;
  wire tx_serial;
  wire tx_busy;

  uart_tx #(.CLKS_PER_BIT(CLKS_PER_BIT)) uut (
    .clk(clk),
    .reset(reset),
    .tx_start(tx_start),
    .tx_data(tx_data),
    .tx_serial(tx_serial),
    .tx_busy(tx_busy)
  );

  always #10 clk = ~clk;

  initial begin
    #50 reset = 0;
    tx_data  = 8'h41;  // ASCII 'A'
    tx_start = 1;
    #20 tx_start = 0;
    
    // Wait for one frame to send
    #((1 + 8 + 1) * CLKS_PER_BIT * 20);
    $finish;
  end
endmodule
