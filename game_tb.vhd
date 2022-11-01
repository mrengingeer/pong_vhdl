--------------------------------------------------------------------------------
-- Company: 
-- Engineer: Taninder Thiara
--
-- Create Date:   14:27:28 11/23/2020
-- Design Name:   
-- Module Name:   E:/COE 758/Labs/Project2/Game_tb.vhd
-- Project Name:  Project2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Game
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_textio.ALL;
USE std.textio.all;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Game_tb IS
END Game_tb;
 
ARCHITECTURE behavior OF Game_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT monitor
    PORT(
         clk : IN  std_logic;
         p1_Up : IN  std_logic;
         p1_Down : IN  std_logic;
         p2_Up : IN  std_logic;
         p2_Down : IN  std_logic;
         power : IN  std_logic;
         h_sync_VGA : OUT  std_logic;
         v_sync_VGA : OUT  std_logic;
         Red_VGA : OUT  std_logic_vector(7 downto 0);
         Green_VGA : OUT  std_logic_vector(7 downto 0);
         Blue_VGA : OUT  std_logic_vector(7 downto 0);
         H_pixel : OUT  std_logic_vector(9 downto 0);
         V_pixel : OUT  std_logic_vector(9 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal p1_Up : std_logic := '0';
   signal p1_Down : std_logic := '0';
   signal p2_Up : std_logic := '0';
   signal p2_Down : std_logic := '0';
   signal power : std_logic := '0';

 	--Outputs
   signal h_sync_VGA : std_logic;
   signal v_sync_VGA : std_logic;
   signal Red_VGA : std_logic_vector(7 downto 0);
   signal Green_VGA : std_logic_vector(7 downto 0);
   signal Blue_VGA : std_logic_vector(7 downto 0);
   signal H_pixel : std_logic_vector(9 downto 0);
   signal V_pixel : std_logic_vector(9 downto 0);

   -- Clock period definitions
   constant clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: monitor PORT MAP (
          clk => clk,
          p1_Up => p1_Up,
          p1_Down => p1_Down,
          p2_Up => p2_Up,
          p2_Down => p2_Down,
          power => power,
          h_sync_VGA => h_sync_VGA,
          v_sync_VGA => v_sync_VGA,
          Red_VGA => Red_VGA,
          Green_VGA => Green_VGA,
          Blue_VGA => Blue_VGA,
          H_pixel => H_pixel,
          V_pixel => V_pixel
        );

   -- Clock process definitions
	process(clk)
		file file_pointer: text is out "write.txt";
		variable line_el: line;
	begin
		if rising_edge(clk) then
			write(line_el, now);
			write(line_el, ":");
			write(line_el, " ");
			write(line_el, h_sync_VGA);
			write(line_el, " ");
			write(line_el, v_sync_VGA);
			write(line_el, " ");
			write(line_el, Red_VGA);
			write(line_el, " ");
			write(line_el, Green_VGA);
			write(line_el, " ");
			write(line_el, Blue_VGA);
			writeline(file_pointer, line_el);
		end if;
	end process;
	
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 10 ns.
		power <= '0';
      wait for 10 ns;	
		power <= '1';

      wait for clk_period*10;
		p1_down<='1';
		p2_down<='1';
      -- insert stimulus here 

      wait;
   end process;

END;
