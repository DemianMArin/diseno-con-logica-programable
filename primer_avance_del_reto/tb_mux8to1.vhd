library ieee;
use ieee.std_logic_1164.all;
use std.textio.all;
use ieee.std_logic_textio.all;

entity tb_mux8to1 is
end entity tb_mux8to1;

architecture stimulus of tb_mux8to1 is
	component mux8to1 is
			port(
			x : in std_logic_vector (7 downto 0);
			sel : in std_logic_vector (2 downto 0);
			y : out std_logic
		);
	end component;
	
	function str_to_stdvec(inp : string) return std_logic_vector is
		variable temp : std_logic_vector(inp'range) := (others => '-');
	begin
		for i in inp'range loop
			if (inp(i) = '1') then
				temp(i) := '1';
			elsif (inp(i) = '0') then
				temp(i) := '0';
			end if;
		end loop;
		return temp;
	end function;
	
	signal x_tb : std_logic_vector (7 downto 0);
	signal sel_tb : std_logic_vector (2 downto 0);
	signal y_tb : std_logic;
	signal y_expected : std_logic;
	
	begin
		UUT : mux8to1 port map (x_tb,sel_tb,y_tb);
		
		read_input : process
			file vector_file : text;
			variable stimulus_in : std_logic_vector(11 downto 0);
			variable str_stimulus_in : string(12 downto 1);
			variable file_line :line;
		begin
			file_open(vector_file,"D:\Diseno con logica programable\Primer_Avance_del_Reto\testvalues.txt",read_mode);
			
			for i in 1 to 5 loop
				readline (vector_file,file_line);
				read (file_line,str_stimulus_in);
				stimulus_in := str_to_stdvec(str_stimulus_in);
				sel_tb <= stimulus_in(11 downto 9);
				x_tb <= stimulus_in(8 downto 1);
				y_expected <= stimulus_in(0);
				wait for 10 ns;
			end loop;
			
			file_close(vector_file);
			wait;
		end process read_input;
			
			
end architecture stimulus;