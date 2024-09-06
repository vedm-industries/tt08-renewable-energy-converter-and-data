`timescale 1ns / 1ps
`default_nettype none

module tb_top_module;

  reg [7:0] ui_in;
  wire [7:0] uo_out;
  reg clk;
  reg rst_n;

  // Instantiate the top module
  tt_um_vedm_industries dut (
    .ui_in(ui_in),
    .uo_out(uo_out),
    .clk(clk),
    .rst_n(rst_n)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk; // 100MHz clock
  end

  // Reset sequence
  initial begin
    rst_n = 0;
    #10 rst_n = 1; // Deassert reset
  end

  // Apply stimulus
  initial begin
    // Initial test case
    ui_in = 8'd0;  // Input 0, expect output 0
    #20 ui_in = 8'd25;  // Input 25, expect output 50
    #20 ui_in = 8'd45;  // Input 45, expect output 90
    #20 ui_in = 8'd100; // Input 100, expect output 200

    // Terminate simulation after 200ns
    #200;
    $finish;
  end

  // Monitor signals
  initial begin
    $monitor("Time = %t, ui_in = %h, uo_out = %h", $time, ui_in, uo_out);
  end

  // Dump waveform for debugging
  initial begin
    $dumpfile("tb_top_module.vcd");
    $dumpvars(0, tb_top_module);
  end

endmodule
