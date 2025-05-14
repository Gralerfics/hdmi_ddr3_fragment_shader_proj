# ----------------------------------------------------------------------------
# 
#  Created With Xilinx Vavado 2021.1 
#   Date : 2023.01.06
# 
#  This design is the property of MicroPhase.  Publication of this
#  design is not authorized without written consent from MicroPhase.
# --------------------------------------------------------------------
#           
#               MicroPhase Technologies Inc
#               Shanghai, China
#
#               web: http://www.microphase.cn   
#               email: support@microphase.cn
# --------------------------------------------------------------------
#  Disclaimer:
#     MicroPhase, Inc. makes no warranty for the use of this code or design.
#     This code is provided  "As Is". MicroPhase, Inc assumes no responsibility
#     for any errors, which may appear in this code, nor does it make a commitment
#     to update the information contained herein. MicroPhase, Inc specifically
#     disclaims any implied warranties of fitness for a particular purpose.
#                      Copyright(c) 2022 MicroPhase, Inc.
#                              All rights reserved.
# 
# ----------------------------------------------------------------------------
create_clock -period 20.00  [get_ports clk]  
set_property -dict {PACKAGE_PIN J19  IOSTANDARD LVCMOS33} [get_ports  clk] 
set_property -dict {PACKAGE_PIN L18  IOSTANDARD LVCMOS33} [get_ports  rst_n] 
###########################UART############################### 
set_property -dict {PACKAGE_PIN U2  IOSTANDARD LVCMOS33} [get_ports  rs232_rx] 
set_property -dict {PACKAGE_PIN V2  IOSTANDARD LVCMOS33} [get_ports  rs232_tx] 
#########################HDMI########################################## 
set_property -dict {PACKAGE_PIN L19  IOSTANDARD TMDS_33} [get_ports  hdmi_tx_clk_p  ] 
set_property -dict {PACKAGE_PIN K21  IOSTANDARD TMDS_33} [get_ports  hdmi_tx_chn_b_p] 
set_property -dict {PACKAGE_PIN J20  IOSTANDARD TMDS_33} [get_ports  hdmi_tx_chn_g_p] 
set_property -dict {PACKAGE_PIN G17  IOSTANDARD TMDS_33} [get_ports  hdmi_tx_chn_r_p] 
set_property -dict {PACKAGE_PIN H15  IOSTANDARD LVCMOS33} [get_ports  hdmi_hpd] 
