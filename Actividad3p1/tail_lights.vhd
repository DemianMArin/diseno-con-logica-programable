library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tail_lights is
	generic(clockfrequencyhz : integer := 10);
	port(
		
		clk, rst : in std_logic;
		l, r, b : in std_logic;
		ltl, rtl : out std_logic_vector (2 downto 0)
	);
end entity tail_lights;

architecture fsm of tail_lights is
	type state_tl is(s0, lefts, rights, blinkers);
	signal curr_state : state_tl;
	
	signal counter : integer range 0 to clockfrequencyhz * 60;
	

	
	begin 
		action_of_state : process(clk)
			variable ltl_pos, rtl_pos : integer range 0 to 2 := 0;
			variable blnk_pos : integer range 0 to 1 := 0;
		begin
			if rising_edge(clk) then
				if rst = '1' then
					--curr_state = s0;
					ltl <= (others => '0');
					rtl <= (others => '0');
					
				else
					counter  <= counter + 1;
					
					case curr_state is
					when lefts =>
						if ltl_pos = 0 and counter = clockfrequencyhz -1 then
							ltl <= "001";
							ltl_pos := 1;
							counter <= 0;
						elsif ltl_pos = 1 and counter = clockfrequencyhz -1 then
							ltl <= "011";
							ltl_pos := 2;
							counter <= 0;
						elsif ltl_pos = 2 and counter = clockfrequencyhz -1 then
							ltl <= "111";
							ltl_pos := 0;
							counter <= 0;
						end if;
						
					when rights =>
						if rtl_pos = 0 and counter = clockfrequencyhz -1 then
							rtl <= "001";
							rtl_pos := 1;
							counter <= 0;
						elsif rtl_pos = 1 and counter = clockfrequencyhz -1 then
							rtl <= "011";
							rtl_pos := 2;
							counter <= 0;
						elsif rtl_pos = 2 and counter = clockfrequencyhz -1 then
							rtl <= "111";
							rtl_pos := 0;
							counter <= 0;
						end if;
						
					when blinkers =>
						if blnk_pos = 0 and counter = clockfrequencyhz -1 then
							ltl <= "111";
							rtl <= "111";
							blnk_pos := 1;
							counter <= 0;
						elsif blnk_pos = 1 and counter = clockfrequencyhz -1 then
							ltl <= "000";
							rtl <= "000";
							blnk_pos := 0;
							counter <= 0;
						end if;
							
					when s0 => 
						ltl <= "000";
						rtl <= "000";
					
						
					when others =>
						ltl <= "000";
						rtl <= "000";
					
					end case;
					
				end if;
				
			end if;
			
		end process action_of_state;
		
		change_state : process(clk) 
		begin
			if rising_edge(clk) then
				if rst = '1' then
					curr_state <= s0;
				else
					case curr_state is
						when s0 =>
							if r = '1' and b = '0' then
								curr_state <= rights;
							elsif l = '1' and b = '0' then
								curr_state <= lefts;
							elsif b = '1' then
								curr_state <= blinkers;
							else
								curr_state <= s0;
							end if;
						
						when lefts =>
							if l = '0' then
								curr_state <= s0;
							elsif b = '1' then
								curr_state <= blinkers;
							elsif r = '1' and b = '0' then
								curr_state <= rights;
							else
								curr_state <= lefts;
							end if;
							
						when rights => 
							if r = '0' then
								curr_state <= s0;
							elsif b = '1' then
								curr_state <= blinkers;
							elsif l = '1' and b = '0' then
								curr_state <= lefts;
							else
								curr_state <= rights;
							end if;
							
						when blinkers =>
							if b = '0' then
								curr_state <= s0;
							end if;
								
						when others =>
							curr_state <= s0;
					end case;
							
				end if;
			end if;
		end process;
		
end architecture fsm;