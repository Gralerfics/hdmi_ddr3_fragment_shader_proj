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
// 2022.09.07     Ao Guohua     1.0          Original
//                                                      
// --------------------------------------------------------------------
// --------------------------------------------------------------------
module uart_loop  #(
        parameter SYS_FRENCY = 50_000_000 ,//时钟
        parameter BAUD_FRENCY =38400       //波特率
    )(
        input  clk,
        input  rst_n,
        input  rs232_rx,
        output rs232_tx
    );
wire       rx_done;
wire [7:0] rx_data;
uart_tx  #(
         .SYS_FRENCY  (SYS_FRENCY), //系统频率50M
         .BAUD_FRENCY (BAUD_FRENCY) //波特率
    )  uart_tx0
(
    .clk        (clk),
    .rst_n      (rst_n),
    .send_en    (rx_done),   //发数据控制信号，脉冲触发
    .tx_data    (rx_data),
    .rs232_tx   (rs232_tx),
    .tx_done    ()
    );

uart_rx  #(
        .SYS_FRENCY  (SYS_FRENCY), //系统频率50M
        .BAUD_FRENCY (BAUD_FRENCY) //波特率
    ) uart_rx0
(
    .clk       (clk) ,
    .rst_n     (rst_n) ,
    .rs232_rx  (rs232_rx) ,
    .rx_done   (rx_done) ,
    .rx_data   (rx_data)
    );
endmodule
