--------------------------------------------------------------------------------------------
-- This module performs the booth multiplier operation using Radix - 4 booth encoding
-- technique, Radix -4 booth encoding technique is the modified booth encoding algorithm
-- which reduces the number of partial products by 2. following are steps involved in
-- Radix-4 booth multiplier
-- 1. Booth encoding
-- 2. Partial product generation
-- 3. Carry look ahead adder addition 
--------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

entity booth_multiplier_12bit is
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
end entity booth_multiplier_12bit;

architecture behavioral of booth_multiplier_12bit is
---------------------------------------------------------------------------------
-- component declaration of booth_r4_encoding
---------------------------------------------------------------------------------
component  booth_r4_encoding 

generic(
  data_width     : integer := 8;
  data_width2    : integer := 9
);
port(
  i_clk            : in  std_logic;
  i_rst            : in  std_logic;
  i_multiplicand   : in  std_logic_vector(data_width2-1 downto 0);
  i_booth_code     : in  std_logic_vector(2 downto 0);
  o_partial_prod   : out std_logic_vector(2*data_width-1 downto 0)
);
end component booth_r4_encoding;

---------------------------------------------------------------------------------
-- component declaration of Carry Look ahead adder 
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

constant data_width_mod  : integer := 7; -- modified data width by checking multiplie of 2

type s_partial_prod_array is array(0 to 6) of 
     std_logic_vector(23 downto 0); -- array of partial product 
type s_sum_array is array(0 to 6) of 
     std_logic_vector(23 downto 0);   -- array of sum data
	 
signal s_partial_prod             : s_partial_prod_array;
signal s_partial_prod_sh          : s_partial_prod_array;
signal s_sum_data                 : s_sum_array;
signal s_sum_data_d               : s_sum_array;
signal s_sum_1stage_adder1        : std_logic_vector(17 downto 0);
signal s_sum_1stage_adder1_opt    : std_logic_vector(14 downto 0);
signal s_sum_1stage_adder1_opt_d  : std_logic_vector(14 downto 0);
signal s_sum_1stage_adder1_extd   : std_logic_vector(21 downto 0);
signal s_sum_1stage_adder2        : std_logic_vector(21 downto 0);
signal s_sum_1stage_adder2_opt    : std_logic_vector(14 downto 0);
signal s_sum_1stage_adder2_opt_d  : std_logic_vector(14 downto 0);
signal s_sum_1stage_adder3        : std_logic_vector(24 downto 0);
signal s_sum_1stage_adder3_opt    : std_logic_vector(14 downto 0);
signal s_sum_1stage_adder3_opt_d  : std_logic_vector(14 downto 0);
signal s_sum_2stage_adder1        : std_logic_vector(22 downto 0);
signal s_sum_2stage_adder1_opt    : std_logic_vector(17 downto 0);
signal s_sum_2stage_adder1_extd   : std_logic_vector(23 downto 0);
signal s_sum_2stage_adder2        : std_logic_vector(24 downto 0);
signal s_sum_2stage_adder2_opt    : std_logic_vector(18 downto 0);
signal s_sum_2stage_adder2_extd   : std_logic_vector(23 downto 0);
signal s_sum_final_adder          : std_logic_vector(24 downto 0);
signal s_sum_final_adder_opt      : std_logic_vector(12 downto 0);
signal s_partial_prod_6_d         : std_logic_vector(11 downto 0);
signal s_multiplier               : std_logic_vector(14 downto 0); 
signal s_multiplicand             : std_logic_vector(12 downto 0); 
signal s_datawidth                : std_logic_vector(4 downto 0);
signal s_done_d1                  : std_logic;
signal s_done_d2                  : std_logic;



begin

s_datawidth <= std_logic_vector(to_unsigned(12,5));


----------------------------------------------------------------------
-- '0' is inserted at LSB of s_multiplier 
-- '0' is inserted at MSB of s_multiplier if  input datawidth is not even and unsigned input data
-- sign extension of s_multiplier of input datawidth is not even
----------------------------------------------------------------------
s_multiplier_proc : process(i_multiplier,s_datawidth,i_unsigned)
begin
  if(i_unsigned = '1')then
    if(s_datawidth(0) = '1') then
      s_multiplier   <= "00" & i_multiplier & '0';
    else
	  s_multiplier   <= "00" & i_multiplier & '0';
    end if;
  else
    if(s_datawidth(0) = '1') then
      s_multiplier   <= i_multiplier(11) & i_multiplier(11) & i_multiplier & '0';
    else
	  s_multiplier   <= i_multiplier(11) & i_multiplier(11) & i_multiplier & '0';
    end if;      
  end if;	
end process;

---------------------------------------------------------------------------------
-- Radix 4 booth encoding for all the bits of s_multiplier
---------------------------------------------------------------------------------
s_multiplicand <= '0' & i_multiplicand;
booth_r4_encoding_gen : for ii in 0 to (data_width_mod-1) generate
inst_booth_r4_encoding : booth_r4_encoding 
generic map(
  data_width        => data_width,
  data_width2       => data_width+1
)
port map(
  i_clk            => i_clk,
  i_rst            => i_rst,
  i_multiplicand   => s_multiplicand,
  i_booth_code     => s_multiplier((ii+1)*2 downto 2*ii),
  o_partial_prod   => s_partial_prod(ii)(23 downto 0)
);
end generate booth_r4_encoding_gen;

---------------------------------------------------------------------------------
-- Shift and addition of partial products using carry look ahead adder
---------------------------------------------------------------------------------

