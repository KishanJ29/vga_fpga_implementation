
//---------------------------------------------------------------------------IN PROGRESS __ COLOR RGB ___ ----------------------------------------------------------------------------------------------------------------

/*

module vga_sram(clk,hs,vs,c,blank,vga_sync,clk_out,addr,ce,oe,data,we,ub,lb);
	input clk;
	//input [11:0] r; 
	//reg [29:0] r = 30'b111111111100000000000000000000;
	output reg hs;
	output reg vs;
	output reg [29:0]c;
	reg [9:0] hcnt = 0;
	reg [9:0] vcnt = 0;
	//wire clk_out;
	
	output  blank;
	output clk_out;
	output vga_sync;
	
	
	inout reg [15:0]data;// bidirectional port
	reg [15:0]b;//
	output oe,ce,ub,lb;//we
	output reg we;
	reg addr_en;
	reg clk12_5 = 1'b0;
	output reg [17:0] addr = 0;
	//reg [15:0] dataout;
	//reg[10:0] count =0;
	
	reg [2:0] rgb_count = 0;
	reg [2:0] count33 = 2;





	clk_div ck(.clk_in(clk), .clk_out(clk_out));

		always @(posedge clk_out)begin
		 if(hcnt<799 && hcnt>95)
		  hs <= 1;
		 else
		  hs <= 0;
		 if(hcnt<799)
		  hcnt <= hcnt + 1;
		 else
		  hcnt <= 0;

		 if(vcnt<525 && vcnt>=2)
		  vs <= 1;
		 else
		  vs <= 0;
		 if(hcnt==799 && vcnt<525)
		  vcnt <= vcnt + 1;
		 if(vcnt == 525)//
		  vcnt <= 0;
		end



		//VGA assignments
		assign blank = hs & vs;
		assign vga_sync = 0;
		
		
		//SRAM assignments
		//assign we =1;
		assign {oe,ce,ub,lb}=4'b0000;
		//assign data = we ? 16'bz : 16'hAB;
		//assign b = data;//---
		


		// 25/2 clk 
		always@(posedge clk_out)
			begin
			clk12_5 <= ~clk12_5;
			
			end
			
			
		// VGA active region
		always@(vcnt,hcnt) begin
		if(vcnt>34 && vcnt<515)
		 if(hcnt>143 && hcnt<784)
		 
		 
		begin
			addr_en <= 1'b1;
			we <=1;
		end
		else 
			addr_en <= 1'b0;
			
		 //else//--
			//addr <= 18'b0;
		end



		// rgb counter ----
		always@(posedge clk_out)  begin 
		b <= data;
		if(addr_en) begin
			if(rgb_count < 1) begin
		c[29:20]<= {b[15:8],2'b00};
		c[19:10]<= {b[7:0],2'b00};
		c[9:0]<= {b[15:8],2'b00};//////
		
		rgb_count <= rgb_count +1;
		end
		else  begin
			c[29:20]<= {b[7:0],2'b00};
			c[19:10]<= {b[15:8],2'b00};
			c[9:0]<= {b[7:0],2'b00};//////
			rgb_count <= 0;
			end
		
			end
	
			


//			if(rgb_count <6) 
//			
//			begin 
//				rgb_count <= rgb_count +1;
//			if(rgb_count <1)
//				 begin
//				c[29:20] <= {b[15:0],2'b00};
//				rgb_count <= rgb_count +1;
//				end
//			else if(rgb_count <2) 
//				begin
//				c[19:10] <= {b[7:0],2'b00};
//				rgb_count <= rgb_count +1;
//				end
//			else if(rgb_count <3) 
//				begin
//				c[9:0] <= {b[15:0],2'b00};
//				rgb_count <= rgb_count +1;
//				end 
//			else if(rgb_count < 4 && rgb_count ==3 ) 
//				begin
//				c[29:20] <= {b[7:0],2'b00};
//				rgb_count <= rgb_count +1;
//				end
//			else if(rgb_count <5 && rgb_count >3) 
//				begin
//				c[19:10] <= {b[15:8],2'b00};
//				rgb_count <= rgb_count +1;
//				end
//			else if(rgb_count <6 & rgb_count >3) 
//				begin
//				c[9:0] <= {b[7:0],2'b00};
//				rgb_count <= rgb_count +1;
//				end else
//				rgb_count <=0;
//			end else 
//				rgb_count <=0;
//			
//
//		end 
		end


	

		// SRAM dataout 
		always@(negedge clk12_5)
		begin	
			if(addr_en) begin 
			addr <= addr + 1'b1;
			//addr <= addr + 1;
			//count <= count + 1;
			//end else begin
			//addr <= 0;
			end 
			
			if(~(vcnt >34 && vcnt <515))
				begin 
			addr <= 0;
			end
		end

		always@(posedge clk_out)
				
			if(we) 
			data <=16'bz;
			

			
endmodule



 module clk_div(clk_in,clk_out);
		  input clk_in;
		  output reg clk_out=0;
		  always@(posedge clk_in)
		  clk_out<=~clk_out;
endmodule


*/ 


