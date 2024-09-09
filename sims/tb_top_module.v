`timescale 1ns / 1ps
`default_nettype none

module tb_top_module;

// Testbench signals
reg [7:0] ui_in;
reg [7:0] uio_in;  // Adding uio_in to prevent undefined signals
wire [7:0] uo_out;
wire [7:0] uio_out;
wire [7:0] uio_oe;
reg clk;
reg rst_n;
reg ena;  // Always declare and use ena in the testbench

// Instantiate the DUT (Device Under Test)
tt_um_vedm_industries dut (
    .ui_in(ui_in),
    .uo_out(uo_out),
    .clk(clk),
    .rst_n(rst_n),
    .ena(ena),
    .uio_in(uio_in),  // Properly initialize
    .uio_out(uio_out),
    .uio_oe(uio_oe)
);

// Clock generation
initial begin
    clk = 0;
    forever #5 clk = ~clk;  // 100MHz clock
end

// Reset and Enable sequence
initial begin
    rst_n = 0;
    ena = 1;  // Ensure ena is set
    #50 rst_n = 1;  // Release reset after 50ns
end

// Stimulus
initial begin
    ui_in = 8'd0;
    uio_in = 8'd0;  // Ensure uio_in is initialized
    #20 ui_in = 8'd150;  // Example stimulus
    #100 ui_in = 8'd45;
end

// Monitor outputs
initial begin
    $monitor("Time = %t, ui_in = %h, uo_out = %h, uio_out = %h", $time, ui_in, uo_out, uio_out);
end

// VCD dump
initial begin
    $dumpfile("tb_top_module.vcd");
    $dumpvars(0, tb_top_module);
end

// End simulation after a certain time
initial begin
    #200000;  // Run simulation for 200,000 time units
    $finish;
end

endmodule
