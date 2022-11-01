----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Taninder Thiara
-- 
-- Create Date:    21:27:44 11/23/2021 
-- Design Name: 
-- Module Name:    video_controller - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity videoController is
    Port ( clk_vga 	: in   STD_LOGIC;
           hsync 		: out  STD_LOGIC;
           vsync 		: out  STD_LOGIC;
           xpos 		: out  unsigned (9 downto 0);
           ypos 		: out  unsigned (9 downto 0));

end videoController;

architecture Behavioral of videoController is

signal video_clk: std_logic:='0';
signal hcount_sig:unsigned(9 downto 0) :=to_unsigned(0,10);
signal vcount_sig:unsigned(9 downto 0) :=to_unsigned(0,10);

begin
process(clk_vga)
	begin
		if clk_vga'event and clk_vga='1' then 
			video_clk<=NOT video_clk;
		end if;
	end process;

process(video_clk)
	begin
		if video_clk'event and video_clk='1' then 
			if hcount_sig>=(639+16) and hcount_sig<=(639+16+96) then 
				hsync<='0';
			else
				hsync<='1';
			end if;	
			
			if vcount_sig>=(479+10) and vcount_sig<=(479+10+2) then
				vsync<='0';
			else
				vsync<='1';
			end if;
		hcount_sig<=hcount_sig+1;
		if hcount_sig=799 then
			vcount_sig<=vcount_sig+1;
			hcount_sig<=to_unsigned(0,10);
		end if;
		if vcount_sig=524 then
			vcount_sig<=to_unsigned(0,10);
		end if;
		if hcount_sig<639 then
			xpos<=hcount_sig;
		end if;
		if vcount_sig<479 then
			ypos<=vcount_sig;
		end if;
	end if;
	
	xpos<=hcount_sig;
	ypos<=vcount_sig;
	end process;
end Behavioral;

