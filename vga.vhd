	library ieee;
		use ieee.std_logic_1164.all;
	
	entity vga is 
	port( 
			clk :  in std_logic;
			rst : in std_logic;
			h_sync_top : out std_logic;
			v_sync_top : out std_logic;
			red_top :	OUT	STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
			green_top:	OUT	STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
			blue_top :	OUT	STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0')
			);
			
	end entity;
	
	architecture top of vga is
		component vga_cntrl is  
			generic (
						h_syncP : INTEGER := 96;     --horiztonal sync pulse
						h_bp : INTEGER := 16; --horiztonal back porch
						h_fp : INTEGER := 16 ; --horiztonal front porch width
						h_pixels : INTEGER := 640; --horiztonal display width
						h_pol : STD_LOGIC := '0'; --horizontal sync pulse polarity (1 = positive, 0 = negative)
						v_syncP : INTEGER := 2 ; --vertical sync pulse width in rows
						v_pixels : INTEGER := 480; --vertical display width in rows
						v_bp : INTEGER := 31; --vertical back porch width in rows
						v_fp : INTEGER := 11; --vertical front porch width in rows
						v_pol : STD_LOGIC := '0' --vertical sync pulse polarity (1 = positive, 0 = negative)
						);
			port  (
						pixelclk :in std_logic; -- Made for 25Mhz
						rst : in std_logic;
						h_sync : out std_logic;
						v_sync : out std_logic;
						DispEnable : out std_logic;
						row : buffer  integer range 0 to 1000;
						col : buffer integer range 0 to 1000
					);
		end component;
		component vga_image IS
--	GENERIC(
--		pixels_y :	INTEGER := 478;    --row that first color will persist until
--		pixels_x	:	INTEGER := 600);   --column that first color will persist until
	PORT(
		disp_ena		:	IN		STD_LOGIC;	--display enable ('1' = display time, '0' = blanking time)
		row			:	IN		INTEGER;		--row pixel coordinate
		column		:	IN		INTEGER;		--column pixel coordinate
		red			:	OUT	STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');  --red magnitude output to DAC
		green			:	OUT	STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');  --green magnitude output to DAC
		blue			:	OUT	STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0')); --blue magnitude output to DAC
	end  component;
			
		signal row_cntrl_image : integer;
		signal col_cntrl_image : integer;
		signal disp_ena_cntrl_image : std_logic;
		begin
	VGA_CNRL_blk :		
			entity work.vga_cntrl port map(
												pixelclk => clk,
												rst => rst,
												h_sync => h_sync_top, 
												v_sync => v_sync_top,
												DispEnable => Disp_ena_cntrl_image,
												row => row_cntrl_image,
												col => col_cntrl_image
											);
	VGA_IMAGE_blk:
			entity work.vga_image port map( 
												disp_ena => Disp_ena_cntrl_image,
												row		=> row_cntrl_image,
												column	=> col_cntrl_image,
												red		=> red_top,
												green		=> green_top,
												blue		=> blue_top															
												);
	end top;									