-------------------------------------------------------------------------------
--  This module implements the carry look ahead adder implemented using 4 bit cla
--  component. This module reduces the propagation delay of the full adder circuity
--  This module is scalable based on the data_width configuration
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;


entity mul_post_addder is
port(
  i_input_data1    : in  std_logic_vector(25 downto 0);
  i_input_data2    : in  std_logic_vector(25 downto 0);
  o_sum_data       : out std_logic_vector(26 downto 0)
);
end entity mul_post_addder;

architecture behavioral of mul_post_addder is

component half_adder is
port(
  i_input_data1  : in  std_logic; 
  i_input_data2  : in  std_logic;
  o_sum_data     : out std_logic;
  o_carry_out    : out std_logic
  );
end component half_adder;  
---------------------------------------------------------------------------------
-- component instatiaton of 4-bit carry_lookahead_sub
---------------------------------------------------------------------------------
component cla_four_bit
port(
  i_input_data1       : in std_logic_vector(3 downto 0);
  i_input_data2       : in std_logic_vector(3 downto 0);
  i_carry_in          : in std_logic;
  o_sum_data          : out std_logic_vector(3 downto 0);
  o_carry_out         : out std_logic
);
end component cla_four_bit;
-- costant which checks for multiple four

--- internal signal creation
signal s_carry         : std_logic_vector(3 downto 0);
signal s_sum_data      : std_logic_vector(26 downto 0);
signal s_data_width    : std_logic_vector(8 downto 0);
signal s_cla_data_in1  : std_logic_vector(3 downto 0) := "0000";
signal s_cla_data_in2  : std_logic_vector(3 downto 0) := "0000";
signal s_sum_last_data : std_logic_vector(3 downto 0);
signal s_sum_cla_fa    : std_logic_vector(11 downto 0);
signal s_ha_inputdata1 : std_logic_vector(13 downto 0);
signal s_carry_ha_array: std_logic_vector(14 downto 0);
signal s_sum_ha_array  : std_logic_vector(13 downto 0);
begin

s_carry(0)       <= '0';
---------------------------------------------------------------------------------
-- component instatiaion of 4-bit carry_lookahead_adder for every 4 bit inputs
---------------------------------------------------------------------------------
cla_four_bit_gen : for i in 0 to 2 generate
inst_cla_four_bit : cla_four_bit
port map(
  i_input_data1    => i_input_data1((i+1)*4-1 downto i*4),
  i_input_data2    => i_input_data2((i+1)*4-1 downto i*4),
  i_carry_in       => s_carry(i),
  o_sum_data       => s_sum_cla_fa((i+1)*4-1 downto i*4),
  o_carry_out      => s_carry(i+1)
);
end generate cla_four_bit_gen;

s_sum_data(11 downto 0)  <= s_sum_cla_fa;
s_sum_data(26 downto 12) <= s_carry_ha_array(14) & s_sum_ha_array;
s_ha_inputdata1          <= i_input_data1(25 downto 12);
s_carry_ha_array(0)      <= s_carry(3);

ha_array_gen : for i in 0 to 13 generate
inst_ha_array : half_adder
port map(
  i_input_data1  => s_ha_inputdata1(i),
  i_input_data2  => s_carry_ha_array(i),
  o_sum_data     => s_sum_ha_array(i),
  o_carry_out    => s_carry_ha_array(i+1)
  );
end generate ha_array_gen; 


o_sum_data               <= s_sum_data;



end architecture behavioral;



