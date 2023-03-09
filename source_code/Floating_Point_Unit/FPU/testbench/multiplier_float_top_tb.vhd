
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.numeric_std.all;

entity multiplier_float_top_tb is
end entity multiplier_float_top_tb;


architecture behavioral of multiplier_float_top_tb is
------------------------------------------------------------------------
-- Component declaration of multiplier_float_top 
------------------------------------------------------------------------
component multiplier_float_top
port(
  i_clk                : in  std_logic;
  i_rst                : in  std_logic;
  i_start              : in  std_logic;
  i_multiplicand       : in  std_logic_vector(31 downto 0);
  i_multiplier         : in  std_logic_vector(31 downto 0);
  o_done               : out std_logic;
  o_product            : out std_logic_vector(31 downto 0);
  o_ovrflow            : out std_logic;
  o_undrflow           : out std_logic
);
end component multiplier_float_top;

signal s_clk           : std_logic := '1';
signal s_rst           : std_logic := '1';
signal s_start         : std_logic := '0';
signal s_multiplicand  : std_logic_vector(31 downto 0) := X"bdfcd35b";
signal s_multiplier    : std_logic_vector(31 downto 0) := X"461c407e";
signal s_done          : std_logic;
signal s_product       : std_logic_vector(31 downto 0);
signal s_ovrflow       : std_logic;
signal s_undrflow      : std_logic;
signal time_period     : time := 10 ns;

begin

------------------------------------------------------------------------
-- Component instantiation of multiplier_float_top
------------------------------------------------------------------------
inst_float_multiplier : multiplier_float_top
port map(
  i_clk           => s_clk,        
  i_rst           => s_rst, 
  i_start         => s_start, 
  i_multiplicand  => s_multiplicand, 
  i_multiplier    => s_multiplier, 
  o_done          => s_done, 
  o_product       => s_product, 
  o_ovrflow       => s_ovrflow, 
  o_undrflow      => s_undrflow     
);

------------------------------------------------------------------------
-- clock signal generation
------------------------------------------------------------------------
s_clk_proc : process
begin
wait for (time_period/2);
  s_clk   <= '0';
wait for (time_period/2);
  s_clk   <= '1';
end process s_clk_proc;

------------------------------------------------------------------------
-- s_rst,s_start, s_multiplier, s_multiplicand signal creation
-----------------------------------------------------------------------

s_signal_proc : process 
begin
  wait for (10*time_period);
  s_rst <= '0';
  wait for (time_period*8);
  s_multiplicand  <= X"3f4ccccd";
  s_multiplier    <= X"bfd9999a";
  s_start         <= '1';
  wait for (time_period*1);
  s_start         <= '0';  
  wait for (time_period*8);
  s_multiplicand  <= X"c36a2000";
  s_multiplier    <= X"c59c419a";
  s_start         <= '1';
  wait for (time_period*1);
  s_start         <= '0';    
  wait for (time_period*8);
  s_multiplicand  <= X"436a2000";
  s_multiplier    <= X"459c419a";
  s_start         <= '1';
  wait for (time_period*1);
  s_start         <= '0';    
  wait for (time_period*8);
  s_multiplicand  <= X"bdfcd35b";
  s_multiplier    <= X"461c407e";
  s_start         <= '1';
  wait for (time_period*12);
  s_start         <= '0';    
  wait for (time_period*8);
  s_multiplicand  <= X"42707e6a";
  s_multiplier    <= X"42700000";
  s_start         <= '1';
  wait for (time_period*1);
  s_start         <= '0';    
  wait;
end process s_signal_proc; 








end architecture behavioral;