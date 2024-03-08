

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity nexys4 is
Port 
(
signal clk:in std_logic;
signal btn:in std_logic_vector(4 downto 0);
signal sw:in std_logic_vector(15 downto 0);
signal led:out std_logic_vector(15 downto 0);
signal cat:out std_logic_vector(7 downto 0);
signal an:out std_logic_vector(7 downto 0)
 );
end nexys4;

architecture Behavioral of nexys4 is

signal date:std_logic_vector(31 downto 0):=(others=>'0');
signal afisor_ceas:std_logic_vector(23 downto 0);
signal btn_rst,btn_start,btn_directie,btn_alarma:std_logic;
begin
-- 0 centru
-- 1 up
-- 2 left
-- 3 right
-- 4 down
btn_c:entity WORK.mpg port map
(
btn=>btn(0),
clk=>clk,
en=>btn_rst
);
btn_u:entity WORK.mpg port map
(
btn=>btn(1),
clk=>clk,
en=>btn_start
);

btn_l:entity WORK.mpg port map
(
btn=>btn(2),
clk=>clk,
en=>btn_directie
);
btn_r:entity WORK.mpg port map
(
btn=>btn(3),
clk=>clk,
en=>btn_alarma
);

afisor:entity WORK.displ7seg port map
(
Clk=>clk,
Rst=>btn_rst,
Data=>date,
An=>an,
Seg=>cat
);
date<=x"00" & afisor_ceas;
ceas:entity WORK.FSM port map
(
clk=>clk,
rst=>btn_rst,
sw=>sw,
btn_on_off=>btn_start,
btn_directie=>btn_directie,
btn_alarma=>btn_alarma,
date=>afisor_ceas,
led=>led(3 downto 0)

);
end Behavioral;
