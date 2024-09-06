module data_collector (
    input wire clk,
    input wire rst_n,        // Changed from 'reset' to 'rst_n'
    input wire [7:0] ui_in,  // Changed from 'data_in' to 'ui_in'
    output reg [7:0] uo_out  // Changed from 'data_out' to 'uo_out'
);
    reg [7:0] data_reg;
    always @(posedge clk or posedge rst_n) begin
        if (rst_n) begin
            data_reg <= 8'b0;
        end else begin
            data_reg <= ui_in;
        end
    end
    assign uo_out = data_reg;  // Forwarding collected data to output
endmodule
