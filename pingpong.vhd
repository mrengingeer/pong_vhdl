library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pingpong is
port (
clk: in std_logic; 
h_sync_vga: out std_logic; 
v_sync_vga: out std_logic; 
H_pixel: out std_logic_vector(9 downto 0);
V_pixel: out std_logic_vector(9 downto 0);
Red_VGA: out std_logic_vector(7 downto 0);
Green_VGA: out std_logic_vector(7 downto 0);
Blue_VGA: out std_logic_vector(7 downto 0);
p1_up: in std_logic; 
p1_down: in std_logic;
p2_up: in std_logic; 
p2_down: in std_logic;
power: in std_logic
);

end pingpong;