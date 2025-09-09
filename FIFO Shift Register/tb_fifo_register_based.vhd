-- Testbench for Register-Based FIFO in VHDL
-- Tests FIFO behavior: write some data, then read it back.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_fifo_register_based is
end tb_fifo_register_based;

architecture behave of tb_fifo_register_based is
  constant W := 4;
  constant DEPTH := 4;
  signal clk       : std_logic := '0';
  signal rst       : std_logic := '1';
  signal wr_en     : std_logic := '0';
  signal rd_en     : std_logic := '0';
  signal din       : std_logic_vector(W-1 downto 0);
  signal dout      : std_logic_vector(W-1 downto 0);
  signal full, empty : std_logic;
  signal fill_count : natural range 0 to DEPTH;
begin
  UUT: entity work.fifo_register_based
    generic map (W => W, DEPTH => DEPTH)
    port map (
      clk        => clk,
      rst        => rst,
      wr_en      => wr_en,
      rd_en      => rd_en,
      din        => din,
      dout       => dout,
      full       => full,
      empty      => empty,
      fill_count => fill_count
    );

  -- Clock generation
  clk_process: process
  begin
    wait for 5 ns; clk <= not clk;
    if now > 200 ns then wait; end if;
  end process;

  stimulus: process
  begin
    wait for 12 ns; rst <= '0';

    -- Write values 1..5 (one more than depth) to test full
    for i in 1 to DEPTH+1 loop
      wr_en <= '1'; din <= std_logic_vector(to_unsigned(i, W));
      wait for 10 ns;
    end loop;
    wr_en <= '0';

    -- Read everything
    for i in 1 to DEPTH+1 loop
      rd_en <= '1';
      wait for 10 ns;
    end loop;
    rd_en <= '0';

    wait;
  end process;
end behave;
