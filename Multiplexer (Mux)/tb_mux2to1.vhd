-- Testbench for 2-to-1 MUX in VHDL
-- Applies all input combinations and verifies output

library ieee;
use ieee.std_logic_1164.all;

entity tb_mux2to1 is
end entity;

architecture behave of tb_mux2to1 is
  signal r_A   : std_logic := '0';
  signal r_B   : std_logic := '0';
  signal r_SEL : std_logic := '0';
  signal w_Z   : std_logic;
begin
  -- Instantiate DUT
  UUT: entity work.mux2to1
    port map (
      i_A   => r_A,
      i_B   => r_B,
      i_sel => r_SEL,
      o_Z   => w_Z
    );

  -- Stimulus process: test all 4 possible input combos
  process
  begin
    -- A=0, B=0
    r_A <= '0'; r_B <= '0'; r_SEL <= '0'; wait for 10 ns;
    r_SEL <= '1'; wait for 10 ns;

    -- A=0, B=1
    r_A <= '0'; r_B <= '1'; r_SEL <= '0'; wait for 10 ns;
    r_SEL <= '1'; wait for 10 ns;

    -- A=1, B=0
    r_A <= '1'; r_B <= '0'; r_SEL <= '0'; wait for 10 ns;
    r_SEL <= '1'; wait for 10 ns;

    -- A=1, B=1
    r_A <= '1'; r_B <= '1'; r_SEL <= '0'; wait for 10 ns;
    r_SEL <= '1'; wait for 10 ns;

    wait;  -- End simulation
  end process;
end architecture;
