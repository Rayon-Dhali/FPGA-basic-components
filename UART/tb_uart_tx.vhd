-- Testbench for UART Transmitter in VHDL
-- Sends a character and captures serial output bits

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_uart_tx is
end tb_uart_tx;

architecture behave of tb_uart_tx is
  constant CLKS_PER_BIT : natural := 10;
  signal clk         : std_logic := '0';
  signal reset       : std_logic := '1';
  signal tx_start    : std_logic := '0';
  signal tx_data     : std_logic_vector(7 downto 0) := (others => '0');
  signal tx_serial   : std_logic;
  signal tx_busy     : std_logic;
begin
  -- Instantiate UART transmitter
  UUT: entity work.uart_tx
    generic map (CLKS_PER_BIT => CLKS_PER_BIT)
    port map (
      clk       => clk,
      reset     => reset,
      tx_start  => tx_start,
      tx_data   => tx_data,
      tx_serial => tx_serial,
      tx_busy   => tx_busy
    );

  -- Clock generation (50 MHz → 20 ns period)
  clk_process: process
  begin
    wait for 10 ns;
    clk <= not clk;
  end process;

  stimulus: process
  begin
    wait for 50 ns;
    reset <= '0';
    tx_data <= x"41";  -- ASCII 'A'
    tx_start <= '1';
    wait for 20 ns;
    tx_start <= '0';

    -- Wait through frame (start bit + 8 data bits + stop bit)
    wait for CLKS_PER_BIT * (1 + 8 + 1) * 20 ns;
    wait;
  end process;
end behave;
