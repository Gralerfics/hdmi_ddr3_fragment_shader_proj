vlib work
vlib riviera

vlib riviera/xpm
vlib riviera/xil_defaultlib

vmap xpm riviera/xpm
vmap xil_defaultlib riviera/xil_defaultlib

vlog -work xpm  -sv2k12 \
"D:/Xilinx/Vivado/2021.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"D:/Xilinx/Vivado/2021.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93 \
"D:/Xilinx/Vivado/2021.1/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  -v2k5 \
"../../../../hdmi_ddr3_uart.gen/sources_1/ip/mig_ddr3/mig_ddr3/user_design/rtl/clocking/mig_7series_v4_2_clk_ibuf.v" \
"../../../../hdmi_ddr3_uart.gen/sources_1/ip/mig_ddr3/mig_ddr3/user_design/rtl/clocking/mig_7series_v4_2_infrastructure.v" \
"../../../../hdmi_ddr3_uart.gen/sources_1/ip/mig_ddr3/mig_ddr3/user_design/rtl/clocking/mig_7series_v4_2_iodelay_ctrl.v" \
"../../../../hdmi_ddr3_uart.gen/sources_1/ip/mig_ddr3/mig_ddr3/user_design/rtl/clocking/mig_7series_v4_2_tempmon.v" \
"../../../../hdmi_ddr3_uart.gen/sources_1/ip/mig_ddr3/mig_ddr3/user_design/rtl/controller/mig_7series_v4_2_arb_mux.v" \
"../../../../hdmi_ddr3_uart.gen/sources_1/ip/mig_ddr3/mig_ddr3/user_design/rtl/controller/mig_7series_v4_2_arb_row_col.v" \
"../../../../hdmi_ddr3_uart.gen/sources_1/ip/mig_ddr3/mig_ddr3/user_design/rtl/controller/mig_7series_v4_2_arb_select.v" \
"../../../../hdmi_ddr3_uart.gen/sources_1/ip/mig_ddr3/mig_ddr3/user_design/rtl/controller/mig_7series_v4_2_bank_cntrl.v" \
"../../../../hdmi_ddr3_uart.gen/sources_1/ip/mig_ddr3/mig_ddr3/user_design/rtl/controller/mig_7series_v4_2_bank_common.v" \
"../../../../hdmi_ddr3_uart.gen/sources_1/ip/mig_ddr3/mig_ddr3/user_design/rtl/controller/mig_7series_v4_2_bank_compare.v" \
"../../../../hdmi_ddr3_uart.gen/sources_1/ip/mig_ddr3/mig_ddr3/user_design/rtl/controller/mig_7series_v4_2_bank_mach.v" \
"../../../../hdmi_ddr3_uart.gen/sources_1/ip/mig_ddr3/mig_ddr3/user_design/rtl/controller/mig_7series_v4_2_bank_queue.v" \
"../../../../hdmi_ddr3_uart.gen/sources_1/ip/mig_ddr3/mig_ddr3/user_design/rtl/controller/mig_7series_v4_2_bank_state.v" \
"../../../../hdmi_ddr3_uart.gen/sources_1/ip/mig_ddr3/mig_ddr3/user_design/rtl/controller/mig_7series_v4_2_col_mach.v" \
"../../../../hdmi_ddr3_uart.gen/sources_1/ip/mig_ddr3/mig_ddr3/user_design/rtl/controller/mig_7series_v4_2_mc.v" \
"../../../../hdmi_ddr3_uart.gen/sources_1/ip/mig_ddr3/mig_ddr3/user_design/rtl/controller/mig_7series_v4_2_rank_cntrl.v" \
"../../../../hdmi_ddr3_uart.gen/sources_1/ip/mig_ddr3/mig_ddr3/user_design/rtl/controller/mig_7series_v4_2_rank_common.v" \
"../../../../hdmi_ddr3_uart.gen/sources_1/ip/mig_ddr3/mig_ddr3/user_design/rtl/controller/mig_7series_v4_2_rank_mach.v" \
"../../../../hdmi_ddr3_uart.gen/sources_1/ip/mig_ddr3/mig_ddr3/user_design/rtl/controller/mig_7series_v4_2_round_robin_arb.v" \
"../../../../hdmi_ddr3_uart.gen/sources_1/ip/mig_ddr3/mig_ddr3/user_design/rtl/ecc/mig_7series_v4_2_ecc_buf.v" \
"../../../../hdmi_ddr3_uart.gen/sources_1/ip/mig_ddr3/mig_ddr3/user_design/rtl/ecc/mig_7series_v4_2_ecc_dec_fix.v" \
"../../../../hdmi_ddr3_uart.gen/sources_1/ip/mig_ddr3/mig_ddr3/user_design/rtl/ecc/mig_7series_v4_2_ecc_gen.v" \
"../../../../hdmi_ddr3_uart.gen/sources_1/ip/mig_ddr3/mig_ddr3/user_design/rtl/ecc/mig_7series_v4_2_ecc_merge_enc.v" \
"../../../../hdmi_ddr3_uart.gen/sources_1/ip/mig_ddr3/mig_ddr3/user_design/rtl/ecc/mig_7series_v4_2_fi_xor.v" \
"../../../../hdmi_ddr3_uart.gen/sources_1/ip/mig_ddr3/mig_ddr3/user_design/rtl/ip_top/mig_7series_v4_2_memc_ui_top_std.v" \
"../../../../hdmi_ddr3_uart.gen/sources_1/ip/mig_ddr3/mig_ddr3/user_design/rtl/ip_top/mig_7series_v4_2_mem_intfc.v" \
"../../../../hdmi_ddr3_uart.gen/sources_1/ip/mig_ddr3/mig_ddr3/user_design/rtl/phy/mig_7series_v4_2_ddr_byte_group_io.v" \
"../../../../hdmi_ddr3_uart.gen/sources_1/ip/mig_ddr3/mig_ddr3/user_design/rtl/phy/mig_7series_v4_2_ddr_byte_lane.v" \
"../../../../hdmi_ddr3_uart.gen/sources_1/ip/mig_ddr3/mig_ddr3/user_design/rtl/phy/mig_7series_v4_2_ddr_calib_top.v" \
"../../../../hdmi_ddr3_uart.gen/sources_1/ip/mig_ddr3/mig_ddr3/user_design/rtl/phy/mig_7series_v4_2_ddr_if_post_fifo.v" \
"../../../../hdmi_ddr3_uart.gen/sources_1/ip/mig_ddr3/mig_ddr3/user_design/rtl/phy/mig_7series_v4_2_ddr_mc_phy.v" \
"../../../../hdmi_ddr3_uart.gen/sources_1/ip/mig_ddr3/mig_ddr3/user_design/rtl/phy/mig_7series_v4_2_ddr_mc_phy_wrapper.v" \
"../../../../hdmi_ddr3_uart.gen/sources_1/ip/mig_ddr3/mig_ddr3/user_design/rtl/phy/mig_7series_v4_2_ddr_of_pre_fifo.v" \
"../../../../hdmi_ddr3_uart.gen/sources_1/ip/mig_ddr3/mig_ddr3/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_4lanes.v" \
"../../../../hdmi_ddr3_uart.gen/sources_1/ip/mig_ddr3/mig_ddr3/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_ck_addr_cmd_delay.v" \
"../../../../hdmi_ddr3_uart.gen/sources_1/ip/mig_ddr3/mig_ddr3/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_dqs_found_cal.v" \
"../../../../hdmi_ddr3_uart.gen/sources_1/ip/mig_ddr3/mig_ddr3/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_dqs_found_cal_hr.v" \
"../../../../hdmi_ddr3_uart.gen/sources_1/ip/mig_ddr3/mig_ddr3/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_init.v" \
"../../../../hdmi_ddr3_uart.gen/sources_1/ip/mig_ddr3/mig_ddr3/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_ocd_cntlr.v" \
"../../../../hdmi_ddr3_uart.gen/sources_1/ip/mig_ddr3/mig_ddr3/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_ocd_data.v" \
"../../../../hdmi_ddr3_uart.gen/sources_1/ip/mig_ddr3/mig_ddr3/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_ocd_edge.v" \
"../../../../hdmi_ddr3_uart.gen/sources_1/ip/mig_ddr3/mig_ddr3/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_ocd_lim.v" \
"../../../../hdmi_ddr3_uart.gen/sources_1/ip/mig_ddr3/mig_ddr3/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_ocd_mux.v" \
"../../../../hdmi_ddr3_uart.gen/sources_1/ip/mig_ddr3/mig_ddr3/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_ocd_po_cntlr.v" \
"../../../../hdmi_ddr3_uart.gen/sources_1/ip/mig_ddr3/mig_ddr3/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_ocd_samp.v" \
"../../../../hdmi_ddr3_uart.gen/sources_1/ip/mig_ddr3/mig_ddr3/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_oclkdelay_cal.v" \
"../../../../hdmi_ddr3_uart.gen/sources_1/ip/mig_ddr3/mig_ddr3/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_prbs_rdlvl.v" \
"../../../../hdmi_ddr3_uart.gen/sources_1/ip/mig_ddr3/mig_ddr3/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_rdlvl.v" \
"../../../../hdmi_ddr3_uart.gen/sources_1/ip/mig_ddr3/mig_ddr3/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_tempmon.v" \
"../../../../hdmi_ddr3_uart.gen/sources_1/ip/mig_ddr3/mig_ddr3/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_top.v" \
"../../../../hdmi_ddr3_uart.gen/sources_1/ip/mig_ddr3/mig_ddr3/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_wrcal.v" \
"../../../../hdmi_ddr3_uart.gen/sources_1/ip/mig_ddr3/mig_ddr3/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_wrlvl.v" \
"../../../../hdmi_ddr3_uart.gen/sources_1/ip/mig_ddr3/mig_ddr3/user_design/rtl/phy/mig_7series_v4_2_ddr_phy_wrlvl_off_delay.v" \
"../../../../hdmi_ddr3_uart.gen/sources_1/ip/mig_ddr3/mig_ddr3/user_design/rtl/phy/mig_7series_v4_2_ddr_prbs_gen.v" \
"../../../../hdmi_ddr3_uart.gen/sources_1/ip/mig_ddr3/mig_ddr3/user_design/rtl/phy/mig_7series_v4_2_ddr_skip_calib_tap.v" \
"../../../../hdmi_ddr3_uart.gen/sources_1/ip/mig_ddr3/mig_ddr3/user_design/rtl/phy/mig_7series_v4_2_poc_cc.v" \
"../../../../hdmi_ddr3_uart.gen/sources_1/ip/mig_ddr3/mig_ddr3/user_design/rtl/phy/mig_7series_v4_2_poc_edge_store.v" \
"../../../../hdmi_ddr3_uart.gen/sources_1/ip/mig_ddr3/mig_ddr3/user_design/rtl/phy/mig_7series_v4_2_poc_meta.v" \
"../../../../hdmi_ddr3_uart.gen/sources_1/ip/mig_ddr3/mig_ddr3/user_design/rtl/phy/mig_7series_v4_2_poc_pd.v" \
"../../../../hdmi_ddr3_uart.gen/sources_1/ip/mig_ddr3/mig_ddr3/user_design/rtl/phy/mig_7series_v4_2_poc_tap_base.v" \
"../../../../hdmi_ddr3_uart.gen/sources_1/ip/mig_ddr3/mig_ddr3/user_design/rtl/phy/mig_7series_v4_2_poc_top.v" \
"../../../../hdmi_ddr3_uart.gen/sources_1/ip/mig_ddr3/mig_ddr3/user_design/rtl/ui/mig_7series_v4_2_ui_cmd.v" \
"../../../../hdmi_ddr3_uart.gen/sources_1/ip/mig_ddr3/mig_ddr3/user_design/rtl/ui/mig_7series_v4_2_ui_rd_data.v" \
"../../../../hdmi_ddr3_uart.gen/sources_1/ip/mig_ddr3/mig_ddr3/user_design/rtl/ui/mig_7series_v4_2_ui_top.v" \
"../../../../hdmi_ddr3_uart.gen/sources_1/ip/mig_ddr3/mig_ddr3/user_design/rtl/ui/mig_7series_v4_2_ui_wr_data.v" \
"../../../../hdmi_ddr3_uart.gen/sources_1/ip/mig_ddr3/mig_ddr3/user_design/rtl/mig_ddr3_mig_sim.v" \
"../../../../hdmi_ddr3_uart.gen/sources_1/ip/mig_ddr3/mig_ddr3/user_design/rtl/mig_ddr3.v" \

vlog -work xil_defaultlib \
"glbl.v"

