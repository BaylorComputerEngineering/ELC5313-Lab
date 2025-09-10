`timescale 1ns / 1ps

module adder_t;

    // Signals
    logic clk;
    logic [3:0] a;
    logic [3:0] b;
    logic [3:0] c;

    // Instantiate the adder
    adder uut (
        .clk(clk),
        .a(a),
        .b(b),
        .c(c)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test stimulus
    initial begin
        a = 0; 
        b = 0;
        
        // Cycle 1
        #10 @(posedge clk);
        a = 4'b0011; 
        b = 4'b0101;  // 5 in 4 bits

        // Cycle 2
        #10 @(posedge clk);
        a = 4'b0110; 
        b = 4'b0010;

        // Cycle 3
        #10 @(posedge clk);
        a = 4'b0111; 
        b = 4'b0001;

        // Finish simulation
        #10 $finish;
    end

    // Monitor values
    initial begin
        $monitor("Time=%0t | a=%0d b=%0d | c=%0d", $time, a, b, c);
    end

endmodule
