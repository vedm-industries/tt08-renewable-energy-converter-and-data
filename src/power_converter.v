module power_converter (
    input wire clk,
    input wire rst_n,
    input wire [7:0] ui_in,  // Input voltage
    output reg [7:0] uo_out  // Output voltage
);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            uo_out <= 8'd0;   // Reset output to 0 when rst_n is asserted
        end else begin
            uo_out <= ui_in * 2;  // Double the input voltage
        end
    end

endmodule
