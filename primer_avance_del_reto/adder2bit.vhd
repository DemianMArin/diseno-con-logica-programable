library ieee;
use ieee.std_logic_1164.all;

entity adder2bit is
	port(
		a : in std_logic_vector(1 downto 0);
		b : in std_logic_vector(1 downto 0);
		ci : in std_logic;
		s: out std_logic_vector(1 downto 0);
		co : out std_logic
		);
end adder2bit;

architecture structure of adder2bit is
	component fulladder
		port(
			a, b, ci : in std_logic;
			s, co : out std_logic
			);
	end component;
	
signal co1 : std_logic;

begin
	fa0 : fulladder
		port map (a(0),b(0),ci,s(0),co1);
		
	fa1 : fulladder 
		port map (a(1),b(1),co1,s(1),co);
	
end structure;