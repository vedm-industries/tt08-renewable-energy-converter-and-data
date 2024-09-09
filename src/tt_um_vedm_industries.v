module tt_um_vedm_industries (
    input wire [7:0] ui_in,
    output wire [7:0] uo_out,
    input wire clk,
    input wire rst_n,
    input wire ena,  // Include ena for all tests

    // Unused ports
    input wire [7:0] uio_in,
    output wire [7:0] uio_out,
    output wire [7:0] uio_oe
);

    // Existing functionality
    wire [7:0] converted_voltage;
    
    // Only process data when enabled
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            converted_voltage <= 8'd0;
        else if (ena)
            converted_voltage <= ui_in;  // Update with input
    end

    assign uo_out = converted_voltage;

    // Unused ports handling
    assign uio_out = 8'b0;
    assign uio_oe = 8'b0;

endmodule
