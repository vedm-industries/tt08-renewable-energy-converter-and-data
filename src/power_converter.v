module power_converter (
    input wire clk,
    input wire reset,
    input wire [7:0] vin,  // Input voltage
    output reg [7:0] vout  // Output voltage
);
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            vout <= 0;
        end else begin
            vout <= vin * 2;  // Example: doubling input voltage for demonstration
        end
    end
endmodule
