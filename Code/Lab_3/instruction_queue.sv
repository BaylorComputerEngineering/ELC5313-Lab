module instruction_queue(
//Main clock signal
input logic clock,
//Flag from issue stage if issuing failed
input logic issue_error,
//Indicates if adder RS is available
input logic adder_available,
// RS ID available for new issue
input logic [5:0] adder_RS_available,
//RS ID that successfully received an instruction
input logic [5:0] RS_issued,
//RS ID that started executing
input logic [5:0] RS_executing_adder,
// "Ready to Send" flag from another adder (end of execution)
input logic adder_rts,
// Reservation station ID that finished execution
input logic [5:0] RS_finished,
// Opcode or ALU operation bits for the issued instruction
output logic [5:0] operation,
// Execution unit type (e.g., ADDER, MULT, etc.)
output logic [2:0] execution_unit,
// Destination register address
output logic [4:0] Dest_address, 
// Source register A address
output logic [4:0] A_address, 
// Source register B address
output logic [4:0] B_address,
// High when an instruction is being issued this cycle
output logic issue
);

   // ----------------------
// General control flags
    // ----------------------
parameter TRUE =1'b1;
parameter FALSE =1'b0;

    // ----------------------
 // Memory & Queue size
    // ----------------------

// Last instruction index in instruction memory (memory has 1024 total)
parameter LAST_INSTRUCTION_ELEMENT = 1023;
// Bits needed for PC (2^10 = 1024)
parameter INSTRUCTION_ADDRESS_BITS = 10;
// Last queue index (queue has 8 total slots)
parameter LAST_QUEUE_ELEMENT = 7;
// Bits needed for queue address (2^3 = 8)
parameter QUEUE_ADDRESS_BITS = 3;
// Used for initializing/clearing variables
parameter CLEAR =0;

    // ----------------------
 // Bit ranges within instruction word
    // ----------------------

// Opcode bits (6 bits)
parameter OPCODE_HIGH      = 31;
parameter OPCODE_LOW       = 26;

// Execution unit bits (top 3 bits)
parameter EXEC_UNIT_HIGH      = 31;
parameter EXEC_UNIT_LOW       = 29;

// Source register 1 address
parameter SOURCE1_HIGH     = 25;
parameter SOURCE1_LOW      = 21;

// Source register 2 address
parameter SOURCE2_HIGH     = 20;
parameter SOURCE2_LOW      = 16;

// Destination register address
parameter DESTINATION_HIGH = 15;
parameter DESTINATION_LOW  = 11;

    // ----------------------
    // Status bitmasks
    // ----------------------

// Instruction has been fetched, waiting to be issued
parameter BUSY_MASK = 4'b0001;
// Instruction has been issued to a reservation station
parameter ISSUE_MASK = 4'b0010;
// Instruction is currently executing
parameter EXECUTE_MASK = 4'b0100;
// Instruction has completed execution and is writing back
parameter WRITE_BACK_MASK = 4'b1000;


    // ----------------------
    // Execution unit identifiers
    // ----------------------

// Execution unit = Adder
parameter ADDER= 3'b000;
// ALU add operation
parameter alu_add = 3'b000;
// ALU subtract
parameter alu_sub = 3'b001;
// ALU OR
parameter alu_or  = 3'b100;
// ALU AND
parameter alu_and = 3'b101;
// ALU NOT
parameter alu_not = 3'b110;
// ALU XOR
parameter alu_xor = 3'b111;


    // ----------------------
    // Internal variables
    // ----------------------

// Loop counters for queue scanning/shifting
integer i,j;

// Prevents multiple issues in one cycle
logic issued_this_clock = 0;
// ROM-style array holding all instructions
logic [31:0] Instruction_Memory [LAST_INSTRUCTION_ELEMENT:0];
// Program Counter — points to next instruction to fetch
logic [INSTRUCTION_ADDRESS_BITS:0] PC=0;
// Unused, placeholder
logic next_queue_location;
// Queue entries holding fetched instructions
logic [31:0] Instruction [LAST_QUEUE_ELEMENT:0];
// Reservation Station ID assigned to each queue entry
logic [5:0] RS_Holding [LAST_QUEUE_ELEMENT:0];
// Status bits (BUSY, ISSUED, EXECUTING, WRITEBACK)
logic [3:0] Status [LAST_QUEUE_ELEMENT:0];
// Points to next free queue slot (tail pointer)
logic [QUEUE_ADDRESS_BITS-1:0] Queue_End = CLEAR;


    // ----------------------
    // Initialization
    // ----------------------
