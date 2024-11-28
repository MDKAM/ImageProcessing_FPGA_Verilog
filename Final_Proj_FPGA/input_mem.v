`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:15:20 12/28/2020 
// Design Name: 
// Module Name:    input_mem 
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
module input_mem #(parameter r_image=202,c_image=302)(  //zero padding
    input clk,
    output reg [7:0] data,
    input [7:0] pxl_row,
    input [8:0] pxl_col
    );


   (* RAM_STYLE="BLOCK" *)
   reg [7:0] mem [0:(r_image*c_image)-1];  

   
   //  The forllowing code is only necessary if you wish to initialize the RAM 
   //  contents via an external file (use $readmemb for binary data)
   initial
      $readmemh("image_matrix.txt", mem);

   always @(posedge clk) begin	  
      data <= mem[pxl_col+302*pxl_row];
   end



endmodule
