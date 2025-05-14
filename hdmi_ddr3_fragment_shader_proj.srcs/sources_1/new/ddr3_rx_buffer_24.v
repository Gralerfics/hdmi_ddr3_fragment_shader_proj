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
module ddr3_rx_buffer_24 #(
        parameter    DDR3_ADDR_MAX=512*512-8,//ddr3地址的最大值
        parameter    BURST_LEN = 64           

 )(
     //数据输入端口
     input               clk                      ,
     input               data_in_vld              ,
     input  [23:0]       data_in                  ,
     //ddr3相关的控制接口
     input               ui_clk                   ,
     input               ui_rst                   ,
     input               ddr3_busy                ,
     output              ddr3_wr_start            ,
     input               ddr3_wr_addr_req         ,
     output reg  [28:0]  ddr3_wr_addr             ,
     input               ddr3_wr_data_req         ,
     output      [127:0] ddr3_wr_data             ,
     input               ddr3_wr_done,
     
     output fifo_wr_rst_done
);
localparam   IDLE  =3'b001 ;  //复位的时候处于空闲状态
localparam   ARBIT =3'b010 ;  //判断状态，等待写入信号
localparam   WRITE =3'b100 ;  //写状态，写入数据
reg  [2:0]      state      ;
reg  [1:0]      shift_cnt  ; //移位的计数器
reg             shift_vld  ; //移位数据有效
reg  [23:0]     shift_data ; //移位的数据
wire [15:0]     din        ; 
wire            full       ;
wire            empty      ;
wire [6 : 0]    rd_data_count;
wire [9 : 0]    wr_data_count;
wire            wr_rst_busy;
wire            rd_rst_busy;

assign fifo_wr_rst_done = ~wr_rst_busy;

////***************shift_cnt******************
//always@(posedge clk or posedge wr_rst_busy)begin
//  if(wr_rst_busy)                         
//        shift_cnt<='d0;                      
//  else if(data_in_vld)begin
//          if(shift_cnt=='d2)
//              shift_cnt<='d0;
//          else 
//              shift_cnt<=shift_cnt+1'b1;
//  end 
//  else 
//       shift_cnt<=shift_cnt;                                                        
//end
////***************wr_rst_busy******************
//always@(posedge clk or posedge wr_rst_busy)begin
//  if(wr_rst_busy)
//     shift_vld<=1'b0;
//  else if(data_in_vld)begin
//           if(shift_cnt=='d2)
//               shift_vld<=1'b1;
//           else
//                shift_vld<=1'b0;               
//  end
//  else 
//        shift_vld<=1'b0;    
//end   
////**************shift_data*********************
//always@(posedge clk or posedge wr_rst_busy)begin
//  if(wr_rst_busy)                           
//        shift_data<='d0;                       
//  else if(data_in_vld)begin                     
//            shift_data<={shift_data[15:0],data_in};                      
//   end                                 
//  else  begin                          
//            shift_data<=shift_data;                      
//  end                                  
//end
assign din={data_in[23:19],data_in[15:10],data_in[7:3]};
ddr3_rx_fifo ddr3_rx_fifo (
  .rst   (ui_rst),                      // input wire rst
  .wr_clk(clk),                // input wire wr_clk
  .rd_clk(ui_clk),                // input wire rd_clk
  .din   (din),                      // input wire [15 : 0] din
  .wr_en (data_in_vld), // shift_vld),                  // input wire wr_en
  .rd_en (ddr3_wr_data_req),                  // input wire rd_en
  .dout  (ddr3_wr_data),                    // output wire [127 : 0] dout
  .full  (full),                    // output wire full
  .empty (empty),                  // output wire empty
  .rd_data_count(rd_data_count),  // output wire [6 : 0] rd_data_count
  .wr_data_count(wr_data_count),  // output wire [9 : 0] wr_data_count
  .wr_rst_busy(wr_rst_busy),      // output wire wr_rst_busy
  .rd_rst_busy(rd_rst_busy)      // output wire rd_rst_busy
);
//finite state machine 
always @(posedge ui_clk or posedge rd_rst_busy) begin
    if(rd_rst_busy)
        state<=IDLE;
    else 
     case (state)
        IDLE:begin
               state<=ARBIT;
        end
        ARBIT: 
            begin
                if(ddr3_wr_start)
                     state<=WRITE;
                else 
                     state<=ARBIT;
            end
        WRITE:
            begin
                 if(ddr3_wr_done)
                    state<=ARBIT;
                 else 
                      state<=WRITE;
            end
        default:  state<=ARBIT;
     endcase       
end
//当fifo中有64个数的时候，产生wr_start信号，
//当fifo在First Word Fall Through模式下rd_data_count显示的数据个数要比fifo中实际的数据个数要少两个 
//当rd_data_count为62的时候，fifo中实际可读个数为64
assign ddr3_wr_start=state==ARBIT&&ddr3_busy==1'b0&&rd_data_count>=BURST_LEN-2;

//ddr3_wr_addr
always @(posedge ui_clk or posedge rd_rst_busy) begin
    if(rd_rst_busy)
        ddr3_wr_addr <='d0;
    else if(ddr3_wr_addr_req)begin
              if(ddr3_wr_addr==DDR3_ADDR_MAX)
                  ddr3_wr_addr <='d0;
              else
                  ddr3_wr_addr <=ddr3_wr_addr+'d8;
    end
    else  ddr3_wr_addr <=ddr3_wr_addr;
end
endmodule