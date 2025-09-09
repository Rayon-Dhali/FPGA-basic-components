-- Testbench for Full Adder in VHDL
-- Applies all 8 input combinations (A, B, Cin)
-- and observes the Sum and Carry outputs.

library ieee;
use ieee.std_logic_1164.all;

entity full_adder_tb is
end full_adder_tb;

architecture behave of full_adder_tb is
  signal r_BIT1  : std_logic := '0';
  signal r_BIT2  : std_logic := '0';
  signal r_CIN   : std_logic := '0';
  signal w_SUM   : std_logic;
  signal w_CARRY : std_logic;
begin
  -- Instantiate the DUT (Device Under Test)
  UUT : entity work.full_adder
    port map (
      i_bit1  => r_BIT1,
      i_bit2  => r_BIT2,
      i_carry => r_CIN,
      o_sum   => w_SUM,
      o_carry => w_CARRY
    );

  -- Apply test cases
  process
  begin
    -- Loop through all 8 possible inputs
    for i in 0 to 7 loop
      r_BIT1 <= std_logic'val((i/4) mod 2); -- MSB
      r_BIT2 <= std_logic'val((i/2) mod 2); -- Middle bit
      r_CIN  <= std_logic'val(i mod 2);     -- LSB
      wait for 10 ns;
    end loop;
    wait;
  end process;
end behave;
