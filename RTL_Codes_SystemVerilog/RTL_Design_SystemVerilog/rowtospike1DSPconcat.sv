module rowtospike1DSPconcat( 
    input  CLK,                  // Clock input
    input signed [47:0] X [1:0],  // Array of 25-bit signed inputs X[0] to X[1]
    input signed [47:0] VINX [3:0], // 48-bit signed inputs VINX[0] to VINX[3]
    input [3:0] counter,
    output signed [47:0] VOUTX0, // 48-bit signed outputs VOUTX[0] to VOUTX[3]
    output signed [47:0] VOUTX1,
    output signed [47:0] VOUTX2,
    output signed [47:0] VOUTX3,
    output [3:0] spikex  // 4-bit spike output
    
);

   

    // Threshold value for spike generation
    //localparam signed [47:0] VTH = 48'sd1; // Adjust the value as needed
    localparam signed [47:0] VTH = 48'h00000010;
    reg signed [47:0] VOUTX_internal [3:0];
    reg [3:0] spikex_internal;
    // Internal registers
   // reg [3:0] cycle_counter = 4'b0000; // 4-bit counter for sequencing (12 cycles total)
    reg signed [47:0] CONCAT_sel;           
    //reg [3:0] counter = 4'b1001; // 4-bit counter for sequencing (12 cycles total)
    reg signed [47:0] C_sel;           
    reg signed [47:0] dsp_reg [3:0];   // Registers for DSP outputs
    wire signed [47:0] dsp_out;        // DSP output wire

    // Cycle counter and operations
    always @(posedge CLK) begin
        case (counter)
            4'b0000: begin CONCAT_sel <= X[0] + 48'h000000008;  C_sel <= VINX[0]; end
            4'b0001: begin CONCAT_sel <= ~X[0] + + 48'h000000009; C_sel <= VINX[1]; end
            4'b0010: begin CONCAT_sel <= X[1] + 48'h000000008;  C_sel <= VINX[2]; end
            4'b0011: begin CONCAT_sel <= ~X[1] + + 48'h000000009;  C_sel <= VINX[3]; end
        endcase

        // Store DSP results
        if (counter > 4) dsp_reg[counter - 5] <= dsp_out;

        // Assign final outputs after all cycles
        if (counter == 4'b1001) begin
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
       // counter <= (counter == 4'b1010) ? 4'b0000 : (counter + 1);
    end


  
    
    concatenc dso_macro (
  .CLK(CLK),        // input wire CLK
  .C(C_sel),            // input wire [47 : 0] C
  .CONCAT(CONCAT_sel),  // input wire [47 : 0] CONCAT
  .P(dsp_out)            // output wire [47 : 0] P
);

assign VOUTX0 = VOUTX_internal[0];
assign VOUTX1 = VOUTX_internal[1];
assign VOUTX2 = VOUTX_internal[2];
assign VOUTX3 = VOUTX_internal[3];
assign spikex = spikex_internal;

endmodule
