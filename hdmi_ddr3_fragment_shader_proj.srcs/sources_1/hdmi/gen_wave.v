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
// 2023.02.16     Ao Guohua     1.0          Original
//                                                      
// --------------------------------------------------------------------
// --------------------------------------------------------------------
`include "vga_parameter_cfg.v"
module gen_wave(
        input                 clk_in       ,
        input                 rst_n        ,  
        //与vga_driver模块连接的信号  
        input                 rd_data_req  , 
        output  reg  [23:0]   rd_data      , //{R,G,B}
        input        [11:0]   h_addr       , //数据横坐标地址
        input        [11:0]   v_addr       , //数据纵坐标
        //读取ROM中的接口信号
        output                rd_rom_req   ,
        input        [23:0]   rom_data
);

////用两个计数器计数一同方块的左上角的位置
//reg [11:0] square_x;//方块左上角横坐标
//reg [11:0] square_y;//方块右上角纵坐标
////方块移动的标志
//reg x_flag;//方块左右移动标志 0：向左移动  1：向右移动
//reg y_flag;//方块上下移动标志 0: 向上移动  1：向下移动
////***************square_x********************
//always@(posedge clk_in or negedge rst_n)begin
//  if(!rst_n)                         
//      square_x<='d0;                      
//  else if(h_addr==`SCREEN_X-1'b1&&v_addr==`SCREEN_Y-1'b1)begin//一帧图像结束
//            if(x_flag)
//                 square_x<=square_x+1'b1;
//            else 
//                 square_x<=square_x-1'b1;  
//  end 
//  else   square_x<=square_x;                                                
//end
////***************square_y********************
//always@(posedge  clk_in or negedge rst_n)begin
//  if(!rst_n)                         
//      square_y<='d0;                      
//  else if(h_addr==`SCREEN_X-1'b1&&v_addr==`SCREEN_Y-1'b1)begin//一帧图像结束
//            if(y_flag)
//                 square_y<=square_y+1'b1;
//            else 
//                 square_y<=square_y-1'b1;  
//  end 
//  else   square_y<=square_y;                                                
//end
////***************x_flag********************
//always@(posedge  clk_in or negedge rst_n)begin
//  if(!rst_n)                         
//        x_flag<=1'b1;//初始为1向右移动                      
//  else if(h_addr==`SCREEN_X-1'b1&&v_addr==`SCREEN_Y-1'b1)begin    
//            if(x_flag==1'b1&&square_x==`SCREEN_X-`SQUARE_X-'d3)
//                   x_flag<=1'b0;
//            else if(x_flag==1'b0&&square_x=='d2)
//                   x_flag<=1'b1;
//            else   x_flag<=x_flag;        
//  end 
//  else  x_flag<=x_flag;                                                  
//end
////***************y_flag********************
//always@(posedge  clk_in or negedge rst_n)begin
//  if(!rst_n)                         
//        y_flag<=1'b1;//初始为1向下移动                      
//  else if(h_addr==`SCREEN_X-1'b1&&v_addr==`SCREEN_Y-1'b1)begin    
//            if(y_flag==1'b1&&square_y==`SCREEN_Y-`SQUARE_Y-'d3)
//                   y_flag<=1'b0;
//            else if(y_flag==1'b0&&square_y=='d2)
//                   y_flag<=1'b1;
//            else   y_flag<=y_flag;        
//  end 
//  else  y_flag<=y_flag;                                                  
//end
// 不移动了，居中
localparam square_x = (`SCREEN_X - `SQUARE_X) / 2;
localparam square_y = (`SCREEN_Y - `SQUARE_Y) / 2;

// 显示区域与背景
always@(*) begin
    if (!rst_n)
        rd_data = 'd0;
    else if (rd_data_req)
        begin
            if (h_addr >= square_x && h_addr < square_x + `SQUARE_X && v_addr >= square_y && v_addr < square_y + `SQUARE_Y)
                rd_data = rom_data;
            else if (h_addr[5:0] < 20)
                rd_data = 24'hffffff; // 24'hff0000;
            else if (h_addr[5:0] < 40)
                rd_data = 24'hffffff; // 24'h00ff00;
            else
                rd_data = 24'hffffff; // 24'h0000ff;
        end
    else
        rd_data = 24'hffffff;
end

// 访存请求（在每个像素的前一个像素时开始访问？）
assign rd_rom_req = rd_data_req && h_addr >= square_x - 1 && h_addr < square_x + `SQUARE_X - 1 && v_addr >= square_y && v_addr < square_y + `SQUARE_Y;

endmodule