module rowtospike1DSP( 
    input  CLK,                  // Clock input
    input signed [24:0] X [1:0],  // Array of 25-bit signed inputs X[0] to X[1]
    input signed [47:0] VINX [3:0], // 48-bit signed inputs VINX[0] to VINX[3]
    input [3:0] counter,
    output signed [47:0] VOUTX0, // 48-bit signed outputs VOUTX[0] to VOUTX[3]
    output signed [47:0] VOUTX1,
    output signed [47:0] VOUTX2,
    output signed [47:0] VOUTX3,
    output [3:0] spikex  // 4-bit spike output
    
);

    // Local parameters for constants B1 and B2
    localparam signed [17:0] B1 = 18'sd1;
    localparam signed [17:0] B2 = -18'sd1;

    // Threshold value for spike generation
    localparam signed [47:0] VTH = 48'sd1; // Adjust the value as needed
    reg signed [47:0] VOUTX_internal [3:0];
    reg [3:0] spikex_internal;
    // Internal registers
   // reg [3:0] cycle_counter = 4'b0000; // 4-bit counter for sequencing (12 cycles total)
    reg signed [17:0] B_sel;           
    reg signed [24:0] A_sel;
    reg signed [47:0] C_sel;           
    reg signed [47:0] dsp_reg [3:0];   // Registers for DSP outputs
    wire signed [47:0] dsp_out;        // DSP output wire

    // Cycle counter and operations
    always @(posedge CLK) begin
        case (counter)
            4'b0001: begin A_sel <= X[0]; B_sel <= B1; C_sel <= VINX[0]; end
            4'b0010: begin A_sel <= X[0]; B_sel <= B2; C_sel <= VINX[1]; end
            4'b0011: begin A_sel <= X[1]; B_sel <= B1; C_sel <= VINX[2]; end
            4'b0100: begin A_sel <= X[1]; B_sel <= B2; C_sel <= VINX[3]; end
        endcase

        // Store DSP results
        if (counter > 5) dsp_reg[counter - 6] <= dsp_out;

        // Assign final outputs after all cycles
        if (counter == 4'b1010) begin
            for (int i = 0; i < 4; i = i + 1) begin
                if (dsp_reg[i] > VTH) begin
                    VOUTX_internal[i] <= 0;           // Reset VOUTX
                    spikex_internal[i] <= 1;          // Generate spike
                    
                end else begin
                    VOUTX_internal[i] <= dsp_reg[i];  // Normal value assignment
                    spikex_internal[i] <= 0;          // No spike
                end
            end
        end

        

        // Increment or reset the counter
        //counter <= (counter == 4'b1010) ? 4'b0000 : (counter + 1);
    end

    // DSP instance
    ABplusC u_dsp_macro (
        .CLK(CLK),    // Use the original clock for DSP operation
        .A(A_sel),    // Connect selected input
        .B(B_sel),    // Selected B value
        .C(C_sel),    // Selected C value
        .P(dsp_out)   // DSP output
    );

assign VOUTX0 = VOUTX_internal[0];
assign VOUTX1 = VOUTX_internal[1];
assign VOUTX2 = VOUTX_internal[2];
assign VOUTX3 = VOUTX_internal[3];
assign spikex = spikex_internal;

endmodule