//-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



//module vga_sram(clk,hs,vs,c,blank,vga_sync,clk_out,addr,ce,oe,data,we,ub,lb);
//	input clk;
//	//input [11:0] r; 
//	//reg [29:0] r = 30'b111111111100000000000000000000;
//	output reg hs;
//	output reg vs;
//	output reg [29:0]c;
//	reg [9:0] hcnt = 0;
//	reg [9:0] vcnt = 0;
//	//wire clk_out;
//	
//	output  blank;
//	output clk_out;
//	output vga_sync;
//	
//	
//	inout reg [15:0]data;// bidirectional port
//	reg [15:0]b;//
//	output oe,ce,ub,lb;//we
//	output reg we;
//	reg addr_en;
//	reg clk12_5 = 1'b0;
//	output reg [17:0] addr = 0;
//	//reg [15:0] dataout;
//	//reg[10:0] count =0;
//	
//	reg [2:0] rgb_count = 0;
//	
//	
//
//	clk_div ck(.clk_in(clk), .clk_out(clk_out));
//
//		always @(posedge clk_out)begin
//		 if(hcnt<799 && hcnt>95)
//		  hs <= 1;
//		 else
//		  hs <= 0;
//		 if(hcnt<799)
//		  hcnt <= hcnt + 1;
//		 else
//		  hcnt <= 0;
//
//		 if(vcnt<525 && vcnt>=2)
//		  vs <= 1;
//		 else
//		  vs <= 0;
//		 if(hcnt==799 && vcnt<525)
//		  vcnt <= vcnt + 1;
//		 if(vcnt == 525)//
//		  vcnt <= 0;
//		end
//
//
//
//		//VGA assignments
//		assign blank = hs & vs;
//		assign vga_sync = 0;
//		
//		
//		//SRAM assignments
//		//assign we =1;
//		assign {oe,ce,ub,lb}=4'b0000;
//		//assign data = we ? 16'bz : 16'hAB;
//		//assign b = data;//---
//		
//
//
//		// 25/2 clk 
//		always@(posedge clk_out)
//			begin
//			clk12_5 <= ~clk12_5;
//			end
//			
//			
//		// VGA active region
//		always@(vcnt,hcnt) begin
//		if(vcnt>34 && vcnt<515)
//		 if(hcnt>143 && hcnt<784)
//		 
//		 
//		begin
//			addr_en <= 1'b1;
//			we <=1;
//		end
//		else 
//			addr_en <= 1'b0;
//			
//		 //else//--
//			//addr <= 18'b0;
//		end
//
//
//
//		// rgb counter ----
//		always@(posedge clk)  begin 
//		b <= data;
//		if(addr_en) begin
////			if(rgb_count < 1) begin
////		c<= {{b[15:8],2'b00},{b[15:8],2'b00},{b[15:8],2'b00}};//////
////		rgb_count <= rgb_count +1;
////		end
////		else if(rgb_count <2) begin
////			c<= {{b[7:0],2'b00},{b[7:0],2'b00},{b[7:0],2'b00}};//////
////			rgb_count <= rgb_count + 1;
////			end
////		else begin
////			c<= {{b[7:0],2'b00},{b[7:0],2'b00},{8'b0,2'b00}};
////			rgb_count <= 0;
////			end
//			
//
//
//			if(rgb_count <6) 
//			
//			begin 
//				rgb_count <= rgb_count +1;
//			if(rgb_count <1)
//				 begin
//				c[29:20] <= {b[15:0],2'b00};
//				rgb_count <= rgb_count +1;
//				end
//			else if(rgb_count <2) 
//				begin
//				c[19:10] <= {b[7:0],2'b00};
//				rgb_count <= rgb_count +1;
//				end
//			else if(rgb_count <3) 
//				begin
//				c[9:0] <= {b[15:0],2'b00};
//				rgb_count <= rgb_count +1;
//				end 
//			else if(rgb_count < 4 && rgb_count ==3 ) 
//				begin
//				c[29:20] <= {b[7:0],2'b00};
//				rgb_count <= rgb_count +1;
//				end
//			else if(rgb_count <5 && rgb_count >3) 
//				begin
//				c[19:10] <= {b[15:8],2'b00};
//				rgb_count <= rgb_count +1;
//				end
//			else if(rgb_count <6 & rgb_count >3) 
//				begin
//				c[9:0] <= {b[7:0],2'b00};
//				rgb_count <= rgb_count +1;
//				end else
//				rgb_count <=0;
//			end else 
//				rgb_count <=0;
//			
//
//
//
//
//
//
//
//		end 
//		end
//
//
//		// SRAM dataout 
//		always@(posedge clk12_5)
//		begin	
//			if(addr_en) begin 
//			addr <= addr + 1'b1;
//			//addr <= addr + 1;
//			//count <= count + 1;
//			//end else begin
//			//addr <= 0;
//			end 
//			
//			if(~(vcnt >34 && vcnt <515))
//				begin 
//			addr <= 0;
//			end
//		end
//
//		always@(posedge clk_out)
//				
//			if(we) 
//			data <=16'bz;
//			
//
//			
//endmodule
//
//
//
// module clk_div(clk_in,clk_out);
//		  input clk_in;
//		  output reg clk_out=0;
//		  always@(posedge clk_in)
//		  clk_out<=~clk_out;
//endmodule







