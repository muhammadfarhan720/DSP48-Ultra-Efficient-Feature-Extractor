`timescale 1ns / 1ps

module top_module1_tb; 
    // Testbench signals
    reg CLK;                               // Clock signal
    reg [24:0] u;                          // Input u
   
    reg spikex_internal [15:0];
    // Instantiate the top module (the unit under test)
    top_module1 uut (
        .CLK(CLK),                          // Connect clock
        .u(u),                       // Connect output P_reg
        .spikex_internal(spikex_internal)
    );

        // Clock generation: 10 ns clock period
    always begin
        #5 CLK = ~CLK;  // Toggle clock every 5 ns for 10 ns period
    end
  
  parameter ROWS = 1000;
  parameter COLS = 152;
  reg signed [24:0] data_buffer[ROWS-1:0][COLS-1:0];






//read the CSV to the declared data_buffer

  integer file;
  string line, token;
  integer row, col, idx;


  initial begin
    file = $fopen("wafer_1000_farhan_scaled_int.csv", "r");
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
        
       for(int i=1; i<COLS; i++) begin
       
       repeat(11) @(posedge CLK); 
       
       u = data_buffer[test_row][i]; // Change input value to test another scenario
       
       end
    
            
            #110;  // Wait for some time to observe outputs
    
         
      end
        
  
parameter out_ROWS = 16;
parameter out_COLS = 152;
reg [out_ROWS-1:0] output_buffer [out_COLS-1:0];

integer output_file;

initial begin
    // Wait for initial clock cycles
    repeat(29) @(posedge CLK);
    #5;
    
    // Store the first set of spikex_internal values
    for (int bits = 0; bits < out_ROWS; bits++) begin
        output_buffer[0][bits] = spikex_internal[bits];
    end

    for (int j = 1; j < out_COLS; j++) begin
        repeat(11) @(posedge CLK);
        
        // Store each bit of spikex_internal into output_buffer
        for (int bits = 0; bits < out_ROWS; bits++) begin
            output_buffer[j][bits] = spikex_internal[bits];
        end
    end

    // Display the recorded output in console
    for (int j = 0; j < out_COLS; j++) begin
        $write("Output timestep %0d: ", j);
        for (int bits = 0; bits < out_ROWS; bits++) begin
            $write("%b ", output_buffer[j][bits]);
        end
        $display("");
    end

    // Open a file for writing
    output_file = $fopen("output_data.csv", "w");
    
    if (output_file == 0) begin
        $display("Error: Could not open output file");
        $finish;
    end

    // Write output buffer to CSV file
    for (int j = 0; j < out_COLS; j++) begin
        for (int bits = 0; bits < out_ROWS; bits++) begin
            if (output_buffer[j][bits] !== 1'bx)  // Ensure no 'x' values are written
                $fwrite(output_file, "%b", output_buffer[j][bits]);
            else
                $fwrite(output_file, "0");  // Replace 'x' with '0' (or appropriate value)

            if (bits < out_ROWS - 1)
                $fwrite(output_file, ","); // Add a comma between values
        end
        $fwrite(output_file, "\n"); // Newline for next row
    end

    // Close the file
    $fclose(output_file);
    
    $display("Output buffer has been written to output_data.csv");
    
    $finish;
end

endmodule
