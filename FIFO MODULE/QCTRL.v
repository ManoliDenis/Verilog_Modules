`timescale 1ns / 1ps

//FIFO CONTROLLER MODULE
// by ManoliDenis

module FIFO(clk, cl, push, pop, di, dout, full, empty, er, cnt);
    parameter n = 4;          // 2^n 
    parameter m = 8;          // data width
    input clk;
    input cl;                 
    input push;
    input pop;
    input [m-1:0] di;
    output [m-1:0] dout;
    output full;
    output empty;
    output reg [n:0] cnt;    // n+1 bits: from 0 to 2^n
    output reg er;            // Error
    
    wire [n-1:0] addrw, addrr;
    wire [m-1:0] diw, dor;
    wire wew;
    wire push_ok, pop_ok;
    
    
    
    assign full  = cnt[n]; 
    assign empty = (cnt == 0);
    
    assign push_ok = push & ~full  & ~cl; // (!clear && !full) => push
    assign pop_ok  = pop  & ~empty & ~cl; // (!clear && !empty) => pop
    
    always @(posedge clk) begin
        if (cl) begin //Clear
            cnt <= 0;
            er  <= 0;
        end
        else begin
            er <= (push & full) | (pop & empty); // Illegal operation
            case ({push_ok, pop_ok})
                2'b10:   cnt <= cnt + 1;
                2'b01:   cnt <= cnt - 1;
                default: cnt <= cnt;      //Nothing or both
            endcase
        end
    end
    
    
    //External modules used:
        DPSRAM MEM(clk, wew, addrw, diw, addrr, dor); // Private memory
        WPTR WP(clk, cl, push_ok, di, addrw, diw, wew); // Write pointer
        RPTR RP(clk, cl, pop_ok, addrr, dor, dout); // Read pointer

endmodule