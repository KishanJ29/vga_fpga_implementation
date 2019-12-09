	use library ieee;
			use ieee_std_logic_1164.all;
			use ieee_numeric_std.all;
	entity sram_cntrl is 
		port(
				clk : in std_logic;
				row : in std_logic;
				col : in std_logic;
				DispEna : in std_logic;
				sram_ChipEna : out std_logic;
				sram_data : inout std_logic_vector(15 downto 0);
				sram_addr : out std_logic_vector(17 downto 0);
				sram_WrEna  : out std_logic;
				sram_HiMask : out std_logic;
				sram_LoMask : out std_logic
			);
	end entity;
	
	use architecture behave of sram_cntrl is 
	 begin 
	signal PixCount : integer;
	constant readset : std_logic := '1';
	constant chipselect : std_logic := '1';
	constant HIMasKbit : std_logic := '1';
	constant LOMasKbit : std_logic := '1';
	constant DataSet  : std_logic_vector(15 downto 0);
	
begin
		DataSet <= (others <= 'z') when readset = '1'  else "10101011";
		
		process(clk,DispEna)
		begin
			if(DispEna = '1')then
				sram_ChipEna <= '0';
				PixCount <= PixCount + 1;
			else 
				sram_ChipEna <= '1';
			end if;
		end process;