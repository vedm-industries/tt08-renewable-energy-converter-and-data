module tt_um_vedm_industries (
    input wire clk,
    input wire reset,
    input wire [7:0] vin,      // Voltage input
    output wire [7:0] vout,    // Voltage output
    output wire [7:0] data_out // Collected data output
);

    wire [7:0] converted_voltage;

    // Instantiate the power converter
    power_converter u1 (
        .clk(clk),
        .reset(reset),
        .vin(vin),
        .vout(converted_voltage)
    );

    // Instantiate the data collector
    data_collector u2 (
        .clk(clk),
        .reset(reset),
        .data_in(converted_voltage),
        .data_out(data_out)
    );

    assign vout = converted_voltage;

endmodule
