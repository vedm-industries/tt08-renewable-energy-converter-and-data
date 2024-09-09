`timescale 1ns / 1ps
`default_nettype none

module tb_top_module;

// Testbench signals
reg [7:0] ui_in;
wire [7:0] uo_out;
reg clk;
reg rst_n;
reg ena;  // Always declare and use ena in the testbench

// Instantiate the DUT (Device Under Test)
tt_um_vedm_industries dut (
    .ui_in(ui_in),
    .uo_out(uo_out),
    .clk(clk),
    .rst_n(rst_n),
    .ena(ena),  // Always connect ena

    .uio_in(8'b0),  // Unused input, set to 0
    .uio_out(),     // Unused output, left unconnected
    .uio_oe()       // Unused output, left unconnected
);

// Clock generation
initial begin
    clk = 0;
    forever #5 clk = ~clk;  // 100MHz clock
end
    
initial begin
    vdd = 1;  // Drive the power pin
    gnd = 0;  // Drive the ground pin
end

// Reset and Enable sequence
initial begin
    rst_n = 0;
    ena = 1;  // Enable signal set to 1
    #50 rst_n = 1;  // Release reset after 50ns
end

// Stimulus
initial begin
    ui_in = 8'd0;
    #20 ui_in = 8'd150;  // Example stimulus
    #100 ui_in = 8'd45;
end

// Monitor outputs
initial begin
    $monitor("Time = %t, ui_in = %h, uo_out = %h", $time, ui_in, uo_out);
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
