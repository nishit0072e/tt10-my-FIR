\m5_TLV_version 1d: tl-x.org
\m5

   // *******************************************
   // * For ChipCraft Course                    *
   // * Replace this file with your own design. *
   // *******************************************

   use(m5-1.0)
\SV
/*
 * Copyright (c) 2023 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`define default_netname none

module tt_um_nishit0072e_counter (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Bidirectional Input path
    output wire [7:0] uio_out,  // IOs: Bidirectional Output path
    output wire [7:0] uio_oe,   // IOs: Bidirectional Enable path (active high: 0=input, 1=output)
    input  wire       ena,
    input  wire       clk,
    input  wire       rst_n
);
wire reset = ! rst_n;
   

   logic [3:0] cnt;
   always_ff @(posedge clk) begin
      cnt <= reset ? 4'b0 : cnt + 1;
   end
   //7-segment decoder for output
   assign uo_out[7:0] = 
      (cnt == 4'h0) ? 8'b00111111 :
      (cnt == 4'h1) ? 8'b00000110 :
      (cnt == 4'h2) ? 8'b01011011 :
      (cnt == 4'h3) ? 8'b01001111 :
      (cnt == 4'h4) ? 8'b01100110 :
      (cnt == 4'h5) ? 8'b01101101 :
      (cnt == 4'h6) ? 8'b01111101 :
      (cnt == 4'h7) ? 8'b00000111 :
      (cnt == 4'h8) ? 8'b01111111 :
      (cnt == 4'h9) ? 8'b01101111 :
      (cnt == 4'hA) ? 8'b01110111 :
      (cnt == 4'hB) ? 8'b01111100 :
      (cnt == 4'hC) ? 8'b00111001 :
      (cnt == 4'hD) ? 8'b01011110 :
      (cnt == 4'hE) ? 8'b01111001 :
      					 8'b01110001 ;

 
   
   // List all unused inputs to prevent warnings
   wire _unused = &{ena, clk, rst_n, 1'b0};
  // All output pins must be assigned. If not used, assign to 0.
 // assign uo_out  = ui_in;  // Example: ou_out is ui_in
  assign uio_out = 0;
  assign uio_oe  = 0;

endmodule
