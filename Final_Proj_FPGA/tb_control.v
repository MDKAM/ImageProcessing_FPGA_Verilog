`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:56:15 12/29/2020
// Design Name:   control
// Module Name:   E:/sbu/7/FPGA/ISE codes/Final_Proj_FPGA/tb_control.v
// Project Name:  Final_Proj_FPGA
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: control
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_control;

	// Inputs
	reg clk;
	reg reset;
	reg start;

	// Outputs
	wire [1:0] row_in;
	wire [1:0] col_in;
	wire [7:0] pxl_row;
	wire [8:0] pxl_col;
	wire [7:0] out_pxl_row;
	wire [8:0] out_pxl_col;
	wire done;
	wire data_in;
	wire write_enable;

	// Instantiate the Unit Under Test (UUT)
	control uut (
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

	initial begin
		clk = 1'b0;
		forever begin
			#10 clk = ~clk;
		end
	end

	initial begin
		// Initialize Inputs
		reset = 0;
		start = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		start=1;
		#10;
		start=0;
	end
      
endmodule

