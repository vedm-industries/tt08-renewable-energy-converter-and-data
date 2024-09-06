`timescale 1ns / 1ps
`default_nettype none

module tb ();

  // Testbench specific signals
  reg [7:0] ui_in;
  wire [7:0] uo_out;
  reg clk;
  reg rst_n;
  reg ena;

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
    rst_n = 1;
    #10 rst_n = 0; // Reset active
    #10 rst_n = 1; // Deactivate reset after 10ns
  end

  // Stimulus generation
  initial begin
    ui_in = 8'd0;

    // Test patterns
    #20 ui_in = 8'd25;  // Expected output: 50 (ui_in * 2)

    #100 ui_in = 8'd45; // Expected output: 90

    #50 $finish;  // End simulation
  end

  // Monitor outputs for debugging
  initial begin
    $monitor("Time = %t, ui_in = %h, uo_out = %h, uio_in = %h, uio_out = %h, uio_oe = %b",
             $time, ui_in, uo_out);
  end
  // VCD dump for waveform analysi
  initial begin
    $dumpfile("tb.vcd");
    $dumpvars(0, tb);
    $dumpvars(1, dut.converted_voltage);  // Monitor converted_voltage
  end
    

endmodule
