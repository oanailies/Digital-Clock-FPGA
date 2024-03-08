


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FSM is
Port 
(
signal clk:in std_logic;
signal rst:in std_logic;
signal sw:in std_logic_vector(15 downto 0);
signal btn_on_off:in std_logic;
signal btn_directie:in std_logic;
signal btn_alarma:in std_logic;
signal date:out std_logic_vector(23 downto 0);
signal led:out std_logic_vector(3 downto 0)


 );
end FSM;

architecture Behavioral of FSM is

signal counter:integer:=0;
signal semnal_divizat_secunda:std_logic:='0';

signal secunde:std_logic_vector(5 downto 0):=(others=>'0');
signal minute:std_logic_vector(5 downto 0):=(others=>'0');
signal ore:std_logic_vector(4 downto 0):=(others=>'0');

signal secunde1:std_logic_vector(5 downto 0):=(others=>'0');
signal minute1:std_logic_vector(5 downto 0):=(others=>'0');
signal ore1:std_logic_vector(4 downto 0):=(others=>'0');

type stari is (meniu,ceas_on_off,directie,alarma);
signal stare_curenta:stari:=meniu;
signal stare_urmatoare:stari:=meniu;

signal semnal_oprire:std_logic:='1';
signal dir:std_logic:='1';
signal armat:std_logic:='0';
signal temp:std_logic;
begin
led<=semnal_oprire & dir & armat & temp;
process(clk,rst)
begin
if rst='1' then
counter<=0;
elsif clk='1' and clk'event then
    if counter<50000000 then
        counter<=counter+1;
    else
        counter<=0;
        semnal_divizat_secunda<=not(semnal_divizat_secunda);
    end if;
end if;
end process;

process(semnal_divizat_secunda,rst)
begin
if rst='1' then
secunde<=(others=>'0');
minute<=(others=>'0');
ore<=(others=>'0');

elsif semnal_divizat_secunda='1' and semnal_divizat_secunda'event then
    if semnal_oprire='1' then 
    if dir='1' then
        if secunde<"111100" then
            secunde<=secunde+1;
        else
            secunde<=(others=>'0');
            if minute<"111100" then
                minute<=minute+1;
            else
                minute<=(others=>'0');
                if ore<"11000" then
                ore<=ore+1;
                else
                ore<=(others=>'0');
                end if;
            end if;
        end if;
    else
       if secunde<"111100" then
            secunde<=secunde-1;
        else
            secunde<="111011";
            if minute<"111100" then
                minute<=minute-1;
            else
                minute<="111011";
                if ore<"11000" then
                ore<=ore-1;
                else
                ore<="10111";
                end if;
            end if;
        end if;
            
    end if;
        --else
--        if secunde>="000000" then
--            secunde<=secunde-1;
--        else
--            secunde<="111011;
--            if minute>="000000" then
--                minute<=minute-1;
--            else
--                minute<="111011;
--                if ore>="00000" then
--                ore<=ore-1;
--                else
--                ore<="10111";
--                end if;
--            end if;
--        end if;
    else
        -- do nothing
    end if;
    if armat='1' then
        if ore1=ore and minute1=minute then
            temp<='1';
        else
            temp<='0';
        end if;
    else
        temp<='0';
    end if;
end if;

end process;

process(ore)
begin

case ore is 
when "00000"=>date(23 downto 20)<="0000";date(19 downto 16)<="0000";
when "00001"=>date(23 downto 20)<="0000";date(19 downto 16)<="0001";
when "00010"=>date(23 downto 20)<="0000";date(19 downto 16)<="0010";
when "00011"=>date(23 downto 20)<="0000";date(19 downto 16)<="0011";
when "00100"=>date(23 downto 20)<="0000";date(19 downto 16)<="0100";
when "00101"=>date(23 downto 20)<="0000";date(19 downto 16)<="0101";
when "00110"=>date(23 downto 20)<="0000";date(19 downto 16)<="0110";
when "00111"=>date(23 downto 20)<="0000";date(19 downto 16)<="0111";
when "01000"=>date(23 downto 20)<="0000";date(19 downto 16)<="1000";
when "01001"=>date(23 downto 20)<="0000";date(19 downto 16)<="1001";
when "01010"=>date(23 downto 20)<="0001";date(19 downto 16)<="0000";
when "01011"=>date(23 downto 20)<="0001";date(19 downto 16)<="0001";
when "01100"=>date(23 downto 20)<="0001";date(19 downto 16)<="0010";
when "01101"=>date(23 downto 20)<="0001";date(19 downto 16)<="0011";
when "01110"=>date(23 downto 20)<="0001";date(19 downto 16)<="0100";
when "01111"=>date(23 downto 20)<="0001";date(19 downto 16)<="0101";
when "10000"=>date(23 downto 20)<="0001";date(19 downto 16)<="0110";
when "10001"=>date(23 downto 20)<="0001";date(19 downto 16)<="0111";
when "10010"=>date(23 downto 20)<="0001";date(19 downto 16)<="1000";
when "10011"=>date(23 downto 20)<="0001";date(19 downto 16)<="1001";
when "10100"=>date(23 downto 20)<="0010";date(19 downto 16)<="0000";
when "10101"=>date(23 downto 20)<="0010";date(19 downto 16)<="0001";
when "10110"=>date(23 downto 20)<="0010";date(19 downto 16)<="0010";
when others=>date(23 downto 20)<="0010";date(19 downto 16)<="0011";
end case;
end process;

