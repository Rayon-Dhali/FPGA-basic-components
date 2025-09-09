-- Full Adder in VHDL
-- A Full Adder adds three 1-bit binary numbers:
--   Inputs: A, B, Carry-In
--   Outputs: SUM, Carry-Out
-- Logic:
--   SUM   = A XOR B XOR Cin
--   CARRY = (A AND B) OR (Cin AND (A XOR B))

library ieee;
use ieee.std_logic_1164.all;

entity full_adder is
  port (
    i_bit1  : in  std_logic;  -- First input bit
    i_bit2  : in  std_logic;  -- Second input bit
    i_carry : in  std_logic;  -- Carry-in
    o_sum   : out std_logic;  -- Sum output
    o_carry : out std_logic   -- Carry output
  );
end full_adder;

architecture rtl of full_adder is
  -- Internal signals (used for clarity)
  signal w_WIRE_1 : std_logic;
  signal w_WIRE_2 : std_logic;
  signal w_WIRE_3 : std_logic;
begin
  -- Step 1: Partial sum
  w_WIRE_1 <= i_bit1 xor i_bit2;

  -- Step 2: Carry terms
  w_WIRE_2 <= w_WIRE_1 and i_carry;
  w_WIRE_3 <= i_bit1 and i_bit2;

  -- Final outputs
  o_sum   <= w_WIRE_1 xor i_carry;
  o_carry <= w_WIRE_2 or w_WIRE_3;

  -- Alternative compact form:
  -- o_sum   <= i_bit1 xor i_bit2 xor i_carry;
  -- o_carry <= (i_bit1 and i_bit2) or (i_carry and (i_bit1 xor i_bit2));
end rtl;
