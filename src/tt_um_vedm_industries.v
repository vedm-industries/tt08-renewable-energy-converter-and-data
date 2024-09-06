module tt_um_vedm_industries (
    input wire [7:0] ui_in,        // Input signal
    output reg [7:0] uo_out,       // Output signal
    input wire clk,                // Clock signal
    input wire rst_n               // Reset signal (active low)
);

    reg [7:0] converted_voltage;   // Internal signal to hold converted voltage

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            converted_voltage <= 8'd0;   // Reset condition
            uo_out <= 8'd0;             // Reset output
        end else begin
            converted_voltage <= ui_in * 2;   // Multiply input by 2
            uo_out <= converted_voltage;      // Drive output from converted_voltage
        end
    end

endmodule
