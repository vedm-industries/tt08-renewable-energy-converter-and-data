module tt_um_vedm_industries (
    input wire [7:0] ui_in,        // Input signal
    output reg [7:0] uo_out,       // Output signal
    input wire clk,                // Clock signal
    input wire rst_n               // Reset signal (active low)
);

    reg [15:0] full_result;        // 16-bit register to handle multiplication results
    reg [7:0] converted_voltage;   // Store only the lower 8 bits

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            full_result <= 16'd0;
            converted_voltage <= 8'd0;
            uo_out <= 8'd0;
        end else begin
            full_result <= ui_in * 2;           // Perform multiplication and store in 16-bit register
            converted_voltage <= full_result[7:0];  // Take the lower 8 bits of the result
            uo_out <= converted_voltage;        // Output the truncated result
        end
    end

endmodule
