-- UART Transmitter in VHDL
-- Converts 8-bit parallel data to serial output with start/stop bits

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uart_tx is
  generic (
    CLKS_PER_BIT : natural := 868  -- Clock cycles per bit for desired baud rate
  );
  port (
    clk       : in  std_logic;
    reset     : in  std_logic;
    tx_start  : in  std_logic;
    tx_data   : in  std_logic_vector(7 downto 0);
    tx_serial : out std_logic;
    tx_busy   : out std_logic
  );
end uart_tx;

architecture rtl of uart_tx is
  type state_type is (IDLE, START, DATA, STOP);
  signal state         : state_type := IDLE;
  signal clk_count     : natural := 0;
  signal bit_index     : integer range 0 to 7 := 0;
  signal tx_shift      : std_logic_vector(7 downto 0) := (others => '0');
begin
  process(clk)
  begin
    if rising_edge(clk) then
      if reset = '1' then
        state     <= IDLE;
        tx_serial <= '1';  -- Idle line is high
        tx_busy   <= '0';
        clk_count <= 0;
      else
        case state is
          when IDLE =>
            tx_serial <= '1';
            tx_busy   <= '0';
            if tx_start = '1' then
              state    <= START;
              tx_shift <= tx_data;
              tx_busy  <= '1';
              clk_count <= 0;
            end if;

          when START =>
            tx_serial <= '0';  -- Start bit is low
            if clk_count < CLKS_PER_BIT - 1 then
              clk_count <= clk_count + 1;
            else
              state      <= DATA;
              clk_count  <= 0;
              bit_index  <= 0;
            end if;

          when DATA =>
            tx_serial <= tx_shift(bit_index);
            if clk_count < CLKS_PER_BIT - 1 then
              clk_count <= clk_count + 1;
            else
              clk_count <= 0;
              if bit_index < 7 then
                bit_index <= bit_index + 1;
              else
                state <= STOP;
              end if;
            end if;

          when STOP =>
            tx_serial <= '1';  -- Stop bit is high
            if clk_count < CLKS_PER_BIT - 1 then
              clk_count <= clk_count + 1;
            else
              state    <= IDLE;
              tx_busy  <= '0';
              clk_count <= 0;
            end if;
        end case;
      end if;
    end if;
  end process;
end rtl;
