module data_collector (
    input wire clk,
    input wire rst_n,         // Make sure this port exists in your module
    input wire [7:0] data_in,  // Collected data (voltage output)
    output wire [7:0] data_out // Data output for monitoring
);
    reg [7:0] data_reg;

    always @(posedge clk or posedge rst_n) begin
        if (rst_n) begin
            data_reg <= 8'b0;
        end else begin
            data_reg <= data_in;
        end
    end

    assign data_out = data_reg;  // Use wire for data_out

endmodule
