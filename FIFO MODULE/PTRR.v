`timescale 1ns / 1ps

// READ POINTER MODULE
// by ManoliDenis

//Brief: Buffer for read operations

module RPTR(clk, cl, pop_ok, addrr, dor, dout);
    parameter n = 4;
    parameter m = 8;
    input clk;
    input cl;                
    input pop_ok;             
    output reg [n-1:0] addrr; 
    input [m-1:0] dor;       
    output [m-1:0] dout;     
    
    initial addrr = 0;
    
    assign dout = dor;
    
    always @(posedge clk) begin
        if (cl)
            addrr <= 0;
        else if (pop_ok)
            addrr <= addrr + 1;
    end
endmodule