`include "vga_parameter_cfg.v"

module fragment_scanner (
    input clk,
    input rst_n,
//    input en,
    output reg [11:0] x,
    output reg [11:0] y,
    output reg frag_vld,
    input frag_rdy
);

    localparam X_MAX = `SQUARE_X;
    localparam Y_MAX = `SQUARE_Y;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            x         <= 12'd0;
            y         <= 12'd0;
            frag_vld  <= 1'b1;
        end else if (frag_rdy && frag_vld) begin // && en) begin
            // advance coordinates
            if (x == X_MAX - 1) begin
                x <= 12'd0;
                if (y == Y_MAX - 1)
                    y <= 12'd0;
                else
                    y <= y + 1;
            end else begin
                x <= x + 1;
            end
        end
    end

    // always ready to send a fragment
//    // optionally, you can disable `frag_vld` when waiting or in reset state
//    always @(posedge clk or negedge rst_n) begin
//        if (!rst_n)
//            frag_vld <= 1'b1;
//        else
//            frag_vld <= 1'b1;  // always valid; you may add gating logic if needed
//    end

endmodule