-------------------------------------------------------------------------------
--  This module implements the carry look ahead adder implemented for 4 bits
--  component. This module reduces the propagation delay of the full adder circuity
--  
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

entity cla_four_bit is
port(
  i_input_data1       : in std_logic_vector(3 downto 0); -- input data1 of 4 bits
  i_input_data2       : in std_logic_vector(3 downto 0); -- input data2 of 4 bits
  i_carry_in          : in std_logic;                    -- Carry_in
  o_sum_data          : out std_logic_vector(3 downto 0);-- Sum output data of 4 bits
  o_carry_out         : out std_logic                    -- Carry output data
);
end entity cla_four_bit;

architecture behavioral of cla_four_bit is
---------------------------------------------------------------------------------
-- component declaration of Full adder
---------------------------------------------------------------------------------
component full_adder 
port(
  i_input_data1       : in  std_logic; 
  i_input_data2       : in  std_logic;
  i_carry_in          : in  std_logic;  
  o_sum_data          : out std_logic;
  o_carry_out         : out std_logic
  );
end component full_adder; 

-- Internal signal declaration
signal s_carry_G      : std_logic_vector(3 downto 0);
signal s_carry_P      : std_logic_vector(3 downto 0);
signal s_carry        : std_logic_vector(4 downto 0);
signal s_sum_data     : std_logic_vector(3 downto 0);

begin

---------------------------------------------------------------------------------
-- Creation of 4 Full adders component for generation of Sum
---------------------------------------------------------------------------------
full_adder_generate : for i in 0 to 3 generate    -- generate statement for four full adders
inst_full_adder1 : full_adder 
port map(
  i_input_data1  => i_input_data1(i),
  i_input_data2  => i_input_data2(i),
  i_carry_in     => s_carry(i),  
  o_sum_data     => s_sum_data(i),
  o_carry_out    => open 
  );
end generate full_adder_generate;

o_sum_data    <= s_sum_data;   -- Sum output

---------------------------------------------------------------------------------
-- Generation of carry using generate and propagate equation of carry look ahead
-- adder
---------------------------------------------------------------------------------
s_carry(0) <= i_carry_in;  
  
carry_generator : for i in 0 to  3 generate   -- generation of Generator, Propagator and carry for four bit input
s_carry_G(i)   <= i_input_data1(i) and i_input_data2(i);   -- Generate equation
s_carry_P(i)   <= i_input_data1(i) or i_input_data2(i);    -- Propagate equation 
s_carry(i+1)   <= s_carry_G(i) or (s_carry_P(i) and s_carry(i)); -- Carry generation equation
end generate carry_generator;

o_carry_out    <= s_carry(4); -- final 4th carry out bit is given to output  

end architecture behavioral;