---------------------------------------------------------------------------------
-- first stage of addition
---------------------------------------------------------------------------------

inst_stage1_adder1 : carry_lookahead_adder
generic map(
  data_width       => 14
)
port map(
  i_input_data1    => s_partial_prod(0)(15 downto 2),
  i_input_data2    => s_partial_prod(1)(13 downto 0),
  o_sum_data       => s_sum_1stage_adder1_opt
);

-- s_sum_1stage_adder1_opt_d_proc : process(i_clk)
-- begin
  -- if(rising_edge(i_clk)) then
    -- s_sum_1stage_adder1_opt_d <= s_sum_1stage_adder1_opt;
  -- end if;
-- end process s_sum_1stage_adder1_opt_d_proc;


s_sum_1stage_adder1 <= s_sum_1stage_adder1_opt(14) & s_sum_1stage_adder1_opt & s_partial_prod(0)(1 downto 0);


inst_stage1_adder2 : carry_lookahead_adder
generic map(
  data_width       => 14
)
port map(
  i_input_data1    => s_partial_prod(2)(15 downto 2),
  i_input_data2    => s_partial_prod(3)(13 downto 0),
  o_sum_data       => s_sum_1stage_adder2_opt
);

-- s_sum_1stage_adder2_opt_d_proc : process(i_clk)
-- begin
  -- if(rising_edge(i_clk)) then
    -- s_sum_1stage_adder2_opt_d <= s_sum_1stage_adder2_opt;
  -- end if;
-- end process s_sum_1stage_adder2_opt_d_proc;

s_sum_1stage_adder2 <= s_sum_1stage_adder2_opt(14) & s_sum_1stage_adder2_opt & s_partial_prod(2)(1 downto  0) & "0000";

inst_stage1_adder3 : carry_lookahead_adder
generic map(
  data_width       => 14
)
port map(
  i_input_data1    => s_partial_prod(4)(15 downto 2),
  i_input_data2    => s_partial_prod(5)(13 downto 0),
  o_sum_data       => s_sum_1stage_adder3_opt
);

-- s_sum_1stage_adder3_opt_d_proc : process(i_clk)
-- begin
  -- if(rising_edge(i_clk)) then
    -- s_sum_1stage_adder3_opt_d <= s_sum_1stage_adder3_opt;
  -- end if;
-- end process s_sum_1stage_adder3_opt_d_proc;

s_sum_1stage_adder3 <= s_sum_1stage_adder3_opt & s_partial_prod(4)(1 downto 0) & "00000000";

---------------------------------------------------------------------------------
-- second stage of addition
---------------------------------------------------------------------------------
s_sum_1stage_adder1_extd  <= (22 downto 19 => s_sum_1stage_adder1(17)) & s_sum_1stage_adder1;
inst_stage2_adder1 : carry_lookahead_adder
generic map(
  data_width       => 17
)
port map(
  i_input_data1    => s_sum_1stage_adder1_extd(20 downto 4),
  i_input_data2    => s_sum_1stage_adder2(20 downto 4),
  o_sum_data       => s_sum_2stage_adder1_opt
);
s_sum_2stage_adder1  <= s_sum_2stage_adder1_opt(17) & s_sum_2stage_adder1_opt & s_sum_1stage_adder1_extd(3 downto 0);
s_sum_2stage_adder1_extd <=  s_sum_2stage_adder1 (22) & s_sum_2stage_adder1;

inst_stage2_adder2 : carry_lookahead_adder
generic map(
  data_width       => 18
)
port map(
  i_input_data1    => s_sum_2stage_adder1_extd(23 downto 6),
  i_input_data2    => s_sum_1stage_adder3(23 downto 6),
  o_sum_data       => s_sum_2stage_adder2_opt
);

s_sum_2stage_adder2      <= s_sum_2stage_adder2_opt & s_sum_2stage_adder1_extd(5 downto 0);
s_sum_2stage_adder2_extd <= s_sum_2stage_adder2(23 downto 0);



---------------------------------------------------------------------------------
-- Final Adder
---------------------------------------------------------------------------------
-- s_partial_prod_6_d_proc : process(i_clk)
-- begin
  -- if(rising_edge(i_clk)) then
    -- s_partial_prod_6_d <= s_partial_prod(6)(11 downto 0);
  -- end if;
-- end process s_partial_prod_6_d_proc;


inst_stage3_adder2 : carry_lookahead_adder
generic map(
  data_width       => 12
)
port map(
  i_input_data1    => s_sum_2stage_adder2_extd(23 downto 12),
  i_input_data2    => s_partial_prod(6)(11 downto 0),
  o_sum_data       => s_sum_final_adder_opt
);

s_sum_final_adder  <= s_sum_final_adder_opt & s_sum_2stage_adder2_extd(11 downto 0); 

--o_product   <= s_sum_final_adder(23 downto 0);
-- o_product_proc : process(i_clk)
-- begin
  -- if(rising_edge(i_clk)) then
    -- if(i_rst = '1') then
      -- o_product   <= (others => '0');
	-- else
	  -- o_product   <= s_sum_final_adder(23 downto 0);
    -- end if;
  -- end if;
-- end process o_product_proc;

o_product   <= s_sum_final_adder(23 downto 0);

s_done_d_proc : process(i_clk)
begin
  if(rising_edge(i_clk)) then
    s_done_d1 <= i_start;
	s_done_d2 <= s_done_d1;
  end if;
end process s_done_d_proc;

o_done <= s_done_d1;

end architecture behavioral;