library ieee;
use ieee.std_logic_1164.all;

entity switch_to_led is
	port(
		sw : in std_logic_vector( 9 downto 0);
		LEDR : out std_logic_vector( 9 downto 0)
		);
end switch_to_led;

architecture behavior of switch_to_led is

component mux_4to1 is
	port(
		x0, x1, x2, x3 : in std_logic;
		sel : in std_logic_vector (1 downto 0);
		y : out std_logic);
end component;

begin

	LEDR (9 downto 1) <= (others => '0');
	
	mux : mux_4to1 port map(
		SW(0), SW(1), SW(2), SW(3), SW(5 downto 4), LEDR(0)
		);
end behavior;