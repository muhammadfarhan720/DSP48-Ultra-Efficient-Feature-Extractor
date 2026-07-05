`timescale 1ns / 1ps

module top8_tb;

  // Inputs
  reg CLK;
  reg signed [24:0] A[0:1];
  reg signed [17:0] B[0:1];

  // Outputs
  wire signed [24:0] P_reg[0:1];

  // Instantiate the Unit Under Test (UUT)
  top8 uut (
    .CLK(CLK),
    .A(A),
    .B(B),
    .P_reg(P_reg)
  );

  // Clock generation
  initial begin
    CLK = 0;
    forever #5 CLK = ~CLK; // Clock period = 10 ns
  end

  // Stimulus process
  initial begin
    // Initialize inputs
    A[0] = 25'sd0;
    B[0] = 18'sd0;
    A[1] = 25'sd0;
    B[1] = 18'sd0;

    // Apply input changes after 2 clock cycles
    //@(posedge CLK); // Wait for the first positive edge
    //@(posedge CLK); // Wait for the second positive edge
    #4;
    A[0] = 25'sd100;   // Change inputs
    B[0] = -18'sd400;
    A[1] = 25'sd100;   // Change inputs
    B[1] = 18'sd400;
    #10;
    // Apply second input changes after 2 more clock cycles
    //@(posedge CLK); // Wait for the third positive edge
    //@(posedge CLK); // Wait for the fourth positive edge
     repeat (8) begin
             A[0] = 25'sd200;
    B[0] = 18'sd500;
    A[1] = 25'sd200;
    B[1] = 18'sd500;
    #10;   // Wait for 90 ns
        end
   A[0] = 25'sd0;
    B[0] = 18'sd0;
    A[1] = 25'sd0;
    B[1] = 18'sd0;
    #10;
   A[0] = 25'sd0;
    B[0] = 18'sd0;
    A[1] = 25'sd0;
    B[1] = 18'sd0;
    #10;
   
    // Apply second input changes after 2 more clock cycles
    //@(posedge CLK); // Wait for the third positive edge
    //@(posedge CLK); // Wait for the fourth positive edge
    A[0] = 25'sd10;
    B[0] = 18'sd30;
    A[1] = 25'sd10;
    B[1] = 18'sd30;
    #10;
    // Apply second input changes after 2 more clock cycles
    //@(posedge CLK); // Wait for the third positive edge
    //@(posedge CLK); // Wait for the fourth positive edge
   repeat (8) begin
             A[0] = 25'sd20;
    B[0] = 18'sd50;
    A[1] = 25'sd20;
    B[1] = 18'sd50;
    #10;   // Wait for 90 ns
        end

    // Wait for the remaining cycles (10 total)
    repeat (8) @(posedge CLK); // Wait for 4 more clock edges
    $stop; // End simulation
  end

  // Monitor process
  initial begin
    $monitor("Time = %0t | CLK = %b | A[0] = %d | B[0] = %d | P_reg[0] = %d", 
             $time, CLK, A[0], B[0], P_reg[0]);
  end

endmodule
