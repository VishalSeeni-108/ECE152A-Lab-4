/*
* Copyright (c) 2023, University of California; Santa Barbara
* Distribution prohibited. All rights reserved.
*
* File: ucsbece152a_fsm.sv
* Description: Starter code for fsm.
*/
typedef enum logic [2:0] {
S000_000,
S000_100,
S000_110,
S000_111,
S001_000,
S011_000,
S111_000,
S111_111
} state_t;
module ucsbece152a_fsm (
input logic clk,
input logic rst_n,
input logic left_i,
input logic right_i,
input logic hazard_i,
output state_t state_o,
output logic [5:0] pattern_o
);
state_t state_d, state_q = S000_000;
assign state_o = state_q;
always_comb begin
pattern_o = 6'b000000;
if(hazard_i || (left_i && right_i)) begin //Hazard lights
case(state_q)
S000_000: state_d = S111_111; 
S000_100: state_d = S111_111;
S000_110: state_d = S111_111;
S000_111: state_d = S111_111;
S001_000: state_d = S111_111;
S011_000: state_d = S111_111;
S111_000: state_d = S111_111;
S111_111: state_d = S000_000; 
endcase
end else if(left_i) begin //Left turn
case(state_q)
S000_000: state_d = S001_000; 
S000_100: state_d = S000_000; 
S000_110: state_d = S000_000; 
S000_111: state_d = S000_000; 
S001_000: state_d = S011_000; 
S011_000: state_d = S111_000; 
S111_000: state_d = S000_000; 
S111_111: state_d = S000_000; 
endcase
end else if(right_i) begin
case(state_q)
S000_000: state_d = S000_100; 
S000_100: state_d = S000_110; 
S000_110: state_d = S000_111; 
S000_111: state_d = S000_000; 
S001_000: state_d = S000_000; 
S011_000: state_d = S000_000; 
S111_000: state_d = S000_000; 
S111_111: state_d = S000_000; 
endcase
end else begin
state_d = S000_000; 
end
if(state_q == S000_000)begin
pattern_o = 6'b000000; 
end else if (state_q == S000_100)begin
pattern_o = 6'b000100; 
end else if (state_q == S000_110)begin
pattern_o = 6'b000110; 
end else if (state_q == S000_111)begin
pattern_o = 6'b000111; 
end else if (state_q == S001_000)begin
pattern_o = 6'b001000; 
end else if (state_q == S011_000)begin
pattern_o = 6'b011000; 
end else if (state_q == S111_000)begin
pattern_o = 6'b111000; 
end else if (state_q == S111_111)begin
pattern_o = 6'b111111; 
end
end
always_ff @ (posedge clk or negedge rst_n) begin
if (!rst_n) begin
state_q <= S000_000;
end else begin
state_q <= state_d;
end
end
endmodule