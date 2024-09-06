`timescale 1ns / 1ps
`default_nettype none

module tb_top_module;

  // Testbench specific signals
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
    forever #5 clk = ~clk; // Generate a 100MHz clock
  end

  // Reset sequence
  initial begin
    #10 rst_n = 0; // Assert reset
    #10 rst_n = 1; // Deassert reset
  end

  // Stimulus generation
  initial begin
    ui_in = 8'd0;

    // Test input patterns
    #20 ui_in = 8'd150; // Set a sample input voltage

    // Wait some time and change inputs
    #100 ui_in = 8'd45;
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
