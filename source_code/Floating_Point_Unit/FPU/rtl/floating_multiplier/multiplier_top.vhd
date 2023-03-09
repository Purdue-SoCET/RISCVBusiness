--------------------------------------------------------------------------------------------------
-- Genertic Multiplier using divide & conquer approach and karatsuba Multiplier
-- this multiplier has following equation
--  A * B   = AH * BH * 2^(n) +((AH + AL) * ( BH + BL) - AH * BH - AL * BL) * 2^(n/2) + AL * HL  
-- 1. signed to unsinged conversion
-- 2. two pre adders for (AH + AL) and (BH + BL)
-- 3. two N/2 bit booth multiplier for sequeantial multiplication of AH * BH and AL * BL 
-- 4. a (N/2 + 1) bit booth multiplier for (AH + AL) * ( BH + BL)
-- 5. Post adder1 for AH * BH + AL * BL
-- 6. Post substractor for Sub_out =  (AH + AL) * ( BH + BL) -(AH * BH + AL * BL)
-- 7. post adder2  for    Sub_out * 2^(n/2) + AL * AL
-- 8. final adder  for  post adder2 output and AH * BH * 2^(n) 
-------------------------------------------------------------------------------------------------



library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

entity multiplier_top is
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
end entity multiplier_top;

architecture behavioral of multiplier_top  is

---------------------------------------------------------------------------------
-- component declaration of generic booth_multiplier 
---------------------------------------------------------------------------------
component booth_multiplier
generic(
 data_width       : integer := 8
);
port(
 i_clk            : in  std_logic;
 i_rst            : in  std_logic;
 i_multiplicand   : in  std_logic_vector(data_width-1 downto 0);
 i_multiplier     : in  std_logic_vector(data_width-1 downto 0);
 i_start          : in  std_logic;
 i_unsigned       : in  std_logic;
 o_product        : out std_logic_vector(2*data_width-1 downto 0);
 o_done           : out std_logic
);
end component booth_multiplier;

component booth_multiplier_12bit
generic(
  data_width    : integer := 12
);
port(
  i_clk            : in  std_logic;
  i_rst            : in  std_logic;
  i_multiplicand   : in  std_logic_vector(11 downto 0);
  i_multiplier     : in  std_logic_vector(11 downto 0);
  i_unsigned       : in  std_logic;
  i_start          : in  std_logic;
  o_product        : out std_logic_vector(23 downto 0);
  o_done           : out std_logic
);
end component booth_multiplier_12bit;

component booth_multiplier_13bit
generic(
  data_width    : integer := 13
);
port(
  i_clk            : in  std_logic;
  i_rst            : in  std_logic;
  i_multiplicand   : in  std_logic_vector(12 downto 0);
  i_multiplier     : in  std_logic_vector(12 downto 0);
  i_unsigned       : in  std_logic;
  i_start          : in  std_logic;
  o_product        : out std_logic_vector(25 downto 0);
  o_done           : out std_logic
);
end component booth_multiplier_13bit;



---------------------------------------------------------------------------------
-- component declaration of carry_lookahead_adder 
---------------------------------------------------------------------------------
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

component mul_post_addder 
port(
  i_input_data1    : in  std_logic_vector(25 downto 0);
  i_input_data2    : in  std_logic_vector(25 downto 0);
  o_sum_data       : out std_logic_vector(26 downto 0)
);
end component mul_post_addder;

component mul_final_addder 
port(
  i_input_data1    : in  std_logic_vector(23 downto 0);
  i_input_data2    : in  std_logic_vector(23 downto 0);
  o_sum_data       : out std_logic_vector(24 downto 0)
);
end component mul_final_addder;




