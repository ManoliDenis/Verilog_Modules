`timescale 1ns / 1ps

// DUALPORT SRAM MODULE
// by ManoliDenis

module DPSRAM(clk, wew, addrw, diw, addrr, dor);

parameter n = 4;
parameter m = 8;

input clk,wew;
input [n-1:0]addrw,addrr;
input [m-1:0] diw;

output reg[m-1:0]dor;

reg [m-1:0]mem[0:(1<<n)-1];

always @(posedge clk)begin
    if(wew)
        mem[addrw]<=diw;
     dor <= mem[addrr];
end
endmodule
