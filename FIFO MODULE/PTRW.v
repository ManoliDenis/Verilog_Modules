`timescale 1ns / 1ps

// WRITE POINTER MODULE
// by ManoliDenis

//Brief: Buffer for write operations

module WPTR(clk, cl, push_ok, di, addrw, diw, wew);
    parameter n = 4;
    parameter m = 8;
    input clk;
    input cl;                
    input push_ok;            
    input [m-1:0] di;         
    output reg [n-1:0] addrw;
    output [m-1:0] diw;       
    output wew;              
     
    initial addrw = 0;
     
    assign diw = di;
    assign wew = push_ok;
     
    always @(posedge clk) begin
        if (cl)            
		addrw <= 0;
        else if (push_ok) 
            	addrw <= addrw + 1;
    end
endmodule
 
