-- Testbench for Half Adder in VHDL
-- A testbench has no inputs/outputs (not real hardware).
-- It generates test signals and verifies the design.

library ieee;
use ieee.std_logic_1164.all;

entity half_adder_tb is
end half_adder_tb;

architecture behave of half_adder_tb is
  -- Signals to connect to the DUT (Device Under Test)
  signal r_BIT1  : std_logic := '0';
  signal r_BIT2  : std_logic := '0';
  signal w_SUM   : std_logic;
  signal w_CARRY : std_logic;
begin
  -- Instantiate the Half Adder (UUT = Unit Under Test)
  UUT : entity work.half_adder
    port map (
      i_bit1  => r_BIT1,
      i_bit2  => r_BIT2,
      o_sum   => w_SUM,
      o_carry => w_CARRY
    );

  -- Apply test cases (stimulus process)
  process
  begin
    -- Test case 1: 0 + 0 = Sum=0, Carry=0
    r_BIT1 <= '0'; r_BIT2 <= '0';
    wait for 10 ns;

    -- Test case 2: 0 + 1 = Sum=1, Carry=0
    r_BIT1 <= '0'; r_BIT2 <= '1';
    wait for 10 ns;

    -- Test case 3: 1 + 0 = Sum=1, Carry=0
    r_BIT1 <= '1'; r_BIT2 <= '0';
    wait for 10 ns;

    -- Test case 4: 1 + 1 = Sum=0, Carry=1
    r_BIT1 <= '1'; r_BIT2 <= '1';
    wait for 10 ns;

    wait; -- End simulation
  end process;
end behave;
