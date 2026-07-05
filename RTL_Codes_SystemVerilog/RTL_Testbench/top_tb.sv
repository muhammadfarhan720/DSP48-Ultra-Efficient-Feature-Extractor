`timescale 1ns / 1ps

module top_tb;

  // Inputs
  reg CLK;
  reg signed [24:0] A;
  reg signed [17:0] B;

  // Outputs
  wire signed [47:0] P;

  // Instantiate the Unit Under Test (UUT)
  top uut (
    .CLK(CLK),
    .A(A),
    .B(B),
    .P(P)
  );

  // Clock generation
  initial begin
    CLK = 0;
    forever #5 CLK = ~CLK; // Clock period = 10 ns
  end

  // Stimulus process
  initial begin
    // Initialize inputs
    A = 25'sd0;
    B = 18'sd0;

    // Apply input changes after 2 clock cycles
    //@(posedge CLK); // Wait for the first positive edge
    //@(posedge CLK); // Wait for the second positive edge
    #4;
    A = 25'sd100;   // Change inputs
    B = 18'sd400;
    #10;
    // Apply second input changes after 2 more clock cycles
    //@(posedge CLK); // Wait for the third positive edge
    //@(posedge CLK); // Wait for the fourth positive edge
     repeat (8) begin
             A = 25'sd200;
    B = 18'sd500;
    #10;   // Wait for 90 ns
        end
   A = 25'sd0;
    B = 18'sd0;
    #10;
    A = 25'sd0;
    B = 18'sd0;
    #10;
   
    // Apply second input changes after 2 more clock cycles
    //@(posedge CLK); // Wait for the third positive edge
    //@(posedge CLK); // Wait for the fourth positive edge
    A = 25'sd100;
    B = 18'sd300;
    #10;
    // Apply second input changes after 2 more clock cycles
    //@(posedge CLK); // Wait for the third positive edge
    //@(posedge CLK); // Wait for the fourth positive edge
   repeat (8) begin
             A = 25'sd200;
    B = 18'sd500;
    #10;   // Wait for 90 ns
        end

    // Wait for the remaining cycles (10 total)
    repeat (8) @(posedge CLK); // Wait for 4 more clock edges
    $stop; // End simulation
  end

  // Monitor process
  initial begin
    $monitor("Time = %0t | CLK = %b | A = %d | B = %d | P = %d", 
             $time, CLK, A, B, P);
  end

endmodule