//-------------------------------------------------------------------OUTPUT(WORKS)-----------------------------------------------------------------------------------------------------------------



module vga_sram(clk,hs,vs,c,blank,vga_sync,clk_out,addr,ce,oe,data,we,ub,lb);
	input clk;
	//input [11:0] r; 
	//reg [29:0] r = 30'b111111111100000000000000000000;
	output reg hs;
	output reg vs;
	output reg [29:0]c;
	reg [9:0] hcnt = 0;
	reg [9:0] vcnt = 0;
	//wire clk_out;
	
	output  blank;
	output clk_out;
	output vga_sync;
	
	
	inout reg [15:0]data;// bidirectional port
	reg [15:0]b;//
	output oe,ce,ub,lb;//we
	output reg we;
	reg addr_en;
	reg clk12_5 = 1'b0;
	output reg [17:0] addr = 0;
	//reg [15:0] dataout;
	//reg[10:0] count =0;
	
	reg [1:0] rgb_count = 0;
	
	

	clk_div ck(.clk_in(clk), .clk_out(clk_out));

		always @(posedge clk_out)begin
		 if(hcnt<799 && hcnt>95)
		  hs <= 1;
		 else
		  hs <= 0;
		 if(hcnt<799)
		  hcnt <= hcnt + 1;
		 else
		  hcnt <= 0;

		 if(vcnt<525 && vcnt>=2)
		  vs <= 1;
		 else
		  vs <= 0;
		 if(hcnt==799 && vcnt<525)
		  vcnt <= vcnt + 1;
		 if(vcnt == 525)//
		  vcnt <= 0;
		end

		
		
		//VGA assignments
		assign blank = hs & vs;
		assign vga_sync = 0;
		
		
		
		//SRAM assignments
		//assign we =1;
		assign {oe,ce,ub,lb}=4'b0000;
		//assign data = we ? 16'bz : 16'hAB;
		//assign b = data;//---
		


		// 25/2 clk 
		always@(posedge clk_out)
			begin
			clk12_5 <= ~clk12_5;
			end
			
			
		// VGA active region
		always@(vcnt,hcnt) begin
		if(vcnt>34 && vcnt<515)
		 if(hcnt>143 && hcnt<784)
		 
		 
		begin
			addr_en <= 1'b1;
			we <=1;
		end
		else 
			addr_en <= 1'b0;
			
		 //else//--
			//addr <= 18'b0;
		end
		
		
		
		// rgb counter ----
		always@(posedge clk_out)  begin 
		b <= data;
		if(addr_en) begin
			if(rgb_count <1) begin
			
		c<= {{b[7:0],2'b00},{b[7:0],2'b00},{b[7:0],2'b00}};
		
		//c<= {{b[15:8],2'b00},{b[15:8],2'b00},{b[15:8],2'b00}};//////
		
		rgb_count <= rgb_count +1;
		end
		else  begin
			//c<= {{b[7:0],2'b00},{b[7:0],2'b00},{b[7:0],2'b00}};//////
			
			c<= {{b[15:8],2'b00},{b[15:8],2'b00},{b[15:8],2'b00}};
			
			
			rgb_count <= 0;
			end
			end
		end 
		
		
		
		// SRAM dataout 
		always@(posedge clk12_5)
		begin	
			if(addr_en) begin 
			addr <= addr + 1'b1;
			//addr <= addr + 1;
			//count <= count + 1;
			//end else begin
			//addr <= 0;
			end 
			
			if(~(vcnt >34 && vcnt <515))
				begin 
			addr <= 0;
			end
		end

		
		always@(posedge clk_out)
				
			if(we) 
			data <=16'bz;
			

			
endmodule



 module clk_div(clk_in,clk_out);
		  input clk_in;
		  output reg clk_out=0;
		  always@(posedge clk_in)
		  clk_out<=~clk_out;
endmodule








//-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

//module vga_sram(clk,hs,vs,blank,vga_sync,clk_out,addr,ce,oe,data,we,ub,lb);
//	input clk;
//	//input [11:0] r; 
//	//reg [29:0] r = 30'b111111111100000000000000000000;
//	output reg hs;
//	output reg vs;
//	//output reg [29:0]c;
//	reg [9:0] hcnt = 0;
//	reg [9:0] vcnt = 0;
//	//wire clk_out;
//	
//	output  blank;
//	output clk_out;
//	output vga_sync;
//	
//	
//	inout reg [15:0]data;
//	//output [15:0]b;//
//	output oe,ce,ub,lb;//we
//	output reg we;
//	reg addr_en;
//	reg clk12_5;
//	output reg [17:0] addr;
//	reg [15:0] dataout;
//	reg[10:0] count;
//	
//	
//
//	clk_div ck(.clk_in(clk), .clk_out(clk_out));
//
//always @(posedge clk_out)begin
//		 if(hcnt<799 && hcnt>95)
//		  hs <= 1;
//		 else
//		  hs <= 0;
//		 if(hcnt<799)
//		  hcnt <= hcnt + 1;
//		 else
//		  hcnt <= 0;
//
//		 if(vcnt<525 && vcnt>=2)
//		  vs <= 1;
//		 else
//		  vs <= 0;
//		 if(hcnt==799 && vcnt<525)
//		  vcnt <= vcnt + 1;
//		 if(vcnt == 525)//
//		  vcnt <= 0;
//		end
//
//		//VGA assignments
//		assign blank = hs & vs;
//		assign vga_sync = 0;
//		
//		
//		//SRAM assignments
//		//assign we =1;
//		assign {oe,ce,ub,lb}=4'b0000;
//		//assign data = we ? 16'bz : 16'hAB;
//		//assign b = data;
//		
//
//
//		// 25/2 clk 
//		always@(posedge clk_out)
//			begin
//			clk12_5 <= ~clk12_5;
//			end
//			
//			
//		// VGA active region
//		always@(vcnt,hcnt) begin
//		if(vcnt>34 && vcnt<515)
//		 if(hcnt>143 && hcnt<784)
//		begin
//			addr_en <= 1'b1;
//			we <=1;
//		end
//		else 
//			addr_en <= 1'b0;
//		end
//		
//		// SRAM dataout 
//		always@(posedge clk12_5)
//		begin	
//			if(addr_en) begin 
//			addr <= count;
//			//addr <= addr + 1;
//			count <= count + 1;
//			end 
//end
//
//		always@(posedge clk_out)
//				
//			if(we) 
//			data <=16'bz;
//			
//
//			
//endmodule
//
//
//
// module clk_div(clk_in,clk_out);
//		  input clk_in;
//		  output reg clk_out=0;
//		  always@(posedge clk_in)
//		  clk_out<=~clk_out;
//endmodule



//-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------













//module vga_sram(clk,hs,vs,blank,vga_sync,clk_out,addr,ce,oe,b,data,we,ub,lb);
//	input clk;
//	//input [11:0] r; 
//	//reg [29:0] r = 30'b111111111100000000000000000000;
//	output reg hs;
//	output reg vs;
//	//output reg [29:0]c;
//	reg [9:0] hcnt = 0;
//	reg [9:0] vcnt = 0;
//	//wire clk_out;
//	
//	output  blank;
//	output clk_out;
//	output vga_sync;
//	
//	
//	inout [15:0]data;
//	output [15:0]b;
//	output oe,ce,ub,lb;//we
//	output reg we;
//	reg addr_en;
//	reg clk12_5;
//	output reg [17:0] addr;
//	reg [15:0] dataout;
//	reg[10:0] count;
//	
//	
//
//	clk_div ck(.clk_in(clk), .clk_out(clk_out));
//
//always @(posedge clk_out)begin
//		 if(hcnt<799 && hcnt>95)
//		  hs <= 1;
//		 else
//		  hs <= 0;
//		 if(hcnt<799)
//		  hcnt <= hcnt + 1;
//		 else
//		  hcnt <= 0;
//
//		 if(vcnt<525 && vcnt>=2)
//		  vs <= 1;
//		 else
//		  vs <= 0;
//		 if(hcnt==799 && vcnt<525)
//		  vcnt <= vcnt + 1;
//		 if(vcnt == 525)//
//		  vcnt <= 0;
//		end
//
//		//VGA assignments
//		assign blank = hs & vs;
//		assign vga_sync = 0;
//		
//		
//		//SRAM assignments
//		//assign we =1;
//		assign {oe,ce,ub,lb}=4'b0000;
//		assign data = we ? 16'bz : 16'hAB;
//		assign b = data;
//
//
//		// 25/2 clk 
//		always@(posedge clk_out)
//			begin
//			clk12_5 <= ~clk12_5;
//			end
//			
//			
//		// VGA active region
//		always@(vcnt,hcnt) begin
//		if(vcnt>34 && vcnt<515)
//		 if(hcnt>143 && hcnt<784)
//		begin
//			addr_en <= 1'b1;
//			we <=1;
//		end
//		else 
//			addr_en <= 1'b0;
//		end
//		
//		// SRAM dataout 
//		always@(posedge clk12_5)
//		begin	
//			if(addr_en) begin 
//			dataout <= addr[count];
//			//addr <= addr + 1;
//			count <= count + 1;
//			end else 
//			//addr <= 0;
//			count <= 0;
//			end
//			
//endmodule
//
//
//
// module clk_div(clk_in,clk_out);
//		  input clk_in;
//		  output reg clk_out=0;
//		  always@(posedge clk_in)
//		  clk_out<=~clk_out;
//endmodule