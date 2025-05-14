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
// 2022.09.19     Ao Guohua     1.0          Original
//                                                      
// --------------------------------------------------------------------
// --------------------------------------------------------------------
module ddr3_tx_buffer  #(
         parameter  DDR3_ADDR_MAX = 512*512-8,
         parameter  WR_MAX        = 896  
     )(
    input             ui_clk              ,
    input             ui_rst              ,
    input             ddr3_busy           ,
    //*********ddr3读控制信号**************/
    output            ddr3_rd_start            ,  //signals about control
    input             ddr3_rd_addr_req         ,  //读地址请求信号
    output  reg [28:0]ddr3_rd_addr             ,  
    input             ddr3_rd_data_vld         ,
    input  [127:0]    ddr3_rd_data             ,
    input             ddr3_rd_done             ,
    //************给hdmi显示的模块***********/
    input             hdmi_clk            ,
    input             hdmi_data_req       ,//hdmi请求数据
    output [23:0]     hdmi_data           ,
    output  reg       hdmi_rst_n  
    );
localparam IDLE        = 3'b001 ; //复位的时候处于空状态
localparam ARBIT       = 3'b010 ; //判断是否从ddr3中读出数据
localparam READ        = 3'b100 ; //从ddr3中读出数据
reg            [2:0]    state  ;
wire          [15:0]    dout   ;
wire                    full   ; 
wire                    empty  ;
wire [12 : 0]    rd_data_count ;
wire [9 : 0]     wr_data_count ;
wire             wr_rst_busy   ;
wire             rd_rst_busy   ;
/********************ui_clk***********************/
//状态机
always @(posedge ui_clk or posedge wr_rst_busy) begin
    if(wr_rst_busy)
       state<=IDLE;
    else
     case (state)
       IDLE  :begin
             state <= ARBIT; 
       end
       ARBIT :
          begin
               if(ddr3_rd_start)
                   state<= READ;
               else 
                    state<= ARBIT;
           end
       READ:
           begin
                if(ddr3_rd_done)
                    state<= ARBIT;
                else 
                    state<= READ;
           end
        default:state<=ARBIT; 
    endcase
end
//ddr3_rd_start
assign ddr3_rd_start=(state==ARBIT)&&(ddr3_busy==1'b0)&&(wr_data_count<=WR_MAX);
//hdmi_rst_n
always @(posedge ui_clk or posedge wr_rst_busy) begin
    if(wr_rst_busy)
        hdmi_rst_n<=1'b0;
    else if(wr_data_count>WR_MAX) 
                hdmi_rst_n<=1'b1;
    else  hdmi_rst_n<= hdmi_rst_n; 
end
//ddr3_rd_addr
always @(posedge ui_clk or posedge wr_rst_busy) begin
    if(wr_rst_busy)
       ddr3_rd_addr<='d0;
    else if(ddr3_rd_addr_req) begin
            if(ddr3_rd_addr==DDR3_ADDR_MAX)
                  ddr3_rd_addr<='d0;
            else 
                  ddr3_rd_addr<=ddr3_rd_addr+'d8; 
    end
    else 
         ddr3_rd_addr<=ddr3_rd_addr;
end
ddr3_tx_fifo ddr3_tx_fifo (
  .rst(ui_rst),                      // input wire rst
  .wr_clk(ui_clk),                // input wire wr_clk
  .rd_clk(hdmi_clk),                // input wire rd_clk
  .din(ddr3_rd_data),                      // input wire [127 : 0] din
  .wr_en(ddr3_rd_data_vld),                  // input wire wr_en
  .rd_en(hdmi_data_req),                  // input wire rd_en
  .dout(dout),                    // output wire [15 : 0] dout
  .full(full),                    // output wire full
  .empty(empty),                  // output wire empty
  .rd_data_count(rd_data_count),  // output wire [12 : 0] rd_data_count
  .wr_data_count(wr_data_count),  // output wire [9 : 0] wr_data_count
  .wr_rst_busy(wr_rst_busy),      // output wire wr_rst_busy
  .rd_rst_busy(rd_rst_busy)      // output wire rd_rst_busy
);
assign hdmi_data={{dout[15:11],dout[13:11]},{dout[10:5],dout[6:5]},{dout[4:0],dout[2:0]}};
endmodule
