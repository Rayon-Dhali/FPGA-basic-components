-- 2-to-1 Multiplexer in VHDL
-- Selects between two 1-bit inputs based on the select line

library ieee;
use ieee.std_logic_1164.all;

entity mux2to1 is
  port (
    i_A   : in  std_logic;  -- Input A
    i_B   : in  std_logic;  -- Input B
    i_sel : in  std_logic;  -- Select: 0 → choose A, 1 → choose B
    o_Z   : out std_logic   -- Output Z
  );
end mux2to1;

architecture rtl of mux2to1 is
begin
  -- Concurrent conditional assignment: simple and clear
  o_Z <= i_A when i_sel = '0' else i_B;
end rtl;
