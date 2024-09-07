module tt_um_vedm_industries (
    input wire [7:0] ui_in,
    output wire [7:0] uo_out,
    input wire clk,
    input wire rst_n,
    input wire ena,  // Add the enable signal (unused)
    
    // Add unused ports
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

    assign uo_out = converted_voltage;

    // Unused ports handling (set to default)
    assign uio_out = 8'b0;
    assign uio_oe = 8'b0;

    // If ena is not used in your design, simply ignore it.
    // You can add logic here if needed, but otherwise, it can be ignored.
endmodule
