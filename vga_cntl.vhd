   library ieee;
			use ieee.std_logic_1164.all;
			use ieee.numeric_std.all;

 entity vga_cntrl is
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
			DispEnable : out std_logic;
			blank_vga : out std_logic
			);
		end entity;

 architecture behave of vga_cntrl is
		constant hperiod : integer := 799;
		constant vperiod : integer :=  524;
		signal VirEnable : std_logic;
		signal h_sync_int : std_logic;
		signal v_sync_int : std_logic;
		signal DispEnable_int 	: std_logic;
		signal row_int : integer range 0 to 1000;
		signal col_int : integer range 0 to 1000;
		begin
		h_sync <= h_sync_int;
		v_sync <= v_sync_int;

-------------------------------------------------------------------------------------------------------------------
--					VGA Counter
-------------------------------------------------------------------------------------------------------------------
			process(pixelclk, rst)
			begin
			if ( rst = '1')then
					col_int <= 0;
					row_int <= 0;
					
			elsif(rising_edge(pixelclk))then
				--col_int <= col_int + 1;
				
				if( col_int > hperiod - 1 )then
					col_int <=  0;
					--row_int <= row_int + 1;
					
					if( row_int = vperiod  )then
						row_int <=  0; 
						col_int <=  0;	
					else 
						row_int <= row_int + 1;
					end if;
					
				else
					col_int <= col_int + 1;
					
				end if;
			end if;
		end process;
-------------------------------------------------------------------------------------------------------------------
-- 					Horizontal SYNC
-------------------------------------------------------------------------------------------------------------------		
			h_sync_int <= '0' when  (col_int < 96 ) else '1';   ----  Hsync period 96 PxClk
		
-------------------------------------------------------------------------------------------------------------------
-- 					Vertical SYNC
-------------------------------------------------------------------------------------------------------------------
		v_sync_int <= '0' when (row_int < 2) else '1';
------------------------------------------------------------------------------------------------------------------
--						Display Active Region
------------------------------------------------------------------------------------------------------------------
		DispEnable_int <= '1' when( ((col_int > 144)and (col_int < 785)) and ((row_int > 34 )and(row_int <= 514 )))  else '0';
	---------------------------------------------
		--DE_2 Requirement	
	---------------------------------------------
		blank_vga <= DispEnable_int;
		
		DispEnable <= DispEnable_int;
		
end behave;