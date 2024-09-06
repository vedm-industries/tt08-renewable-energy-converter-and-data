module tt_um_vedm_industries (
    input wire clk,
    input wire rst_n,
    input wire [7:0] ui_in,  // Input voltage or data
    output wire [7:0] uo_out // Output data or voltage
);

    wire [7:0] converted_voltage;

    // Instantiate power converter
    power_converter pc (
        .clk(clk),
        .rst_n(rst_n),
        .ui_in(ui_in),
        .uo_out(converted_voltage)
    );

    // Instantiate data collector
    data_collector dc (
        .clk(clk),
        .rst_n(rst_n),
        .ui_in(converted_voltage), // Feed the converted voltage to the data collector
        .uo_out(uo_out)
    );

endmodule
