library  ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tail_lights_tb is
end entity;

architecture test of tail_lights_tb is
	
	constant clockfrequencyhz : integer := 10;
   constant clockperiod : time := 1000 ms / clockfrequencyhz;
	

	
	component tail_lights 
		generic(clockfrequencyhz : integer);
		port(
			clk, rst : in std_logic;
			l, r, b : in std_logic;
			ltl, rtl :out std_logic_vector (2 downto 0)
		);
	end component;
	
	signal clk, rst : std_logic := '0';
	signal l, r, b : std_logic := '0';
	signal ltl, rtl : std_logic_vector (2 downto 0);
	
	begin
	
		fsm_mustang : tail_lights 
		generic map (clockfrequencyhz => clockfrequencyhz)
		port map(clk=>clk, rst=>rst, l=>l, r=>r, b=>b, ltl=>ltl, rtl=>rtl);
		
		clk <= not clk after clockperiod / 2;
		
		process
		begin
			wait until rising_edge(clk);
			wait until rising_edge(clk);
			
			rst <= '0'; l<='1';
			
			wait for clockperiod * clockfrequencyhz * 3;
			
			rst <= '0'; r<='1';
			
			wait for clockperiod * clockfrequencyhz * 3;
			
			rst <= '0'; b <= '1';
				
			wait;
			
		end process;
	
	
end architecture;