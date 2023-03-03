library ieee;
use ieee.std_logic_1164.all;
use std.textio.all;
use ieee.std_logic_textio.all;

entity tb_alu is
end entity tb_alu;

architecture test of tb_alu is
	component ALU is
		port(
			sel_xwv : in std_logic_vector(2 downto 0);
			a, b : in std_logic_vector (1 downto 0);
			cout_final :out std_logic;
			result : out std_logic_vector(1 downto 0)
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
	
	signal sel_xwv_tb : std_logic_vector(2 downto 0);
	signal a_tb, b_tb : std_logic_vector (1 downto 0);
	signal cout_final_tb : std_logic;
	signal result_tb : std_logic_vector(1 downto 0);
	
	signal expected_result : std_logic_vector(1 downto 0);
	signal expected_cout : std_logic;
	
	begin
	
		UUT : ALU port map (sel_xwv_tb,a_tb,b_tb,cout_final_tb,result_tb);
		
		read_input : process
			file vector_file : text;
			variable stimulus_in : std_logic_vector(9 downto 0);
			variable str_stimulus_in : string(10 downto 1);
			variable file_line :line;
		begin
			file_open(vector_file,"D:\Diseno con logica programable\Primer_Avance_del_Reto\testvalues_alu.txt",read_mode);
			
			while not endfile(vector_file) loop
				readline (vector_file,file_line);
				read (file_line,str_stimulus_in);
				stimulus_in := str_to_stdvec(str_stimulus_in);
			
				sel_xwv_tb <= stimulus_in(9 downto 7);
				a_tb <= stimulus_in(6 downto 5);
				b_tb <= stimulus_in(4 downto 3);
				expected_result <= stimulus_in(2 downto 1);
				expected_cout <= stimulus_in(0);
				
				wait for 10 ns;
			end loop;
			
			file_close(vector_file);
			wait;
		end process read_input;
	
end architecture test;