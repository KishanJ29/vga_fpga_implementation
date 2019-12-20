	
	library ieee;
			use ieee.std_logic_1164.all;
			use ieee.numeric_std.all;
	entity sram_cntrl is 
		generic(
					sram_address_number : integer := 153600
				 );
		port(	
				rst : in std_logic;
				vga_clk : in std_logic;
				clk : in std_logic;
				DispEna : in std_logic;
				
				sram_data : inout std_logic_vector(15 downto 0);
				sram_addr : out std_logic_vector(17 downto 0);
				sram_ChipEna : out std_logic; --/CE
				sram_WrEna  : out std_logic;  --/WE
				sram_OutEna : out std_logic; --/OE
				sram_HiMask : out std_logic;  -- /LoByteEn
				sram_LoMask : out std_logic;  -- /HiByteEn
				
				R  : buffer std_logic_vector(9 downto 0);
				G,B: out std_logic_vector(9 downto 0)
			);
	end entity;
	
architecture behave of sram_cntrl is 
	 
	type  sram_mode is (FIRST, SECOND );
	signal SRAM_ARRAY : std_logic_vector(4 downto 0);
	signal AddrCount : integer range 0 to 200000;--unsigned(17 downto 0):=(others =>'0');
	signal curr_sram_mode : sram_mode;

	
	signal sram_ChipEna_int :  std_logic; --/CE
	signal sram_WrEna_int  :  std_logic;  --/WE
	signal sram_OutEna_int :  std_logic; --/OE
	signal sram_HiMask_int :  std_logic;  -- /LoByteEn
	signal sram_LoMask_int :  std_logic;  -- /HiByteEn
				
	signal R_int  :  std_logic_vector(9 downto 0);
	
	signal hcnt :integer;
	signal vcnt : integer;
	signal hflag :std_logic;
	signal vflag :std_logic;
	signal Addr_inc : std_logic;
	signal ns : std_logic;
	signal rgb : std_logic_vector(29 downto 0);
begin
		sram_ChipEna <= sram_ChipEna_int;
		sram_WrEna	 <=	sram_WrEna_int;
		sram_OutEna	<= sram_OutEna_int;
		sram_HiMask <= sram_HiMask_int;
		sram_LoMask <= sram_LoMask_int;
		
---------------------------------------------------------------------
--						VGA set to MONOCHROME DISPLAY eqating R=G=B
---------------------------------------------------------------------		
		G <= rgb(19 downto 10);
		B <= rgb(29 downto 20);
		R <= rgb(9 downto 0); 
---------------------------------------------------------------------
		
		sram_data <= (others => 'Z') when sram_WrEna_int = '1'  else (others => '1');
	    
		sram_ChipEna_int <=SRAM_ARRAY(4);
	    sram_OutEna_int <= SRAM_ARRAY(3); 
		sram_WrEna_int  <= SRAM_ARRAY(2);
		sram_LoMask_int <= SRAM_ARRAY(1);
		sram_HiMask_int <= SRAM_ARRAY(0);
 
 	SRAM_ARRAY <= "00100"; -- Retriveing data Input first 

---------------------------------------------------------------------
		-- 		SRAM FSM
---------------------------------------------------------------------

		process(vga_clk,rst)
		begin
		if(rst = '1')then
			AddrCount <= 0;
			curr_sram_mode <= FIRST;
 
		elsif(rising_edge(vga_clk))then 
			if(DispEna = '1' and AddrCount <= (sram_address_number))then
				case(curr_sram_mode)is
				when FIRST =>
					rgb  <= ((sram_data(7 downto 0)& "00")&(sram_data(7 downto 0)& "00")&(sram_data(7 downto 0)& "00"));
					curr_sram_mode <= SECOND;
				when SECOND =>
					 rgb  <= ((sram_data(15 downto 8)& "00")&(sram_data(15 downto 8)& "00")&(sram_data(15 downto 8)& "00"));
					 AddrCount <= AddrCount + 1;
					 curr_sram_mode <= FIRST;
				end case;
			elsif(AddrCount = (sram_address_number))then
				rgb  <= (others => '0');
				AddrCount <= 0;
			end if;
		  end if;
	 sram_addr <= std_logic_vector(to_unsigned((AddrCount),18));
		 end process;

end behave;
		
