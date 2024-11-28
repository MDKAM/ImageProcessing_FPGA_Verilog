`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   01:23:24 12/27/2020
// Design Name:   conv
// Module Name:   E:/sbu/7/FPGA/ISE codes/Final_Proj_FPGA/tb_conv.v
// Project Name:  Final_Proj_FPGA
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: conv
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_conv;

	// Inputs
	reg data_in;
	reg [7:0] data;
	reg [1:0] row_in;
	reg [1:0] col_in;
	reg clk;
	reg reset;

	// Outputs
	wire [7:0] out;

	// Instantiate the Unit Under Test (UUT)
	conv uut (
		.data_in(data_in), 
		.data(data),
		.clk(clk),
		.reset(reset),
		.row_in(row_in), 
		.col_in(col_in), 
		.out(out)
	);
	
	reg signed [8:0] x_real [0:2][0:2];
	reg signed [2:0] kernel_real [0:2][0:2];
	reg signed  [12:0] result_real = 0;
	reg [7:0] out_real;
	integer i=0,j=0;
	
	initial begin					//initiallizing Kernel matrix
		kernel_real [0][0]= -1;
		kernel_real [0][1]= -2;
		kernel_real [0][2]= -1;
		kernel_real [1][0]= 0;
		kernel_real [1][1]= 0;
		kernel_real [1][2]= 0;
		kernel_real [2][0]= 1;
		kernel_real [2][1]= 2;
		kernel_real [2][2]= 1;
	end

	initial begin
		clk = 1'b0;
		forever begin
			#10 clk = ~clk;
		end
	end

	initial begin
		// Initialize Inputs
		data_in = 0;
		data = 0;
		row_in = 0;
		col_in = 0;
		reset=0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here


		for(i=0;i<3;i=i+1)begin
				for(j=0;j<3;j=j+1)begin
					data_in = 1;
					data = $random;
					row_in = i;
					col_in = j;
					x_real[row_in][col_in]=data;
					result_real = result_real + ((kernel_real[2-row_in][2-col_in])*(x_real[row_in][col_in]));
					#20;
				end
		end
		
		
		
		
		
		
		/*data_in = 1;
		data = 0;
		row_in = 0;
		col_in = 0;
		x_real[row_in][col_in]=data;
		result_real = result_real + ((kernel_real[2-row_in][2-col_in])*(x_real[row_in][col_in]));
		#20;
		
		data = 0;
		row_in = 0;
		col_in = 1;
		x_real[row_in][col_in]=data;
		result_real = result_real + ((kernel_real[2-row_in][2-col_in])*(x_real[row_in][col_in]));
		#20;
		
		data = 0;
		row_in = 0;
		col_in = 2;
		x_real[row_in][col_in]=data;
		result_real = result_real + ((kernel_real[2-row_in][2-col_in])*(x_real[row_in][col_in]));
		#20;
		
		data = 1;
		row_in = 1;
		col_in = 0;
		x_real[row_in][col_in]=data;
		result_real = result_real + ((kernel_real[2-row_in][2-col_in])*(x_real[row_in][col_in]));
		#20;
		
		data = 2;
		row_in = 1;
		col_in = 1;
		x_real[row_in][col_in]=data;
		result_real = result_real + ((kernel_real[2-row_in][2-col_in])*(x_real[row_in][col_in]));
		#20;
		
		data = 3;
		row_in = 1;
		col_in = 2;
		x_real[row_in][col_in]=data;
		result_real = result_real + ((kernel_real[2-row_in][2-col_in])*(x_real[row_in][col_in]));
		#20;
		
		data = 4;
		row_in = 2;
		col_in = 0;
		x_real[row_in][col_in]=data;
		result_real = result_real + ((kernel_real[2-row_in][2-col_in])*(x_real[row_in][col_in]));
		#20;
		
		data = 5;
		row_in = 2;
		col_in = 1;
		x_real[row_in][col_in]=data;
		result_real = result_real + ((kernel_real[2-row_in][2-col_in])*(x_real[row_in][col_in]));
		#20;
		
		data = 6;
		row_in = 2;
		col_in = 2;
		x_real[row_in][col_in]=data;
		result_real = result_real + ((kernel_real[2-row_in][2-col_in])*(x_real[row_in][col_in]));
		
		#20;*/
		
		data_in = 0;
		#20;
			if(result_real<0)begin
				out_real = 0;
				$display(" out= %d \n out_real= %d \n while result= %d", out , out_real , result_real);
			end else if(result_real>255)begin
				out_real = 255;
				$display(" out= %d \n out_real= %d \n while result= %d", out , out_real , result_real);
			end else begin
				out_real = $unsigned(result_real);		//out must be positive 0-255
				$display(" out= %d \n out_real= %d", out , out_real);
			end
			
		if(out==out_real)begin
			$display("Correct!Done!");
		end else begin
			$display("Wrong!Error!");
		end
		#40;
		reset=1;
		
	end
      
endmodule

