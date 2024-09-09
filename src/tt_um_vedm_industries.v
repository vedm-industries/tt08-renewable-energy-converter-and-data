module tt_um_vedm_industries (
    input wire clk,
    input wire rst_n,
    input wire ena,              // 'ena' included here
    input wire [7:0] ui_in,
    output reg [7:0] uo_out,     // Change 'wire' to 'reg'
    input wire [7:0] uio_in,
    output wire [7:0] uio_out,
    output wire [7:0] uio_oe
);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            uo_out <= 8'b0;  // Reset logic
        else if (ena)        // Update uo_out only when ena is 1
            uo_out <= ui_in;
        // No need for an else here; when ena is 0, uo_out holds its value
    end

    assign uio_out = 8'b0;
    assign uio_oe = 8'b0;

endmodule
