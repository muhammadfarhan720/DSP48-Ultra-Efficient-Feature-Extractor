`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/05/2025 10:23:06 AM
// Design Name: 
// Module Name: rowtospike1DSP_wrapper
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module rowtospike1DSP_wrapper1(
    input CLK,  // Clock input
    input signed [47:0] X [7:0],  // 8-element array of 25-bit signed inputs
    input signed [47:0] VINX [15:0], // 16-element array of 48-bit signed inputs
    input [3:0] counter,
    output signed [47:0] VOUTX [15:0], // 16-element array of 48-bit signed outputs
    output spike_train [15:0] // 4x4-bit spike output
);
wire [3:0] spikex [3:0];
    rowtospike1DSPconcat u_rowtospike1DSP_0 (
        .CLK(CLK),
        .X({X[0], X[1]}),
        .VINX({VINX[0], VINX[1], VINX[2], VINX[3]}),
        .counter(counter),
        .VOUTX0(VOUTX[0]),
        .VOUTX1(VOUTX[1]),
        .VOUTX2(VOUTX[2]),
        .VOUTX3(VOUTX[3]),
        .spikex(spikex[0])
    );

    rowtospike1DSPconcat u_rowtospike1DSP_1 (
        .CLK(CLK),
        .X({X[2], X[3]}),
        .VINX({VINX[4], VINX[5], VINX[6], VINX[7]}),
        .counter(counter),
        .VOUTX0(VOUTX[4]),
        .VOUTX1(VOUTX[5]),
        .VOUTX2(VOUTX[6]),
        .VOUTX3(VOUTX[7]),
        .spikex(spikex[1])
    );

    rowtospike1DSPconcat u_rowtospike1DSP_2 (
        .CLK(CLK),
        .X({X[4], X[5]}),
        .VINX({VINX[8], VINX[9], VINX[10], VINX[11]}),
        .counter(counter),
        .VOUTX0(VOUTX[8]),
        .VOUTX1(VOUTX[9]),
        .VOUTX2(VOUTX[10]),
        .VOUTX3(VOUTX[11]),
        .spikex(spikex[2])
    );

    rowtospike1DSPconcat u_rowtospike1DSP_3 (
        .CLK(CLK),
        .X({X[6], X[7]}),
        .VINX({VINX[12], VINX[13], VINX[14], VINX[15]}),
        .counter(counter),
        .VOUTX0(VOUTX[12]),
        .VOUTX1(VOUTX[13]),
        .VOUTX2(VOUTX[14]),
        .VOUTX3(VOUTX[15]),
        .spikex(spikex[3])
    );
   // Correct assignment of 16 individual bits
genvar i, j;
generate
    for (i = 0; i < 4; i++) begin
        for (j = 0; j < 4; j++) begin
            assign spike_train[i*4 + j] = spikex[i][j]; // Extract individual bits
        end
    end
endgenerate
endmodule

