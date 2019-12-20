	library ieee;
		use ieee.std_logic_1164.all;
	
	entity vga is 
	port( 
			clk :  in std_logic;
			rst : in std_logic;
			h_sync_top : out std_logic;
			v_sync_top : out std_logic;
			sram_data_top : inout std_logic_vector(15 downto 0);
			sram_addr_top : out std_logic_vector(17 downto 0);
			sram_ChipEna_top : out std_logic; --/CE
			sram_WrEna_top  : out std_logic;  --/WE
			sram_OutEna_top : out std_logic; --/OE
			sram_HiMask_top : out std_logic;  -- /LoByteEn
			sram_LoMask_top : out std_logic;  -- /HiByteEn
			red_top :	OUT	STD_LOGIC_VECTOR(9 DOWNTO 0) := (OTHERS => '0');
			green_top:	OUT	STD_LOGIC_VECTOR(9 DOWNTO 0) := (OTHERS => '0');
			blue_top :	OUT	STD_LOGIC_VECTOR(9 DOWNTO 0) := (OTHERS => '0');
			--\\Following parameters based on Req of DE2 Board pin req spec 
			clk_vga			: out std_logic;
			sync_vga		: out std_logic;
			blank_vga_top	:out std_logic
			);
			
	end entity;
	
	architecture top of vga is
		component vga_cntrl is  
			generic (
						h_syncP : INTEGER := 128;     --horiztonal sync pulse
						h_bp : INTEGER := 16; --horiztonal back porch
						h_fp : INTEGER := 16; --horiztonal front porch width
						h_pixels : INTEGER := 640; --horiztonal display width
						h_pol : STD_LOGIC := '0'; --horizontal sync pulse polarity (1 = positive, 0 = negative)
						
						v_syncP : INTEGER := 2; --vertical sync pulse width in rows
						v_pixels : INTEGER := 480; --vertical display width in rows
						v_bp : INTEGER := 29; --vertical back porch width in rows
						v_fp : INTEGER := 10; --vertical front porch width in rows
						v_pol : STD_LOGIC := '0' --vertical sync pulse polarity (1 = positive, 0 = negative)
					);
			port  (
						pixelclk :in std_logic; -- Made for 25Mhz
						rst : in std_logic;
						h_sync : out std_logic;
						v_sync : out std_logic;
						DispEnable : out std_logic
						
					);
		end component;
		
-------------------------------------------------------------------------------
--							Demo Single Color Display - uncomment to function
-------------------------------------------------------------------------------		
		
--		component vga_image IS
--	GENERIC(
--		pixels_y :	INTEGER := 200;    --row that first color will persist until
--		pixels_x	:	INTEGER := 320);   --column that first color will persist until
--	PORT(
--		disp_ena		:	IN		STD_LOGIC;	--display enable ('1' = display time, '0' = blanking time)
--		row			:	IN		INTEGER;		--row pixel coordinate
--		column		:	IN		INTEGER;		--column pixel coordinate
--		red			:	OUT	STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');  --red magnitude output to DAC
--		green			:	OUT	STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');  --green magnitude output to DAC
--		blue			:	OUT	STD_LOGIC_VECTOR(1 DOWNTO 0) := (OTHERS => '0')); --blue magnitude output to DAC
--	end  component;
		
		
		component sram_cntrl is 
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
				sram_ChipEna : buffer std_logic; --/CE
				sram_WrEna  : buffer std_logic;  --/WE
				sram_OutEna : buffer std_logic; --/OE
				sram_HiMask : buffer std_logic;  -- /LoByteEn
				sram_LoMask : buffer std_logic;  -- /HiByteEn
				
				R  : buffer std_logic_vector(9 downto 0);
				G,B: out std_logic_vector(9 downto 0)
			);
		end component;
		
			
		component vga_pll
			PORT
			(
				areset		: IN STD_LOGIC  := '0';
				inclk0		: IN STD_LOGIC  := '0';
				c0		: OUT STD_LOGIC 
			);
		end component;

		signal Disp_ena_cntrl_image : std_logic;
		signal clk_25 :std_logic;
		
		
		
		begin
		---------------------
		--DE_2 Requirement
		---------------------
		DE2_spec:
					clk_vga<= clk_25;
					sync_vga <= '0';

			
			
	VGA_CNRL_blk :		
			entity work.vga_cntrl port map(
												pixelclk => clk_25,
												rst => rst,
												h_sync => h_sync_top, 
												v_sync => v_sync_top,
												DispEnable => Disp_ena_cntrl_image,
												blank_vga => blank_vga_top
												);
												
												
-------------------------------------------------------------------------------
--							Demo Single Color Display - uncomment to function
-------------------------------------------------------------------------------
--	VGA_IMAGE_blk:
--			entity work.vga_image port map( 
--												disp_ena => Disp_ena_cntrl_image,
--												row		=> row_cntrl_image,
--												column	=> col_cntrl_image,
--												red		=> red_top,
--												green		=> green_top,
--												blue		=> blue_top															
--												);
	VGA_SRAM_BLK: 																																																																																																																																																																																																																						
	
			entity work.sram_cntrl port map (
												rst => rst,
												vga_clk => clk_25,
												clk => clk,
												DispEna => Disp_ena_cntrl_image,
												
												sram_data => sram_data_top,
												sram_addr => sram_addr_top,
												sram_ChipEna => sram_ChipEna_top, --/CE
												sram_WrEna  => sram_WrEna_top,  --/WE
												sram_OutEna => sram_OutEna_top, --/OE
												sram_HiMask => sram_HiMask_top,  -- /LoByteEn
												sram_LoMask => sram_LoMask_top,  -- /HiByteEn
												
												R  => RED_top,
												G  => Green_top,
												B  => Blue_top
											);
	
	vga_pll_inst : vga_pll PORT MAP (
												areset	 => rst,
												inclk0	 => clk,
												
												c0	 => clk_25
												--locked	 => locked_sig
												);

	end top;									