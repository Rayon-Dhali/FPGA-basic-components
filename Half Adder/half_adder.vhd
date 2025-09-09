-- Half Adder in VHDL
-- A Half Adder adds two 1-bit binary numbers.
-- It produces two outputs:
--   SUM   = A XOR B
--   CARRY = A AND B

library ieee;
use ieee.std_logic_1164.all;

-- Define the entity (interface of the circuit)
entity half_adder is
  port (
    i_bit1  : in  std_logic;  -- First input bit
    i_bit2  : in  std_logic;  -- Second input bit
    o_sum   : out std_logic;  -- Sum output
    o_carry : out std_logic   -- Carry output
  );
end half_adder;

-- Define the architecture (implementation of logic)
architecture rtl of half_adder is
begin
  -- Logic equations for Half Adder
  o_sum   <= i_bit1 xor i_bit2;  -- Sum = XOR
  o_carry <= i_bit1 and i_bit2;  -- Carry = AND
end rtl;
