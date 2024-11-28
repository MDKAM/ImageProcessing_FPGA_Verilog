`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   00:13:17 12/31/2020
// Design Name:   main_module
// Module Name:   E:/sbu/7/FPGA/ISE codes/Final_Proj_FPGA/tb_main.v
// Project Name:  Final_Proj_FPGA
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: main_module
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_main;

	// Inputs
	reg clk;
	reg start;
	reg reset;

	// Outputs
	wire [7:0] out_pxl_row;
	wire [8:0] out_pxl_col;
	wire write_enable;
	wire done;
	wire [7:0] out;

	// Instantiate the Unit Under Test (UUT)
	main_module uut (
		.out_pxl_row(out_pxl_row), 
		.out_pxl_col(out_pxl_col), 
		.write_enable(write_enable), 
		.done(done), 
		.out(out), 
		.clk(clk), 
		.start(start), 
		.reset(reset)
	);

integer i,j,image;
reg [7:0] sobel [0:299];

	initial begin
		clk = 1'b0;
		forever begin
			#20 clk = ~clk;
			if(done==1)begin
			$display("IMAGE HAS PROCESSED! DONE!\n Time: %t ns", $realtime/1000);
			$stop;
			end
		end
	end

	initial begin
		// Initialize Inputs
		start = 0;
		reset = 0;

		// Wait 100 ns for global reset to finish
		#100;		
		// Add stimulus here
		start = 1;
		#40;
		start = 0;
	end
	
	
	
	initial begin
      // Open file output.dat for writing
      image = $fopen("output_image.txt", "w");
		#100;
		for(j=0;j<200;j=j+1)begin
			for(i=0;i<300;i=i+1)begin
			@(out_pxl_col);
			sobel[out_pxl_col] = out;
			end		
      // Check if file was properly opened and if not, produce error and exit      
			if (image == 0) begin
				$display("Error: File, output_image.txt could not be opened.\nExiting Simulation.");
				$finish;
			end
      
      // Write monitor data to a file
			for(i=0;i<300;i=i+1)begin
				if(i==299)begin
					$fwrite (image, "%d\n", sobel[i]);
				end else begin
					$fwrite (image, "%d\t", sobel[i]);
				end
			end
		end
		
      // Wait for 1 ms and end monitoring
      #800;
      
      // Close file to end monitoring
      $fclose(image);
   end
	
      
endmodule

