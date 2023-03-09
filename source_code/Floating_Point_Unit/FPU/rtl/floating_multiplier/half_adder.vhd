-------------------------------------------------------------------------------
--  Full adder code for addition of two input bits and carry in
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;


entity half_adder is
port(
  i_input_data1  : in  std_logic; 
  i_input_data2  : in  std_logic;
  o_sum_data     : out std_logic;
  o_carry_out    : out std_logic
  );
end entity half_adder;  

architecture arch_half_addr of half_adder is

begin

-------------------------------------------------------------------------------
--  Sum data generation
-------------------------------------------------------------------------------
o_sum_data     <=  i_input_data1 xor i_input_data2;

-------------------------------------------------------------------------------
--  carry out generation
-------------------------------------------------------------------------------
o_carry_out    <= i_input_data1 and i_input_data2;

end architecture arch_half_addr;
  