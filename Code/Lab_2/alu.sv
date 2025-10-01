module alu(
// inputs
    input  wire clock, 
    input  wire issue,
    input  wire signed [31:0] A, B,
    input  wire A_invalid, B_invalid,
    input  wire [5:0] opcode,
    input  wire CDB_xmit,
// inout, meaning they can be input and output
    inout  wire signed [31:0] CDB_data,
    inout  wire [5:0] CDB_source,
    inout  wire CDB_write,
// outputs
    output reg  CDB_rts,
    output wire available,
    output wire [5:0] RS_available,
    output reg  [5:0] issued,
    output wire [5:0] RS_executing,
    output reg  error
);

//////////// Define Constants ////////////// 
    // Disconnected buses have high impedance
    parameter disconnected = 32'bz;
    
    // Calculation delay
    parameter delay = 20;
    
    // Updating delay
    parameter update_delay = 5;
    
    // No unit is calculating
    parameter none = 2'b00;
    
    // Clear Qj/Qk, thus Vj/Vk valid
    parameter valid = 6'b000000;
    
    // Error code
    parameter no_error = 1'b0;
    parameter all_rs_busy = 1'b1;
    
    // Command not issued
    parameter not_issued = 6'b000000;
    
    // Status of reservation station or ALU
    parameter not_busy = 1'b0;
    parameter in_use = 1'b1;
    
    // Is the value ready to send or not
    parameter ready = 1'b1;
    parameter not_ready = 1'b0;
    
    // Used to clear a data value
    parameter clear = 0;
    
    // Reservation station
    parameter no_rs = 6'b000000;
    parameter adder_1 = 6'b000001;
    parameter adder_2 = 6'b000010;
    parameter adder_3 = 6'b000011;
    
    // Operation codes used by ALU
    parameter alu_add = 3'b000;
    parameter alu_sub = 3'b001;
    parameter alu_or  = 3'b100;
    parameter alu_and = 3'b101;
    parameter alu_not = 3'b110;
    parameter alu_xor = 3'b111;
   
////////// Define Internal signals to be used in this module ////////////
    reg signed [31:0] CDB_data_out;
    reg [5:0] CDB_source_out;
    reg CDB_write_out;
    reg [5:0] operation [2:0];

// Qj and Qk are arrays of 4 (index 0-3) 6 bit values
// They hold reservation station numbers when either A or B is invalid
    reg [5:0] Qj [2:0], Qk [2:0];

// Vj and Vk are arrays of 4 (index 0-3) 32 bit values
// They hold operand values (A or B) if the A and B are valid
// If A or B are valid, then they get updated when the invalid
// value (the value we've been waiting for) is produced
    reg signed [31:0] Vj [2:0], Vk [2:0];


    reg Busy [2:0];  // Busy indicates if a station is in use 
    reg Unit_Busy;   
    reg [1:0] adder_calculating;    
    reg [5:0] RS_num_of [2:0];     // These are reservation station identifiers, not the index used when indexing V, Q, Busy, etc.    reg [1:0] Priority_Station;    
    reg [1:0] Second_Station;     
    reg [1:0] Last_Station;
    wire [5:0] RS_availability_of_Second_or_Last, RS_availability_of_Last; 
////////////// End Define Internal signals ////////////


////////////// Initialize signals //////////////////
    initial begin
        CDB_rts = not_ready;
        CDB_data_out = clear;
        CDB_source_out = no_rs;
        CDB_write_out = not_ready;
        Priority_Station = 0;
	Second_Station = 1;
	Last_Station = 2;
        Unit_Busy = not_busy;
        Busy[0] = not_busy;
        Busy[1] = not_busy;
        Busy[2] = not_busy;
        issued = not_issued;
        error = no_error;
        RS_num_of[0] = adder_1;
        RS_num_of[1] = adder_2;
        RS_num_of[2] = adder_3;
        adder_calculating = none;
    end
////////////// End Initialize signals /////////////

////////////// Perform continuous assignments that update any time (no clock trigger) ////////////////


    ///////// Figure out if there is a reservation station available and, if so, what is the highest priority reservation station available? ///////////  
    // available, RS_available and RS_executing are module outputs...they are not used in the module
    // Logic to indicate that at least one RS is available
    
    // Test Plan: Verify the value of available, RS_available, and RS_executing in the wave window
    
    // TODO: Finish the following lines of code
    assign available = finish this line;
    assign RS_availability_of_Last = ~Busy[Last_Station] ? RS_num_of[Last_Station] : no_rs; //if the first station is not busy, assign the RS_num_of to the last station, else, no_rs is assigned to inform that no reservation stations are available
    assign RS_availability_of_Second_or_Last = finish this line;  // if the second station is availability, choose it
    assign RS_available = finish this line   // if the priority station is available, choose it

    // RS executing, to track the unit that is currently in use
    assign RS_executing = Unit_Busy ? RS_num_of[adder_calculating] : no_rs;

 ///////////////// End continuous assignments ////////////////////////
    
