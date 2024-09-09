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

// Reset and Enable sequence
initial begin
    rst_n = 0;
    ena = 1;  // Ensure ena is set
    #50 rst_n = 1;  // Release reset after 50ns
end
`ifdef GL_TEST
      .VPWR(1'b1),
      .VGND(1'b0),
`endif

      .ui_in  (ui_in),    // Dedicated inputs
      .uo_out (uo_out),   // Dedicated outputs
      .uio_in (uio_in),   // IOs: Input path
      .uio_out(uio_out),  // IOs: Output path
      .uio_oe (uio_oe),   // IOs: Enable path (active high: 0=input, 1=output)
      .ena    (ena),      // enable - goes high when design is selected
      .clk    (clk),      // clock
      .rst_n  (rst_n)     // not reset
  );

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
