`timescale 1ns / 1ps

module dcache_controller(
    input clk,
    input rst,
    
    // cpu <-> cache
    input [63:0] data_addr, // address from cpu requesting read/write
    input write, // cpu write request when 1
    input [63:0] data_wdata, // data that cpu wants to write to the cache
    input read, // cpu read request when 1
    output [63:0] data_rdata, // requested data returned to cpu from cache
    
    // cache <-> main memory
    output [63:0] mem_addr, // address sent to main memory from cache
    output [63:0] mem_wdata, // data that cache wants to write to main memory
    input  [63:0] mem_rdata, // constantly reading data from main memory
    output mem_write // cache write request to main memory when 1
);

	reg [63:0] data_cache [255:0]; // 2KB
	// you can use separate register arrays here for tag and valid bits

	always @(posedge clk) begin
		if(rst) begin
		
		end
		else begin
		
		end
	end

endmodule
