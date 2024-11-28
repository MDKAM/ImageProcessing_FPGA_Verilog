`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:46:59 12/30/2020 
// Design Name: 
// Module Name:    main_module 
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
module main_module(
    output [7:0] out_pxl_row,
    output [8:0] out_pxl_col,
    output write_enable,
	 output done,
    output [7:0] out,
    input clk,
    input start,
    input reset
    );
	 
	 wire data_in;
	 wire [7:0] data;
	 wire [7:0] pxl_row;
	 wire [8:0] pxl_col;
	 wire [1:0] row_in;
	 wire [1:0] col_in;
	 
	 
	control uut1 (
		.clk(clk), 
		.reset(reset), 
		.start(start), 
		.row_in(row_in), 
		.col_in(col_in), 
		.pxl_row(pxl_row), 
		.pxl_col(pxl_col), 
		.out_pxl_row(out_pxl_row), 
		.out_pxl_col(out_pxl_col), 
		.done(done), 
		.data_in(data_in), 
		.write_enable(write_enable)
	);

	conv uut2 (
		.data_in(data_in), 
		.data(data),
		.clk(clk),
		.reset(reset),
		.row_in(row_in), 
		.col_in(col_in), 
		.out(out)
	);

	input_mem uut3 (
		.clk(clk), 
		.data(data), 
		.pxl_row(pxl_row), 
		.pxl_col(pxl_col)
	);
	
	
endmodule
