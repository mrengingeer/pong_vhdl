
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity monitor is
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

end monitor;



architecture Behavioral of monitor is

signal p1: integer :=158;
signal p2: integer := 158;
signal player_speed: integer :=3;
signal player_width: integer := 50;

signal ballX : integer:= 300;
signal ballY : integer := 200;
signal ballSpeed : integer := 4;
signal ballX_move : integer := 4;
signal ballY_move : integer := 4;
signal score : integer range -160 to 160 :=0;


signal R_sig: std_logic_vector(7 downto 0) := (others => 'X');
signal G_sig: std_logic_vector(7 downto 0) := (others => 'X');
signal B_sig: std_logic_vector(7 downto 0) := (others => 'X');
signal video_clk: std_logic:='0';
signal vga_hsync: std_logic;
signal vga_vsync: std_logic;
signal vga_xpos : unsigned(9 downto 0) := to_unsigned(0,10);
signal vga_ypos: unsigned (9 downto 0) := to_unsigned (0,10);

signal gameover : std_logic:= '0';
signal reset : std_logic := '0';
signal top_net : integer := 126;
signal bottom_net : integer := 358;




component videoController 
port (
         clk_vga : in std_logic; 
			vsync : out std_logic; 
			hsync : out std_logic; 
			xpos: out unsigned (9 downto 0);
			ypos : out unsigned (9 downto 0)
);
end component; 

begin 

process(clk)
begin
if clk'event and clk ='1' then 
video_clk <= NOT video_clk; 
end if; 
end process; 

video_Controller: videoController 
port map (
 clk_vga => clk,
 vsync => vga_vsync,
 hsync => vga_hsync,
 xpos => vga_xpos,
 ypos => vga_ypos
);

process (video_clk, vga_vsync,vga_hsync,vga_xpos,vga_ypos,power)
begin
if power = '1' then 
if gameover = '1' then 
ballX <= 312;
ballY <= 232;
ballX_move <= -ballX_move;
ballY_move <= -ballY_move;
ballSpeed <= 0;
end if; 
if (vga_xpos <640 and vga_ypos <480) then 
--white border at the top and bottom
if (vga_xpos >= 25 and vga_xpos <= 615 and ((vga_ypos >= 25 and vga_ypos <= 36) or (vga_ypos >= 448 and vga_ypos <=459))) then 
R_sig <= "11111111";
G_sig <= "11111111";
B_sig <= "11111111";
--white border on the sides
elsif(((vga_xpos >= 25 and vga_xpos <=36) or (vga_xpos>= 604 and vga_xpos <=615)) and ((vga_ypos >= 36 and vga_ypos <= top_net) or (vga_ypos >= bottom_net and vga_ypos <= 448))) then
R_sig <= "11111111";
G_sig <= "11111111";
B_sig <= "11111111";

--middle white line
elsif((vga_xpos >316 and vga_xpos <324)) then 
if(vga_ypos > 60 and vga_ypos < 60+40) or 
(vga_ypos >140 and vga_ypos <140 + 40) or 
(vga_ypos >220 and vga_ypos <220 + 40) or 
(vga_ypos >300 and vga_ypos <300 + 40) or 
(vga_ypos >380 and vga_ypos <380+ 40) then 
R_sig <= "00000000";
G_sig <= "00000000";
B_sig <= "00000000";
end if;
--green screen
else 
R_sig <= "00000000";
G_sig <= "11111111";
B_sig <= "00000000";
end if; 
--black outline outside of the active area
else 
R_sig <= "00000000";
G_sig <= "00000000";
B_sig <= "00000000";
end if; 


--player 1 is set to blue
if (vga_xpos >45 and vga_xpos <= 59 and vga_ypos > p1 and vga_ypos <= p1 + player_width) then 
R_sig <= "00000000";
G_sig <= "00000000";
B_sig <= "11111111";
--player 2 is set to pink
elsif (vga_xpos > 581 and vga_xpos <= 595 and vga_ypos > p2 and vga_ypos <= p2 + player_width) then 
R_sig <= "11111111"; 
G_sig <= "00001011";
B_sig <= "01000000";
end if; 

--check if ball pos is in gate, set to red
if(vga_xpos > ballX and vga_xpos <= ballX + 16 and vga_ypos > ballY and vga_ypos <= (ballY + 16)) then 
if (ballX <= 12 or ballX + 16 >= 628 ) then 

R_sig <= "10101010";
G_sig <= "00000000";
B_sig <= "00000000";
if reset = '1' then 

--if ball goes into net reset ball pos and update score
if ballX <= 12 then 
score <= score - 16;
else 
score <= score + 16;
end if; 

if (score = 160 or score = -160) then 
score <= 0;
gameover <= '1';
end if; 
--ball moves to original position
ballX <= 312; 
ballY <= 232;
ballX_move <= -ballX_move; 
ballY_move <= -ballY_move; 
reset <= '0';




end if; 
else 
--ball colour set back to yellow
R_sig <= "10101010";
G_sig <= "10101010";
B_sig <= "00000000";
end if;
end if; 


if (vga_xpos = 639 and vga_ypos = 479) then 


if(ballX <= 36 or ballX + 16 >= 604) then 

if(ballY > top_net and ballY < bottom_net ) then 
reset <= '1';
else 
--automatically move ball when within the frame
if (ballX <= 36) then 
ballX_move <= ballSpeed; 
else 
ballX_move <= -ballSpeed; 
end if; 
end if; 
end if;

--if ball hits a wall then moves in opposite direction
if(ballY <=36) then 
ballY_move <= ballSpeed; 
end if; 

if(ballY+16 >= 448) then 
ballY_move <= -ballSpeed; 
end if; 

--if ball hits player 1 it moves the ball in opposite direction
if((ballX<= 60 and ballX+16 >= 44) and (ballY+16 > p1 and ballY < p1 + player_width)) then 

ballX_move <= -ballSpeed;
end if; 

--if ball hits player 2 it moves the ball in opposite direction
if((ballX <= 597 and ballX+16 >= 581) and (ballY+16 > p2 and ballY < p2 + player_width)) then 

ballX_move <= ballSpeed;
end if; 

--moving the player up and down
if(p1_up = '1' and p1 >= 43) then 
p1 <= p1-player_speed;
end if; 
if(p1_down = '1' and p1 + player_width <= 440) then 
p1 <= p1 + player_speed; 
end if;

if(p2_up = '1' and p2 >= 43) then 
p2 <= p2-player_speed;
end if; 
if(p2_down = '1' and p2 + player_width <= 440) then 
p2 <= p2 + player_speed; 
end if;

--if ball is not in the net then move it 
if (not (ballX <= 12) or (ballX + 16 >= 628)) then 
ballX <= ballX + ballX_move;
ballY <= ballY + ballY_move;
end if;
end if;
end if;

Red_VGA <= R_sig;
Green_VGA <= G_sig;
Blue_VGA <= B_sig;
h_sync_vga <= vga_hsync;
v_sync_vga <= vga_vsync;
H_pixel <= std_logic_vector (vga_xpos);
V_pixel <= std_logic_vector(vga_ypos);

end process;

end Behavioral;