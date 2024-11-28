`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:28:23 12/27/2020 
// Design Name: 
// Module Name:    control 
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
module control(
    input clk,
    input reset,
	 input start,
    output reg [1:0] row_in,
    output reg [1:0] col_in,
    output [7:0] pxl_row,
    output [8:0] pxl_col,
    output reg [7:0] out_pxl_row,
    output reg [8:0] out_pxl_col,
    output reg done,
    output reg data_in,
    output reg write_enable
    );

localparam A=3'b000, B=3'b001, C=3'b010,
				D=3'b011, E=3'b100, F=3'b101, G=3'b110;

assign pxl_row = out_pxl_row + row_in;
assign pxl_col = out_pxl_col + col_in;


reg [2:0] nstate, pstate;

//==========state Register===============
always @ (posedge clk)begin
	if(reset)begin
		pstate<=A;
	end else begin
		pstate<=nstate;
	end
end
//========Combitional Logic for nstate=========
always @ (pstate, start)begin

	case(pstate)
		A: begin
			data_in<=0;
			write_enable<=0;
			row_in<=0;
			col_in<=0;
			out_pxl_row<=0;
			out_pxl_col<=0;
			done<=0;
			if(start)begin
				nstate<= B;
			end else begin
				nstate<= A;
			end
		end
		
		B: begin
			data_in<=1;
			write_enable<=0;
			row_in<=0;
			col_in<=0;
			nstate<= G;
		end
		
		G: begin
			if(row_in>2 ||(row_in==2 && col_in==2))begin
				data_in<=0;
				nstate<= D;
			end else begin
				nstate<= C;
			end
		end
		
		C: begin
			data_in<=1;
			if(col_in<2)begin
				col_in <= col_in+1;
			end else begin
				col_in <= 0;
				row_in <= row_in+1;
			end
			nstate<= G;
		end
		
		D: begin
			data_in<=0;
			col_in <= 0;
			row_in <= 0;
			write_enable<=1;
			nstate<= E;
		end
		
		E: begin
		write_enable<=1;
			if(out_pxl_row<=199)begin
				if(out_pxl_col<299)begin
					out_pxl_col <= out_pxl_col+1;
				end else begin
					out_pxl_col <= 0;
					out_pxl_row <= out_pxl_row+1;
				end
				nstate<= B;
			end else if(out_pxl_row>199)begin
				nstate<= F;
			end
		end
		
		F: begin
			data_in<=0;
			write_enable<=0;
			out_pxl_row<=0;
			out_pxl_col<=0;
			done<=1;
			if(start)begin
				nstate<= B;
			end else begin
				nstate<= F;
			end
		end

		default: begin
			nstate<= A;
		end
		
	endcase

end

endmodule
