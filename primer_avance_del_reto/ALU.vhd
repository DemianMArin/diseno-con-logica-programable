library ieee;
use ieee.std_logic_1164.all;

entity ALU is
	port(
		sel_xwv : in std_logic_vector(2 downto 0);
		a, b : in std_logic_vector (1 downto 0);
		cout_final :out std_logic;
		result : out std_logic_vector(1 downto 0)
	);
end ALU;

architecture behavior of ALU is
	component mux8to1
		port(
			x : in std_logic_vector (7 downto 0);
			sel : in std_logic_vector (2 downto 0);
			y : out std_logic := '0'
	
		);
	end component;
	
	component adder2bit is
		port(
			a : in std_logic_vector(1 downto 0);
			b : in std_logic_vector(1 downto 0);
			ci : in std_logic;
			s: out std_logic_vector(1 downto 0);
			co : out std_logic
			);
	end component;
	
		
	signal a0_invec : std_logic_vector (7 downto 0) := (others => '1');
	signal a0_outvec : std_logic := '0';
	signal a1_invec : std_logic_vector (7 downto 0) := (others => '1');
	signal a1_outvec : std_logic := '0';
	
	signal b0_invec : std_logic_vector (7 downto 0) := (others => '1');
	signal b0_outvec : std_logic := '0';
	signal b1_invec : std_logic_vector (7 downto 0) := (others => '1');
	signal b1_outvec : std_logic := '0';
	
	signal cin_invec : std_logic_vector(7 downto 0) := (others => '0');
	signal cin_outvec : std_logic := '0';
	
	signal a_add : std_logic_vector(1 downto 0);
	signal b_add : std_logic_vector(1 downto 0);
	signal cin_add : std_logic;
	
	
	
begin

	a0mux: mux8to1 port map(a0_invec, sel_xwv, a0_outvec);
	a1mux: mux8to1 port map(a1_invec, sel_xwv, a1_outvec);
	b0mux: mux8to1 port map(b0_invec, sel_xwv, b0_outvec);
	b1mux: mux8to1 port map(b1_invec, sel_xwv, b1_outvec);
	cinmux: mux8to1 port map(cin_invec, sel_xwv, cin_outvec);
	
	a_add <= (0 => a0_outvec, 1 => a1_outvec);
	b_add <= (0 => b0_outvec, 1 => b1_outvec);
	cin_add <= cin_outvec;

	
	add: adder2bit port map(
		a_add,
		b_add,
		cin_outvec,
		result,
		cout_final
	);

	process(a, b, sel_xwv)
		
	begin
		
		declaring_a : case sel_xwv is
			when "000" => a0_invec <= (others => a(0)); a1_invec<= (others => a(1));
			when "001" => a0_invec <= (others => a(0)); a1_invec<= (others => a(1));
			when "010" => a0_invec <= (others => a(0)); a1_invec<= (others => a(1));
			when "011" => a0_invec<= (3 => '0', others => a(0)); a1_invec<= (3 => '0', others => a(1));	
			when "100" => a0_invec<= (4 => a(0) and b(0), others => a(0)); a1_invec <= (4 => a(1) and b(1), others => a(1));
			when "101" => a0_invec<= (5 => a(0) or b(0), others => a(0)); a1_invec<= (5 => a(1) or b(1), others => a(1));
			when "110" => a0_invec<= (6 => a(0) xor b(0), others => a(0)); a1_invec<= (6 => a(1) xor b(1), others => a(1));
			when "111" => a0_invec<= (7 => not a(0), others => a(0)); a1_invec<= (7 => not a(1), others => a(1));
			when others => a0_invec <= (others => a(0)); a1_invec<= (others => a(1));
		end case;
		
		declaring_b : case sel_xwv is
			when "000" => b0_invec <= (others => b(0)); b1_invec<= (others => b(1));
			when "001" => b0_invec<= (1 => not b(0), others => b(0)); b1_invec<= (1 => not b(1), others => b(1));
			when others => b0_invec <= (others => '0'); b1_invec <= (others => '0');
		end case;
		
		
		declaring_cin : case sel_xwv is
			when "000" => cin_invec<= (0 => '0', others => '-');
			when "001" => cin_invec<= (1 => '1', others => '-');
			when "010" => cin_invec<= (2 => '1', others => '-');
			when others => cin_invec <= (others => '0');
		end case;
		

	end process;
--	
--	a_add <= (0 => a0_outvec, 1 => a1_outvec);
--	b_add <= (0 => b0_outvec, 1 => b1_outvec);
--	c_add <= cin_outvec;
		
end behavior;
