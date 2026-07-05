`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/21/2024 01:52:13 PM
// Design Name: 
// Module Name: ABPSCLR
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Reset P using SCLR based on external 4-bit counter input.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module ABPSCLR(
    input CLK,                   // Clock input
    input [3:0] counter,         // 4-bit external counter input
    input [6:0] ts,
    input signed [24:0] A,       // 25-bit input A
    input signed [17:0] B,       // 18-bit input B
    output signed [47:0] P       // 48-bit output P
);

    // SCLRP as a combinational wire
   wire SCLRP = ((ts != 7'b0000000) && (counter == 4'b0000)) || ((ts == 7'b0000000) && ((counter == 4'b1000) || (counter == 4'b1001)));
    //wire SCLRP = (counter == 4'b0000);
    // wire SCLRP =((ts != 7'b0000000) && (counter == 4'b0000)) ;
    // Instantiate ABplusPCLR module
    ABplusPCLR inst1 (
        .CLK(CLK),               // Clock input
        .A(A),                   // Input A
        .B(B),                   // Input B
        .P(P),                   // Output P
        .SCLRP(SCLRP)            // SCLR signal
    );

endmodule
