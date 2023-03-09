-------------------------------------------------------------------------------
--  Full adder code for addition of two input bits and carry in
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;


entity full_adder is
port(
  i_input_data1  : in  std_logic; 
  i_input_data2  : in  std_logic;
  i_carry_in     : in  std_logic;  
  o_sum_data     : out std_logic;
  o_carry_out    : out std_logic
  );
end entity full_adder;  

architecture arch_full_addr of full_adder is
signal s_sum_data_ha  : std_logic; 
signal s_carry_ha1    : std_logic;
signal s_carry_ha2    : std_logic; 

begin

-------------------------------------------------------------------------------
--  Sum data generation
-------------------------------------------------------------------------------
s_sum_data_ha  <=  i_input_data1 xor i_input_data2;
o_sum_data     <=  s_sum_data_ha xor i_carry_in;

-------------------------------------------------------------------------------
--  carry out generation
-------------------------------------------------------------------------------
s_carry_ha1    <= s_sum_data_ha and i_carry_in;
s_carry_ha2    <= i_input_data1 and i_input_data2;
o_carry_out    <= s_carry_ha1 or s_carry_ha2;

end architecture arch_full_addr;
  