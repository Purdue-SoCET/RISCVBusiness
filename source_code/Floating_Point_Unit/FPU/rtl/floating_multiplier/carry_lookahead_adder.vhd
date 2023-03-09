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


entity carry_lookahead_adder is
generic(
  data_width       : integer  := 16
);
port(
  i_input_data1    : in  std_logic_vector(data_width-1 downto 0);
  i_input_data2    : in  std_logic_vector(data_width-1 downto 0);
  o_sum_data       : out std_logic_vector(data_width downto 0)
);
end entity carry_lookahead_adder;

architecture behavioral of carry_lookahead_adder is


---------------------------------------------------------------------------------
-- component instatiaton of 4-bit carry_lookahead_adder
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
constant data_multple_4  : integer := (data_width - 4*(data_width/4));

--- internal signal creation
signal s_carry         : std_logic_vector(data_width/4 downto 0);
signal s_sum_data      : std_logic_vector(data_width-1 downto 0);
signal s_data_width    : std_logic_vector(8 downto 0);
signal s_cla_data_in1  : std_logic_vector(3 downto 0) := "0000";
signal s_cla_data_in2  : std_logic_vector(3 downto 0) := "0000";
signal s_sum_last_data : std_logic_vector(3 downto 0);

begin

s_carry(0)       <= '0';
s_data_width     <= std_logic_vector(to_unsigned(data_width,9));
---------------------------------------------------------------------------------
-- component instatiaion of 4-bit carry_lookahead_adder for every 4 bit inputs
---------------------------------------------------------------------------------
cla_four_bit_gen : for i in 0 to (data_width/4-1) generate
inst_cla_four_bit : cla_four_bit
port map(
  i_input_data1    => i_input_data1((i+1)*4-1 downto i*4),
  i_input_data2    => i_input_data2((i+1)*4-1 downto i*4),
  i_carry_in       => s_carry(i),
  o_sum_data       => s_sum_data((i+1)*4-1 downto i*4),
  o_carry_out      => s_carry(i+1)
);
end generate cla_four_bit_gen;


---------------------------------------------------------------------------------
-- component instatiaion of  full adder if data_width is not multiple of 
-- 4
---------------------------------------------------------------------------------
cla_last_stage : if(data_multple_4 /= 0 ) generate 
s_cla_data_in1 <= (3 downto data_multple_4 => i_input_data1(data_width-1)) & i_input_data1(data_width-1 downto  data_width-data_multple_4);
s_cla_data_in2 <= (3 downto data_multple_4 => i_input_data2(data_width-1)) & i_input_data2(data_width-1 downto  data_width-data_multple_4);

inst_cla_four_bit_last : cla_four_bit
port map(
  i_input_data1    => s_cla_data_in1,
  i_input_data2    => s_cla_data_in2,
  i_carry_in       => s_carry(data_width/4),
  o_sum_data       => s_sum_last_data,
  o_carry_out      => open
);

o_sum_data <= s_sum_last_data(data_multple_4 downto 0) & s_sum_data(data_width-data_multple_4-1 downto 0);

end generate cla_last_stage;


---------------------------------------------------------------------------------
-- output sum data generation with s_sum_data and final carry data
---------------------------------------------------------------------------------
cla_last_stage_true : if(data_multple_4 = 0 ) generate 

o_sum_data      <= s_carry(data_width/4) & s_sum_data;

end generate cla_last_stage_true;



end architecture behavioral;



