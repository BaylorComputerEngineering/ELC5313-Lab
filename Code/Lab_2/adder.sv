module adder(
    input  wire clock, 
    input  wire issue,
    input  wire signed [31:0] A, B,
    input  wire A_invalid, B_invalid,
    input  wire [5:0] opcode,
    input  wire CDB_xmit,
    inout  wire signed [31:0] CDB_data,
    inout  wire [5:0] CDB_source,
    inout  wire CDB_write,
    output reg  CDB_rts,
    output wire available,
    output wire [5:0] RS_available,
    output reg  [5:0] issued,
    output wire [5:0] RS_executing,
    output reg  error
);

    // Constants 
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
   
    // Internal registers
    reg signed [31:0] CDB_data_out;
    reg [5:0] CDB_source_out;
    reg CDB_write_out;
    reg [5:0] operation [2:0];
    reg [5:0] Qj [2:0], Qk [2:0];
    reg signed [31:0] Vj [2:0], Vk [2:0];
    reg Busy [2:0];
    reg Unit_Busy;
    reg [1:0] adder_calculating;
    reg [5:0] RS_num_of [2:0];
    reg [1:0] Priority_Station;
    wire [1:0] Second_Station;
    wire [1:0] Last_Station;
    wire [5:0] RS_availability_of_Second_or_Last, RS_availability_of_Last;
    
    // Tri-state assignments for CDB connections
    assign CDB_data = CDB_xmit ? CDB_data_out : disconnected;
    assign CDB_source = CDB_xmit ? CDB_source_out : disconnected;
    assign CDB_write = CDB_xmit ? CDB_write_out : disconnected;
   
    // Logic to indicate that at least one RS is available
    assign available = ~(Busy[0] & Busy[1] & Busy[2]);
    // assign RS_availability_of_Last =
    // finish this line
    // assign RS_availability_of_Second_or_Last =
    // finish this line
    assign RS_available = ~Busy[Priority_Station] ? RS_num_of[Priority_Station] : RS_availability_of_Second_or_Last;

    // RS executing, to track the unit that is currently in use
    // assign RS_executing = // finish this line
   
    // Cycle through the order of the stations to prevent starvation
    mod3counter mod3count1(.num(Priority_Station), .mod3num(Second_Station));

    // calculate the last station
    
    // Initialize signals
    initial begin
        CDB_rts = not_ready;
        CDB_data_out = clear;
        CDB_source_out = no_rs;
        CDB_write_out = not_ready;
        Priority_Station = no_rs;
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
   
    // Reset signals on each clock cycle
    always @(posedge clock) begin
        issued = not_issued;
        error = no_error;
    end
   
    // Clean up when CDB transmission finishes
    always @(negedge CDB_xmit) begin
        CDB_rts = not_ready;
    //    CDB_write_out = finish this line
    //    Unit_Busy = finish this line
    //    Busy[adder_calculating] = finish this line
    //    adder_calculating = finish this line
    end
   
    // Handle execution each cycle
    always @(posedge clock) begin
        begin
		// Each cycle handle execution
	end
   
    // Handle updates on the negative edge of clock
    always @(negedge clock) begin

		//handle updates
           end
   
    // Handle issue logic
    always @(negedge clock) begin
                    
        //handle issue
    end

endmodule
