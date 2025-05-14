// Ping-pong address multiplexer with write and read FSMs
module double_buffer_ctrl #(
    // total number of addresses per half-buffer
    parameter DDR3_ADDR_MAX = 512 * 512 - 8
)(
    input  wire                    clk,
    input  wire                    rst,
    // end-of-frame pulses from write (slow) and read (fast) sides
    input  wire                    frame_end_wr,
    input  wire                    frame_end_rd,
    // base addresses from individual controllers
    input  wire [28:0]             base_wr_addr,
    input  wire [28:0]             base_rd_addr,
    // ping-ponged addresses to DDR3 controller
    output wire [28:0]             mapped_wr_addr,
    output wire [28:0]             mapped_rd_addr,
    // current buffer selections (0 or 1)
    output reg                     wr_buf_sel,
    output reg                     rd_buf_sel
);
    localparam INTERVAL = DDR3_ADDR_MAX + 8;

    // Write-side FSM: toggle wr_buf_sel on each write-frame-end
    always @(posedge clk or posedge rst) begin
        if (rst)
            wr_buf_sel <= 1'b0;
        else if (frame_end_wr)
            wr_buf_sel <= ~wr_buf_sel;
    end

    // Read-side FSM: toggle rd_buf_sel whenever a frame ends and both sides currently in same buffer
    always @(posedge clk or posedge rst) begin
        if (rst)
            rd_buf_sel <= 1'b0;
        else if (frame_end_rd && (rd_buf_sel == wr_buf_sel))
            rd_buf_sel <= ~rd_buf_sel;
    end

    // Address mapping: combinatorial to avoid one-cycle delay
    assign mapped_wr_addr = base_wr_addr + (wr_buf_sel ? INTERVAL : 0);
    assign mapped_rd_addr = base_rd_addr + (rd_buf_sel ? INTERVAL : 0);

endmodule