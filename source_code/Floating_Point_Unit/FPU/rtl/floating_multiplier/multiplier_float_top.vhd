
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity multiplier_float_top is
port(
  i_clk           : in  std_logic;
  i_rst           : in  std_logic;
  i_start         : in  std_logic;
  i_multiplicand  : in  std_logic_vector(31 downto 0);
  i_multiplier    : in  std_logic_vector(31 downto 0);
  o_done          : out std_logic;
  o_product       : out std_logic_vector(31 downto 0);
  o_ovrflow       : out std_logic;
  o_undrflow      : out std_logic
);
end entity multiplier_float_top;

architecture behavioral of multiplier_float_top is
------------------------------------------------------------------------
-- Component declaration of multiplier_top for mantissa multiplication
------------------------------------------------------------------------
component multiplier_top
port(
  i_clk            : in  std_logic;
  i_rst            : in  std_logic;
  i_multiplicand   : in  std_logic_vector(23 downto 0);
  i_multiplier     : in  std_logic_vector(23 downto 0);
  i_start          : in  std_logic;
  i_unsigned       : in  std_logic;
  o_product        : out std_logic_vector(47 downto 0);
  o_done           : out std_logic
);
end component multiplier_top;

------------------------------------------------------------------------
-- Component declaration of carry look ahead  adder for exponent Addition
------------------------------------------------------------------------
component carry_lookahead_adder
generic(
  data_width       : integer  := 16
);
port(
  i_input_data1    : in  std_logic_vector(data_width-1 downto 0);
  i_input_data2    : in  std_logic_vector(data_width-1 downto 0);
  o_sum_data       : out std_logic_vector(data_width downto 0)
);
end component carry_lookahead_adder;

component full_adder
port(
  i_input_data1  : in  std_logic; 
  i_input_data2  : in  std_logic;
  i_carry_in     : in  std_logic;  
  o_sum_data     : out std_logic;
  o_carry_out    : out std_logic
  );
end component full_adder;  


-- Internal signal declaration
signal s_mantisa_mulcnd    : std_logic_vector(23 downto 0) := (others => '0');
signal s_mantisa_mulplr    : std_logic_vector(23 downto 0) := (others => '0');
signal s_matisa_product    : std_logic_vector(47 downto 0);
signal s_done              : std_logic;
signal s_exponent_mulcnd   : std_logic_vector(7 downto 0);
signal s_exponent_mulplr   : std_logic_vector(7 downto 0);
signal s_exponent_bias     : std_logic_vector(7 downto 0) :=  X"81";
signal s_exponent_sum      : std_logic_vector(8 downto 0);
signal s_exponent_unbiased : std_logic_vector(8 downto 0);
signal s_exponent_float    : std_logic_vector(7 downto 0);
signal s_sign_mulcnd       : std_logic;
signal s_sign_mulplr       : std_logic;
signal s_sign_prod         : std_logic;
signal s_mantisa_norm      : std_logic_vector(22 downto 0);
signal s_exponent_norm     : std_logic_vector(7 downto 0);
signal s_carry_adder       : std_logic_vector(8 downto 0);
signal s_carry_sub         : std_logic_vector(9 downto 0);
signal s_exponent_fa       : std_logic_vector(7 downto 0);
signal s_cntr              : std_logic_vector(5 downto 0);

begin
--
--s_cntr_proc : process(i_clk)
--begin
--  if(rising_edge(i_clk)) then
--    if(i_rst = '1') then
--	  s_cntr <= (others => '1');
--	else
--      s_cntr <= s_cntr +1 ;
--	end if;  
--  end if;
--end process s_cntr_proc;
------------------------------------------------------------------------
-- Sign extraction and sign of product computation
------------------------------------------------------------------------
s_sign_mulcnd     <= i_multiplicand(31);
s_sign_mulplr     <= i_multiplier(31);
s_sign_prod       <= (s_sign_mulcnd xor s_sign_mulplr);

------------------------------------------------------------------------
-- exponent extraction of multiplier and multiplicand
------------------------------------------------------------------------
s_exponent_mulcnd <= i_multiplicand(30 downto 23);
s_exponent_mulplr <= i_multiplier(30 downto 23);

------------------------------------------------------------------------
-- Mantisa extraction from input Multiplicand and Multiplier
------------------------------------------------------------------------
s_mantisa_mulcnd    <= '1' & i_multiplicand(22 downto 0);
s_mantisa_mulplr    <= '1' & i_multiplier(22 downto 0);

------------------------------------------------------------------------
-- Component instantiation of multiplier_top for mantissa multiplication
------------------------------------------------------------------------
inst_mantisa_multiplier : multiplier_top
port map(
  i_clk            => i_clk,
  i_rst            => i_rst,
  i_multiplicand   => s_mantisa_mulcnd,
  i_multiplier     => s_mantisa_mulplr,
  i_start          => i_start,
  i_unsigned       => '1',
  o_product        => s_matisa_product,
  o_done           => s_done
);


------------------------------------------------------------------------
-- Component instantiation and generation of Full adder for
-- Ripple Carry  Adder for exponent addition
------------------------------------------------------------------------
s_carry_adder(0) <= '0'; 
exp_adder_RCA_gen : for i in 0 to 7 generate
inst_exponent_adder : full_adder
port map(
  i_input_data1  => s_exponent_mulcnd(i),
  i_input_data2  => s_exponent_mulplr(i),
  i_carry_in     => s_carry_adder(i),
  o_sum_data     => s_exponent_fa(i),
  o_carry_out    => s_carry_adder(i+1)
  );
end generate exp_adder_RCA_gen; 
s_exponent_sum <= s_carry_adder(8) & s_exponent_fa;
------------------------------------------------------------------------
-- Component instantiation and generation of Full adder for
-- Ripple Carry  Adder for exponent bias removal
------------------------------------------------------------------------
s_carry_sub(0) <= '0';

exp_sub_RCA_gen: for i in 0 to 7 generate
inst_bias_remover : full_adder
port map(
  i_input_data1  => s_exponent_sum(i),
  i_input_data2  => s_exponent_bias(i),
  i_carry_in     => s_carry_sub(i),
  o_sum_data     => s_exponent_unbiased(i),
  o_carry_out    => s_carry_sub(i+1)
  );
end generate exp_sub_RCA_gen; 

 s_exponent_unbiased(8) <= s_carry_sub(8);

s_exponent_float  <= s_exponent_unbiased(7 downto 0);
----------------------------------------------------------------------
-- Normalization and rounding
-- if 47th bit of Mantisa product is '1' then exponent has to be incremented
-- by one and Mantisa has to be right shifted by 1, other wise exponent and 
-- Mantisa will go without normalization
-- out of 48 bits of the mantisa product only 45 downto 23 bits are valid in
-- non-normalization and 46 downto 24 when normalized
----------------------------------------------------------------------
s_normalization_proc : process(s_matisa_product,s_exponent_float)
begin
  if(s_matisa_product(47) = '1') then
    s_mantisa_norm         <= s_matisa_product(46 downto 24); -- shift right
    s_exponent_norm        <= s_exponent_float + 1;
  else
    s_mantisa_norm         <= s_matisa_product(45 downto 23);
    s_exponent_norm        <= s_exponent_float;
  end if;
end process s_normalization_proc;  


o_product <= s_sign_prod & s_exponent_norm & s_mantisa_norm;


o_done_proc : process(i_clk)
begin
  if(rising_edge(i_clk)) then
    o_done    <= s_done;
  end if;
end process o_done_proc;

end architecture behavioral;
