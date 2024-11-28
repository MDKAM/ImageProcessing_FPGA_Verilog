`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:21:20 12/27/2020 
// Design Name: 
// Module Name:    conv 
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
module conv(
    input data_in,
	 input clk,
	 input reset,
    input [7:0] data,
    input [1:0] row_in,
    input [1:0] col_in,
    output reg [7:0] out
    );

reg signed [8:0] x [0:2][0:2];			//one extra bit because of signed
reg signed [2:0] Kernel [0:2][0:2];
reg signed [12:0] result;					//result of sum all elements of conv would be maximum 13bit


initial begin					//initiallizing Kernel matrix
Kernel [0][0]= -1;
Kernel [0][1]= -2;
Kernel [0][2]= -1;
Kernel [1][0]= 0;
Kernel [1][1]= 0;
Kernel [1][2]= 0;
Kernel [2][0]= 1;
Kernel [2][1]= 2;
Kernel [2][2]= 1;
end


integer m=0,n=0;

	always @ (posedge clk)begin
		if(reset)begin
			for (m=0 ; m<3 ; m=m+1)begin
				for (n=0 ; n<3 ; n=n+1)begin
					x[m][n]<=0;
				end
			end
		end else if(data_in==1 && reset==0)begin
			x[row_in][col_in]<= data;
		end else if (data_in==0 && reset==0)begin
			result = {(13){1'b0}}; 						// all zero
			for(m=0;m<3;m=m+1)begin
				for(n=0;n<3;n=n+1)begin
					result = result + ((Kernel[2-m][2-n])*(x[m][n]));		//convolution
				end
			end
			if(result<0)begin
				out = 0;
			end else if(result>255)begin
				out = 255;
			end else begin
				out = $unsigned(result);		//out must be positive 0-255
			end
		end
	end


endmodule
