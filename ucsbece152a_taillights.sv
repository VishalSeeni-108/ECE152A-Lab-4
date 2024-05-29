/*
* Copyright (c) 2023, University of California; Santa Barbara
* Distribution prohibited. All rights reserved.
*
* File: ucsbece152a_taillights.sv
* Description: Starter code for taillights.
*/
module ucsbece152a_taillights (
input logic clk,
input logic rst_n,
input logic clk_dimmer_i,
input logic left_i,
input logic right_i,
input logic hazard_i,
input logic brake_i,
input logic runlights_i,
output logic [5:0] lights_o
);
logic [5:0] fsm_pattern;
ucsbece152a_fsm fsm (
.clk(clk),
.rst_n(rst_n),
.left_i(left_i),
.right_i(right_i),
.hazard_i(hazard_i),
.state_o(/* unused */ ),
.pattern_o(fsm_pattern)
);
logic [5:0] lights_runlightsoff, lights_runlightson;
always_comb begin
lights_runlightsoff = fsm_pattern; 
if(brake_i)begin
case(fsm_pattern) 
6'b000000: lights_runlightsoff = 6'b111111;
6'b000100: lights_runlightsoff = 6'b111100; 
6'b000110: lights_runlightsoff = 6'b111110;
6'b000111: lights_runlightsoff = 6'b111111; 
6'b001000: lights_runlightsoff = 6'b001111; 
6'b011000: lights_runlightsoff = 6'b011111; 
6'b111000: lights_runlightsoff = 6'b111111; 
6'b111111: lights_runlightsoff = 6'b111111; 
endcase
end
if(runlights_i && clk_dimmer_i)begin
lights_runlightsoff = 6'b111111;
end
end
always_ff @ (posedge clk, posedge clk_dimmer_i) begin
lights_o = lights_runlightsoff; 
end
endmodule