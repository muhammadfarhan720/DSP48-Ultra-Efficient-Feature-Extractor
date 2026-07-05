`timescale 1ns / 1ps

module rowtospike1DSP_tb;

    // Parameters
    localparam CLK_PERIOD = 10; // Clock period in ns

    // Testbench signals
    reg CLK;
    reg signed [24:0] X [1:0];
    reg signed [47:0] VINX [3:0];
    wire signed [47:0] VOUTX [3:0];
    wire [3:0] spikex;
    
    // DUT instantiation
    rowtospike1DSP uut (
        .CLK(CLK),
        .X(X),
        .VINX(VINX),
        .VOUTX(VOUTX),
        .spikex(spikex)
    );
    
    rowtospike1DSPconcat uut (
        .CLK(CLK),
        .X(X),
        .VINX(VINX),
        .VOUTX(VOUTX),
        .spikex(spikex)
    );

    // Clock generation
    initial begin
        CLK = 0;
        forever #(CLK_PERIOD / 2) CLK = ~CLK;
    end

    // Stimulus generation
    initial begin
        // Initialize inputs
        X[0] = 25'sd0;
        X[1] = 25'sd0;
        VINX[0] = 48'sd0;
        VINX[1] = 48'sd0;
        VINX[2] = 48'sd0;
        VINX[3] = 48'sd0;

        // Apply test vectors
        #4;
        X[0] = 25'sd120;
        X[1] = -25'sd80;
        VINX[0] = 48'sd400;
        VINX[1] = -48'sd200;
        VINX[2] = 48'sd600;
        VINX[3] = 48'sd1000;
        #100;
        X[0] = 25'sd0;   
X[1] = 25'sd0;   
VINX[0] = 48'sd0;
VINX[1] = 48'sd0;
VINX[2] = 48'sd0;
VINX[3] = 48'sd0;

#10
        
        X[0] = -25'sd90;
        X[1] = 25'sd70;
        VINX[0] = -48'sd350;
        VINX[1] = 48'sd450;
        VINX[2] = -48'sd550;
        VINX[3] = 48'sd650;
        #100;

        X[0] = 25'sd0;
        X[1] = 25'sd0;
        VINX[0] = 48'sd0;
        VINX[1] = 48'sd0;
        VINX[2] = 48'sd0;
        VINX[3] = 48'sd0;
        #10;

        X[0] = 25'sd60;
        X[1] = -25'sd40;
        VINX[0] = 48'sd300;
        VINX[1] = 48'sd200;
        VINX[2] = -48'sd250;
        VINX[3] = 48'sd500;
        

        // Finish simulation
        #150;
        $finish;
    end

    // Monitor outputs
    initial begin
        $monitor($time, " CLK=%b, X[0]=%d, X[1]=%d, VINX[0]=%d, VINX[1]=%d, VINX[2]=%d, VINX[3]=%d, VOUTX[0]=%d, VOUTX[1]=%d, VOUTX[2]=%d, VOUTX[3]=%d, spikex=%b",
                 CLK, X[0], X[1], VINX[0], VINX[1], VINX[2], VINX[3], VOUTX[0], VOUTX[1], VOUTX[2], VOUTX[3], spikex);
    end

endmodule
