`timescale 1ns / 1ps

// GENERIC SRAM MODULE
// by ManoliDenis

module SRAM(clk, we, addr, di, do);
parameter n = 4;
parameter m = 8;
input clk;
input we;
input [n-1:0]addr;
input [m-1:0]di; 

output reg [m-1:0]do;

reg [m-1:0]mem[0:(1<<n)-1];

always @(posedge clk) begin
    if(we)
        mem[addr]<=di;  
    do <= mem[addr];       
end

endmodule
