module tt_um_vedm_industries (
    input wire [7:0] ui_in,        // Input signal
    output reg [7:0] uo_out,       // Output signal
    input wire clk,                // Clock signal
    input wire rst_n,              // Reset signal (active low)
    input wire ena                 // Enable signal
);

    reg [15:0] full_result;        // 16-bit register for multiplication result
    reg [7:0] converted_voltage;   // Truncated output voltage

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            full_result <= 16'd0;
            converted_voltage <= 8'd0;
            uo_out <= 8'd0;
        end else if (ena) begin
            full_result <= ui_in * 2;           // Simple multiplication by 2
            converted_voltage <= full_result[7:0];  // Take the lower 8 bits
            uo_out <= converted_voltage;
        end
    end

endmodule
