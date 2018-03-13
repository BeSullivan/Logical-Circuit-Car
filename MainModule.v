`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:44:29 01/22/2018 
// Design Name: 
// Module Name:    MainModule 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module MainModule(carX ,carY ,tarX ,tarY ,clk ,rWheel ,lWheel ,reset);

	input[31:0] carX, carY, tarX, tarY;
	input reset, clk; 
	output[1:0] rWheel, lWheel;
	
	parameter s0 = 4'b0000 ,s1 = 4'b0001 ,s2 = 4'b0010 ,s3 = 4'b0011 ,s4 = 4'b0100 
				,s5 = 4'b0101 ,s6 = 4'b0110 ,s7 = 4'b0111 ,s8 = 4'b1000;
				
	parameter loc50 = 32'b00000000000000000000000000110010 
				,mainLocX = 32'b10111110101111000010000000000
				,mainLocY = 32'b10111110101111000010000000000;
				
	reg[3:0] state;
	
	/* always @(negedge reset)
	begin 
		state = s0;
		rWheel = 2'b00;
		lWheel = 2'b00;
	end
	*/
	always @(posedge clk)
	begin
	
		if(carX - tarX < 0)
		begin
			assign state = s1;
			
			if(tarY - carY > loc50) 
			begin
				assign state = s1;
			end
			
			if((tarY - carY <= loc50) && (tarY - carY > 0))
			begin 
				assign state = s2;
			end
			
			if(tarY - carY == 0)
			begin
				assign state = s3;
			end
			
			if((tarY - carY == 0) && (carX - tarX == 0))
			begin
				assign state = s8;
			end
			
		end
		if(tarX - carX < 0)
		begin
		
			if (carY - mainLocY < loc50)
			begin
				assign state = s4;
			end
			
			if(carY - mainLocY == loc50 && carX - tarX > loc50)
			begin
				assign state = s5;
			end
		
			if((carX - tarX <= loc50) && (carX- tarX > 0))
			begin
				assign state = s6;
			end
			
			if(carX - tarX == 0)
			begin
				assign state = s7;
			end
			
			if((carX - tarX == 0) && (carY - tarY == 0))
			begin
				assign state = s8;
			end
			
		end
	end
	
	reg[1:0] rWheel ,lWheel;
	
	always @(posedge clk)
	begin
		
		if(state == s1)
		begin
			rWheel = 2'b01;
			lWheel = 2'b01;
		end
		
		if(state == s2)
		begin
			rWheel = 2'b00;
			lWheel = 2'b01;
		end
		
		if(state == s3)
		begin
			rWheel = 2'b01;
			lWheel = 2'b01;
		end
		
		if(state == s4)
		begin
			rWheel = 2'b01;
			lWheel = 2'b00;
		end
		
		if(state == s5)
		begin
			rWheel = 2'b01;
			lWheel = 2'b01;
		end
		
		if(state == s6)
		begin
			rWheel = 2'b01;
			lWheel = 2'b00;
		end
		
		if(state == s7)
		begin
			rWheel = 2'b01;
			lWheel = 2'b01;
		end
		
		if(state == s8)
		begin
			rWheel =  2'b00;
			lWheel = 2'b00;
		end
		
	end
	
endmodule