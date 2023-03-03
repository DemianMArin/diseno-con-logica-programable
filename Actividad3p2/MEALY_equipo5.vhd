library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity MEALY_equipo5 is
	port (
		clk_5: in STD_LOGIC;
		clr_5: in STD_LOGIC;
		w_5: in STD_LOGIC;
		z_5: out STD_LOGIC);
end MEALY_equipo5;

architecture behavior of MEALY_equipo5 is
	type state_type is (s0_5, s1_5, s2_5, s3_5);
	signal present_state_5, next_state_5 : state_type;
	
begin

	sreg: process(clk_5, clr_5)
	begin
		if clr_5 = '1' then
			present_state_5 <= s0_5;
		elsif clk_5'event and clk_5 = '1' then
			present_state_5 <= next_state_5;
		end if;
	end process;
	
	C1: process(present_state_5, w_5)
	begin
		case present_state_5 is
			when s0_5 =>
				if w_5 = '1' then
					next_state_5 <= s1_5;
				else
					next_state_5 <= s0_5;
				end if;
			
			when s1_5 =>
				if w_5 = '1' then
					next_state_5 <= s2_5;
				else
					next_state_5 <= s0_5;
				end if;
				
			when s2_5 =>
				if w_5 = '0' then
					next_state_5 <= s3_5;
				else
					next_state_5 <= s2_5;
				end if;
				
			when s3_5 =>
				if w_5 = '1' then
					next_state_5 <= s1_5;
				else
					next_state_5 <= s0_5;
				end if;
				
			when others => null;
		end case;
	end process;
	
	C2: process(clk_5, clr_5)
	begin
		if clr_5 = '1' then
			z_5 <= '0';
		elsif clk_5'event and clk_5 = '1' then
			if present_state_5 = s3_5 and w_5 = '1' then
				z_5 <= '1';
			else
				z_5 <= '0';
			end if;
		end if;
	end process;

end architecture;