-- LFSR (Linear Feedback Shift Register) in VHDL
-- Generates a pseudo-random bit sequence using XOR feedback taps.
-- This is a Fibonacci-style LFSR: new bit = XOR of selected bits + shift.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lfsr is
  generic (
    N   : integer := 4;                              -- Width of the register
    TAPS : std_logic_vector(N-1 downto 0) := "1001"  -- Tap positions (e.g., MSB and LSB)
  );
  port (
    clk    : in  std_logic;                     -- Clock signal
    reset  : in  std_logic;                     -- Active-high synchronous reset
    q      : out std_logic_vector(N-1 downto 0)  -- Current LFSR state
  );
end lfsr;

architecture rtl of lfsr is
  signal reg : std_logic_vector(N-1 downto 0);
begin
  process(clk)
    variable feedback : std_logic;
  begin
    if rising_edge(clk) then
      if reset = '1' then
        reg <= (others => '1');  -- Initialize to non-zero state
      else
        -- Compute feedback as XOR of tapped bits
        feedback := '0';
        for i in 0 to N-1 loop
          if TAPS(i) = '1' then
            feedback := feedback xor reg(i);
          end if;
        end loop;

        -- Shift right and insert feedback at MSB
        reg <= feedback & reg(N-1 downto 1);
      end if;
    end if;
  end process;

  q <= reg;  -- Output current state
end rtl;
