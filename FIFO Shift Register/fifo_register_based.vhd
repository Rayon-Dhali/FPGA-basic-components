-- Register-Based FIFO in VHDL
-- A synchronous FIFO using registers, head/tail pointers, and flags.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fifo_register_based is
  generic (
    W : natural := 8;  -- Data width (bits per entry)
    DEPTH : natural := 4  -- Number of FIFO slots
  );
  port (
    clk     : in  std_logic;
    rst     : in  std_logic;  -- Synchronous reset
    wr_en   : in  std_logic;  -- Write enable (push data)
    rd_en   : in  std_logic;  -- Read enable (pop data)
    din     : in  std_logic_vector(W-1 downto 0);  -- Input data
    dout    : out std_logic_vector(W-1 downto 0);  -- Output data
    full    : out std_logic;
    empty   : out std_logic;
    fill_count : out natural range 0 to DEPTH
  );
end fifo_register_based;

architecture rtl of fifo_register_based is
  type ram_type is array (0 to DEPTH-1) of std_logic_vector(W-1 downto 0);
  signal ram          : ram_type := (others => (others => '0'));
  signal head, tail   : natural range 0 to DEPTH-1 := 0;
  signal count        : natural range 0 to DEPTH := 0;
begin
  -- Output flags
  full  <= '1' when count = DEPTH else '0';
  empty <= '1' when count = 0 else '0';
  fill_count <= count;

  process(clk)
  begin
    if rising_edge(clk) then
      if rst = '1' then
        head  <= 0;
        tail  <= 0;
        count <= 0;
        dout  <= (others => '0');
      else
        -- Write logic (if not full)
        if wr_en = '1' and full = '0' then
          ram(head) <= din;
          head <= (head + 1) mod DEPTH;
          count <= count + 1;
        end if;

        -- Read logic (if not empty)
        if rd_en = '1' and empty = '0' then
          dout <= ram(tail);
          tail <= (tail + 1) mod DEPTH;
          count <= count - 1;
        end if;
      end if;
    end if;
  end process;
end rtl;
