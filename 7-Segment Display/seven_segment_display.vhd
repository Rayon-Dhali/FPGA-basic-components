-- 7-Segment Display Decoder in VHDL
-- Converts a 4-bit hexadecimal input into 7 output signals controlling segments (a–g).

library ieee;
use ieee.std_logic_1164.all;

entity seven_segment_display is
  port (
    i_nibble : in  std_logic_vector(3 downto 0);  -- 4-bit input representing hex value (0–F)
    o_segments : out std_logic_vector(6 downto 0) -- 7 outputs for segments a to g
  );
end seven_segment_display;

architecture rtl of seven_segment_display is
begin
  -- Each when clause maps the input value to the corresponding segment pattern.
  -- A "0" turns a segment on, and "1" turns it off (common-anode style).
  process(i_nibble)
  begin
    case i_nibble is
      when "0000" => o_segments <= "0000001"; -- 0
      when "0001" => o_segments <= "1001111"; -- 1
      when "0010" => o_segments <= "0010010"; -- 2
      when "0011" => o_segments <= "0000110"; -- 3
      when "0100" => o_segments <= "1001100"; -- 4
      when "0101" => o_segments <= "0100100"; -- 5
      when "0110" => o_segments <= "0100000"; -- 6
      when "0111" => o_segments <= "0001111"; -- 7
      when "1000" => o_segments <= "0000000"; -- 8
      when "1001" => o_segments <= "0000100"; -- 9
      when "1010" => o_segments <= "0000010"; -- A
      when "1011" => o_segments <= "1100000"; -- b (lowercase)
      when "1100" => o_segments <= "0110001"; -- C
      when "1101" => o_segments <= "1000010"; -- d (lowercase)
      when "1110" => o_segments <= "0110000"; -- E
      when "1111" => o_segments <= "0111000"; -- F
      when others => o_segments <= "1111111"; -- All off (invalid input)
    end case;
  end process;
end rtl;
