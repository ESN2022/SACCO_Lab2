library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter is 
	port (
		clk	: in  std_logic;
      reset	: in  std_logic;
		segment : out std_logic_vector(23 downto 0)
      );
end entity;


architecture arch of counter is
	
	component lab2 is	
		port (
			clk_clk                          : in  std_logic                    := 'X'; -- clk
			pio_0_external_connection_export : out std_logic_vector(11 downto 0);        -- export
			reset_reset_n                    : in  std_logic                    := 'X'  -- reset_n
		);
		end component;

	component bin_to_7seg is	
			port(
				input: in std_logic_vector(3 downto 0);
				output : out std_logic_vector(7 downto 0)
			);
		end component;
	
	
	signal unit: std_logic_vector(3 downto 0);
	signal ten: std_logic_vector(3 downto 0);
	signal hundred: std_logic_vector(3 downto 0);
	
	begin
		u0 : component lab2
			port map (
				clk_clk                          => clk,                          --                       clk.clk
				pio_0_external_connection_export(3 downto 0) => unit, -- pio_0_external_connection.export
				pio_0_external_connection_export(7 downto 4) => ten, -- pio_0_external_connection.export
				pio_0_external_connection_export(11 downto 8) => hundred, -- pio_0_external_connection.export
				reset_reset_n                    => reset                     --                     reset.reset_n
			);

		u1: component bin_to_7seg 
			port map (
				input									=> unit,                         
				output 								=> segment(7 downto 0)
			);	
		u2: component bin_to_7seg 
			port map (
				input									=> ten,                         
				output 								=> segment(15 downto 8)
			);	
		u3: component bin_to_7seg 
			port map (
				input									=> hundred,                         
				output 								=> segment(23 downto 16)
			);	

end architecture;