-- internal signal declaration
signal s_mulcnd_lsb_reg            : std_logic_vector(11 downto 0);
signal s_mulplr_lsb_reg            : std_logic_vector(11 downto 0);
signal s_mulcnd_msb_reg            : std_logic_vector(11 downto 0);
signal s_mulplr_msb_reg            : std_logic_vector(11 downto 0);
signal s_data_sel_reg              : std_logic;
signal s_done                      : std_logic;
signal s_sum_mulcnd                : std_logic_vector(12 downto 0);
signal s_sum_mulplr                : std_logic_vector(12 downto 0);
signal s_boothmult_pdata_lsb       : std_logic_vector(23 downto 0);
signal s_boothmult_pdata_msb       : std_logic_vector(23 downto 0);
signal s_boothmult_pdata_lsb_1     : std_logic_vector(23 downto 0);
signal s_boothmult_pdata_msb_1     : std_logic_vector(23 downto 0);
signal s_booth_mult2_pdata         : std_logic_vector(25 downto 0);
signal s_booth_mult2_pdata_d1      : std_logic_vector(26 downto 0);
signal s_booth_mult2_pdata_d2      : std_logic_vector(26 downto 0);
signal s_start                     : std_logic;
signal s_start_d2                  : std_logic;
signal s_done_1                    : std_logic;
signal s_done_2                    : std_logic;
signal s_post_adder_in1            : std_logic_vector(24 downto 0);
signal s_post_adder_in2            : std_logic_vector(24 downto 0);
signal s_sum_post_addr             : std_logic_vector(24 downto 0);
signal s_diff_post_sub             : std_logic_vector(26 downto 0);
signal s_diff_post_sub_1           : std_logic_vector(26 downto 0);
signal s_sum_post_addr_2comp       : std_logic_vector(26 downto 0);  
signal s_sum_post_addr_comp        : std_logic_vector(25 downto 0);  
signal s_post_adder2_in1           : std_logic_vector(39 downto 0);
signal s_post_adder2_in2           : std_logic_vector(39 downto 0);
signal s_sum_post_adder2           : std_logic_vector(40 downto 0);
signal s_sum_post_adder2_opt       : std_logic_vector(26 downto 0);
signal s_final_addr_in1            : std_logic_vector(23 downto 0); 
signal s_final_addr_in2            : std_logic_vector(23 downto 0); 
signal s_sum_final_addr_data       : std_logic_vector(48 downto 0); 
signal s_sum_final_addr_data_opt   : std_logic_vector(24 downto 0);
signal s_lsb_selected              : std_logic;
signal s_unsigned                  : std_logic;
signal s_unsigned_2                : std_logic;
signal s_multiplier                : std_logic_vector(23 downto 0);
signal s_multiplier_2scomp         : std_logic_vector(23 downto 0);
signal s_multiplicand_2scomp       : std_logic_vector(23 downto 0);
signal s_multiplicand              : std_logic_vector(23 downto 0);
signal s_signal_ones               : std_logic_vector(23 downto 0) := (others => '1');
signal s_signal_ones_2             : std_logic_vector(47 downto 0) := (others => '1');
signal s_signed_out                : std_logic;
signal s_done_d3                   : std_logic;
signal s_done_d4                   : std_logic;
signal s_done_d5                   : std_logic;
signal s_done_d6                   : std_logic;
signal s_done_d7                   : std_logic;


begin


s_multiplier    <= i_multiplier;          						   		   
s_multiplicand	<= i_multiplicand;					   
---------------------------------------------------------------------------------
-- delaying of i_start for two clock cycles
---------------------------------------------------------------------------------
						   
s_start_proc : process(i_clk)
begin
  if(rising_edge(i_clk)) then
    s_start     <= i_start;
	s_start_d2  <= s_start; 
  end if;
end process s_start_proc;

---------------------------------------------------------------------------------
-- done output is 3 clock cycles delayed version of s_done_2 
---------------------------------------------------------------------------------
process(i_clk)
begin
  if(rising_edge(i_clk)) then
    s_done_d3    <= s_done_2;
    s_done_d4    <= s_done_d3;
    s_done_d5    <= s_done_d4;	
    s_done_d6    <= s_done_d5;	
    s_done_d7    <= s_done_d6;	
  end if;
end process;  

o_done   <=  s_start;
-----------------------------------------------------------------------------
-- Division Multiplicand and Multiplier into high and low registers
-----------------------------------------------------------------------------
s_mulcnd_lsb_reg  <= s_multiplicand(11 downto 0);
s_mulcnd_msb_reg  <= s_multiplicand(23 downto 12);
s_mulplr_lsb_reg  <= s_multiplier(11 downto 0);
s_mulplr_msb_reg  <= s_multiplier(23 downto 12);


-----------------------------------------------------------------------------
-- Pre adder1 for addition of HSB and LSB of multiplicand 
-----------------------------------------------------------------------------
inst_pre_adder1 : carry_lookahead_adder
generic map(
  data_width       => 12
)
port map(
  i_input_data1    => s_mulcnd_lsb_reg,
  i_input_data2    => s_mulcnd_msb_reg,
  o_sum_data       => s_sum_mulcnd
);

