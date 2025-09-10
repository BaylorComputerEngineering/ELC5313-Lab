`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Josie D'Acquisto
// Create Date: 09/07/2025 02:25:45 PM
// Design Name: ELC5313 SV Ex
// Module Name: adder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module adder (
    input  logic        clk,
    input  logic [3:0]  a,
    input  logic [3:0]  b,
    output logic [3:0]  c
);

    always_ff @(posedge clk) begin
        c <= a + b;   // use nonblocking assignment in sequential logic
    end

endmodule
