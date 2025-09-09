-- Testbench for LFSR in VHDL
-- Drives clock and prints the LFSR state for several cycles.

library ieee;
use ieee.std_logic_1164.all;

entity tb_lfsr is
end tb_lfsr;

architecture behave of tb_lfsr is
  constant N : integer := 4;
  signal clk    : std_logic := '0';
  signal reset  : std_logic := '1';
  signal q      : std_logic_vector(N-1 downto 0);
begin
  uut: entity work.lfsr
    generic map (N => N, TAPS => "1001")  -- taps on bit 3 and bit 0
    port map (
      clk => clk, reset => reset, q => q
    );

  -- Clock generation
  clk_process: process
  begin
    wait for 5 ns;
    clk <= not clk;
    if now > 100 ns then
      wait;
    end if;
  end process;

  -- Stimulus
  stimulus: process
  begin
    wait for 12 ns;
    reset <= '0';  -- Release reset
    repeat 10 loop
      wait until rising_edge(clk);
      report "LFSR state: " & q;
    end loop;
    wait;
  end process;
end behave;
