library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bin_to_7seg is 
	port(
		input: in std_logic_vector(3 downto 0);
		output : out std_logic_vector(7 downto 0)
		);
end entity;

architecture arch of bin_to_7seg is
	signal s: std_logic_vector(3 downto 0);
begin
	s<=input;
	process (s)
		begin
		case s is
			when "0000" => output <= not("00111111");
			when "0001" => output <= not("00000110");
			when "0010" => output <= not("01011011");
			when "0011" => output <= not("01001111");
			when "0100" => output <= not("01100110");
			when "0101" => output <= not("01101101");
			when "0110" => output <= not("01111101");
			when "0111" => output <= not("00000111");
			when "1000" => output <= not("01111111");
			when "1001" => output <= not("01101111");
			when others => output <= not("00000000");
		end case;
	end process;
end architecture;