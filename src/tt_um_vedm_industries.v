module tt_um_vedm_industries (
    input wire [7:0] ui_in,
    output reg [7:0] uo_out,  // Changed from wire to reg so it can hold the value
    input wire clk,
    input wire rst_n,
    input wire ena,  // Always include ena for all tests (RTL, gate-level, and GDS)

    // Unused ports
    input wire [7:0] uio_in,
    output wire [7:0] uio_out,
    output wire [7:0] uio_oe
);

    // Existing functionality
    wire [7:0] converted_voltage;
    data_collector data_collector_inst (
        .clk(clk),
        .rst_n(rst_n),
        .data_in(ui_in),
        .data_out(converted_voltage)
    );

    // Output logic, controlled by 'ena'
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            uo_out <= 8'd0;  // Reset output to 0
        end else if (ena) begin
            uo_out <= converted_voltage;  // Update output only when 'ena' is high
        end
    end

    // Unused ports handling
    assign uio_out = 8'b0;
    assign uio_oe = 8'b0;

endmodule
