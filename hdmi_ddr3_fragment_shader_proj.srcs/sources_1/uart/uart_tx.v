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
module uart_tx #(
        parameter SYS_FRENCY = 50_000_000 ,//时钟
        parameter BAUD_FRENCY =38400       //波特率
    )

(
    input      clk       ,
    input      rst_n     ,
    input      send_en   ,   //发数据控制信号，脉冲触发
    input [7:0]tx_data   ,
    output reg rs232_tx  ,
    output     tx_done
    );
localparam  CNT_MAX = SYS_FRENCY/BAUD_FRENCY-1 ;
reg        en_cnt   ;
reg [7:0]  r_tx_data;//用来寄存tx_data
reg [3:0]  bps_cnt  ;
reg [15:0] cnt      ;
//r_tx_data
always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        r_tx_data<='d0;
    else if(send_en)
            r_tx_data<=tx_data;
    else   r_tx_data<=r_tx_data;
end
//en_cnt
always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        en_cnt<=1'b0;
    else if(send_en)
            en_cnt<=1'b1;
    else if(cnt==(CNT_MAX>>1)+(CNT_MAX>>2)&&bps_cnt==8'd9)
            en_cnt<=1'b0;
    else    en_cnt<=en_cnt;
end
//bps_cnt
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
    else cnt<='d0;
end

//rs232_tx数据输出
always @(*) begin
    if(!rst_n)
        rs232_tx<=1'b1;
    else if(en_cnt)begin
            case (bps_cnt)
                0:rs232_tx<=1'b0;
                1:rs232_tx<=r_tx_data[0];
                2:rs232_tx<=r_tx_data[1];
                3:rs232_tx<=r_tx_data[2];
                4:rs232_tx<=r_tx_data[3];
                5:rs232_tx<=r_tx_data[4];
                6:rs232_tx<=r_tx_data[5];
                7:rs232_tx<=r_tx_data[6];
                8:rs232_tx<=r_tx_data[7];
                9:rs232_tx<=1'b1;
                default:rs232_tx<=1'b1; 
            endcase
    end 
    else    rs232_tx<=1'b1;
end
assign tx_done=(cnt==(CNT_MAX>>1)+(CNT_MAX>>2))&&bps_cnt==4'd9;
endmodule
