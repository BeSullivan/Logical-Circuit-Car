`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:35:21 01/22/2018 
// Design Name: 
// Module Name:    top_module 
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
module top_module(rgb ,clk ,reset ,target);
	
	output[9:0] rgb;
	input clk ,reset;
	input target;
	
	wire [31:0] carX ,carY;
	wire clk_out;
	wire [1:0] rWheel ,lWheel;
	wire vsync ,hsync;
	reg [31:0] tarY ,tarX;
	
	always @(posedge clk)
	begin
		if(target == 0)
		begin
			tarX = 32'b00101001101110010010011100000000;
			tarY = 32'b00101111101011110000100000000000;
		end
		else
		begin
			tarX = 32'b00000000000000000000000000000000;
			tarY = 32'b00001011111010111100001000000000;
		end
	end

	Given_top given(clk ,reset ,carX ,carY ,lWheel ,rWheel ,clk_out ,rgb ,vsync ,hsync);
	MainModule mm(carX ,carY ,tarX ,tarY ,clk_out ,rWheel ,lWheel ,reset);

endmodule
