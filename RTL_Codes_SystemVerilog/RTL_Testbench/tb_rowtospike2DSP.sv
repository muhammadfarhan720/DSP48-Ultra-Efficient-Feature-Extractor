`timescale 1ns / 1ps

module tb_rowtospike2DSP;

    // Parameters
    localparam CLK_PERIOD = 10; // Clock period in ns

    // Testbench signals
    reg CLK;
    reg signed [24:0] X [1:0];
    reg signed [47:0] VINX [3:0];
    wire signed [47:0] VOUTX [3:0];
    wire [3:0] spikex;
    wire signed [47:0] dsp_out;
    

    // DUT instantiation
    rowtospike2DSP uut (
        .CLK(CLK),
        .X(X),
        .VINX(VINX),
        .VOUTX(VOUTX),
        .spikex(spikex),
        .dsp_out(dsp_out)
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
        X[0] = 25'sd100;
        X[1] = 25'sd200;
        VINX[0] = 48'sd500;
        VINX[1] = 48'sd600;
        VINX[2] = 48'sd700;
        VINX[3] = 48'sd800;
        #100;
        X[0] = 25'sd0;
        X[1] = 25'sd0;
        VINX[0] = 48'sd0;
        VINX[1] = 48'sd0;
        VINX[2] = 48'sd0;
        VINX[3] = 48'sd0;
        #10;
        X[0] = -25'sd50;
        X[1] = 25'sd150;
        VINX[0] = 48'sd250;
        VINX[1] = -48'sd300;
        VINX[2] = 48'sd350;
        VINX[3] = 48'sd400;
        #100;
        X[0] = 25'sd0;
        X[1] = 25'sd0;
        VINX[0] = 48'sd0;
        VINX[1] = 48'sd0;
        VINX[2] = 48'sd0;
        VINX[3] = 48'sd0;
        #10;
        X[0] = 25'sd0;
        X[1] = 25'sd0;
        VINX[0] = 48'sd0;
        VINX[1] = 48'sd0;
        VINX[2] = 48'sd0;
        VINX[3] = 48'sd0;

        // Finish simulation
        #150;
        $finish;
    end

    // Monitor outputs
    initial begin
        $monitor($time, " CLK=%b, X[0]=%d, X[1]=%d, VINX[0]=%d, VINX[1]=%d, VINX[2]=%d, VINX[3]=%d, VOUTX[0]=%d, VOUTX[1]=%d, VOUTX[2]=%d, VOUTX[3]=%d, spikex=%b, dsp_out=%d",
                 CLK, X[0], X[1], VINX[0], VINX[1], VINX[2], VINX[3], VOUTX[0], VOUTX[1], VOUTX[2], VOUTX[3], spikex, dsp_out);
    end

endmodule