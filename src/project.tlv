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

module tt_um_nishit0072e_FIR (
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
   

   // **FIX**: Define the hardwired filter coefficients
    localparam signed [3:0] COEFF_0 = 4'sd2;
    localparam signed [3:0] COEFF_1 = 4'sd3;
    localparam signed [3:0] COEFF_2 = 4'sd2;

    // **FIX**: Declare all internal signals with proper `signed` type
    logic signed [3:0] data_in;
    logic signed [3:0] data_s1_reg;
    logic signed [3:0] data_s2_reg;
    logic signed [7:0] data_out_reg;

    // **FIX**: Connect the filter's input to the chip's input port
    assign data_in = ui_in[3:0];

    // Pipelined sequential logic for the FIR filter
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Asynchronous reset for all pipeline stages
            data_s1_reg  <= '0;
            data_s2_reg  <= '0;
            data_out_reg <= '0;
        end
        else if (ena) begin // **FIX**: Use the correct `ena` signal
            // Stage 1: Data delay line shifts previous samples
            data_s1_reg <= data_in;
            data_s2_reg <= data_s1_reg;
            
            // Stage 2: Perform Multiply-Accumulate (MAC) operation
            data_out_reg <= (data_in      * COEFF_0) + 
                            (data_s1_reg  * COEFF_1) + 
                            (data_s2_reg  * COEFF_2);
        end
    end

    // Assign the final result to the chip's output port
    assign uo_out = data_out_reg;

 
   
   // List all unused inputs to prevent warnings
   wire _unused = &{ena, clk, rst_n, 1'b0};
  // All output pins must be assigned. If not used, assign to 0.
 // assign uo_out  = ui_in;  // Example: ou_out is ui_in
  assign uio_out = 0;
  assign uio_oe  = 0;

endmodule
