module tb_top_module;

  reg clk;
  reg reset;
  reg [7:0] vin;
  wire [7:0] vout;
  wire [7:0] data_out;

  // Instantiate the top module
  tt_um_vedm_industries dut (
      .clk(clk),
      .reset(reset),
      .vin(vin),
      .vout(vout),
      .data_out(data_out)
  );

  // Clock generation
  initial begin
      clk = 0;
      forever #5 clk = ~clk;  // 10ns period => 100MHz clock
  end

  // Test stimulus
  initial begin
      // Initialize signals
      reset = 1;
      vin = 8'd10;
      #10 reset = 0;

      // Test cases
      #20 vin = 8'd20;
      #20 vin = 8'd50;
      #20 vin = 8'd100;

      #100 $finish;
  end

endmodule
