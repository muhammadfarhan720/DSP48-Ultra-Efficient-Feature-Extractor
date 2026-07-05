`timescale 1ns / 1ps

module top_module_tb_ecg5days; 
    // Testbench signals
    reg CLK;                               // Clock signal
    reg  signed [24:0] u;                          // Input u
    
    wire  spikex_internal [15:0]  ;
    // Instantiate the top module (the unit under test)
    top_module_ecg5days uut (
        .CLK(CLK),                          // Connect clock
        .u(u),                              // Connect input u
        .spikex_internal(spikex_internal)
    );

    // Clock generation: 10 ns clock period
    always begin
        #5 CLK = ~CLK;  // Toggle clock every 5 ns for 10 ns period
    end

//    // Test sequence
//    initial begin
//        // Initialize signals
//        CLK = 0;                             // Start with CLK = 0
//        u = 25'd64;
//        // Wait for a few clock cycles and observe P_reg
//        $display("Time\tu\t\tP_reg[0]\tP_reg[1]\tP_reg[2]\tP_reg[3]\tP_reg[4]\tP_reg[5]\tP_reg[6]\tP_reg[7]");
//        $monitor("%t\t%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%0d\t%0d", 
//                 $time, u, P_reg[0], P_reg[1], P_reg[2], P_reg[3], P_reg[4], P_reg[5], P_reg[6], P_reg[7]);
        
//        // Apply some test vectors
//        #110 u = 25'd23; // Change input value to test another scenario
//        #110 u = 25'd34; // Change input value again
        
//        // Add more test cases if needed

//        #110;  // Wait for some time to observe outputs

//        // Finish simulation
//        $finish;
//    end

//Select the dimension of the data_buffer according to CSV (Row x Column) size and bit width  
    
  parameter ROWS = 861;
  parameter COLS = 136;
  reg signed [24:0] data_buffer[ROWS-1:0][COLS-1:0];






//read the CSV to the declared data_buffer

  integer file;
  string line, token;
  integer row, col, idx;


  initial begin
    file = $fopen("quantized_input_train_ECGFiveDays.csv", "r");
    if (file == 0) begin
      $display("Error: Could not open file");
      $finish;
    end

    row = 0;
    while (!$feof(file) && row < ROWS) begin
      // Read entire line
      if ($fgets(line, file) == 0) break; // Exit on read error

      col = 0;
      idx = 0;

      // Split line into tokens using commas
      while (col < COLS) begin
        // Extract token up to next comma or end of line
        token = "";
        while (idx < line.len() && line[idx] != ",") begin
          token = {token, line[idx]};
          idx = idx + 1;
        end
        idx = idx + 1; // Skip comma or move past end

        // Convert token to integer
        if (token != "") begin
          $sscanf(token, "%d", data_buffer[row][col]);
          col = col + 1;
        end else begin
          break; // No more tokens
        end
      end

      row = row + 1; // Move to next row
    end

    $fclose(file); // Close after all rows

//     Display data for verification
    for (int i = 0; i < row; i++) begin
      $write("Row %0d: ", i);
      for (int j = 0; j < COLS; j++) begin
        $write("%d ", data_buffer[i][j]);
      end
      $display("");
    end
  end
 
 
 // Input sending thread   
 
 
    
    
  int  test_row=0;  //Select the sample row here
  
 // Input from data_buffer is sent to design from below  
 
    
      // Test sequence
    initial begin
        // Initialize signals
        CLK = 0;                             // Start with CLK = 0
        u = data_buffer[test_row][0];

        
        // Apply some test vectors
      for(int k=0;k<ROWS;k++) begin
        
       for(int i=1; i<COLS; i++) begin
       
       repeat(11) @(posedge CLK); 
       
       u = data_buffer[k][i]; // Change input value to test another scenario
       
       end
       
       if(k!=ROWS-1) begin
       repeat(11) @(posedge CLK);
       
       u = 0;
       
       repeat(11) @(posedge CLK);
       
       u = data_buffer[k+1][0];
       
    end
end
            
            #110;  // Wait for some time to observe outputs
    
         
      end
        
     



//Testing for all rows


parameter IN_ROWS = 861;       // 100 input rows
parameter IN_COLS = 136;        // 96 timesteps per row
parameter OUT_BITS = 16;       // 16-bit output
parameter OUT_ROWS = IN_ROWS * OUT_BITS;  // 1600 rows (100*16)
parameter OUT_COLS = IN_COLS;  // 96 columns

reg [OUT_COLS-1:0] output_buffer [0:OUT_ROWS-1];  // [1600][96] matrix
integer output_file;
integer row_offset = 0;

initial begin
    // Wait for initial stabilization
    repeat(25) @(posedge CLK);
    
    #5;
    
    // Process all input rows
    for(int input_row = 0; input_row < IN_ROWS; input_row++) begin
        // Process all timesteps for current input row
        for(int ts = 0; ts < IN_COLS; ts++) begin
            if(ts != 0) repeat(11) @(posedge CLK);  // Maintain 11-cycle delay
            
            // Store all 16 bits for this timestep
            for(int bits = 0; bits < OUT_BITS; bits++) begin
                // Each bit gets its own output row
                output_buffer[row_offset + bits][ts] = spikex_internal[bits];
            end
        end
        
        // Move to next output block for next input row
        row_offset += OUT_BITS;  // +16 rows per input row
        
        // Add inter-row delay
        repeat(11) @(posedge CLK);
    end
    
     // Display output buffer in console
    $display("\n=== Output Buffer Contents ===");
    for(int r = 0; r < OUT_ROWS; r++) begin
        $write("Row %4d: ", r);
        for(int c = 0; c < OUT_COLS; c++) begin
            $write("%b", output_buffer[r][c]);
            if(c != OUT_COLS-1) $write(",");  // Add comma separator
        end
        $display("");  // New line after each row
    end
    $display("=== End of Output Buffer ===");
    

    output_file = $fopen("ECG5days_results.csv", "w");
    for(int r = 0; r < OUT_ROWS; r++) begin
        for(int c = 0; c < OUT_COLS; c++) begin
            $fwrite(output_file, "%b,", output_buffer[r][c]);
        end
        $fwrite(output_file, "\n");
    end
    $fclose(output_file);
    $finish;
end


endmodule
