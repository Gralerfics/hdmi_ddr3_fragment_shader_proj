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
module uart_rx
    #(
        parameter SYS_FRENCY =50_000_000 ,//系统频率50M
        parameter BAUD_FRENCY =38400      //波特率
    )

(
    input           clk          ,
    input           rst_n        ,
    input           rs232_rx     ,
    output reg      rx_done      ,
    output reg [7:0]rx_data
    );
localparam CNT_MAX = SYS_FRENCY/BAUD_FRENCY-1;
reg        en_cnt          ; //计数器使能控制
reg [15:0] cnt             ;
wire       bps_vld         ;  //计数到每bit数据的中心产生一个高电平
reg [3:0]  bps_cnt         ;  //接受位数的计数器
reg [1:0]  rs232_rx_filter ;  //用两个寄存器消除亚稳态
reg        rs232_rx_d;    //用一个寄存器来识别下降沿
wire       nedge;                //下降沿信号
reg [9:0]  rx_data_r;
wire       rx_done_r;
//消除亚稳态
always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        rs232_rx_filter<=2'b11;
    else 
        rs232_rx_filter<={rs232_rx_filter[0],rs232_rx};
end
//下降沿识别
always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        rs232_rx_d<=1'b1;
    else 
        rs232_rx_d<=rs232_rx_filter[1];
end
assign nedge=rs232_rx_d&(!rs232_rx_filter[1]);
//en_cnt
always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        en_cnt<=1'b0;
    else if(nedge)
            en_cnt<=1'b1; 
    else if(rx_done_r)
             en_cnt<=1'b0;
    else   en_cnt<=en_cnt;
end
//cnt
always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        cnt<='d0;
    else if(en_cnt)begin
            if(cnt==CNT_MAX) 
                cnt<='d0;
            else 
                cnt<=cnt+1'b1;
    end
    else  cnt<='d0;
end
//在中间的时刻采集信号线上的数据，表明数据有效
assign bps_vld=cnt==(CNT_MAX>>1);
//bps_cnt  计数到每bit信号的中心然后再读取数值
always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        bps_cnt<='d0;
    else if(en_cnt)begin
            if(cnt==CNT_MAX)
                bps_cnt<=bps_cnt+1'b1;
            else 
                bps_cnt<=bps_cnt;
    end
    else  bps_cnt<='d0;
end
//rx_data 读出数据
always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        rx_data_r<='d0;
    else if (bps_vld)begin
            case (bps_cnt)
               0,1,2,3,4,5,6,7,8,9: rx_data_r<={rs232_rx_filter[1],rx_data_r[9:1]};
                default: rx_data_r<=rx_data_r;
            endcase 
    end
    else rx_data_r<=rx_data_r;
end
//在停止位的的3/4处产生结束信号
assign rx_done_r=(cnt==CNT_MAX-(CNT_MAX>>2))&&(bps_cnt==4'd9);
always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        rx_data<='d0;
    else if(rx_done_r)begin
            if(!rx_data_r[0]&rx_data_r[9])
                    rx_data<=rx_data_r[8:1]; 
            else    rx_data<=8'd0;//数据错误置零
    end
    else rx_data<=rx_data;
end
always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        rx_done<=1'b0;
    else rx_done<=rx_done_r;
end
endmodule