//////////////// Block 1 - Assign incoming instructions to a reservation station ////////////////
    // Concept: If a new instruction has been issued, populate operation, Busy,
    // Qj, Qk, Vj, Vk for one of the 3 reservation stations. Choose the first
    // one available. If none are available, indicate that the instruction was
    // not issued b/c all reservation stations were full.

    // Test Plan: Run the provided test and add Qj, Qk, Vj, Vk, operation, and Busy to the wave window
    // Verify that you get the expected results from Qj, Qk, Vj, Vk, operation, Busy, issued, and error
    
    always @(negedge clock) begin
       
	// TODO: Implement this logic
        
	// if an instruction has been issued
 	   // if station 0 (priority station) is not busy
             // set station 0 (array index 0) values, including operation, Busy, Qj, Qk, Vj, Vk
	     // set Q to the 'valid' parameter when valid, otherwise set it to A or B
             // set V to A or B if valid, otherwise do not set V (A->j and B->k)
             // set 'issued' to the RS number for that station (this is different than the index and defined by RS_num_of
             // set 'error' to 'no_error'
           // repeat with 'else if' for station 2 and 3, with priority of 1, 2, 3
           // if no stations are available
	     // set 'issued' to 'not_issued'
             // set 'error' to 'all_rs_busy'

     end
////////////////// End Block 1 //////////////////////////////

///////////////// Block 2 - Update reservation station data when CDB data is received ////////////////////
    // Handle updates on the negative edge of clock
    // Check to see if there has been an update on the CDB. If not, do nothing.
    // If so, look at which reservation station published a new value (CDB_Source)
    // Check to see if the CDB_source matches Qj or Qk for each of the 3 reservation
    // stations. This tells us if the data on the CDB is the data that we were waiting
    // for in the reservation stations
    // If there is a match, update V to CBD_data and set Q to valid (0) to indicate that
    // we are no longer waiting for that data
    always @(negedge clock) begin

        // TODO: Implement the logic described above

    end
/////////////// End Block 2 /////////////////////

/////////////// Block 3 - Execute an instruction if ready /////////////////////
    // Handle execution each cycle
    // If the ALU is busy, you cannot execute the instruction. 
    // If the ALU is not busy, execute, you can check the Priority, 
    // Second, and Last Stations to see if they are ready to execute
    // We know that a station is ready to execute if Qj and Qk are valid (0), indicating
    // that Qj and Qk are no longer waiting and Vj and Vk are populated and ready
    // When you are performing the calculations, set Unit_Busy to 'in_use'
    // Set adder_calculating to the station index you are using (Priority, Second, Last)
    // Then implement the arithmetic/logic operation and set CDB_data_out to the result
    // You should use a case statment when choosing the operation
    // CDB_source_out should be set to the RS number of the station you are using
    // CBD_write_out and CDB_rts should be set to 'ready'
    always @(posedge clock) begin
    
        // TODO: Implement the logic above
        
    end   
////////////////// End Block 3 ///////////////////////

////////////// CDB continuous assignments ////////
    ////////// Update CDB if CDB_xmit (moudule input) is 1 ///////////////
    // Tri-state assignments for CDB connections
    // If CDB_xmit (module input) is 1, then copy the CDB_data_out to CDB_data,
    // CDB_source_out to CDB_source, and CDB_write_out to CDB_write
    // If CDB_xmit is not 1, leave the CDB data/source/write 'disconnected'
    // You should use the ternary operator and continuous assignments to do this
    
    // TODO: Implement the logic above

///////////// End CDB continuous assignments //////////////


////////////////// Block 4 - Cleanup ////////////////////////   
    // Reset signals on each clock cycle
    always @(posedge clock) begin
        issued = not_issued;
        error = no_error;
    end
   
    // Clean up when CDB transmission finishes
    always @(negedge CDB_xmit) begin
        CDB_rts = not_ready;
        CDB_write_out = not_ready;
        Unit_Busy = not_busy;
        Busy[adder_calculating] = not_busy;
        adder_calculating = none;
    end
//////////////// End Block 4 ////////////////////   


endmodule