-----------------------------------------------------------------------------
-- Pre adder2 for addition of HSB and LSB of multiplier
-----------------------------------------------------------------------------
inst_pre_adder2 : carry_lookahead_adder
generic map(
  data_width       => 12
)
port map(
  i_input_data1    => s_mulplr_lsb_reg,
  i_input_data2    => s_mulplr_msb_reg,
  o_sum_data       => s_sum_mulplr
);

-----------------------------------------------------------------------------
-- N/2 bit booth Multiplier 
-- 
-----------------------------------------------------------------------------
inst_booth_mult_lsb : booth_multiplier_12bit
generic map(
  data_width       => 12
)
port map(
  i_clk            => i_clk,
  i_rst            => i_rst,
  i_multiplicand   => s_mulcnd_lsb_reg,
  i_multiplier     => s_mulplr_lsb_reg,
  i_start          => i_start,
  i_unsigned       => '1',
  o_product        => s_boothmult_pdata_lsb_1,
  o_done           => open
);

s_boothmult_pdata_lsb <= s_boothmult_pdata_lsb_1;

inst_booth_mult_msb : booth_multiplier_12bit
generic map(
  data_width       => 12
)
port map(
  i_clk            => i_clk,
  i_rst            => i_rst,
  i_multiplicand   => s_mulcnd_msb_reg,
  i_multiplier     => s_mulplr_msb_reg,
  i_start          => i_start,
  i_unsigned       => '1',
  o_product        => s_boothmult_pdata_msb_1,
  o_done           => open
);

s_boothmult_pdata_msb <= s_boothmult_pdata_msb_1;


-----------------------------------------------------------------------------
-- N/2 + 1 bit booth Multiplier 
-- 
-------------------------------------------------------------------------------
inst_booth_mult2 : booth_multiplier_13bit
generic map(
 data_width       => 13
)
port map(
 i_clk            => i_clk,
 i_rst            => i_rst,
 i_multiplicand   => s_sum_mulcnd,
 i_multiplier     => s_sum_mulplr,
 i_start          => i_start,
 i_unsigned       => '1',
 o_product        => s_booth_mult2_pdata,
 o_done           => s_done_2
);


-----------------------------------------------------------------------------
-- post adder1 for N/2 bit booth Multiplier 
-- 
-----------------------------------------------------------------------------	  
inst_post_adder1 : carry_lookahead_adder
generic map(
  data_width       => 24
)
port map(
  i_input_data1    => s_boothmult_pdata_msb,
  i_input_data2    => s_boothmult_pdata_lsb,
  o_sum_data       => s_sum_post_addr(24 downto 0)
);

s_sum_post_addr_comp   <= (not ('0' & s_sum_post_addr(24 downto 0))) + 1;

s_booth_mult2_pdata_d1 <= '0' & s_booth_mult2_pdata;
-----------------------------------------------------------------------------
-- post substractor1 for mid term
-- 
-----------------------------------------------------------------------------
inst_post_substractor1 : carry_lookahead_adder
generic map(
  data_width       => 26
)
port map(
  i_input_data1    => s_booth_mult2_pdata,
  i_input_data2    => s_sum_post_addr_comp,
  o_sum_data       => s_diff_post_sub
);

-- shift by N/2 times of substraction output data

-----------------------------------------------------------------------------
-- Post Adder2 for AH*BH*K^24+ AL*BL
-- 
----------------------------------------------------------------------------- 
-- shift by N times of substraction output data

s_post_adder2_in1    <= (39 downto 24 => '0') & s_boothmult_pdata_lsb;       


inst_post_adder2 : mul_post_addder 
port map(
  i_input_data1    => s_diff_post_sub(25 downto 0),
  i_input_data2    => s_post_adder2_in1(37 downto 12),
  o_sum_data       => s_sum_post_adder2_opt
);


-----------------------------------------------------------------------------
-- final Adder
-- 
----------------------------------------------------------------------------- 
s_final_addr_in2   <= (23 downto 15 => '0') & s_sum_post_adder2_opt(26 downto 12);


inst_final_adder : mul_final_addder 
port map(
  i_input_data1    => s_boothmult_pdata_msb,
  i_input_data2    => s_final_addr_in2,
  o_sum_data       => s_sum_final_addr_data_opt
);
 
s_sum_final_addr_data <= s_sum_final_addr_data_opt & s_sum_post_adder2_opt(11 downto 0) & s_post_adder2_in1(11 downto 0);


o_product    <= s_sum_final_addr_data(47 downto 0);

end architecture behavioral;