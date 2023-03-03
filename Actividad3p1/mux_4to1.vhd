Library ieee;
use ieee.std_logic_1164.all;

entity mux_4to1 is
	port(
		x0, x1, x2, x3 : in std_logic;
		sel				: in std_logic_vector (1 downto 0);
		y					: out std_logic
	);
end entity;

architecture behavioran of mux_4to1 is
begin
	y <= x3 when sel = "11" else
			x2 when sel = "10" else
			x1 when sel = "01" else
			x0;
end architecture;

