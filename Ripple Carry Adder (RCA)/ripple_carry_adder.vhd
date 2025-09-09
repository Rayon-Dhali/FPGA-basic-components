-- Ripple Carry Adder in VHDL
-- Adds two N-bit numbers with an input carry
-- Modules used: N cascading Full Adders

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ripple_carry_adder is
  generic (
    N : integer := 4  -- Bit-width, default 4 bits
  );
  port (
    i_A     : in  std_logic_vector(N-1 downto 0);  -- First input
    i_B     : in  std_logic_vector(N-1 downto 0);  -- Second input
    i_Cin   : in  std_logic;                       -- Carry-in
    o_Sum   : out std_logic_vector(N-1 downto 0);  -- Sum output
    o_Cout  : out std_logic                        -- Final carry-out
  );
end ripple_carry_adder;

architecture rtl of ripple_carry_adder is
  signal carry : std_logic_vector(N downto 0);
begin
  carry(0) <= i_Cin;  -- Initial carry-in
  -- Connect N full adders
  gen_adders: for i in 0 to N-1 generate
    full: entity work.full_adder
      port map (
        i_bit1  => i_A(i),
        i_bit2  => i_B(i),
        i_carry => carry(i),
        o_sum   => o_Sum(i),
        o_carry => carry(i+1)
      );
  end generate gen_adders;
  o_Cout <= carry(N);  -- Final carry-out
end rtl;