process(minute)
begin

case minute is 
when "000000"=>date(15 downto 12)<="0000";date(11 downto 8)<="0000"; --0
when "000001"=>date(15 downto 12)<="0000";date(11 downto 8)<="0001"; --1
when "000010"=>date(15 downto 12)<="0000";date(11 downto 8)<="0010"; --2
when "000011"=>date(15 downto 12)<="0000";date(11 downto 8)<="0011"; --3
when "000100"=>date(15 downto 12)<="0000";date(11 downto 8)<="0100"; --4
when "000101"=>date(15 downto 12)<="0000";date(11 downto 8)<="0101"; --5
when "000110"=>date(15 downto 12)<="0000";date(11 downto 8)<="0110"; --6
when "000111"=>date(15 downto 12)<="0000";date(11 downto 8)<="0111"; --7
when "001000"=>date(15 downto 12)<="0000";date(11 downto 8)<="1000"; --8
when "001001"=>date(15 downto 12)<="0000";date(11 downto 8)<="1001"; --9
when "001010"=>date(15 downto 12)<="0001";date(11 downto 8)<="0000"; --10
when "001011"=>date(15 downto 12)<="0001";date(11 downto 8)<="0001"; --11
when "001100"=>date(15 downto 12)<="0001";date(11 downto 8)<="0010"; --12
when "001101"=>date(15 downto 12)<="0001";date(11 downto 8)<="0011"; --13
when "001110"=>date(15 downto 12)<="0001";date(11 downto 8)<="0100"; --14
when "001111"=>date(15 downto 12)<="0001";date(11 downto 8)<="0101"; --15
when "010000"=>date(15 downto 12)<="0001";date(11 downto 8)<="0110"; --16
when "010001"=>date(15 downto 12)<="0001";date(11 downto 8)<="0111"; --17
when "010010"=>date(15 downto 12)<="0001";date(11 downto 8)<="1000"; --18
when "010011"=>date(15 downto 12)<="0001";date(11 downto 8)<="1001"; --19
when "010100"=>date(15 downto 12)<="0010";date(11 downto 8)<="0000"; --20
when "010101"=>date(15 downto 12)<="0010";date(11 downto 8)<="0001"; --21
when "010110"=>date(15 downto 12)<="0010";date(11 downto 8)<="0010"; --22
when "010111"=>date(15 downto 12)<="0010";date(11 downto 8)<="0011"; --23
when "011000"=>date(15 downto 12)<="0010";date(11 downto 8)<="0100"; --24
when "011001"=>date(15 downto 12)<="0010";date(11 downto 8)<="0101"; --25
when "011010"=>date(15 downto 12)<="0010";date(11 downto 8)<="0110"; --26
when "011011"=>date(15 downto 12)<="0010";date(11 downto 8)<="0111"; --27
when "011100"=>date(15 downto 12)<="0010";date(11 downto 8)<="1000"; --28
when "011101"=>date(15 downto 12)<="0010";date(11 downto 8)<="1001"; --29
when "011110"=>date(15 downto 12)<="0011";date(11 downto 8)<="0000"; --30
when "011111"=>date(15 downto 12)<="0011";date(11 downto 8)<="0001"; --31
when "100000"=>date(15 downto 12)<="0011";date(11 downto 8)<="0010"; --32
when "100001"=>date(15 downto 12)<="0011";date(11 downto 8)<="0011"; --33
when "100010"=>date(15 downto 12)<="0011";date(11 downto 8)<="0100"; --34
when "100011"=>date(15 downto 12)<="0011";date(11 downto 8)<="0101"; --35
when "100100"=>date(15 downto 12)<="0011";date(11 downto 8)<="0110"; --36
when "100101"=>date(15 downto 12)<="0011";date(11 downto 8)<="0111"; --37
when "100110"=>date(15 downto 12)<="0011";date(11 downto 8)<="1000"; --38
when "100111"=>date(15 downto 12)<="0011";date(11 downto 8)<="1001"; --39
when "101000"=>date(15 downto 12)<="0100";date(11 downto 8)<="0000"; --40
when "101001"=>date(15 downto 12)<="0100";date(11 downto 8)<="0001"; --41
when "101010"=>date(15 downto 12)<="0100";date(11 downto 8)<="0010"; --42
when "101011"=>date(15 downto 12)<="0100";date(11 downto 8)<="0011"; --43
when "101100"=>date(15 downto 12)<="0100";date(11 downto 8)<="0100"; --44
when "101101"=>date(15 downto 12)<="0100";date(11 downto 8)<="0101"; --45
when "101110"=>date(15 downto 12)<="0100";date(11 downto 8)<="0110"; --46
when "101111"=>date(15 downto 12)<="0100";date(11 downto 8)<="0111"; --47
when "110000"=>date(15 downto 12)<="0100";date(11 downto 8)<="1000"; --48
when "110001"=>date(15 downto 12)<="0100";date(11 downto 8)<="1001"; --49
when "110010"=>date(15 downto 12)<="0101";date(11 downto 8)<="0000"; --50
when "110011"=>date(15 downto 12)<="0101";date(11 downto 8)<="0001"; --51
when "110100"=>date(15 downto 12)<="0101";date(11 downto 8)<="0010"; --52
when "110101"=>date(15 downto 12)<="0101";date(11 downto 8)<="0011"; --53
when "110110"=>date(15 downto 12)<="0101";date(11 downto 8)<="0100"; --54
when "110111"=>date(15 downto 12)<="0101";date(11 downto 8)<="0101"; --55
when "111000"=>date(15 downto 12)<="0101";date(11 downto 8)<="0110"; --56
when "111001"=>date(15 downto 12)<="0101";date(11 downto 8)<="0111"; --57
when "111010"=>date(15 downto 12)<="0101";date(11 downto 8)<="1000"; --58
when others=>date(15 downto 12)<="0101";date(11 downto 8)<="1001"; --59
end case;
end process;


