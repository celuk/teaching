`timescale 1ns / 1ps

module tb_dcache_controller(
);

reg [63:0] main_memory [0:4095]; // 32KB

reg clk;
reg rst;
reg [63:0] data_addr;
reg write;
reg [63:0] data_wdata;
reg read;
wire [63:0] data_rdata;
wire [63:0] mem_addr;
wire [63:0] mem_wdata;
wire [63:0] mem_rdata;
wire mem_write;

integer errors;
integer total_tests;

dcache_controller uut(
    .clk(clk),
    .rst(rst),
    .data_addr(data_addr),
    .write(write),
    .data_wdata(data_wdata),
    .read(read),
    .data_rdata(data_rdata),
    .mem_addr(mem_addr),
    .mem_wdata(mem_wdata),
    .mem_rdata(mem_rdata),
    .mem_write(mem_write)
);

assign mem_rdata = main_memory[mem_addr[63:3]];

always @(posedge clk) begin
    if (mem_write) begin
        main_memory[mem_addr[63:3]] <= mem_wdata;
    end
end

always begin
    clk = !clk;
    #0.5;
end

integer i;

initial begin
    clk = 0;
    //$dumpfile("dump.vcd");
    //$dumpvars(0,tb_dcache_controller);

    errors = 0;
    total_tests = 0;

    for(i=0;i<4096;i=i+1) begin
        main_memory[i] = 64'h0;
    end
    
    rst = 1;
    write = 0;
    read = 0;
    data_addr = 0;
    data_wdata = 0;
    #1;
    rst = 0;
    #1;
    
    // basic read write
    for(i=0;i<256;i=i+1) begin
       data_addr = i * 8;
       write = 1;
       data_wdata = 64'hA000_0000_0000_0000 + i;
       read = 0;
       #1;
    end
    write = 0;
    #1;
    
    // read back and verify
    for(i=0;i<256;i=i+1) begin
       data_addr = i * 8;
       write = 0;
       read = 1;
       #1;
       total_tests = total_tests + 1;
       if(data_rdata !== (64'hA000_0000_0000_0000 + i)) begin
           errors = errors + 1;
       end
    end
    read = 0;
    #1;
    
    //test writethrough
    for(i=0;i<256;i=i+1) begin
       total_tests = total_tests + 1;
       if(main_memory[i] !== (64'hA000_0000_0000_0000 + i)) begin
           errors = errors + 1;
       end
    end
    
    // test fifo
    rst = 1;
    #1;
    rst = 0;
    #1;

    for(i=0; i<300; i=i+1) begin
        main_memory[i] = i;
    end
    
    write = 0;
    read = 1;
    
    for(i=0; i<256; i=i+1) begin
        data_addr = i * 8;
        #1;
    end
    
    data_addr = 0;
    #1;
    
    data_addr = 256 * 8;
    #1;
    
    read = 0;
    main_memory[0] = 64'hDEAD_BEEF_DEAD_BEEF;
    main_memory[1] = 64'hCAFE_BABE_CAFE_BABE;
    #1;
    
    read = 1;
    data_addr = 8;
    #1;
    total_tests = total_tests + 1;
    if(data_rdata !== 1) begin
        errors = errors + 1;
    end

    data_addr = 0;
    #1;
    total_tests = total_tests + 1;
    if(data_rdata !== 64'hDEAD_BEEF_DEAD_BEEF) begin
        errors = errors + 1;
    end
    
    read = 0;
    #1;

    write = 0; read = 0;
    for(i=0;i<256;i=i+1) begin
       main_memory[i] = 64'hA000_0000_0000_0000 + i;
    end

    rst = 1; 
    #1; 
    rst = 0; 
    #1;
    
    // cache misses
    for(i=0;i<256;i=i+1) begin
       data_addr = i * 8;
       write = 0;
       read = 1;
       #1;
       total_tests = total_tests + 1;
       if(data_rdata !== (64'hA000_0000_0000_0000 + i)) begin
           errors = errors + 1;
       end
    end
    read = 0;
    #1;
    
    // cache hit on write
    data_addr = 0;
    write = 1;
    data_wdata = 64'hDEAD_BEEF_CAFE_BABE;
    read = 0;
    #1;
    write = 0;
    #1;
    
    data_addr = 0;
    read = 1;
    #1;
    total_tests = total_tests + 1;
    if(data_rdata !== 64'hDEAD_BEEF_CAFE_BABE) begin
        errors = errors + 1;
    end
    
    // writethrough
    total_tests = total_tests + 1;
    if(main_memory[0] !== 64'hDEAD_BEEF_CAFE_BABE) begin
        errors = errors + 1;
    end
    read = 0;
    #1;
    
    // read miss
    main_memory[1000] = 64'hFEED_FACE_DEAD_C0DE;
    
    data_addr = 64'h0000_1F40;
    read = 1;
    #1;
    total_tests = total_tests + 1;
    if(data_rdata !== 64'hFEED_FACE_DEAD_C0DE) begin
        errors = errors + 1;
    end
    read = 0;
    #1;
    
    data_addr = 64'h0000_1F40;
    read = 1;
    #1;
    total_tests = total_tests + 1;
    if(data_rdata !== 64'hFEED_FACE_DEAD_C0DE) begin
        errors = errors + 1;
    end
    read = 0;
    #1;
    
    data_addr = 64'h0000_2000;
    write = 1;
    data_wdata = 64'hAAAA_BBBB_CCCC_DDDD;
    read = 0;
    #1;
    
    write = 0;
    read = 1;
    #1;
    
    total_tests = total_tests + 1;
    if(data_rdata !== 64'hAAAA_BBBB_CCCC_DDDD) begin
        errors = errors + 1;
    end
    read = 0;
    #1;
    
    // large addresses
    data_addr = 64'h0000_0000_0000_0100;
    write = 1;
    data_wdata = 64'h8888_7777_6666_5555;
    read = 0;
    #1;
    write = 0;
    
    data_addr = 64'h0000_0000_0000_0100;
    read = 1;
    #1;
    total_tests = total_tests + 1;
    if(data_rdata !== 64'h8888_7777_6666_5555) begin
        errors = errors + 1;
    end
    read = 0;
    #1;

    $display("%d passes, %d fails\n", total_tests-errors, errors);

    if(errors == 0) begin
        $display("ALL PASSED!\n");
    end
    if(total_tests == errors) begin
        $display("all failed!\n");
    end

    $finish;
end

endmodule
