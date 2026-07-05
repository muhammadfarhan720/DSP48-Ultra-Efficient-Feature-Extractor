`timescale 1ns / 1ps

module rowtospikecombined_tb;

    // Parameters
    localparam CLK_PERIOD = 10; // Clock period in ns

    // Testbench signals
    reg CLK;
    reg signed [24:0] X [3:0];
    reg signed [47:0] VINX [7:0];
    wire signed [47:0] VOUTX [7:0];
    wire [7:0] spikex;
    wire signed [47:0] dsp_out;
    wire [3:0] counter;

    // Instantiate the DUT (Device Under Test)
    rowtospikecombined dut (
        .CLK(CLK),
        .X(X),
        .VINX(VINX),
        .VOUTX(VOUTX),
        .spikex(spikex),
        .dsp_out(dsp_out),
        .counter(counter)
    );

    // Clock generation
    initial begin
        CLK = 0;
        forever #(CLK_PERIOD / 2) CLK = ~CLK;
    end

    // Input stimulus
    initial begin
        // Initialize inputs
        integer i;
        for (i = 0; i < 4; i = i + 1) begin
            X[i] = $signed(i * 0); // Example initialization for X
        end

        for (i = 0; i < 8; i = i + 1) begin
            VINX[i] = $signed(i * 0); // Example initialization for VINX
        end

        // Wait for 4 ns to change inputs
        #(4);

        // Change inputs every 12 cycles (12 * CLK_PERIOD = 120 ns)
        for (i = 0; i < 4; i = i + 1) begin
            X[i] = $signed(i * 100); // Example initialization for X
        end

        for (i = 0; i < 8; i = i + 1) begin
            VINX[i] = $signed(i * 1000); // Example initialization for VINX
        end

        // Wait for 4 ns to change inputs
        #(120);
        repeat (5) begin // Change 5 times as an example
            
            for (i = 0; i < 4; i = i + 1) begin
                X[i] = $signed(X[i] + 10); // Update X values
            end
            for (i = 0; i < 8; i = i + 1) begin
                VINX[i] = $signed(VINX[i] + 100); // Update VINX values
            end
            #(120);
        end

        // Finish the simulation after a while
        #(1000);
        $finish;
    end

    // Monitor outputs
    initial begin
        $monitor("Time = %0dns, Counter = %b, VOUTX = %p, spikex = %b", 
                 $time, counter, VOUTX, spikex);
    end

endmodule
