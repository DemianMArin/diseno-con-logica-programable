library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uart_2 is 
	port
	(
		clk, reset: 	in 	std_logic;
		tx_start: 	in 	std_logic;
		--s_tick: 	in	std_logic;
		d_in: 		in 	std_logic_vector(7 downto 0); 
		tx_done_tick:	out	std_logic;
		tx: 		out 	std_logic;
		
		led_data : out std_logic_vector(7 downto 0) := (others => '1')
		
	);
end uart_2;

architecture transmission of uart_2 is 

	component baudrate_gen is
	generic
	(
    		--M = clk_freq / baudrate, without oversampling
		M: integer 	:= 434;	--M = 50 MHz / 9600
		N: integer	:= 9		--size of M
	);
	port
	(
		clk, reset:	in 	std_logic;
		tick: 		out 	std_logic
	);
	end component;
	
	signal s_tick: std_logic;
	signal d_in_u: std_logic_vector(7 downto 0);
	type state is (idle, start, data, stop);
	signal curr_state: state:=idle;
	signal	i:integer:=0;	

begin
		
		baud_gen: baudrate_gen generic map(434, 9)
		port map(clk=>clk,reset=>reset,tick=>s_tick);
		
		process(clk,reset)
		begin
			
			if (reset = '0') then
				led_data <= (others => '0');
				tx <= '0';
				curr_state <= idle;
				i <= 0;
				
			elsif rising_edge(clk) then
			
				case curr_state is 
					when idle =>
						tx <= '1';
						tx_done_tick <= '0';
						if(tx_start = '0' and s_tick = '1') then 
							curr_state <= start;
						else
							curr_state <= idle;
						end if;
					
					when start =>
						tx <= '0';
						
						if(s_tick ='1') then
							curr_state <= data;
						else 
							curr_state <= start;
						end if;
					
					when data =>
						tx <= d_in(i);
						--tx <= '1';
						--led_data(i) <= d_in(i);
						if((s_tick ='1') and (i <  7)) then
							i <=i+1;
							curr_state <= data;
						elsif (i>=7 and s_tick = '1') then
							curr_state <= stop;
							i <= 0;
						end if;
					
					when stop =>
						
						tx<='1';
						tx_done_tick<='1';
						if(s_tick ='1') then
							curr_state <= idle;
						else 
							curr_state <= stop;
						end if;				
					
				end case;
					
			end if;
			
		end process;
		
		
end architecture;

