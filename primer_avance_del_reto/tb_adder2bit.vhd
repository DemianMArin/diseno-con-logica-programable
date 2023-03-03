library ieee;
use ieee.std_logic_1164.all;

entity tb_adder2bit is
end tb_adder2bit;

architecture test of tb_adder2bit is
	component adder2bit
		port (
			a : in std_logic_vector(1 downto 0);
			b : in std_logic_vector(1 downto 0);
			ci : in std_logic;
			s: out std_logic_vector(1 downto 0);
			co : out std_logic
		);
	end component;
	
signal tb_a, tb_b, tb_s : std_logic_vector(1 downto 0);
signal tb_ci, tb_co : std_logic;
signal expect_s : std_logic_vector (1 downto 0);
signal expect_co : std_logic;

begin 
	dut : adder2bit port map(tb_a, tb_b, tb_ci, tb_s, tb_co);
	
	process
		begin
			tb_a <= "11"; tb_b <= "11"; tb_ci <= '0'; expect_s <= "10";  expect_co <= '1';
		wait;
	end process;
	
end test;