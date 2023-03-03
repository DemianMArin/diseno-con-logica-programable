library ieee;
use ieee.std_logic_1164.all;

entity  fulladder is
	port( a, b, ci : in std_logic;
			s, co : out std_logic
			);
end fulladder;

architecture behavior of fulladder is
begin
	process(a, b, ci)
	begin
		s <= (a xor b) xor ci;
		co <= (a and b) or (ci and a) or (ci and b);
	end process;
end behavior;