`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/21/2024
// Design Name: 
// Module Name: Top_ABPSCLR
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Counter starts from 9 and cycles in intervals of 10,
//              Instantiates 8 distinct DSP modules in parallel with distinct input and output connections,
//              Inputs and outputs are represented as 2D arrays.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module ldn(
    input CLK,                          // Clock input
    input [3:0] counter,                // 4-bit counter input
    input signed [24:0] A[0:7],         // 2D array: 8 x 25-bit input A
    input signed [17:0] B[0:7],         // 2D array: 8 x 18-bit input B
    output signed [47:0] P[0:7]         // 2D array: 8 x 48-bit output P
);

wire signed [47:0] P_raw[0:7];   

    // Instantiate 8 distinct DSP modules in parallel with unique connections
    ABPSCLR abpsclr_inst0 (
        .CLK(CLK),
        .counter(counter),
        .A(A[0]),    // Use the 0th element of A
        .B(B[0]),    // Use the 0th element of B
        .P(P_raw[0])     // Use the 0th element of P
    );

    ABPSCLR abpsclr_inst1 (
        .CLK(CLK),
        .counter(counter),
        .A(A[1]),    // Use the 1st element of A
        .B(B[1]),    // Use the 1st element of B
        .P(P_raw[1])     // Use the 1st element of P
    );

    ABPSCLR abpsclr_inst2 (
        .CLK(CLK),
        .counter(counter),
        .A(A[2]),    // Use the 2nd element of A
        .B(B[2]),    // Use the 2nd element of B
        .P(P_raw[2])     // Use the 2nd element of P
    );

    ABPSCLR abpsclr_inst3 (
        .CLK(CLK),
        .counter(counter),
        .A(A[3]),    // Use the 3rd element of A
        .B(B[3]),    // Use the 3rd element of B
        .P(P_raw[3])     // Use the 3rd element of P
    );

    ABPSCLR abpsclr_inst4 (
        .CLK(CLK),
        .counter(counter),
        .A(A[4]),    // Use the 4th element of A
        .B(B[4]),    // Use the 4th element of B
        .P(P_raw[4])     // Use the 4th element of P
    );

    ABPSCLR abpsclr_inst5 (
        .CLK(CLK),
        .counter(counter),
        .A(A[5]),    // Use the 5th element of A
        .B(B[5]),    // Use the 5th element of B
        .P(P_raw[5])     // Use the 5th element of P
    );

    ABPSCLR abpsclr_inst6 (
        .CLK(CLK),
        .counter(counter),
        .A(A[6]),    // Use the 6th element of A
        .B(B[6]),    // Use the 6th element of B
        .P(P_raw[6])     // Use the 6th element of P
    );

    ABPSCLR abpsclr_inst7 (
        .CLK(CLK),
        .counter(counter),
        .A(A[7]),    // Use the 7th element of A
        .B(B[7]),    // Use the 7th element of B
        .P(P_raw[7])     // Use the 7th element of P
    );
// Divide by 10^10 using scaling: Approximate division using multiplication
//    localparam signed [47:0] INV_10E10 = 48'd109; // Approximate (1/10^10) * 2^40

//    generate
//        genvar i;
//        for (i = 0; i < 8; i = i + 1) begin
//            wire signed [47:0] P_scaled = (P[i] * INV_10E10) >>> 40; // Scale down
//            assign P[i] = P_scaled[24:0]; // Truncate to 25 bits
//        end
//    endgenerate
    
//    assign P = P;
    
    
    assign P[0] = P_raw[0] >>> 10;
    assign P[1] = P_raw[1] >>> 10;
    assign P[2] = P_raw[2] >>> 10;
    assign P[3] = P_raw[3] >>> 10;
    assign P[4] = P_raw[4] >>> 10;
    assign P[5] = P_raw[5] >>> 10;
    assign P[6] = P_raw[6] >>> 10;
    assign P[7] = P_raw[7] >>> 10;
endmodule
