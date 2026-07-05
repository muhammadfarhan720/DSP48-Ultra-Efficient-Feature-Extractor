`timescale 1ns / 1ps

module top_module2 (
    input CLK,                          // Clock input
    input [24:0] u,
    input signed [17:0] B_static[0:7],
    output spikex_internal [15:0] 
);
    reg [3:0] counter = 4'b1001;         // Initialize counter to 9 (binary 1001)
    reg [7:0] time_step = 8'b00000000;
    reg signed [47:0] P[0:7];            // Internal 2D array: 8 x 48-bit output P
    reg signed [24:0] A[0:7];            // Internal 2D array for column access
    reg signed [17:0] B[0:7];            // 2D array: 8 x 18-bit input A
    //reg signed [17:0] B_static[0:7][0:8];  // Static 8x9 matrix (8 rows, 9 columns) of 25-bit values
    reg signed [47:0] P_reg[0:7]; // 2D array: 8 x 48-bit output P_reg
    // Internal signals to connect to the rowtospike1DSP_wrapper instance
    wire signed [47:0] X_internal [7:0];
    reg signed [47:0] VINX_internal [15:0];
    wire signed [47:0] VOUTX_internal [15:0];
    //wire [3:0] spikex_internal [3:0];



initial begin
//      B_static[0] = {18'b000000000000000001, 18'b000000001111101000, 18'b111111111111111111, 18'b111111111111111111, 18'b111111111111111111, 18'b111111111111111111, 18'b111111111111111111, 18'b111111111111111111, 18'b111111111111111111}; // Row 0
//B_static[1] = {18'b111111111111111100, 18'b000000000000000011, 18'b000000001111101000, 18'b111111111111111101, 18'b111111111111111101, 18'b111111111111111101, 18'b111111111111111101, 18'b111111111111111101, 18'b111111111111111101}; // Row 1
//B_static[2] = {18'b000000000000000110, 18'b111111111111111011, 18'b000000000000000101, 18'b000000001111101000, 18'b111111111111111011, 18'b111111111111111011, 18'b111111111111111011, 18'b111111111111111011, 18'b111111111111111011}; // Row 2
//B_static[3] = {18'b111111111111110111, 18'b000000000000000111, 18'b111111111111111001, 18'b000000000000000111, 18'b000000001111101000, 18'b111111111111111001, 18'b111111111111111001, 18'b111111111111111001, 18'b111111111111111001}; // Row 3
//B_static[4] = {18'b000000000000001011, 18'b111111111111110111, 18'b000000000000001001, 18'b111111111111110111, 18'b000000000000001001, 18'b000000001111101000, 18'b111111111111110111, 18'b111111111111110111, 18'b111111111111110111}; // Row 4
//B_static[5] = {18'b111111111111110010, 18'b000000000000001011, 18'b111111111111110101, 18'b000000000000001011, 18'b111111111111110101, 18'b000000000000001011, 18'b000000001111101000, 18'b111111111111110101, 18'b111111111111110101}; // Row 5
//B_static[6] = {18'b000000000000010001, 18'b111111111111110011, 18'b000000000000001101, 18'b111111111111110011, 18'b000000000000001101, 18'b111111111111110011, 18'b000000000000001101, 18'b000000001111101000, 18'b111111111111110011}; // Row 6
//B_static[7] = {18'b111111111111101101, 18'b000000000000001111, 18'b111111111111110001, 18'b000000000000001111, 18'b111111111111110001, 18'b000000000000001111, 18'b111111111111110001, 18'b000000000000001111, 18'b000000001111101000}; // Row 7
B[0] = 0; 
        B[1] = 0; B[2] = 0; 
                B[3] = 0; B[4] = 0; B[5] = 0; 
                B[6] = 0; B[7] = 0; A[0] = 0; A[1] = 0; A[2] = 0; 
                A[3] = 0; A[4] = 0; A[5] = 0; 
                A[6] = 0; A[7] = 0;
    end

    // Logic to select columns based on counter value
    always @(posedge CLK) begin
        case(counter)
        4'b1000: begin
        if (time_step == 8'b10011000)  // If time_step is 151, reset to 0
                   time_step <= 8'b0;
                else  // Otherwise, increment time_step
                   time_step <= time_step + 1;
         end
            4'b1001: begin  // Counter = 9, read first column of B_static
                B[0] <= B_static[0]; B[1] <= B_static[1]; B[2] <= B_static[2]; 
                B[3] <= B_static[3]; B[4] <= B_static[4]; B[5] <= B_static[5]; 
                B[6] <= B_static[6]; B[7] <= B_static[7]; A[0] <= u;
                A[1] <= u; A[2] <= u; A[3] <= u; A[4] <= u; A[5] <= u;
                A[6] <= u; A[7] <= u;
                
               
            end
            4'b1010: begin  // Counter = 10, read second column of B_static
                B[0] <= B_static[0]; B[1] <= B_static[1]; B[2] <= B_static[2]; 
                B[3] <= B_static[3]; B[4] <= B_static[4]; B[5] <= B_static[5]; 
                B[6] <= B_static[6]; B[7] <= B_static[7]; 
//                A[0] <= {P[0][47], P[0][23:0]}; A[1] <= {P[0][47], P[0][23:0]}; A[2] <= {P[0][47], P[0][23:0]};
//                A[3] <= {P[0][47], P[0][23:0]}; A[4] <= {P[0][47], P[0][23:0]}; A[5] <= {P[0][47], P[0][23:0]};
//                A[6] <= {P[0][47], P[0][23:0]}; A[7] <= {P[0][47], P[0][23:0]};
                A[0] <= P[0]; A[1] <= P[0]; A[2] <=P[0];
                A[3] <=P[0]; A[4] <= P[0]; A[5] <= P[0];
                A[6] <= P[0]; A[7] <= P[0];
                if (time_step == 8'b11111111 || time_step == 8'b00000000 || time_step == 8'b00000001) begin
            // If time_step is FF or 0, set X_internal and VINX_internal to 0
            integer i;
                    //for (i = 0; i < 8; i = i + 1) begin
                    //    X_internal[i] <= 0;  // Set each element of X_internal to 0
                   // end
                    for (i = 0; i < 16; i = i + 1) begin
                        VINX_internal[i] <= 0;  // Set each element of VINX_internal to 0
                    end
        end else begin
            // Otherwise, set X_internal to p_reg and VINX_internal to VOUTX_internal
           // X_internal <= P_reg;
            VINX_internal <= VOUTX_internal;
        end
            end
            4'b0000: begin  // Counter = 0, read third column of B_static
               B[0] <= B_static[0]; B[1] <= B_static[1]; B[2] <= B_static[2]; 
                B[3] <= B_static[3]; B[4] <= B_static[4]; B[5] <= B_static[5]; 
                B[6] <= B_static[6]; B[7] <= B_static[7];  A[0] <= P_reg[1];
                A[1] <= P_reg[1]; A[2] <= P_reg[1]; A[3] <= P_reg[1]; A[4] <= P_reg[1]; A[5] <= P_reg[1];
                A[6] <= P_reg[1]; A[7] <= P_reg[1];
                 
            end
            4'b0001: begin  // Counter = 1, read fourth column of B_static
                B[0] <= B_static[0]; B[1] <= B_static[1]; B[2] <= B_static[2]; 
                B[3] <= B_static[3]; B[4] <= B_static[4]; B[5] <= B_static[5]; 
                B[6] <= B_static[6]; B[7] <= B_static[7];  A[0] <= P_reg[2];
                A[1] <= P_reg[2]; A[2] <= P_reg[2]; A[3] <= P_reg[2]; A[4] <= P_reg[2]; A[5] <= P_reg[2];
                A[6] <= P_reg[2]; A[7] <= P_reg[2];
            end
            4'b0010: begin  // Counter = 2, read fifth column of B_static
                B[0] <= B_static[0]; B[1] <= B_static[1]; B[2] <= B_static[2]; 
                B[3] <= B_static[3]; B[4] <= B_static[4]; B[5] <= B_static[5]; 
                B[6] <= B_static[6]; B[7] <= B_static[7];  A[0] <= P_reg[3];
                A[1] <= P_reg[3]; A[2] <= P_reg[3]; A[3] <= P_reg[3]; A[4] <= P_reg[3]; A[5] <= P_reg[3];
                A[6] <= P_reg[3]; A[7] <= P_reg[3];
            end
            4'b0011: begin  // Counter = 3, read sixth column of B_static
                B[0] <= B_static[0]; B[1] <= B_static[1]; B[2] <= B_static[2]; 
                B[3] <= B_static[3]; B[4] <= B_static[4]; B[5] <= B_static[5]; 
                B[6] <= B_static[6]; B[7] <= B_static[7]; A[0] <= P_reg[4];
                A[1] <= P_reg[4]; A[2] <= P_reg[4]; A[3] <= P_reg[4]; A[4] <= P_reg[4]; A[5] <= P_reg[4];
                A[6] <= P_reg[4]; A[7] <= P_reg[4];
            end
            4'b0100: begin  // Counter = 4, read seventh column of B_static
                B[0] <= B_static[0]; B[1] <= B_static[1]; B[2] <= B_static[2]; 
                B[3] <= B_static[3]; B[4] <= B_static[4]; B[5] <= B_static[5]; 
                B[6] <= B_static[6]; B[7] <= B_static[7];  A[0] <= P_reg[5];
                A[1] <= P_reg[5]; A[2] <= P_reg[5]; A[3] <= P_reg[5]; A[4] <= P_reg[5]; A[5] <= P_reg[5];
                A[6] <= P_reg[5]; A[7] <= P_reg[5];
            end
            4'b0101: begin  // Counter = 5, read eighth column of B_static
                B[0] <= B_static[0]; B[1] <= B_static[1]; B[2] <= B_static[2]; 
                B[3] <= B_static[3]; B[4] <= B_static[4]; B[5] <= B_static[5]; 
                B[6] <= B_static[6]; B[7] <= B_static[7]; A[0] <= P_reg[6];
                A[1] <= P_reg[6]; A[2] <= P_reg[6]; A[3] <= P_reg[6]; A[4] <= P_reg[6]; A[5] <= P_reg[6];
                A[6] <= P_reg[6]; A[7] <= P_reg[6];
            end
            4'b0110: begin  // Counter = 6, read ninth column of B_static
                B[0] <= B_static[0]; B[1] <= B_static[1]; B[2] <= B_static[2]; 
                B[3] <= B_static[3]; B[4] <= B_static[4]; B[5] <= B_static[5]; 
                B[6] <= B_static[6]; B[7] <= B_static[7];  A[0] <= P_reg[7];
                A[1] <= P_reg[7]; A[2] <= P_reg[7]; A[3] <= P_reg[7]; A[4] <= P_reg[7]; A[5] <= P_reg[7];
                A[6] <= P_reg[7]; A[7] <= P_reg[7];
            end
            default: begin
                B[0] <= 0; B[1] <= 0; B[2] <= 0; 
                B[3] <= 0; B[4] <= 0; B[5] <= 0; 
                B[6] <= 0; B[7] <= 0; A[0] <= 0; A[1] <= 0; A[2] <= 0; 
                A[3] <= 0; A[4] <= 0; A[5] <= 0; 
                A[6] <= 0; A[7] <= 0;
            end
        endcase
    end

    // Counter logic to cycle in intervals of 10
    always @(posedge CLK) begin
        if (counter == 4'b1010) begin
            counter <= 0;               // Reset counter after reaching 10
        end else begin
            counter <= counter + 1;     // Increment counter
        end
    end

    // Instantiate the LDN module
    ldn u_ldn (
        .CLK(CLK),                         // Connect clock input
        .counter(counter),                 // Connect counter
        .A(A),                             // Connect the selected column of B
        .B(B),                             // Connect 2D array A
        .P(P)                              // Connect internal 2D array output P
    );
    
     // Instantiate the rowtospike1DSP_wrapper
    rowtospike1DSP_wrapper1 rowtospike1DSP_inst (
        .CLK(CLK),  // Connect the clock input
        .X(X_internal),  // Connect the 8-element signed X input array
        .VINX(VINX_internal),  // Connect the 16-element signed VINX input array
        .counter(counter),
        .VOUTX(VOUTX_internal),  // Connect the 16-element signed VOUTX output array
        .spike_train(spikex_internal)  // Connect the 4x4-bit spikex output
    );
    
    // When counter reaches 10, assign P to P_reg
    always @(posedge CLK) begin
        if (counter == 4'b1010) begin
            P_reg <= P;                   // Bssign P to P_reg
//            P_reg[0] <= {P[0][47], P[0][23:0]}; // MSB + 24 LSBs
//            P_reg[1] <= {P[1][47], P[1][23:0]};
//            P_reg[2] <= {P[2][47], P[2][23:0]};
//            P_reg[3] <= {P[3][47], P[3][23:0]};
//            P_reg[4] <= {P[4][47], P[4][23:0]};
//            P_reg[5] <= {P[5][47], P[5][23:0]};
//            P_reg[6] <= {P[6][47], P[6][23:0]};
//            P_reg[7] <= {P[7][47], P[7][23:0]};
        end
    end
assign X_internal = P_reg;
endmodule
