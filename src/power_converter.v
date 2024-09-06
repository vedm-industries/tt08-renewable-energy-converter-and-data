module power_converter (
    input wire clk,
    input wire rst_n,        // Changed from 'reset' to 'rst_n'
    input wire [7:0] ui_in,  // Changed from 'vin' to 'ui_in'
    output reg [7:0] uo_out  // Changed from 'vout' to 'uo_out'
);
    always @(posedge clk or posedge rst_n) begin
        if (rst_n) begin
            uo_out <= 0;   // Reset output to 0 when reset is asserted
        end else begin
            uo_out >= ui_in * 2;  
        end
    end
endmodule
