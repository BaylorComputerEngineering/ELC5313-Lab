module instruction_queue(
input logic clock,
input logic issue_error,
input logic adder_available,
input logic [5:0] adder_RS_available,
input logic [5:0] RS_issued,
input logic [5:0] RS_executing_adder,
input logic adder_rts,
input logic [5:0] RS_finished,
output logic [5:0] operation,
output logic [2:0] execution_unit,
output logic [4:0] Dest_address, 
output logic [4:0] A_address, 
output logic [4:0] B_address,
output logic issue
);

parameter TRUE =1'b1;
parameter FALSE =1'b0;
parameter LAST_INSTRUCTION_ELEMENT = 1023;
parameter INSTRUCTION_ADDRESS_BITS = 10;
parameter LAST_QUEUE_ELEMENT = 7;
parameter QUEUE_ADDRESS_BITS = 3;
parameter CLEAR =0;
parameter OPCODE_HIGH      = 31;
parameter OPCODE_LOW       = 26;
parameter EXEC_UNIT_HIGH      = 31;
parameter EXEC_UNIT_LOW       = 29;
parameter SOURCE1_HIGH     = 25;
parameter SOURCE1_LOW      = 21;
parameter SOURCE2_HIGH     = 20;
parameter SOURCE2_LOW      = 16;
parameter DESTINATION_HIGH = 15;
parameter DESTINATION_LOW  = 11;
parameter BUSY_MASK = 4'b0001;
parameter ISSUE_MASK = 4'b0010;
parameter EXECUTE_MASK = 4'b0100;
parameter WRITE_BACK_MASK = 4'b1000;
parameter ADDER= 3'b000;
parameter alu_add = 3'b000;
parameter alu_sub = 3'b001;
parameter alu_or  = 3'b100;
parameter alu_and = 3'b101;
parameter alu_not = 3'b110;
parameter alu_xor = 3'b111;


integer i,j;

logic issued_this_clock = 0;
logic [31:0] Instruction_Memory [LAST_INSTRUCTION_ELEMENT:0];
logic [INSTRUCTION_ADDRESS_BITS:0] PC=0;
logic next_queue_location;
logic [31:0] Instruction [LAST_QUEUE_ELEMENT:0];
logic [5:0] RS_Holding [LAST_QUEUE_ELEMENT:0];
logic [3:0] Status [LAST_QUEUE_ELEMENT:0];
logic [QUEUE_ADDRESS_BITS-1:0] Queue_End = CLEAR;

initial
begin
    issue<=FALSE;
    for(i=0;i<=LAST_QUEUE_ELEMENT;i=i+1)
    begin
        Instruction[i] <= CLEAR;
        RS_Holding[i] <= CLEAR;
        Status[i] <= CLEAR;
    end
    for(i=0;i<=32;i=i+1)
    begin
        Instruction_Memory[i] <= {ADDER , alu_add , 5'b00001 ,  5'b00011, 5'b00111, 11'b0};
    end
end


//Fetch Block
// This block fetches an instruction each clock cycle until the queue or memory fills up

always@(posedge(clock))
begin
    // TODO fetch instruction
   end
end

//Issue Block
// This block looks for an instruction that can be issued to the adder reservation station

always@(posedge(clock))
begin
    // TODO handle issue start

end

// Issue Completion
// This block marks an instruction as officially issued once the reservation station acknowledges it

always@(RS_issued)
begin
    #1;
	// TODO handle issue done
    issue<=FALSE;
    issued_this_clock<=FALSE;
end


// Execute Start
// When the reservation station signals its executing, mark the instruction as executing (EXECUTE_MASK)

always@(posedge(RS_executing_adder))
begin
    // TODO handle execute
end

//Write Back
// Marks instruction as finished with write-back

always@(posedge(adder_rts))
begin
    // TODO handle write back
end

// Instruction Removal
// Once a reservation station signals an instruction is finished, remove it from the queue and shift all remaining instructions forward

always@(RS_finished)
begin
    // TODO handle instruction done        
    end
end

endmodule