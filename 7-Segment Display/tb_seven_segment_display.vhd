-- Testbench for 7-Segment Display Decoder in VHDL
-- Tests all 16 possible inputs and prints the output patterns.

library ieee;
use ieee.std_logic_1164.all;

entity tb_seven_segment_display is
end tb_seven_segment_display;

architecture behave of tb_seven_segment_display is
  signal r_nibble : std_logic_vector(3 downto 0) := "0000";
  signal w_segments : std_logic_vector(6 downto 0);
begin
  UUT: entity work.seven_segment_display
    port map (
      i_nibble  => r_nibble,
      o_segments => w_segments
    );

  process
  begin
    for i in 0 to 15 loop
      r_nibble <= std_logic_vector(to_unsigned(i, 4));
      wait for 10 ns;
      report "Input=" & integer'image(i) & " Segments=" & w_segments;
    end loop;
    wait;
  end process;
end behave;
