module mod3counter_tb;
    logic [1:0] num_in;
    logic [1:0] num_out;

    mod3counter uut (
        .num(num_in),
        .mod3num(num_out)
    );

    initial begin
        num_in = 0; #10;
        num_in = 1; #10;
        num_in = 2; #10;
        num_in = 3; #10;  // should wrap to 0
        $finish;
    end
endmodule
