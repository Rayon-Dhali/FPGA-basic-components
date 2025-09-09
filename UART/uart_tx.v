// UART Transmitter in Verilog
// Converts 8-bit parallel data into serial output (start, data, stop bits)

module uart_tx
  #(parameter CLKS_PER_BIT = 868)
(
  input  wire        clk,
  input  wire        reset,
  input  wire        tx_start,
  input  wire [7:0]  tx_data,
  output reg         tx_serial,
  output reg         tx_busy
);

  localparam IDLE  = 0, START = 1, DATA = 2, STOP = 3;
  reg [1:0] state = IDLE;
  reg [9:0] clk_count = 0;
  reg [2:0] bit_index = 0;
  reg [7:0] tx_shift = 0;

  always @(posedge clk) begin
    if (reset) begin
      state      <= IDLE;
      tx_serial  <= 1'b1;
      tx_busy    <= 1'b0;
      clk_count  <= 0;
    end else begin
      case (state)
        IDLE: begin
          tx_serial <= 1'b1;
          tx_busy   <= 1'b0;
          if (tx_start) begin
            state     <= START;
            tx_shift  <= tx_data;
            tx_busy   <= 1'b1;
            clk_count <= 0;
          end
        end

        START: begin
          tx_serial <= 1'b0;
          if (clk_count < CLKS_PER_BIT-1)
            clk_count <= clk_count + 1;
          else begin
            state     <= DATA;
            clk_count <= 0;
            bit_index <= 0;
          end
        end

        DATA: begin
          tx_serial <= tx_shift[bit_index];
          if (clk_count < CLKS_PER_BIT-1)
            clk_count <= clk_count + 1;
          else begin
            clk_count <= 0;
            if (bit_index < 7)
              bit_index <= bit_index + 1;
            else
              state <= STOP;
          end
        end

        STOP: begin
          tx_serial <= 1'b1;
          if (clk_count < CLKS_PER_BIT-1)
            clk_count <= clk_count + 1;
          else begin
            state     <= IDLE;
            tx_busy   <= 1'b0;
            clk_count <= 0;
          end
        end
      endcase
    end
  end
endmodule
