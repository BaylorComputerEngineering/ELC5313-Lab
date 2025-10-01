module alu_tb;

    // Constants
    parameter clock_period = 10;
    
    // ALU operation codes
    parameter alu_add = 3'b000;
    parameter alu_sub = 3'b001;
    parameter alu_or  = 3'b100; 
    parameter alu_and = 3'b101;
    parameter alu_not = 3'b110;
    parameter alu_xor = 3'b111;
    
    // Inputs
    reg clk;
    reg issue_command;
    reg [5:0] command;
    reg signed [31:0] A, B;
    reg A_invalid, B_invalid;
    reg CDB_xmit;

    // I/O for outputs
    wire signed [31:0] data_out;
    wire [5:0] data_from_rs_num;
    wire data_valid;

    // Outputs
    wire CDB_rts;
    wire available;
    wire [5:0] issued_to_rs_num, RS_available, RS_executing;
    wire error;

    // Instantiate the adders module
    alu my_alu (
        .clock(clk),
        .issue(issue_command),
        .A(A), 
        .B(B),
        .A_invalid(A_invalid),
        .B_invalid(B_invalid),
        .opcode(command),
        .CDB_xmit(CDB_xmit),
        .CDB_data(data_out),
        .CDB_source(data_from_rs_num),
        .CDB_write(data_valid),
        .CDB_rts(CDB_rts),
        .available(available),
        .RS_available(RS_available),
        .issued(issued_to_rs_num),
        .RS_executing(RS_executing),
        .error(error)
    );

    // Clock generation and stimulus
    initial begin
        clk = 0;
        issue_command = 0;
        command = 0;
        A = 0;
        B = 0;
        A_invalid = 0;
        B_invalid = 0;
        CDB_xmit = 0;
        
        // Initial clock cycles
        #clock_period clk = ~clk;
        #clock_period clk = ~clk;
        
        // First issue command (ALU add)
        issue_command = 1;
        command = alu_add;
        A = 5;
        B = 5;
        A_invalid = 0;
        B_invalid = 0;
        CDB_xmit = 0;

        // Clock cycles
        #clock_period clk = ~clk;
        #clock_period clk = ~clk;
        
        // Second issue command (ALU sub)
        issue_command = 1;
        command = alu_sub;
        A = 3;
        B = 13;
        A_invalid = 1;
        B_invalid = 0;
        CDB_xmit = 0;

        // Clock cycles
        #clock_period clk = ~clk;
        #clock_period clk = ~clk;
        
        // Third issue command (ALU and)
        issue_command = 1;
        command = alu_and;
        A = 15;
        B = 60;
        A_invalid = 0;
        B_invalid = 0;
        CDB_xmit = 0;

        // Clock cycles
        #clock_period clk = ~clk;
        #clock_period clk = ~clk;
        
        // Fourth issue command (ALU add)
        issue_command = 1;
        command = alu_add;
        A = 25;
        B = 35;
        A_invalid = 0;
        B_invalid = 0;
        CDB_xmit = 0;

        // Clock cycles
        #clock_period clk = ~clk;
        #clock_period clk = ~clk;
        
        // No more issues
        issue_command = 0;
        command = 0;
        A = 0;
        B = 0;
        A_invalid = 0;
        B_invalid = 0;
        CDB_xmit = 0;

        // Clock cycles
        #clock_period clk = ~clk;
        #clock_period clk = ~clk;
        #clock_period clk = ~clk;
        #clock_period clk = ~clk;
        #clock_period clk = ~clk;
        
        // Transmit CDB data
        CDB_xmit = 1;
        
        // Clock cycles
        #clock_period clk = ~clk;
        #clock_period clk = ~clk;
        
        // Stop transmitting CDB data
        CDB_xmit = 0;

        // Clock cycles
        #clock_period clk = ~clk;
        #clock_period clk = ~clk;
        
        #clock_period clk = ~clk;
        #clock_period clk = ~clk;
        
        // Transmit CDB data again
        CDB_xmit = 1;
        
        // Clock cycles
        #clock_period clk = ~clk;
        #clock_period clk = ~clk;
        
        // Stop transmitting CDB data
        CDB_xmit = 0;

        // Clock cycles
        #clock_period clk = ~clk;
        #clock_period clk = ~clk;
        
        #clock_period clk = ~clk;
        #clock_period clk = ~clk;
        
        #clock_period clk = ~clk;
        #clock_period clk = ~clk;
        
        // Transmit CDB data once more
        CDB_xmit = 1;
        
        // Clock cycles
        #clock_period clk = ~clk;
        #clock_period clk = ~clk;
        
        // Stop transmitting CDB data
        CDB_xmit = 0;
        
        // Final clock cycles
        #clock_period clk = ~clk;
        #clock_period clk = ~clk;
    end

endmodule
