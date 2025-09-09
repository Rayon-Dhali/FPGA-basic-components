-- Testbench for Ripple Carry Adder in VHDL
-- Tests all combinations for a small N (e.g., 3-bit adder)

library ieee;
use ieee.std_logic_1164.all;

entity tb_ripple_carry_adder is
end tb_ripple_carry_adder;

architecture behave of tb_ripple_carry_adder is
  constant N       : integer := 3;
  signal r_A       : std_logic_vector(N-1 downto 0) := (others => '0');
  signal r_B       : std_logic_vector(N-1 downto 0) := (others => '0');
  signal r_Cin     : std_logic := '0';
  signal w_Sum     : std_logic_vector(N-1 downto 0);
  signal w_Cout    : std_logic;
begin
  UUT: entity work.ripple_carry_adder
    generic map (N => N)
    port map (
      i_A    => r_A,
      i_B    => r_B,
      i_Cin  => r_Cin,
      o_Sum  => w_Sum,
      o_Cout => w_Cout
    );

  process
  begin
    for a in 0 to 2**N - 1 loop
      for b in 0 to 2**N - 1 loop
        for c in 0 to 1 loop
          r_A   <= std_logic_vector(to_unsigned(a, N));
          r_B   <= std_logic_vector(to_unsigned(b, N));
          r_Cin <= std_logic'val(c);
          wait for 10 ns;
        end loop;
      end loop;
    end loop;
    wait;
  end process;
end behave;
