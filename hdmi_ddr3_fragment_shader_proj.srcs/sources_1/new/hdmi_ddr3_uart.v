// --------------------------------------------------------------------
// Copyright (c) 2022 by MicroPhase Technologies Inc. 
// --------------------------------------------------------------------
//
// Permission:
//
//   MicroPhase grants permission to use and modify this code for use
//   in synthesis for all MicroPhase Development Boards.
//   Other use of this code, including the selling 
//   ,duplication, or modification of any portion is strictly prohibited.
//
// Disclaimer:
//
//   This VHDL/Verilog or C/C++ source code is intended as a design reference
//   which illustrates how these types of functions can be implemented.
//   It is the user's responsibility to verify their design for
//   consistency and functionality through the use of formal
//   verification methods.  MicroPhase provides no warranty regarding the use 
//   or functionality of this code.
//
// --------------------------------------------------------------------
//           
//                     MicroPhase Technologies Inc
//                     Shanghai, China
//
//                     web: http://www.microphase.cn/   
//                     email: support@microphase.cn
//
// --------------------------------------------------------------------
// --------------------------------------------------------------------
//   
// Major Functions:   
//
// --------------------------------------------------------------------
// --------------------------------------------------------------------
//
//  Revision History    
//  Date          By            Revision    Change Description
//---------------------------------------------------------------------
// 2023.02.27     Ao Guohua     1.0          Original
//                                                      
// --------------------------------------------------------------------
// --------------------------------------------------------------------
`include "vga_parameter_cfg.v"

module hdmi_ddr3_uart  #(
    parameter DDR3_ADDR_MAX = `SQUARE_X * `SQUARE_Y - 8 // BL = 8
)(
    input                clk           ,
    input                rst_n         ,
    //uart 接口
    input                rs232_rx       ,
    output               rs232_tx       ,
    //ddr3 接口
    output [14:0]		ddr3_addr      ,  
    output [2:0]		    ddr3_ba        ,
    output	            ddr3_cas_n     ,
    output [0:0]		    ddr3_ck_n      ,
    output [0:0]		    ddr3_ck_p      ,
    output [0:0]		    ddr3_cke       ,
    output	            ddr3_ras_n     ,
    output	            ddr3_reset_n   ,
    output	            ddr3_we_n      ,
    inout  [15:0]		ddr3_dq        ,
    inout  [1:0]		    ddr3_dqs_n     ,
    inout  [1:0]		    ddr3_dqs_p     ,
    output [1:0]		    ddr3_dm        ,
    output [0:0]		    ddr3_odt       ,
    //hdmi 输出
    output               hdmi_tx_clk_n   ,
    output               hdmi_tx_clk_p   ,
    output               hdmi_tx_chn_r_n ,
    output               hdmi_tx_chn_r_p ,
    output               hdmi_tx_chn_g_n ,
    output               hdmi_tx_chn_g_p ,
    output               hdmi_tx_chn_b_n ,
    output               hdmi_tx_chn_b_p,
    output               hdmi_hpd
);
wire        sys_clk     ;
wire        sys_rst_n   ;
/*************应用层接口以及时钟**********/
wire        ui_clk     ;
wire        ui_rst     ;
wire        ddr3_busy  ;      //置1表明ddr3忙碌
/**********写控制信号**************/
wire         ddr3_wr_start    ;   //写开始信号
wire         ddr3_wr_data_req ;
wire [127:0] ddr3_wr_data     ;    
wire         ddr3_wr_addr_req ;
wire  [28:0] ddr3_wr_addr     ;
wire         ddr3_wr_done     ;
/*********读控制信号**************/
wire          ddr3_rd_start     ;  //signals about control
wire          ddr3_rd_addr_req  ;  //读地址请求信号
wire [28:0]   ddr3_rd_addr      ;  
wire          ddr3_rd_data_vld  ;
wire [127:0]  ddr3_rd_data      ;
wire          ddr3_rd_done      ; 
wire          hdmi_rst_n        ;
wire          clk1x             ;
wire          clk5x             ;
wire          hdmi_data_req     ; 
wire [23:0]   hdmi_data         ; //{R,G,B}
wire [11:0]   h_addr            ; //数据横坐标地址
wire [11:0]   v_addr            ;//数据纵坐标 
wire          rd_rom_req        ;
wire [23:0]   rom_data          ;   
assign   hdmi_hpd=1'b1;

wire pipe_clk;
assign pipe_clk = clk;
wire rst;
assign rst = ~rst_n;

wire frame_end_wr, frame_end_rd;

// ----------------------------------------------------------------
// 1 us counter for iTime generation.
// ----------------------------------------------------------------
localparam CYCLE_1US = 50; // 50MHz
reg [19:0] cnt_1us;
reg [63:0] itime_us;
always @(posedge pipe_clk or posedge rst) begin
    if (rst) begin
            cnt_1us <= 0;
            itime_us <= 0;
    end else begin
        if (cnt_1us == CYCLE_1US - 1) begin
            cnt_1us <= 0;
            itime_us <= itime_us + 1;
        end else begin
            cnt_1us <= cnt_1us + 1;
        end
    end
end

// ----------------------------------------------------------------
// Double-buffer controller instantiation
// ----------------------------------------------------------------
wire [28:0] mapped_wr_addr;
wire [28:0] mapped_rd_addr;
wire wr_buf_sel, rd_buf_sel;

double_buffer_ctrl #(
    .DDR3_ADDR_MAX(DDR3_ADDR_MAX)
) u_db_ctrl (
    .clk           (ui_clk),
    .rst           (ui_rst),
    .frame_end_wr  (frame_end_wr),
    .frame_end_rd  (frame_end_rd),
    .base_wr_addr  (ddr3_wr_addr),
    .base_rd_addr  (ddr3_rd_addr),
    .mapped_wr_addr(mapped_wr_addr),
    .mapped_rd_addr(mapped_rd_addr),
    .wr_buf_sel    (wr_buf_sel),
    .rd_buf_sel    (rd_buf_sel)
);

// ----------------------------------------------------------------
// fragment_scanner
// ----------------------------------------------------------------
wire [11:0] frag_x, frag_y;
wire frag_vld, frag_rdy;

fragment_scanner frag_scanner (
    .clk (pipe_clk),
    .rst_n (rst_n),
    .x (frag_x),
    .y (frag_y),
    .frag_vld (frag_vld),
    .frag_rdy (frag_rdy)
);

// ----------------------------------------------------------------
// shader
// ----------------------------------------------------------------
wire [23:0] shader_output;
wire shader_output_vld;
wire ddr3_rx_buffer_ready;

shader sdr (
    .clock (pipe_clk),
    .reset (rst),
    .in_ready (frag_rdy),
    .in_valid (frag_vld),
    .out_ready (ddr3_rx_buffer_ready),
    .out_valid (shader_output_vld),
    .itime_us (itime_us),
    .frag_x (frag_x),
    .frag_y (frag_y),
    .frag_color (shader_output)
);

// ----------------------------------------------------------------
// ddr3_rx_buffer
// ----------------------------------------------------------------
//ddr3_rx_buffer #(
ddr3_rx_buffer_24 #(
    .DDR3_ADDR_MAX            (DDR3_ADDR_MAX    ) //ddr3地址的最大值
) ddr3_rx_buffer (
    //数据输入端口
    .clk                      (clk              ),
    .data_in_vld              (shader_output_vld),
    .data_in                  (shader_output    ),
    //ddr3相关的控制接口
    .ui_clk                   (ui_clk           ),
    .ui_rst                   (ui_rst           ),
    .ddr3_busy                (ddr3_busy        ),
    .ddr3_wr_start            (ddr3_wr_start    ),
    .ddr3_wr_addr_req         (ddr3_wr_addr_req ),
    .ddr3_wr_addr             (ddr3_wr_addr     ),
    .ddr3_wr_data_req         (ddr3_wr_data_req ),
    .ddr3_wr_data             (ddr3_wr_data     ),
    .ddr3_wr_done             (ddr3_wr_done     ),
    
    .fifo_wr_rst_done (ddr3_rx_buffer_ready)
);

assign frame_end_wr = (ddr3_wr_addr == DDR3_ADDR_MAX) && ddr3_wr_addr_req;

// ----------------------------------------------------------------
// ddr3_tx_buffer
// ----------------------------------------------------------------
ddr3_tx_buffer  #(
         .DDR3_ADDR_MAX ( DDR3_ADDR_MAX),
         .WR_MAX        (    896  )
     )  ddr3_tx_buffer
     (
    .ui_clk              (ui_clk          ),
    .ui_rst              (ui_rst          ),
    .ddr3_busy           (ddr3_busy       ),
    //*********ddr3读控制信号**************/
    .ddr3_rd_start        (ddr3_rd_start    )   ,  //signals about control
    .ddr3_rd_addr_req     (ddr3_rd_addr_req )   ,  //读地址请求信号
    .ddr3_rd_addr         (ddr3_rd_addr     )   ,  
    .ddr3_rd_data_vld     (ddr3_rd_data_vld )   ,
    .ddr3_rd_data         (ddr3_rd_data     )   ,
    .ddr3_rd_done         (ddr3_rd_done     )   ,
    //************给hdmi显示的模块***********/
    .hdmi_clk            (clk1x),
    .hdmi_data_req       (rd_rom_req),//hdmi请求数据
    .hdmi_data           (rom_data),
    .hdmi_rst_n          (hdmi_rst_n   )
);

assign frame_end_rd = (ddr3_rd_addr == DDR3_ADDR_MAX) && ddr3_rd_addr_req;

// ----------------------------------------------------------------
// ddr3_ctrl
// ----------------------------------------------------------------
ddr3_ctrl ddr3_ctrl(
        .sys_clk    (sys_clk),
        .sys_rst_n  (sys_rst_n),
/*************应用层接口以及时钟**********/
         .ui_clk     (ui_clk   ),
         .ui_rst     (ui_rst   ),
         .ddr3_busy  (ddr3_busy),      //置1表明ddr3忙碌
/**********写控制信号**************/
         .ddr3_wr_start    (ddr3_wr_start   ),   //写开始信号
         .ddr3_wr_data_req (ddr3_wr_data_req),
         .ddr3_wr_data     (ddr3_wr_data    ),    
         .ddr3_wr_addr_req (ddr3_wr_addr_req),
         .ddr3_wr_addr     (mapped_wr_addr  ),   // ddr3_wr_addr
         .ddr3_wr_done     (ddr3_wr_done    ),
/*********读控制信号**************/
         .ddr3_rd_start     (ddr3_rd_start   ),  //signals about control
         .ddr3_rd_addr_req  (ddr3_rd_addr_req),  //读地址请求信号
         .ddr3_rd_addr      (mapped_rd_addr  ),  // ddr3_rd_addr
         .ddr3_rd_data_vld  (ddr3_rd_data_vld),
         .ddr3_rd_data      (ddr3_rd_data    ),
         .ddr3_rd_done      (ddr3_rd_done    ),
/*************ddr3硬件接口*****************/
         .ddr3_addr         (ddr3_addr   ),  
         .ddr3_ba           (ddr3_ba     ),
         .ddr3_cas_n        (ddr3_cas_n  ),
         .ddr3_ck_n         (ddr3_ck_n   ),
         .ddr3_ck_p         (ddr3_ck_p   ),
         .ddr3_cke          (ddr3_cke    ),
         .ddr3_ras_n        (ddr3_ras_n  ),
         .ddr3_reset_n      (ddr3_reset_n),
         .ddr3_we_n         (ddr3_we_n   ),
         .ddr3_dq           (ddr3_dq     ),
         .ddr3_dqs_n        (ddr3_dqs_n  ),
         .ddr3_dqs_p        (ddr3_dqs_p  ),
         .ddr3_dm           (ddr3_dm     ),
         .ddr3_odt          (ddr3_odt    )
     );

// ----------------------------------------------------------------
// gen_wave
// ----------------------------------------------------------------
gen_wave u_gen_wave(
    .clk_in       ( clk1x          ),
    .rst_n        ( hdmi_rst_n     ),
    .rd_data_req  ( hdmi_data_req  ),
    .rd_data      ( hdmi_data      ),
    .h_addr       ( h_addr         ),
    .v_addr       ( v_addr         ),
    .rd_rom_req   ( rd_rom_req     ),
    .rom_data     ( rom_data       )
//    .frame_end_rd ( frame_end_rd   )
);

// ----------------------------------------------------------------
// uart_tx
// ----------------------------------------------------------------
wire tx_en;
wire tx_done;
wire [7:0] tx_data;

uart_tx #(
    .SYS_FRENCY(50_000_000),
    .BAUD_FRENCY(115200)
) uart_tx (
    .clk          (clk     ),
    .rst_n        (rst_n   ),
    .send_en      (tx_en   ),
    .tx_data      (tx_data ),
    .rs232_tx     (rs232_tx),
    .tx_done      (tx_done )
);

// ----------------------------------------------------------------
// uart_loop 回环测试
// ----------------------------------------------------------------
//uart_loop  #(
//    .SYS_FRENCY  (50_000_000 ),//时钟
//    .BAUD_FRENCY (115200 )     //波特率
//) uart_loop(
//    .clk        (clk     ),
//    .rst_n      (rst_n   ),
//    .rs232_rx   (rs232_rx),
//    .rs232_tx   (rs232_tx)
//);

// ----------------------------------------------------------------
// uart_rx
// ----------------------------------------------------------------
//wire rx_done;
//wire [7:0] rx_data;

//uart_rx #(
//    .SYS_FRENCY  (50_000_000),//系统频率50M
//    .BAUD_FRENCY (115200)//波特率
//) uart_rx (
//    .clk          (clk     ),
//    .rst_n        (rst_n   ),
//    .rs232_rx     (rs232_rx),
//    .rx_done      (rx_done),
//    .rx_data      (rx_data)
//);

// ----------------------------------------------------------------
// ddr3_clock
// ----------------------------------------------------------------
ddr3_clock ddr3_clock (
    // Clock out ports
    .clk_out1   (sys_clk),     // output clk_out1
    // Status and control signals
    .resetn     (rst_n), // input resetn
    .locked     (sys_rst_n),       // output locked
    // Clock in ports
    .clk_in1    (clk)   // input clk_in1
);

// ----------------------------------------------------------------
// hdmi_clock
// ----------------------------------------------------------------
clock hdmi_clock
   (
    // Clock out ports
    .clk_out1(clk1x),     // output clk_out1
    .clk_out2(clk5x),     // output clk_out2
    // Status and control signals
    .resetn(rst_n), // input resetn
    .locked(),       // output locked
   // Clock in ports
    .clk_in1(clk));      // input clk_in1  

// ----------------------------------------------------------------
// hdmi_driver
// ----------------------------------------------------------------
hdmi_driver u_hdmi_driver(
    .clk1x           ( clk1x           ),
    .clk5x           ( clk5x           ),
    .rst_n           ( hdmi_rst_n      ),
    .hdmi_data_req   ( hdmi_data_req   ),
    .hdmi_data       ( hdmi_data       ),
    .h_addr          ( h_addr          ),
    .v_addr          ( v_addr          ),
    .hdmi_tx_clk_n   ( hdmi_tx_clk_n   ),
    .hdmi_tx_clk_p   ( hdmi_tx_clk_p   ),
    .hdmi_tx_chn_r_n ( hdmi_tx_chn_r_n ),
    .hdmi_tx_chn_r_p ( hdmi_tx_chn_r_p ),
    .hdmi_tx_chn_g_n ( hdmi_tx_chn_g_n ),
    .hdmi_tx_chn_g_p ( hdmi_tx_chn_g_p ),
    .hdmi_tx_chn_b_n ( hdmi_tx_chn_b_n ),
    .hdmi_tx_chn_b_p  ( hdmi_tx_chn_b_p  )
);

endmodule