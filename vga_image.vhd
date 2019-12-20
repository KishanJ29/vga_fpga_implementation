LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY vga_image IS
	GENERIC(
		displayStart_x: INTEGER := 144;
		displayStart_y : INTEGER := 33;
		pixels_y :	INTEGER := 200;    --row that first columnor will persist until
		pixels_x	:	INTEGER := 320);   --columnumn that first column will persist until
	PORT(
		disp_ena		:	IN		STD_LOGIC;	--display enable ('1' = display time, '0' = blanking time)
		row			:	IN		INTEGER;		--row pixel coordinate
		column		:	IN		INTEGER;		--columnumn pixel coordinate
		red			:	OUT	STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');  --red magnitude output to DAC
		green			:	OUT	STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');  --green magnitude output to DAC
		blue			:	OUT	STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0')); --blue magnitude output to DAC
END vga_image;

ARCHITECTURE behavior OF vga_image IS
BEGIN
	PROCESS(disp_ena, row, column)
	BEGIN

		IF(disp_ena = '1') THEN		--display time
--			IF(row < pixels_y AND columnumn < pixels_x) THEN
--				red <= (OTHERS => '0');
--				green	<= (OTHERS => '0');
--				blue <= (OTHERS => '1');
--			ELSE
				red <= (OTHERS => '1');
				green	<= (OTHERS => '1');
				blue <= (OTHERS => '1');
--			END IF; 
		ELSE								--blanking time
			red <= (OTHERS => '0');
			green <= (OTHERS => '0');
			blue <= (OTHERS => '0');
		END IF;
	
	END PROCESS;

--		process(disp_ena, column)
--			begin 
--				IF(disp_ena = '1') THEN --display time
--					if((column >=  144)and (column < 235))then
--						red <= (OTHERS => '1');
--						green	<= (OTHERS => '1');
--						blue <= (OTHERS => '1');
--					elsif((column >=  235)and (column < 326))then 
--						red <= (OTHERS => '1');
--						green	<= (OTHERS => '1');
--						blue <= (OTHERS => '0');
--					elsif((column >=  326)and (column < 417))then 
--						red <= (OTHERS => '0');
--						green	<= (OTHERS => '1');
--						blue <= (OTHERS => '1');	
--					elsif((column >=  417)and (column <508 ))then 
--						red <= (OTHERS => '0');
--						green	<= (OTHERS => '1');
--						blue <= (OTHERS => '0');
--					elsif((column >= 508)and (column < 599))then 
--						red <= (OTHERS => '1');
--						green	<= (OTHERS => '0');
--						blue <= (OTHERS => '1');
--					elsif((column >=  599)and (column < 690))then 
--						red <= (OTHERS => '1');
--						green	<= (OTHERS => '0');
--						blue <= (OTHERS => '0');
--					else 
--						 red <= (OTHERS => '0');
--						green	<= (OTHERS => '0');
--						blue <= (OTHERS => '1');
--						
--					end if;
--				else 
--						red <= (OTHERS => '0');
--						green	<= (OTHERS => '0');
--						blue <= (OTHERS => '0');
--				end if;
--				end process;
END behavior;