process(secunde)
begin

case secunde is 
when "000000"=>date(7 downto 4)<="0000";date(3 downto 0)<="0000"; --0
when "000001"=>date(7 downto 4)<="0000";date(3 downto 0)<="0001"; --1
when "000010"=>date(7 downto 4)<="0000";date(3 downto 0)<="0010"; --2
when "000011"=>date(7 downto 4)<="0000";date(3 downto 0)<="0011"; --3
when "000100"=>date(7 downto 4)<="0000";date(3 downto 0)<="0100"; --4
when "000101"=>date(7 downto 4)<="0000";date(3 downto 0)<="0101"; --5
when "000110"=>date(7 downto 4)<="0000";date(3 downto 0)<="0110"; --6
when "000111"=>date(7 downto 4)<="0000";date(3 downto 0)<="0111"; --7
when "001000"=>date(7 downto 4)<="0000";date(3 downto 0)<="1000"; --8
when "001001"=>date(7 downto 4)<="0000";date(3 downto 0)<="1001"; --9
when "001010"=>date(7 downto 4)<="0001";date(3 downto 0)<="0000"; --10
when "001011"=>date(7 downto 4)<="0001";date(3 downto 0)<="0001"; --11
when "001100"=>date(7 downto 4)<="0001";date(3 downto 0)<="0010"; --12
when "001101"=>date(7 downto 4)<="0001";date(3 downto 0)<="0011"; --13
when "001110"=>date(7 downto 4)<="0001";date(3 downto 0)<="0100"; --14
when "001111"=>date(7 downto 4)<="0001";date(3 downto 0)<="0101"; --15
when "010000"=>date(7 downto 4)<="0001";date(3 downto 0)<="0110"; --16
when "010001"=>date(7 downto 4)<="0001";date(3 downto 0)<="0111"; --17
when "010010"=>date(7 downto 4)<="0001";date(3 downto 0)<="1000"; --18
when "010011"=>date(7 downto 4)<="0001";date(3 downto 0)<="1001"; --19
when "010100"=>date(7 downto 4)<="0010";date(3 downto 0)<="0000"; --20
when "010101"=>date(7 downto 4)<="0010";date(3 downto 0)<="0001"; --21
when "010110"=>date(7 downto 4)<="0010";date(3 downto 0)<="0010"; --22
when "010111"=>date(7 downto 4)<="0010";date(3 downto 0)<="0011"; --23
when "011000"=>date(7 downto 4)<="0010";date(3 downto 0)<="0100"; --24
when "011001"=>date(7 downto 4)<="0010";date(3 downto 0)<="0101"; --25
when "011010"=>date(7 downto 4)<="0010";date(3 downto 0)<="0110"; --26
when "011011"=>date(7 downto 4)<="0010";date(3 downto 0)<="0111"; --27
when "011100"=>date(7 downto 4)<="0010";date(3 downto 0)<="1000"; --28
when "011101"=>date(7 downto 4)<="0010";date(3 downto 0)<="1001"; --29
when "011110"=>date(7 downto 4)<="0011";date(3 downto 0)<="0000"; --30
when "011111"=>date(7 downto 4)<="0011";date(3 downto 0)<="0001"; --31
when "100000"=>date(7 downto 4)<="0011";date(3 downto 0)<="0010"; --32
when "100001"=>date(7 downto 4)<="0011";date(3 downto 0)<="0011"; --33
when "100010"=>date(7 downto 4)<="0011";date(3 downto 0)<="0100"; --34
when "100011"=>date(7 downto 4)<="0011";date(3 downto 0)<="0101"; --35
when "100100"=>date(7 downto 4)<="0011";date(3 downto 0)<="0110"; --36
when "100101"=>date(7 downto 4)<="0011";date(3 downto 0)<="0111"; --37
when "100110"=>date(7 downto 4)<="0011";date(3 downto 0)<="1000"; --38
when "100111"=>date(7 downto 4)<="0011";date(3 downto 0)<="1001"; --39
when "101000"=>date(7 downto 4)<="0100";date(3 downto 0)<="0000"; --40
when "101001"=>date(7 downto 4)<="0100";date(3 downto 0)<="0001"; --41
when "101010"=>date(7 downto 4)<="0100";date(3 downto 0)<="0010"; --42
when "101011"=>date(7 downto 4)<="0100";date(3 downto 0)<="0011"; --43
when "101100"=>date(7 downto 4)<="0100";date(3 downto 0)<="0100"; --44
when "101101"=>date(7 downto 4)<="0100";date(3 downto 0)<="0101"; --45
when "101110"=>date(7 downto 4)<="0100";date(3 downto 0)<="0110"; --46
when "101111"=>date(7 downto 4)<="0100";date(3 downto 0)<="0111"; --47
when "110000"=>date(7 downto 4)<="0100";date(3 downto 0)<="1000"; --48
when "110001"=>date(7 downto 4)<="0100";date(3 downto 0)<="1001"; --49
when "110010"=>date(7 downto 4)<="0101";date(3 downto 0)<="0000"; --50
when "110011"=>date(7 downto 4)<="0101";date(3 downto 0)<="0001"; --51
when "110100"=>date(7 downto 4)<="0101";date(3 downto 0)<="0010"; --52
when "110101"=>date(7 downto 4)<="0101";date(3 downto 0)<="0011"; --53
when "110110"=>date(7 downto 4)<="0101";date(3 downto 0)<="0100"; --54
when "110111"=>date(7 downto 4)<="0101";date(3 downto 0)<="0101"; --55
when "111000"=>date(7 downto 4)<="0101";date(3 downto 0)<="0110"; --56
when "111001"=>date(7 downto 4)<="0101";date(3 downto 0)<="0111"; --57
when "111010"=>date(7 downto 4)<="0101";date(3 downto 0)<="1000"; --58
when others=>date(7 downto 4)<="0101";date(3 downto 0)<="1001"; --59
end case;
end process;


process(clk,rst)
begin
if rst='1' then
stare_curenta<=meniu;
elsif clk'event and clk='1' then
stare_curenta<=stare_urmatoare;
end if;
end process;

process(stare_curenta,btn_on_off,btn_directie,btn_alarma)
begin
case stare_curenta is 
when meniu=>if btn_on_off='1' then
                stare_urmatoare<=ceas_on_off;
            elsif btn_directie='1' then
                stare_urmatoare<=directie;
            elsif btn_alarma='1' then 
                stare_urmatoare<=alarma;
            else
                stare_urmatoare<=meniu;
            end if;
when ceas_on_off=>stare_urmatoare<=meniu;
when directie=>stare_urmatoare<=meniu;
when others=>stare_urmatoare<=meniu;
end case;
end process;

process(clk)
begin
if clk='1' and clk'event then       
    if stare_curenta=ceas_on_off then
        semnal_oprire<=not(semnal_oprire);
    elsif stare_curenta=directie then
        dir<=not(dir);
    elsif  stare_curenta=alarma then
        armat<=not(armat);
        ore1<=sw(15 downto 11);
        minute1<=sw(10 downto 5);
    end if;
end if;
end process;
end Behavioral;
