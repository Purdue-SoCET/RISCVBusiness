---------------------------------------------------------------------------------
-- Radix 4 booth encoding which encodes input 3 bits and generates partial products
---------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.std_logic_arith.all;

entity  booth_r4_encoding is
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
end entity booth_r4_encoding;

architecture behavioral of booth_r4_encoding is

signal s_partial_prod    : std_logic_vector(2*data_width-1 downto 0);
signal s_prod_reg        : std_logic_vector(2*data_width-1 downto 0) := (others => '0');
signal s_multcnd_2s_comp : std_logic_vector(data_width2-1 downto 0);


begin
-- 2's complement creation of i_multiplicand
s_multcnd_2s_comp <= (not i_multiplicand) + 1;

---------------------------------------------------------------------------------
-- Radix 4 booth encoding logic
---------------------------------------------------------------------------------

booth_encode_proc : process(i_booth_code,i_multiplicand,s_multcnd_2s_comp) 
begin
   case i_booth_code is
     when "001"   => 
	     -- +Multiplicand as partial product 
         s_partial_prod  <= ((2*data_width-1  downto data_width+1 => i_multiplicand(data_width2-1)) & i_multiplicand);
     when "010"   => 
         -- +Multiplicand as partial product
         s_partial_prod  <= ((2*data_width-1  downto data_width+1 => i_multiplicand(data_width2-1)) & i_multiplicand);
     when "011"           => 
         -- +2*Multiplicand as partial product
	     s_partial_prod  <= ((2*data_width-1  downto data_width+2 => i_multiplicand(data_width2-1)) & (i_multiplicand & '0'));
     when "100"           => 
         -- (-2* Multiplicand) as partial product
	     s_partial_prod  <= ((2*data_width-1  downto data_width+2 => s_multcnd_2s_comp(data_width2-1)) & (s_multcnd_2s_comp & '0'));
     when "101"        =>            
         -- (-Multiplicand) as partial product
	     s_partial_prod  <= ((2*data_width-1  downto data_width+1 => s_multcnd_2s_comp(data_width2-1)) & (s_multcnd_2s_comp));
     when "110"   =>    
         -- (-Multiplicand) as partial product
	     s_partial_prod  <= ((2*data_width-1  downto data_width+1 => s_multcnd_2s_comp(data_width2-1)) & (s_multcnd_2s_comp)); 		 
     when others          => 
	   s_partial_prod  <= (others => '0');
    end case;
end process booth_encode_proc;

-- output partial product with pipeline register 
-- pipeline_reg1_proc : process(i_clk)
-- begin
  -- if(rising_edge(i_clk)) then
    -- if(i_rst = '1') then
	  -- o_partial_prod <= (others => '0');
	-- else
      -- o_partial_prod <= s_partial_prod;
	-- end if;
  -- end if;
-- end process pipeline_reg1_proc;
o_partial_prod <= s_partial_prod;

end architecture behavioral;
