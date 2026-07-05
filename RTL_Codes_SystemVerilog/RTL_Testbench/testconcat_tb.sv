module testconcat_tb;
    // Clock signal
    logic CLK;
    
    // Inputs
    logic signed [47:0] X [1:0];
    logic signed [47:0] VINX [3:0];
    logic [3:0] counter;

    // Outputs from both modules
    logic signed [47:0] VOUTX0_1, VOUTX1_1, VOUTX2_1, VOUTX3_1;
    logic signed [47:0] VOUTX0_2, VOUTX1_2, VOUTX2_2, VOUTX3_2;
    logic [3:0] spikex_1, spikex_2;

   

    // Instantiate the second module
    rowtospike1DSPconcat uut2 (
        .CLK(CLK),
        .X(X),
        .VINX(VINX),
        .VOUTX0(VOUTX0_2),
        .VOUTX1(VOUTX1_2),
        .VOUTX2(VOUTX2_2),
        .VOUTX3(VOUTX3_2),
        .spikex(spikex_2)
    );

    // Clock generation
    initial begin
        CLK = 0;
        forever #5 CLK = ~CLK;  // 10 ns clock period
    end

    // Stimulus generation
    initial begin
        // Initialize inputs
        X[0] = 48'sd0;
        X[1] = 48'sd0;
        VINX[0] = 48'sd0;
        VINX[1] = 48'sd0;
        VINX[2] = 48'sd0;
        VINX[3] = 48'sd0;

        // Wait for initial state
        #4;

        // Test case 1: No spike expected
        X[0] = 48'sd100;
        X[1] = 48'sd50;
        VINX[0] = 48'sd1400;
        VINX[1] = 48'sd300;
        VINX[2] = 48'sd200;
        VINX[3] = 48'sd500;
     
        #100;
        X[0] = 48'sd0;
        X[1] = 48'sd0;
        VINX[0] = 48'sd0;
        VINX[1] = 48'sd0;
        VINX[2] = 48'sd0;
        VINX[3] = 48'sd0;

        // Wait for initial state
        #10;
        // Test case 2: Spike expected on spike0
        X[0] = 48'sd200;
        X[1] = 48'sd100;
        VINX[0] = 48'sd1200;  // Exceeds threshold
        VINX[1] = 48'sd1900;
        VINX[2] = 48'sd500;
        VINX[3] = 48'sd2500;
        #100;
        X[0] = 48'sd0;
        X[1] = 48'sd0;
        VINX[0] = 48'sd0;
        VINX[1] = 48'sd0;
        VINX[2] = 48'sd0;
        VINX[3] = 48'sd0;

        // Wait for initial state
        #10;

        // Test case 3: Spike expected on spike1
        X[0] = 48'sd150;
        X[1] = 48'sd75;
        VINX[0] = 48'sd700;
        VINX[1] = 48'sd1500;  // Exceeds threshold
        VINX[2] = 48'sd300;
        VINX[3] = 48'sd800;
        counter = 4'b0011;
        #150;
$finish;
    end


endmodule