initial
begin
    issue<=FALSE;
 // Initialize queue entries
    for(i=0;i<=LAST_QUEUE_ELEMENT;i=i+1)
    begin
        Instruction[i] <= CLEAR;
        RS_Holding[i] <= CLEAR;
        Status[i] <= CLEAR;
    end
// Load a simple sequence of ADD instructions into memory for testing
    for(i=0;i<=32;i=i+1)
    begin
        Instruction_Memory[i] <= {ADDER , alu_add , 5'b00001 ,  5'b00011, 5'b00111, 11'b0};
    end
end



    // =============================================================
    // FETCH BLOCK
    // =============================================================
    // Each clock cycle, if the queue and memory have space,
    // fetch the next instruction from Instruction_Memory into Instruction queue.
    // Set status to BUSY, increment PC, and move the queue tail pointer.


always@(posedge(clock))
begin
    // TODO fetch instruction
   end
end

    // =============================================================
    // ISSUE BLOCK
    // =============================================================
    // Searches queue for a ready instruction to issue to the adder unit.
    // Sends its operands and destination info to outputs if available.

always@(posedge(clock))
begin
	if(adder_available) begin
		for (i = 0; i <= LAST_QUEUE_ELEMENT; i = i + 1) begin
			if (~issued_this_clock &
				// not yet issued
				~(|(Status[i] & ISSUE_MASK)) &
				// instruction is busy
				 (|(Status[i] & BUSY_MASK)) &  
				// belongs to adder unit
				Instruction[i][EXEC_UNIT_HIGH:EXEC_UNIT_LOW] == ADDER) begin

    			// TODO handle issue start
			// Set operation, execution_unit, A_address, B_address, Dest_address
			// Track which RS is holding
			// Signal issue

end

    // =============================================================
    // ISSUE COMPLETION BLOCK
    // =============================================================
    // When reservation station confirms an issue (RS_issued),
    // mark that instruction as officially issued.

// Example block completed for reference — use this pattern for the next ones.

always@(RS_issued)
begin
        #1; // small delay to simulate confirmation
        for (i = 0; i <= LAST_QUEUE_ELEMENT; i = i + 1) begin
            if (RS_Holding[i] == RS_issued & RS_issued > 0) begin
                if (~issue_error)
                    Status[i] = Status[i] | ISSUE_MASK; // Mark as issued
            end
        end
        issue <= FALSE;
        issued_this_clock <= FALSE;
end


    // =============================================================
    // EXECUTE START BLOCK
    // =============================================================
    // Marks instruction as executing when RS signals execution start.


always@(posedge(RS_executing_adder))
begin
    // TODO handle execute
	// You do not need a delay
	// HINT: Look at ISSUE COMPLETION BLOCK for the pattern — find the matching RS and set the EXECUTE_MASK.

end

    // =============================================================
    // WRITE-BACK BLOCK
    // =============================================================
    // When adder signals completion (adder_rts),
    // mark instruction as finished and ready for write-back.

always@(posedge(adder_rts))
begin
    // TODO handle write back
	// HINT: Look at ISSUE COMPLETION BLOCK for the pattern — find the matching RS and set the WRITE_MASK.

	// You do not need a delay
end


    // =============================================================
    // INSTRUCTION REMOVAL BLOCK
    // =============================================================
    // When a Reservation Station (RS) signals that its instruction has finished,
    // we need to remove that instruction from the queue so new ones can enter.
    // NOTE: You’ll need two loops:
    //  - Outer loop (i): to find the finished instruction.
    //  - Inner loop (j): to shift everything down after that index.
    // This keeps the queue compact and in order after removal.

always@(RS_finished)
begin
	for(i = 0; i <= LAST_QUEUE_ELEMENT; i = i + 1) begin
    // TODO handle instruction done    
	// Step 1: Check if RS_Holding[i] matches the finished RS 
        //    and if     RS_finished > 0, which prevents reacting to uninitialized signals
            // Step 2: If not the last queue element, shift remaining entries up
            // For example: if element 2 finishes, move 3→2, 4→3, etc.

	// What do you need to shift?

	// Clear the now-empty last slot

	// Move the queue tail pointer back one position
    end
end

endmodule
