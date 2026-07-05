`timescale 1ns / 1ps

module top_ldn_tb; 
    // Testbench signals
    reg CLK;                               // Clock signal
    reg [24:0] u;                          // Input u
    wire signed [47:0] P_reg [0:7];        // Output P_reg (array)
    reg spikex_internal [15:0];
    // Instantiate the top module (the unit under test)
    top_ldn uut (
        .CLK(CLK),                          // Connect clock
        .u(u),                              // Connect input u
        .P_reg(P_reg)
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
 
  int  test_row=0;  //Select the sample row here
  
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





endmodule
