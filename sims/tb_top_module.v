`timescale 1ns / 1ps
`default_nettype none

module tb_top_module;

  // Testbench specific signals
  reg [7:0] ui_in;
  wire [7:0] uo_out;
  reg clk;
  reg rst_n;
//  reg ena;

  // Instantiate the top module
  tt_um_vedm_industries dut (
    .ui_in(ui_in),
    .uo_out(uo_out),
    .clk(clk),
    .rst_n(rst_n)
    .ena(1'b0)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk; // Generate a 100MHz clock
  end

  // Reset and Enable sequence
  initial begin
    rst_n = 0;
//    ena = 0;
    #10 rst_n = 1; // Deassert reset
//    #10 ena = 1; // Enable after reset
  end

  // Stimulus generation
  initial begin
    ui_in = 8'd0;
    #20 ui_in = 8'd25; // Test input 25 -> Expect output 50
    #50 ui_in = 8'd45; // Test input 45 -> Expect output 90
  end

  // Monitoring outputs
  initial begin
    $monitor("Time = %t, ui_in = %h, uo_out = %h",
             $time, ui_in, uo_out);
  end

  // VCD wave generation
  initial begin
    $dumpfile("tb_top_module.vcd");
    $dumpvars(0, tb_top_module);
  end

  // Terminate simulation after a certain time
  initial begin
    #200000; // Adjust time units as necessary
    $finish;
  end

endmodule
