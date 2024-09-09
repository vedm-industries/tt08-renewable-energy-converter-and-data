module tt_um_vedm_industries (
    input wire clk,
    input wire rst_n,
    input wire ena,              // Ensure the 'ena' signal is included
    input wire [7:0] ui_in,
    output wire [7:0] uo_out,
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

     // Logic for processing when enable (ena) is high
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            uo_out <= 8'b0;  // Reset condition
        else if (ena)        // Enable-controlled logic
            uo_out <= ui_in;
    end

    assign uo_out = converted_voltage;

    // Unused ports handling
    assign uio_out = 8'b0;
    assign uio_oe = 8'b0;

    // Use ena in the design if needed, otherwise leave it for future use.
    // For now, ena can remain unused but declared to pass synthesis.
endmodule


   
