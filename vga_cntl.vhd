   library ieee;
			use ieee.std_logic_1164.all;
			use ieee.numeric_std.all;

 entity vga_cntrl is
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
		end entity;

 architecture behave of vga_cntrl is
		constant hperiod : integer := h_syncP + h_bp + h_pixels + h_fp;
		constant vperiod : integer :=  v_syncP + v_bp + h_fp ;
		signal VirEnable : std_logic;
		begin
-------------------------------------------------------------------------------------------------------------------
--					Horizontal
-------------------------------------------------------------------------------------------------------------------
		process(pixelclk, rst)
			begin
			if ( rst = '1')then
				col <= 0;
			elsif(rising_edge(pixelclk))then
				if( col = h_pixels -1)then
					col <=  0;
					VirEnable <= '1';
				else
					col <= col + 1;
					VirEnable <= '0';
				end if;
			end if;
		end process;
		
		h_sync <= '0' when col < 96 else '1'; ----  Hsync on 
-------------------------------------------------------------------------------------------------------------------
-- 					Vertical
-------------------------------------------------------------------------------------------------------------------
		process(pixelclk, rst, virEnable)
		  begin
			if ( rst = '1')then
				row <= 0;
			elsif(rising_edge(pixelclk) and VirEnable = '1')then
				if( row = h_pixels -1)then
				row <=  0;
				  
				else
				row <= row + 1;
				end if;
			end if;
		end process;

		v_sync <= '0' when row < 3 else '1'; ----  Hsync on when more than 128
------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------
		DispEnable <= '0' when (row > 144) and ( col > 31 ) else '1';
end behave;


