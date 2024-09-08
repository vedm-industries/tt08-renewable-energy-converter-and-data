module tt_um_vedm_industries (
    input wire [7:0] ui_in,
    output wire [7:0] uo_out,
    input wire clk,
    input wire rst_n,

`ifdef GL_TEST
    input wire ena,  // Only include ena for gate-level test
`endif

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

    assign uo_out = converted_voltage;

    // Unused ports handling
    assign uio_out = 8'b0;
    assign uio_oe = 8'b0;

`ifdef GL_TEST
    // If ena is used, include logic here (currently unused)
    assign ena = 1'b1;  // If needed, modify this to control logic based on `ena`
`endif

endmodule
