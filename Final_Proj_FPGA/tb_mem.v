`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:07:26 12/30/2020
// Design Name:   input_mem
// Module Name:   E:/sbu/7/FPGA/ISE codes/Final_Proj_FPGA/tb_mem.v
// Project Name:  Final_Proj_FPGA
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: input_mem
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_mem;

	// Inputs
	reg clk;
	reg [7:0] input_data;
	reg [8:0] pxl_row;
	reg [8:0] pxl_col;
	reg [8:0] wrow;
	reg [8:0] wcol;
	reg we;

	// Outputs
	wire [7:0] data;

	// Instantiate the Unit Under Test (UUT)
	input_mem uut (
		.clk(clk), 
		.data(data), 
		.input_data(input_data), 
		.pxl_row(pxl_row), 
		.pxl_col(pxl_col), 
		.wrow(wrow), 
		.wcol(wcol), 
		.we(we)
	);

	initial begin
		clk = 1'b0;
		forever begin
			#10 clk = ~clk;
		end
	end

	initial begin
		// Initialize Inputs
		input_data = 0;
		pxl_row = 0;
		pxl_col = 0;
		wrow = 0;
		wcol = 0;
		we = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

		pxl_row = 0;					//just for testing the validity of the module
		pxl_col = 2;
		#50;
		pxl_row = 27;
		pxl_col = 30;
		#50;
		pxl_row = 91;
		pxl_col = 29;
		#50;
		pxl_row = 201;
		pxl_col = 301;
		#50;
		pxl_row = 199;
		pxl_col = 0;
		#50;
		pxl_row = 199;
		pxl_col = 1;
		#50;
		pxl_row = 199;
		pxl_col = 11;
		#50;
	end
      
endmodule

