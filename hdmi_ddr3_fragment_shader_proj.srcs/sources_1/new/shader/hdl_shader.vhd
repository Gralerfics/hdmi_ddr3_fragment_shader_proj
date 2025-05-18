library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.types.all;

entity shader is
    port (
        clock: in std_logic;
        reset: in std_logic;
        itime_us: in std_logic_vector(63 downto 0);
        frag_x: in std_logic_vector(11 downto 0);
        frag_y: in std_logic_vector(11 downto 0);
        frag_color: out std_logic_vector(23 downto 0);
        in_ready: out std_logic_vector(0 downto 0);
        in_valid: in std_logic_vector(0 downto 0);
        out_ready: in std_logic_vector(0 downto 0);
        out_valid: out std_logic_vector(0 downto 0)
    );
end entity;

architecture structural of shader is
    component Convert_UInt_64_SFixedPoint_36_12 is
        port (
            i: in std_logic_vector(63 downto 0);
            o: out std_logic_vector(48 downto 0)
        );
    end component;

    component Shift_Neg20_SFixedPoint_36_12 is
        port (
            i: in std_logic_vector(48 downto 0);
            o: out std_logic_vector(48 downto 0)
        );
    end component;

    component Convert_SFixedPoint_36_12_SFixedPoint_16_12 is
        port (
            i: in std_logic_vector(48 downto 0);
            o: out std_logic_vector(28 downto 0)
        );
    end component;

    component Convert_UInt_12_SFixedPoint_16_12 is
        port (
            i: in std_logic_vector(11 downto 0);
            o: out std_logic_vector(28 downto 0)
        );
    end component;

    component Shift_Neg9_SFixedPoint_16_12 is
        port (
            i: in std_logic_vector(28 downto 0);
            o: out std_logic_vector(28 downto 0)
        );
    end component;

    component Shift_Neg7_SFixedPoint_16_12 is
        port (
            i: in std_logic_vector(28 downto 0);
            o: out std_logic_vector(28 downto 0)
        );
    end component;

    component EqualTypesAdd_SFixedPoint_16_12_SFixedPoint_16_12 is
        port (
            a: in std_logic_vector(28 downto 0);
            b: in std_logic_vector(28 downto 0);
            r: out std_logic_vector(28 downto 0)
        );
    end component;

    component Constants_e3cfae0963b7234f_Core is
        port (
            o: out std_logic_vector(28 downto 0)
        );
    end component;

    component EqualTypesSubtract_SFixedPoint_16_12_SFixedPoint_16_12 is
        port (
            a: in std_logic_vector(28 downto 0);
            b: in std_logic_vector(28 downto 0);
            r: out std_logic_vector(28 downto 0)
        );
    end component;

    component Constants_31fa47991dc69fb6_Core is
        port (
            o: out std_logic_vector(28 downto 0)
        );
    end component;

    component Fract_SFixedPoint_16_12 is
        port (
            i: in std_logic_vector(28 downto 0);
            o: out std_logic_vector(28 downto 0)
        );
    end component;

    component Constants_99e998fd468424c7_Core is
        port (
            o: out std_logic_vector(28 downto 0)
        );
    end component;

    component Min_SFixedPoint_16_12 is
        port (
            a: in std_logic_vector(28 downto 0);
            b: in std_logic_vector(28 downto 0);
            o: out std_logic_vector(28 downto 0)
        );
    end component;

    component Ceil_SFixedPoint_16_12 is
        port (
            i: in std_logic_vector(28 downto 0);
            o: out std_logic_vector(28 downto 0)
        );
    end component;

    component Constants_ed453308e8a82f66_Core is
        port (
            o: out std_logic_vector(28 downto 0)
        );
    end component;

    component Multiply_SInt_29_SInt_29_AddendsGenerator is
        port (
            long: in std_logic_vector(28 downto 0);
            short: in std_logic_vector(28 downto 0);
            addend_0: out std_logic_vector(57 downto 0);
            addend_1: out std_logic_vector(57 downto 0);
            addend_2: out std_logic_vector(57 downto 0);
            addend_3: out std_logic_vector(57 downto 0);
            addend_4: out std_logic_vector(57 downto 0);
            addend_5: out std_logic_vector(57 downto 0);
            addend_6: out std_logic_vector(57 downto 0);
            addend_7: out std_logic_vector(57 downto 0);
            addend_8: out std_logic_vector(57 downto 0);
            addend_9: out std_logic_vector(57 downto 0);
            addend_10: out std_logic_vector(57 downto 0);
            addend_11: out std_logic_vector(57 downto 0);
            addend_12: out std_logic_vector(57 downto 0);
            addend_13: out std_logic_vector(57 downto 0);
            addend_14: out std_logic_vector(57 downto 0);
            addend_15: out std_logic_vector(57 downto 0);
            addend_16: out std_logic_vector(57 downto 0);
            addend_17: out std_logic_vector(57 downto 0);
            addend_18: out std_logic_vector(57 downto 0);
            addend_19: out std_logic_vector(57 downto 0);
            addend_20: out std_logic_vector(57 downto 0);
            addend_21: out std_logic_vector(57 downto 0);
            addend_22: out std_logic_vector(57 downto 0);
            addend_23: out std_logic_vector(57 downto 0);
            addend_24: out std_logic_vector(57 downto 0);
            addend_25: out std_logic_vector(57 downto 0);
            addend_26: out std_logic_vector(57 downto 0);
            addend_27: out std_logic_vector(57 downto 0);
            subend: out std_logic_vector(57 downto 0)
        );
    end component;

    component BitsAdd_SInt_58_SInt_58 is
        port (
            a: in std_logic_vector(57 downto 0);
            b: in std_logic_vector(57 downto 0);
            r: out std_logic_vector(57 downto 0)
        );
    end component;

    component BitsSubtract_SInt_58_SInt_58 is
        port (
            a: in std_logic_vector(57 downto 0);
            b: in std_logic_vector(57 downto 0);
            r: out std_logic_vector(57 downto 0)
        );
    end component;

    component Multiply_SFixedPoint_16_12_SFixedPoint_16_12_Truncated_Truncator is
        port (
            i: in std_logic_vector(57 downto 0);
            o: out std_logic_vector(28 downto 0)
        );
    end component;

    component Shift_Neg3_SFixedPoint_16_12 is
        port (
            i: in std_logic_vector(28 downto 0);
            o: out std_logic_vector(28 downto 0)
        );
    end component;

    component Shift_Neg1_SFixedPoint_16_12 is
        port (
            i: in std_logic_vector(28 downto 0);
            o: out std_logic_vector(28 downto 0)
        );
    end component;

    component Shift_Neg2_SFixedPoint_16_12 is
        port (
            i: in std_logic_vector(28 downto 0);
            o: out std_logic_vector(28 downto 0)
        );
    end component;

    component Shift_1_SFixedPoint_16_12 is
        port (
            i: in std_logic_vector(28 downto 0);
            o: out std_logic_vector(28 downto 0)
        );
    end component;

    component Shift_2_SFixedPoint_16_12 is
        port (
            i: in std_logic_vector(28 downto 0);
            o: out std_logic_vector(28 downto 0)
        );
    end component;

    component Slice_28 is
        port (
            i: in std_logic_vector(28 downto 0);
            o: out std_logic_vector(0 downto 0)
        );
    end component;

    component BinaryMultiplexer_SFixedPoint_16_12 is
        port (
            i0: in std_logic_vector(28 downto 0);
            i1: in std_logic_vector(28 downto 0);
            sel: in std_logic_vector(0 downto 0);
            o: out std_logic_vector(28 downto 0)
        );
    end component;

    component Constants_22096c00982b9179_Core is
        port (
            o: out std_logic_vector(28 downto 0)
        );
    end component;

    component Shift_4_SFixedPoint_16_12 is
        port (
            i: in std_logic_vector(28 downto 0);
            o: out std_logic_vector(28 downto 0)
        );
    end component;

    component Constants_de92917d4133a7ee_Core is
        port (
            o: out std_logic_vector(28 downto 0)
        );
    end component;

    component Max_SFixedPoint_16_12 is
        port (
            a: in std_logic_vector(28 downto 0);
            b: in std_logic_vector(28 downto 0);
            o: out std_logic_vector(28 downto 0)
        );
    end component;

    component Constants_13749133a7754138_Core is
        port (
            o: out std_logic_vector(28 downto 0)
        );
    end component;

    component Constants_6b991d5b30977123_Core is
        port (
            o: out std_logic_vector(28 downto 0)
        );
    end component;

    component Shift_8_SFixedPoint_16_12 is
        port (
            i: in std_logic_vector(28 downto 0);
            o: out std_logic_vector(28 downto 0)
        );
    end component;

    component Convert_SFixedPoint_16_12_UFixedPoint_8_0 is
        port (
            i: in std_logic_vector(28 downto 0);
            o: out std_logic_vector(7 downto 0)
        );
    end component;

    component Concatenate_UFixedPoint_8_0_UFixedPoint_8_0 is
        port (
            a: in std_logic_vector(7 downto 0);
            b: in std_logic_vector(7 downto 0);
            o: out std_logic_vector(15 downto 0)
        );
    end component;

    component Constants_e22224e03e3e720f_Core is
        port (
            o: out std_logic_vector(7 downto 0)
        );
    end component;

    component Concatenate_Bits_16_Bits_8 is
        port (
            a: in std_logic_vector(15 downto 0);
            b: in std_logic_vector(7 downto 0);
            o: out std_logic_vector(23 downto 0)
        );
    end component;

    signal to_sfixed_io_i: std_logic_vector(63 downto 0);
    signal to_sfixed_io_o: std_logic_vector(48 downto 0);
    signal shifter_io_i: std_logic_vector(48 downto 0);
    signal shifter_io_o: std_logic_vector(48 downto 0);
    signal to_sfixed_1_io_i: std_logic_vector(48 downto 0);
    signal to_sfixed_1_io_o: std_logic_vector(28 downto 0);
    signal to_sfixed_2_io_i: std_logic_vector(11 downto 0);
    signal to_sfixed_2_io_o: std_logic_vector(28 downto 0);
    signal to_sfixed_3_io_i: std_logic_vector(11 downto 0);
    signal to_sfixed_3_io_o: std_logic_vector(28 downto 0);
    signal shifter_1_io_i: std_logic_vector(28 downto 0);
    signal shifter_1_io_o: std_logic_vector(28 downto 0);
    signal shifter_2_io_i: std_logic_vector(28 downto 0);
    signal shifter_2_io_o: std_logic_vector(28 downto 0);
    signal adder_io_a: std_logic_vector(28 downto 0);
    signal adder_io_b: std_logic_vector(28 downto 0);
    signal adder_io_r: std_logic_vector(28 downto 0);
    signal constant_opt_io_o: std_logic_vector(28 downto 0);
    signal subtractor_io_a: std_logic_vector(28 downto 0);
    signal subtractor_io_b: std_logic_vector(28 downto 0);
    signal subtractor_io_r: std_logic_vector(28 downto 0);
    signal shifter_3_io_i: std_logic_vector(28 downto 0);
    signal shifter_3_io_o: std_logic_vector(28 downto 0);
    signal shifter_4_io_i: std_logic_vector(28 downto 0);
    signal shifter_4_io_o: std_logic_vector(28 downto 0);
    signal adder_1_io_a: std_logic_vector(28 downto 0);
    signal adder_1_io_b: std_logic_vector(28 downto 0);
    signal adder_1_io_r: std_logic_vector(28 downto 0);
    signal constant_1_opt_io_o: std_logic_vector(28 downto 0);
    signal subtractor_1_io_a: std_logic_vector(28 downto 0);
    signal subtractor_1_io_b: std_logic_vector(28 downto 0);
    signal subtractor_1_io_r: std_logic_vector(28 downto 0);
    signal subtractor_2_io_a: std_logic_vector(28 downto 0);
    signal subtractor_2_io_b: std_logic_vector(28 downto 0);
    signal subtractor_2_io_r: std_logic_vector(28 downto 0);
    signal constant_2_opt_io_o: std_logic_vector(28 downto 0);
    signal adder_2_io_a: std_logic_vector(28 downto 0);
    signal adder_2_io_b: std_logic_vector(28 downto 0);
    signal adder_2_io_r: std_logic_vector(28 downto 0);
    signal adder_3_io_a: std_logic_vector(28 downto 0);
    signal adder_3_io_b: std_logic_vector(28 downto 0);
    signal adder_3_io_r: std_logic_vector(28 downto 0);
    signal constant_3_opt_io_o: std_logic_vector(28 downto 0);
    signal adder_4_io_a: std_logic_vector(28 downto 0);
    signal adder_4_io_b: std_logic_vector(28 downto 0);
    signal adder_4_io_r: std_logic_vector(28 downto 0);
    signal fract_io_i: std_logic_vector(28 downto 0);
    signal fract_io_o: std_logic_vector(28 downto 0);
    signal fract_1_io_i: std_logic_vector(28 downto 0);
    signal fract_1_io_o: std_logic_vector(28 downto 0);
    signal constant_4_opt_io_o: std_logic_vector(28 downto 0);
    signal subtractor_3_io_a: std_logic_vector(28 downto 0);
    signal subtractor_3_io_b: std_logic_vector(28 downto 0);
    signal subtractor_3_io_r: std_logic_vector(28 downto 0);
    signal constant_5_opt_io_o: std_logic_vector(28 downto 0);
    signal subtractor_4_io_a: std_logic_vector(28 downto 0);
    signal subtractor_4_io_b: std_logic_vector(28 downto 0);
    signal subtractor_4_io_r: std_logic_vector(28 downto 0);
    signal min_io_a: std_logic_vector(28 downto 0);
    signal min_io_b: std_logic_vector(28 downto 0);
    signal min_io_o: std_logic_vector(28 downto 0);
    signal min_1_io_a: std_logic_vector(28 downto 0);
    signal min_1_io_b: std_logic_vector(28 downto 0);
    signal min_1_io_o: std_logic_vector(28 downto 0);
    signal ceil_io_i: std_logic_vector(28 downto 0);
    signal ceil_io_o: std_logic_vector(28 downto 0);
    signal ceil_1_io_i: std_logic_vector(28 downto 0);
    signal ceil_1_io_o: std_logic_vector(28 downto 0);
    signal constant_6_opt_io_o: std_logic_vector(28 downto 0);
    signal subtractor_5_io_a: std_logic_vector(28 downto 0);
    signal subtractor_5_io_b: std_logic_vector(28 downto 0);
    signal subtractor_5_io_r: std_logic_vector(28 downto 0);
    signal constant_7_opt_io_o: std_logic_vector(28 downto 0);
    signal subtractor_6_io_a: std_logic_vector(28 downto 0);
    signal subtractor_6_io_b: std_logic_vector(28 downto 0);
    signal subtractor_6_io_r: std_logic_vector(28 downto 0);
    signal multiplier_sint_mul_gen_addends_io_long: std_logic_vector(28 downto 0);
    signal multiplier_sint_mul_gen_addends_io_short: std_logic_vector(28 downto 0);
    signal multiplier_sint_mul_gen_addends_io_addend_0: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_gen_addends_io_addend_1: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_gen_addends_io_addend_2: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_gen_addends_io_addend_3: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_gen_addends_io_addend_4: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_gen_addends_io_addend_5: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_gen_addends_io_addend_6: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_gen_addends_io_addend_7: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_gen_addends_io_addend_8: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_gen_addends_io_addend_9: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_gen_addends_io_addend_10: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_gen_addends_io_addend_11: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_gen_addends_io_addend_12: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_gen_addends_io_addend_13: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_gen_addends_io_addend_14: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_gen_addends_io_addend_15: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_gen_addends_io_addend_16: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_gen_addends_io_addend_17: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_gen_addends_io_addend_18: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_gen_addends_io_addend_19: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_gen_addends_io_addend_20: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_gen_addends_io_addend_21: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_gen_addends_io_addend_22: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_gen_addends_io_addend_23: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_gen_addends_io_addend_24: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_gen_addends_io_addend_25: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_gen_addends_io_addend_26: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_gen_addends_io_addend_27: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_0_io_a: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_0_io_b: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_0_io_r: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_1_io_a: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_1_io_b: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_1_io_r: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_2_io_a: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_2_io_b: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_2_io_r: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_3_io_a: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_3_io_b: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_3_io_r: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_4_io_a: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_4_io_b: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_4_io_r: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_5_io_a: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_5_io_b: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_5_io_r: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_6_io_a: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_6_io_b: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_6_io_r: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_7_io_a: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_7_io_b: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_7_io_r: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_8_io_a: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_8_io_b: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_8_io_r: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_9_io_a: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_9_io_b: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_9_io_r: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_10_io_a: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_10_io_b: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_10_io_r: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_11_io_a: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_11_io_b: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_11_io_r: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_12_io_a: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_12_io_b: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_12_io_r: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_13_io_a: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_13_io_b: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_13_io_r: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_14_io_a: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_14_io_b: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_14_io_r: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_15_io_a: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_15_io_b: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_15_io_r: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_16_io_a: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_16_io_b: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_16_io_r: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_17_io_a: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_17_io_b: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_17_io_r: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_18_io_a: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_18_io_b: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_18_io_r: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_19_io_a: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_19_io_b: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_19_io_r: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_20_io_a: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_20_io_b: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_20_io_r: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_21_io_a: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_21_io_b: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_21_io_r: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_22_io_a: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_22_io_b: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_22_io_r: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_23_io_a: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_23_io_b: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_23_io_r: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_24_io_a: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_24_io_b: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_24_io_r: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_25_io_a: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_25_io_b: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_25_io_r: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_26_io_a: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_26_io_b: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_adder_26_io_r: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_subtractor_io_a: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_subtractor_io_b: std_logic_vector(57 downto 0);
    signal multiplier_sint_mul_subtractor_io_r: std_logic_vector(57 downto 0);
    signal multiplier_tc_io_i: std_logic_vector(57 downto 0);
    signal multiplier_tc_io_o: std_logic_vector(28 downto 0);
    signal multiplier_1_sint_mul_gen_addends_io_long: std_logic_vector(28 downto 0);
    signal multiplier_1_sint_mul_gen_addends_io_short: std_logic_vector(28 downto 0);
    signal multiplier_1_sint_mul_gen_addends_io_addend_0: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_gen_addends_io_addend_1: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_gen_addends_io_addend_2: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_gen_addends_io_addend_3: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_gen_addends_io_addend_4: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_gen_addends_io_addend_5: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_gen_addends_io_addend_6: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_gen_addends_io_addend_7: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_gen_addends_io_addend_8: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_gen_addends_io_addend_9: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_gen_addends_io_addend_10: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_gen_addends_io_addend_11: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_gen_addends_io_addend_12: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_gen_addends_io_addend_13: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_gen_addends_io_addend_14: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_gen_addends_io_addend_15: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_gen_addends_io_addend_16: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_gen_addends_io_addend_17: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_gen_addends_io_addend_18: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_gen_addends_io_addend_19: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_gen_addends_io_addend_20: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_gen_addends_io_addend_21: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_gen_addends_io_addend_22: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_gen_addends_io_addend_23: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_gen_addends_io_addend_24: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_gen_addends_io_addend_25: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_gen_addends_io_addend_26: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_gen_addends_io_addend_27: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_0_io_a: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_0_io_b: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_0_io_r: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_1_io_a: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_1_io_b: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_1_io_r: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_2_io_a: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_2_io_b: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_2_io_r: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_3_io_a: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_3_io_b: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_3_io_r: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_4_io_a: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_4_io_b: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_4_io_r: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_5_io_a: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_5_io_b: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_5_io_r: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_6_io_a: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_6_io_b: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_6_io_r: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_7_io_a: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_7_io_b: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_7_io_r: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_8_io_a: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_8_io_b: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_8_io_r: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_9_io_a: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_9_io_b: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_9_io_r: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_10_io_a: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_10_io_b: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_10_io_r: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_11_io_a: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_11_io_b: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_11_io_r: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_12_io_a: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_12_io_b: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_12_io_r: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_13_io_a: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_13_io_b: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_13_io_r: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_14_io_a: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_14_io_b: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_14_io_r: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_15_io_a: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_15_io_b: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_15_io_r: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_16_io_a: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_16_io_b: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_16_io_r: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_17_io_a: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_17_io_b: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_17_io_r: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_18_io_a: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_18_io_b: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_18_io_r: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_19_io_a: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_19_io_b: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_19_io_r: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_20_io_a: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_20_io_b: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_20_io_r: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_21_io_a: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_21_io_b: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_21_io_r: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_22_io_a: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_22_io_b: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_22_io_r: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_23_io_a: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_23_io_b: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_23_io_r: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_24_io_a: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_24_io_b: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_24_io_r: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_25_io_a: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_25_io_b: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_25_io_r: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_26_io_a: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_26_io_b: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_adder_26_io_r: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_subtractor_io_a: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_subtractor_io_b: std_logic_vector(57 downto 0);
    signal multiplier_1_sint_mul_subtractor_io_r: std_logic_vector(57 downto 0);
    signal multiplier_1_tc_io_i: std_logic_vector(57 downto 0);
    signal multiplier_1_tc_io_o: std_logic_vector(28 downto 0);
    signal adder_5_io_a: std_logic_vector(28 downto 0);
    signal adder_5_io_b: std_logic_vector(28 downto 0);
    signal adder_5_io_r: std_logic_vector(28 downto 0);
    signal shifter_5_io_i: std_logic_vector(28 downto 0);
    signal shifter_5_io_o: std_logic_vector(28 downto 0);
    signal constant_8_opt_io_o: std_logic_vector(28 downto 0);
    signal adder_6_io_a: std_logic_vector(28 downto 0);
    signal adder_6_io_b: std_logic_vector(28 downto 0);
    signal adder_6_io_r: std_logic_vector(28 downto 0);
    signal shifter_6_io_i: std_logic_vector(28 downto 0);
    signal shifter_6_io_o: std_logic_vector(28 downto 0);
    signal subtractor_7_io_a: std_logic_vector(28 downto 0);
    signal subtractor_7_io_b: std_logic_vector(28 downto 0);
    signal subtractor_7_io_r: std_logic_vector(28 downto 0);
    signal shifter_7_io_i: std_logic_vector(28 downto 0);
    signal shifter_7_io_o: std_logic_vector(28 downto 0);
    signal fract_2_io_i: std_logic_vector(28 downto 0);
    signal fract_2_io_o: std_logic_vector(28 downto 0);
    signal shifter_8_io_i: std_logic_vector(28 downto 0);
    signal shifter_8_io_o: std_logic_vector(28 downto 0);
    signal constant_9_opt_io_o: std_logic_vector(28 downto 0);
    signal subtractor_8_io_a: std_logic_vector(28 downto 0);
    signal subtractor_8_io_b: std_logic_vector(28 downto 0);
    signal subtractor_8_io_r: std_logic_vector(28 downto 0);
    signal min_2_io_a: std_logic_vector(28 downto 0);
    signal min_2_io_b: std_logic_vector(28 downto 0);
    signal min_2_io_o: std_logic_vector(28 downto 0);
    signal shifter_9_io_i: std_logic_vector(28 downto 0);
    signal shifter_9_io_o: std_logic_vector(28 downto 0);
    signal fract_3_io_i: std_logic_vector(28 downto 0);
    signal fract_3_io_o: std_logic_vector(28 downto 0);
    signal slicer_io_i: std_logic_vector(28 downto 0);
    signal slicer_io_o: std_logic_vector(0 downto 0);
    signal constant_10_opt_io_o: std_logic_vector(28 downto 0);
    signal subtractor_9_io_a: std_logic_vector(28 downto 0);
    signal subtractor_9_io_b: std_logic_vector(28 downto 0);
    signal subtractor_9_io_r: std_logic_vector(28 downto 0);
    signal mux_io_i0: std_logic_vector(28 downto 0);
    signal mux_io_i1: std_logic_vector(28 downto 0);
    signal mux_io_sel: std_logic_vector(0 downto 0);
    signal mux_io_o: std_logic_vector(28 downto 0);
    signal constant_11_opt_io_o: std_logic_vector(28 downto 0);
    signal multiplier_2_sint_mul_gen_addends_io_long: std_logic_vector(28 downto 0);
    signal multiplier_2_sint_mul_gen_addends_io_short: std_logic_vector(28 downto 0);
    signal multiplier_2_sint_mul_gen_addends_io_addend_0: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_gen_addends_io_addend_1: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_gen_addends_io_addend_2: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_gen_addends_io_addend_3: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_gen_addends_io_addend_4: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_gen_addends_io_addend_5: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_gen_addends_io_addend_6: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_gen_addends_io_addend_7: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_gen_addends_io_addend_8: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_gen_addends_io_addend_9: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_gen_addends_io_addend_10: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_gen_addends_io_addend_11: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_gen_addends_io_addend_12: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_gen_addends_io_addend_13: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_gen_addends_io_addend_14: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_gen_addends_io_addend_15: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_gen_addends_io_addend_16: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_gen_addends_io_addend_17: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_gen_addends_io_addend_18: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_gen_addends_io_addend_19: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_gen_addends_io_addend_20: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_gen_addends_io_addend_21: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_gen_addends_io_addend_22: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_gen_addends_io_addend_23: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_gen_addends_io_addend_24: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_gen_addends_io_addend_25: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_gen_addends_io_addend_26: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_gen_addends_io_addend_27: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_0_io_a: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_0_io_b: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_0_io_r: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_1_io_a: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_1_io_b: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_1_io_r: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_2_io_a: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_2_io_b: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_2_io_r: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_3_io_a: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_3_io_b: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_3_io_r: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_4_io_a: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_4_io_b: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_4_io_r: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_5_io_a: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_5_io_b: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_5_io_r: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_6_io_a: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_6_io_b: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_6_io_r: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_7_io_a: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_7_io_b: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_7_io_r: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_8_io_a: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_8_io_b: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_8_io_r: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_9_io_a: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_9_io_b: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_9_io_r: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_10_io_a: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_10_io_b: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_10_io_r: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_11_io_a: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_11_io_b: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_11_io_r: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_12_io_a: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_12_io_b: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_12_io_r: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_13_io_a: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_13_io_b: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_13_io_r: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_14_io_a: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_14_io_b: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_14_io_r: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_15_io_a: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_15_io_b: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_15_io_r: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_16_io_a: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_16_io_b: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_16_io_r: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_17_io_a: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_17_io_b: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_17_io_r: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_18_io_a: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_18_io_b: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_18_io_r: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_19_io_a: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_19_io_b: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_19_io_r: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_20_io_a: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_20_io_b: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_20_io_r: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_21_io_a: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_21_io_b: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_21_io_r: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_22_io_a: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_22_io_b: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_22_io_r: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_23_io_a: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_23_io_b: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_23_io_r: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_24_io_a: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_24_io_b: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_24_io_r: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_25_io_a: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_25_io_b: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_25_io_r: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_26_io_a: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_26_io_b: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_adder_26_io_r: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_subtractor_io_a: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_subtractor_io_b: std_logic_vector(57 downto 0);
    signal multiplier_2_sint_mul_subtractor_io_r: std_logic_vector(57 downto 0);
    signal multiplier_2_tc_io_i: std_logic_vector(57 downto 0);
    signal multiplier_2_tc_io_o: std_logic_vector(28 downto 0);
    signal multiplier_3_sint_mul_gen_addends_io_long: std_logic_vector(28 downto 0);
    signal multiplier_3_sint_mul_gen_addends_io_short: std_logic_vector(28 downto 0);
    signal multiplier_3_sint_mul_gen_addends_io_addend_0: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_gen_addends_io_addend_1: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_gen_addends_io_addend_2: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_gen_addends_io_addend_3: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_gen_addends_io_addend_4: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_gen_addends_io_addend_5: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_gen_addends_io_addend_6: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_gen_addends_io_addend_7: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_gen_addends_io_addend_8: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_gen_addends_io_addend_9: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_gen_addends_io_addend_10: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_gen_addends_io_addend_11: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_gen_addends_io_addend_12: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_gen_addends_io_addend_13: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_gen_addends_io_addend_14: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_gen_addends_io_addend_15: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_gen_addends_io_addend_16: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_gen_addends_io_addend_17: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_gen_addends_io_addend_18: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_gen_addends_io_addend_19: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_gen_addends_io_addend_20: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_gen_addends_io_addend_21: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_gen_addends_io_addend_22: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_gen_addends_io_addend_23: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_gen_addends_io_addend_24: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_gen_addends_io_addend_25: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_gen_addends_io_addend_26: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_gen_addends_io_addend_27: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_0_io_a: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_0_io_b: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_0_io_r: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_1_io_a: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_1_io_b: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_1_io_r: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_2_io_a: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_2_io_b: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_2_io_r: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_3_io_a: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_3_io_b: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_3_io_r: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_4_io_a: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_4_io_b: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_4_io_r: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_5_io_a: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_5_io_b: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_5_io_r: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_6_io_a: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_6_io_b: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_6_io_r: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_7_io_a: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_7_io_b: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_7_io_r: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_8_io_a: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_8_io_b: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_8_io_r: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_9_io_a: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_9_io_b: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_9_io_r: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_10_io_a: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_10_io_b: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_10_io_r: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_11_io_a: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_11_io_b: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_11_io_r: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_12_io_a: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_12_io_b: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_12_io_r: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_13_io_a: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_13_io_b: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_13_io_r: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_14_io_a: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_14_io_b: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_14_io_r: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_15_io_a: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_15_io_b: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_15_io_r: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_16_io_a: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_16_io_b: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_16_io_r: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_17_io_a: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_17_io_b: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_17_io_r: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_18_io_a: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_18_io_b: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_18_io_r: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_19_io_a: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_19_io_b: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_19_io_r: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_20_io_a: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_20_io_b: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_20_io_r: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_21_io_a: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_21_io_b: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_21_io_r: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_22_io_a: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_22_io_b: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_22_io_r: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_23_io_a: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_23_io_b: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_23_io_r: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_24_io_a: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_24_io_b: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_24_io_r: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_25_io_a: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_25_io_b: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_25_io_r: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_26_io_a: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_26_io_b: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_adder_26_io_r: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_subtractor_io_a: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_subtractor_io_b: std_logic_vector(57 downto 0);
    signal multiplier_3_sint_mul_subtractor_io_r: std_logic_vector(57 downto 0);
    signal multiplier_3_tc_io_i: std_logic_vector(57 downto 0);
    signal multiplier_3_tc_io_o: std_logic_vector(28 downto 0);
    signal subtractor_10_io_a: std_logic_vector(28 downto 0);
    signal subtractor_10_io_b: std_logic_vector(28 downto 0);
    signal subtractor_10_io_r: std_logic_vector(28 downto 0);
    signal shifter_10_io_i: std_logic_vector(28 downto 0);
    signal shifter_10_io_o: std_logic_vector(28 downto 0);
    signal shifter_11_io_i: std_logic_vector(28 downto 0);
    signal shifter_11_io_o: std_logic_vector(28 downto 0);
    signal adder_7_io_a: std_logic_vector(28 downto 0);
    signal adder_7_io_b: std_logic_vector(28 downto 0);
    signal adder_7_io_r: std_logic_vector(28 downto 0);
    signal constant_12_opt_io_o: std_logic_vector(28 downto 0);
    signal adder_8_io_a: std_logic_vector(28 downto 0);
    signal adder_8_io_b: std_logic_vector(28 downto 0);
    signal adder_8_io_r: std_logic_vector(28 downto 0);
    signal constant_13_opt_io_o: std_logic_vector(28 downto 0);
    signal max_io_a: std_logic_vector(28 downto 0);
    signal max_io_b: std_logic_vector(28 downto 0);
    signal max_io_o: std_logic_vector(28 downto 0);
    signal constant_14_opt_io_o: std_logic_vector(28 downto 0);
    signal min_3_io_a: std_logic_vector(28 downto 0);
    signal min_3_io_b: std_logic_vector(28 downto 0);
    signal min_3_io_o: std_logic_vector(28 downto 0);
    signal constant_15_opt_io_o: std_logic_vector(28 downto 0);
    signal multiplier_4_sint_mul_gen_addends_io_long: std_logic_vector(28 downto 0);
    signal multiplier_4_sint_mul_gen_addends_io_short: std_logic_vector(28 downto 0);
    signal multiplier_4_sint_mul_gen_addends_io_addend_0: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_gen_addends_io_addend_1: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_gen_addends_io_addend_2: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_gen_addends_io_addend_3: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_gen_addends_io_addend_4: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_gen_addends_io_addend_5: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_gen_addends_io_addend_6: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_gen_addends_io_addend_7: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_gen_addends_io_addend_8: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_gen_addends_io_addend_9: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_gen_addends_io_addend_10: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_gen_addends_io_addend_11: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_gen_addends_io_addend_12: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_gen_addends_io_addend_13: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_gen_addends_io_addend_14: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_gen_addends_io_addend_15: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_gen_addends_io_addend_16: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_gen_addends_io_addend_17: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_gen_addends_io_addend_18: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_gen_addends_io_addend_19: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_gen_addends_io_addend_20: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_gen_addends_io_addend_21: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_gen_addends_io_addend_22: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_gen_addends_io_addend_23: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_gen_addends_io_addend_24: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_gen_addends_io_addend_25: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_gen_addends_io_addend_26: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_gen_addends_io_addend_27: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_0_io_a: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_0_io_b: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_0_io_r: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_1_io_a: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_1_io_b: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_1_io_r: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_2_io_a: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_2_io_b: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_2_io_r: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_3_io_a: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_3_io_b: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_3_io_r: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_4_io_a: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_4_io_b: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_4_io_r: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_5_io_a: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_5_io_b: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_5_io_r: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_6_io_a: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_6_io_b: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_6_io_r: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_7_io_a: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_7_io_b: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_7_io_r: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_8_io_a: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_8_io_b: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_8_io_r: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_9_io_a: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_9_io_b: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_9_io_r: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_10_io_a: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_10_io_b: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_10_io_r: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_11_io_a: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_11_io_b: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_11_io_r: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_12_io_a: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_12_io_b: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_12_io_r: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_13_io_a: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_13_io_b: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_13_io_r: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_14_io_a: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_14_io_b: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_14_io_r: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_15_io_a: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_15_io_b: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_15_io_r: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_16_io_a: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_16_io_b: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_16_io_r: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_17_io_a: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_17_io_b: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_17_io_r: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_18_io_a: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_18_io_b: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_18_io_r: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_19_io_a: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_19_io_b: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_19_io_r: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_20_io_a: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_20_io_b: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_20_io_r: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_21_io_a: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_21_io_b: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_21_io_r: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_22_io_a: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_22_io_b: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_22_io_r: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_23_io_a: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_23_io_b: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_23_io_r: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_24_io_a: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_24_io_b: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_24_io_r: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_25_io_a: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_25_io_b: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_25_io_r: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_26_io_a: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_26_io_b: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_adder_26_io_r: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_subtractor_io_a: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_subtractor_io_b: std_logic_vector(57 downto 0);
    signal multiplier_4_sint_mul_subtractor_io_r: std_logic_vector(57 downto 0);
    signal multiplier_4_tc_io_i: std_logic_vector(57 downto 0);
    signal multiplier_4_tc_io_o: std_logic_vector(28 downto 0);
    signal adder_9_io_a: std_logic_vector(28 downto 0);
    signal adder_9_io_b: std_logic_vector(28 downto 0);
    signal adder_9_io_r: std_logic_vector(28 downto 0);
    signal shifter_12_io_i: std_logic_vector(28 downto 0);
    signal shifter_12_io_o: std_logic_vector(28 downto 0);
    signal constant_16_opt_io_o: std_logic_vector(28 downto 0);
    signal subtractor_11_io_a: std_logic_vector(28 downto 0);
    signal subtractor_11_io_b: std_logic_vector(28 downto 0);
    signal subtractor_11_io_r: std_logic_vector(28 downto 0);
    signal shifter_13_io_i: std_logic_vector(28 downto 0);
    signal shifter_13_io_o: std_logic_vector(28 downto 0);
    signal constant_17_opt_io_o: std_logic_vector(28 downto 0);
    signal subtractor_12_io_a: std_logic_vector(28 downto 0);
    signal subtractor_12_io_b: std_logic_vector(28 downto 0);
    signal subtractor_12_io_r: std_logic_vector(28 downto 0);
    signal constant_18_opt_io_o: std_logic_vector(28 downto 0);
    signal max_1_io_a: std_logic_vector(28 downto 0);
    signal max_1_io_b: std_logic_vector(28 downto 0);
    signal max_1_io_o: std_logic_vector(28 downto 0);
    signal constant_19_opt_io_o: std_logic_vector(28 downto 0);
    signal max_2_io_a: std_logic_vector(28 downto 0);
    signal max_2_io_b: std_logic_vector(28 downto 0);
    signal max_2_io_o: std_logic_vector(28 downto 0);
    signal constant_20_opt_io_o: std_logic_vector(28 downto 0);
    signal min_4_io_a: std_logic_vector(28 downto 0);
    signal min_4_io_b: std_logic_vector(28 downto 0);
    signal min_4_io_o: std_logic_vector(28 downto 0);
    signal constant_21_opt_io_o: std_logic_vector(28 downto 0);
    signal min_5_io_a: std_logic_vector(28 downto 0);
    signal min_5_io_b: std_logic_vector(28 downto 0);
    signal min_5_io_o: std_logic_vector(28 downto 0);
    signal shifter_14_io_i: std_logic_vector(28 downto 0);
    signal shifter_14_io_o: std_logic_vector(28 downto 0);
    signal to_sfixed_4_io_i: std_logic_vector(28 downto 0);
    signal to_sfixed_4_io_o: std_logic_vector(7 downto 0);
    signal shifter_15_io_i: std_logic_vector(28 downto 0);
    signal shifter_15_io_o: std_logic_vector(28 downto 0);
    signal to_sfixed_5_io_i: std_logic_vector(28 downto 0);
    signal to_sfixed_5_io_o: std_logic_vector(7 downto 0);
    signal concatenator_io_a: std_logic_vector(7 downto 0);
    signal concatenator_io_b: std_logic_vector(7 downto 0);
    signal concatenator_io_o: std_logic_vector(15 downto 0);
    signal constant_22_opt_io_o: std_logic_vector(7 downto 0);
    signal concatenator_1_io_a: std_logic_vector(15 downto 0);
    signal concatenator_1_io_b: std_logic_vector(7 downto 0);
    signal concatenator_1_io_o: std_logic_vector(23 downto 0);
    signal reg_next_0_d_to_sfixed_1_io_o: std_logic_vector(28 downto 0);
    signal reg_0_d_to_sfixed_1_io_o: std_logic_vector(28 downto 0);
    signal reg_next_1_d_to_sfixed_1_io_o: std_logic_vector(28 downto 0);
    signal reg_1_d_to_sfixed_1_io_o: std_logic_vector(28 downto 0);
    signal reg_next_2_d_to_sfixed_1_io_o: std_logic_vector(28 downto 0);
    signal reg_2_d_to_sfixed_1_io_o: std_logic_vector(28 downto 0);
    signal reg_next_3_d_to_sfixed_1_io_o: std_logic_vector(28 downto 0);
    signal reg_3_d_to_sfixed_1_io_o: std_logic_vector(28 downto 0);
    signal reg_next_4_d_to_sfixed_1_io_o: std_logic_vector(28 downto 0);
    signal reg_4_d_to_sfixed_1_io_o: std_logic_vector(28 downto 0);
    signal reg_next_5_d_to_sfixed_1_io_o: std_logic_vector(28 downto 0);
    signal reg_5_d_to_sfixed_1_io_o: std_logic_vector(28 downto 0);
    signal reg_next_6_d_to_sfixed_1_io_o: std_logic_vector(28 downto 0);
    signal reg_6_d_to_sfixed_1_io_o: std_logic_vector(28 downto 0);
    signal reg_next_7_d_to_sfixed_1_io_o: std_logic_vector(28 downto 0);
    signal reg_7_d_to_sfixed_1_io_o: std_logic_vector(28 downto 0);
    signal reg_next_8_d_to_sfixed_1_io_o: std_logic_vector(28 downto 0);
    signal reg_8_d_to_sfixed_1_io_o: std_logic_vector(28 downto 0);
    signal reg_next_9_d_to_sfixed_1_io_o: std_logic_vector(28 downto 0);
    signal reg_9_d_to_sfixed_1_io_o: std_logic_vector(28 downto 0);
    signal reg_next_10_d_to_sfixed_1_io_o: std_logic_vector(28 downto 0);
    signal reg_10_d_to_sfixed_1_io_o: std_logic_vector(28 downto 0);
    signal reg_next_0_d_adder_io_r: std_logic_vector(28 downto 0);
    signal reg_0_d_adder_io_r: std_logic_vector(28 downto 0);
    signal reg_next_0_d_constant_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_0_d_constant_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_0_d_subtractor_io_r: std_logic_vector(28 downto 0);
    signal reg_0_d_subtractor_io_r: std_logic_vector(28 downto 0);
    signal reg_next_0_d_adder_1_io_r: std_logic_vector(28 downto 0);
    signal reg_0_d_adder_1_io_r: std_logic_vector(28 downto 0);
    signal reg_next_0_d_constant_1_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_0_d_constant_1_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_0_d_subtractor_1_io_r: std_logic_vector(28 downto 0);
    signal reg_0_d_subtractor_1_io_r: std_logic_vector(28 downto 0);
    signal reg_next_0_d_subtractor_2_io_r: std_logic_vector(28 downto 0);
    signal reg_0_d_subtractor_2_io_r: std_logic_vector(28 downto 0);
    signal reg_next_0_d_constant_2_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_0_d_constant_2_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_1_d_constant_2_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_1_d_constant_2_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_2_d_constant_2_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_2_d_constant_2_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_0_l_ceil_io_i: std_logic_vector(28 downto 0);
    signal reg_0_l_ceil_io_i: std_logic_vector(28 downto 0);
    signal reg_next_0_d_adder_3_io_r: std_logic_vector(28 downto 0);
    signal reg_0_d_adder_3_io_r: std_logic_vector(28 downto 0);
    signal reg_next_0_d_constant_3_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_0_d_constant_3_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_1_d_constant_3_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_1_d_constant_3_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_2_d_constant_3_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_2_d_constant_3_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_0_l_ceil_1_io_i: std_logic_vector(28 downto 0);
    signal reg_0_l_ceil_1_io_i: std_logic_vector(28 downto 0);
    signal reg_next_0_d_fract_io_o: std_logic_vector(28 downto 0);
    signal reg_0_d_fract_io_o: std_logic_vector(28 downto 0);
    signal reg_next_0_l_min_io_a: std_logic_vector(28 downto 0);
    signal reg_0_l_min_io_a: std_logic_vector(28 downto 0);
    signal reg_next_0_d_fract_1_io_o: std_logic_vector(28 downto 0);
    signal reg_0_d_fract_1_io_o: std_logic_vector(28 downto 0);
    signal reg_next_0_l_min_1_io_a: std_logic_vector(28 downto 0);
    signal reg_0_l_min_1_io_a: std_logic_vector(28 downto 0);
    signal reg_next_0_d_constant_4_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_0_d_constant_4_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_1_d_constant_4_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_1_d_constant_4_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_2_d_constant_4_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_2_d_constant_4_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_3_d_constant_4_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_3_d_constant_4_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_0_d_subtractor_3_io_r: std_logic_vector(28 downto 0);
    signal reg_0_d_subtractor_3_io_r: std_logic_vector(28 downto 0);
    signal reg_next_0_d_constant_5_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_0_d_constant_5_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_1_d_constant_5_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_1_d_constant_5_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_2_d_constant_5_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_2_d_constant_5_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_3_d_constant_5_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_3_d_constant_5_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_0_d_subtractor_4_io_r: std_logic_vector(28 downto 0);
    signal reg_0_d_subtractor_4_io_r: std_logic_vector(28 downto 0);
    signal reg_next_0_d_min_io_o: std_logic_vector(28 downto 0);
    signal reg_0_d_min_io_o: std_logic_vector(28 downto 0);
    signal reg_next_0_d_min_1_io_o: std_logic_vector(28 downto 0);
    signal reg_0_d_min_1_io_o: std_logic_vector(28 downto 0);
    signal reg_next_0_d_ceil_io_o: std_logic_vector(28 downto 0);
    signal reg_0_d_ceil_io_o: std_logic_vector(28 downto 0);
    signal reg_next_0_d_ceil_1_io_o: std_logic_vector(28 downto 0);
    signal reg_0_d_ceil_1_io_o: std_logic_vector(28 downto 0);
    signal reg_next_0_d_constant_6_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_0_d_constant_6_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_1_d_constant_6_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_1_d_constant_6_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_2_d_constant_6_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_2_d_constant_6_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_3_d_constant_6_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_3_d_constant_6_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_4_d_constant_6_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_4_d_constant_6_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_0_d_constant_7_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_0_d_constant_7_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_1_d_constant_7_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_1_d_constant_7_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_2_d_constant_7_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_2_d_constant_7_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_3_d_constant_7_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_3_d_constant_7_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_4_d_constant_7_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_4_d_constant_7_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_0_d_multiplier_sint_mul_gen_addends_io_addend_12: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_sint_mul_gen_addends_io_addend_12: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_sint_mul_gen_addends_io_addend_13: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_sint_mul_gen_addends_io_addend_13: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_sint_mul_gen_addends_io_addend_14: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_sint_mul_gen_addends_io_addend_14: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_sint_mul_gen_addends_io_addend_15: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_sint_mul_gen_addends_io_addend_15: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_sint_mul_gen_addends_io_addend_16: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_sint_mul_gen_addends_io_addend_16: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_sint_mul_gen_addends_io_addend_17: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_sint_mul_gen_addends_io_addend_17: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_sint_mul_gen_addends_io_addend_18: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_sint_mul_gen_addends_io_addend_18: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_sint_mul_gen_addends_io_addend_19: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_sint_mul_gen_addends_io_addend_19: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_sint_mul_gen_addends_io_addend_20: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_sint_mul_gen_addends_io_addend_20: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_sint_mul_gen_addends_io_addend_21: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_sint_mul_gen_addends_io_addend_21: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_sint_mul_gen_addends_io_addend_22: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_sint_mul_gen_addends_io_addend_22: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_sint_mul_gen_addends_io_addend_23: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_sint_mul_gen_addends_io_addend_23: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_sint_mul_gen_addends_io_addend_24: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_sint_mul_gen_addends_io_addend_24: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_sint_mul_gen_addends_io_addend_25: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_sint_mul_gen_addends_io_addend_25: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_sint_mul_gen_addends_io_addend_26: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_sint_mul_gen_addends_io_addend_26: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_sint_mul_gen_addends_io_addend_27: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_sint_mul_gen_addends_io_addend_27: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal reg_next_1_d_multiplier_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal reg_1_d_multiplier_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal reg_next_2_d_multiplier_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal reg_2_d_multiplier_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal reg_next_3_d_multiplier_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal reg_3_d_multiplier_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_sint_mul_adder_6_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_sint_mul_adder_6_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_sint_mul_adder_7_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_sint_mul_adder_7_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_sint_mul_adder_8_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_sint_mul_adder_8_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_sint_mul_adder_9_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_sint_mul_adder_9_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_sint_mul_adder_16_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_sint_mul_adder_16_io_r: std_logic_vector(57 downto 0);
    signal reg_next_1_d_multiplier_sint_mul_adder_16_io_r: std_logic_vector(57 downto 0);
    signal reg_1_d_multiplier_sint_mul_adder_16_io_r: std_logic_vector(57 downto 0);
    signal reg_next_2_d_multiplier_sint_mul_adder_16_io_r: std_logic_vector(57 downto 0);
    signal reg_2_d_multiplier_sint_mul_adder_16_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_sint_mul_adder_17_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_sint_mul_adder_17_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_sint_mul_adder_18_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_sint_mul_adder_18_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_sint_mul_adder_19_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_sint_mul_adder_19_io_r: std_logic_vector(57 downto 0);
    signal reg_next_1_d_multiplier_sint_mul_adder_19_io_r: std_logic_vector(57 downto 0);
    signal reg_1_d_multiplier_sint_mul_adder_19_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_sint_mul_adder_20_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_sint_mul_adder_20_io_r: std_logic_vector(57 downto 0);
    signal reg_next_1_d_multiplier_sint_mul_adder_20_io_r: std_logic_vector(57 downto 0);
    signal reg_1_d_multiplier_sint_mul_adder_20_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_sint_mul_adder_21_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_sint_mul_adder_21_io_r: std_logic_vector(57 downto 0);
    signal reg_next_1_d_multiplier_sint_mul_adder_21_io_r: std_logic_vector(57 downto 0);
    signal reg_1_d_multiplier_sint_mul_adder_21_io_r: std_logic_vector(57 downto 0);
    signal reg_next_2_d_multiplier_sint_mul_adder_21_io_r: std_logic_vector(57 downto 0);
    signal reg_2_d_multiplier_sint_mul_adder_21_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_sint_mul_adder_24_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_sint_mul_adder_24_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_sint_mul_adder_25_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_sint_mul_adder_25_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_tc_io_o: std_logic_vector(28 downto 0);
    signal reg_0_d_multiplier_tc_io_o: std_logic_vector(28 downto 0);
    signal reg_next_0_d_multiplier_1_sint_mul_gen_addends_io_addend_12: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_1_sint_mul_gen_addends_io_addend_12: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_1_sint_mul_gen_addends_io_addend_13: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_1_sint_mul_gen_addends_io_addend_13: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_1_sint_mul_gen_addends_io_addend_14: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_1_sint_mul_gen_addends_io_addend_14: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_1_sint_mul_gen_addends_io_addend_15: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_1_sint_mul_gen_addends_io_addend_15: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_1_sint_mul_gen_addends_io_addend_16: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_1_sint_mul_gen_addends_io_addend_16: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_1_sint_mul_gen_addends_io_addend_17: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_1_sint_mul_gen_addends_io_addend_17: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_1_sint_mul_gen_addends_io_addend_18: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_1_sint_mul_gen_addends_io_addend_18: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_1_sint_mul_gen_addends_io_addend_19: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_1_sint_mul_gen_addends_io_addend_19: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_1_sint_mul_gen_addends_io_addend_20: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_1_sint_mul_gen_addends_io_addend_20: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_1_sint_mul_gen_addends_io_addend_21: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_1_sint_mul_gen_addends_io_addend_21: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_1_sint_mul_gen_addends_io_addend_22: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_1_sint_mul_gen_addends_io_addend_22: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_1_sint_mul_gen_addends_io_addend_23: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_1_sint_mul_gen_addends_io_addend_23: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_1_sint_mul_gen_addends_io_addend_24: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_1_sint_mul_gen_addends_io_addend_24: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_1_sint_mul_gen_addends_io_addend_25: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_1_sint_mul_gen_addends_io_addend_25: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_1_sint_mul_gen_addends_io_addend_26: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_1_sint_mul_gen_addends_io_addend_26: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_1_sint_mul_gen_addends_io_addend_27: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_1_sint_mul_gen_addends_io_addend_27: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_1_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_1_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal reg_next_1_d_multiplier_1_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal reg_1_d_multiplier_1_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal reg_next_2_d_multiplier_1_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal reg_2_d_multiplier_1_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal reg_next_3_d_multiplier_1_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal reg_3_d_multiplier_1_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_1_sint_mul_adder_6_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_1_sint_mul_adder_6_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_1_sint_mul_adder_7_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_1_sint_mul_adder_7_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_1_sint_mul_adder_8_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_1_sint_mul_adder_8_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_1_sint_mul_adder_9_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_1_sint_mul_adder_9_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_1_sint_mul_adder_16_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_1_sint_mul_adder_16_io_r: std_logic_vector(57 downto 0);
    signal reg_next_1_d_multiplier_1_sint_mul_adder_16_io_r: std_logic_vector(57 downto 0);
    signal reg_1_d_multiplier_1_sint_mul_adder_16_io_r: std_logic_vector(57 downto 0);
    signal reg_next_2_d_multiplier_1_sint_mul_adder_16_io_r: std_logic_vector(57 downto 0);
    signal reg_2_d_multiplier_1_sint_mul_adder_16_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_1_sint_mul_adder_17_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_1_sint_mul_adder_17_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_1_sint_mul_adder_18_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_1_sint_mul_adder_18_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_1_sint_mul_adder_19_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_1_sint_mul_adder_19_io_r: std_logic_vector(57 downto 0);
    signal reg_next_1_d_multiplier_1_sint_mul_adder_19_io_r: std_logic_vector(57 downto 0);
    signal reg_1_d_multiplier_1_sint_mul_adder_19_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_1_sint_mul_adder_20_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_1_sint_mul_adder_20_io_r: std_logic_vector(57 downto 0);
    signal reg_next_1_d_multiplier_1_sint_mul_adder_20_io_r: std_logic_vector(57 downto 0);
    signal reg_1_d_multiplier_1_sint_mul_adder_20_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_1_sint_mul_adder_21_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_1_sint_mul_adder_21_io_r: std_logic_vector(57 downto 0);
    signal reg_next_1_d_multiplier_1_sint_mul_adder_21_io_r: std_logic_vector(57 downto 0);
    signal reg_1_d_multiplier_1_sint_mul_adder_21_io_r: std_logic_vector(57 downto 0);
    signal reg_next_2_d_multiplier_1_sint_mul_adder_21_io_r: std_logic_vector(57 downto 0);
    signal reg_2_d_multiplier_1_sint_mul_adder_21_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_1_sint_mul_adder_24_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_1_sint_mul_adder_24_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_1_sint_mul_adder_25_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_1_sint_mul_adder_25_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_1_tc_io_o: std_logic_vector(28 downto 0);
    signal reg_0_d_multiplier_1_tc_io_o: std_logic_vector(28 downto 0);
    signal reg_next_0_d_shifter_5_io_o: std_logic_vector(28 downto 0);
    signal reg_0_d_shifter_5_io_o: std_logic_vector(28 downto 0);
    signal reg_next_0_d_constant_8_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_0_d_constant_8_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_1_d_constant_8_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_1_d_constant_8_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_2_d_constant_8_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_2_d_constant_8_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_3_d_constant_8_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_3_d_constant_8_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_4_d_constant_8_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_4_d_constant_8_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_5_d_constant_8_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_5_d_constant_8_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_6_d_constant_8_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_6_d_constant_8_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_7_d_constant_8_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_7_d_constant_8_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_8_d_constant_8_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_8_d_constant_8_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_9_d_constant_8_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_9_d_constant_8_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_10_d_constant_8_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_10_d_constant_8_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_0_d_constant_9_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_0_d_constant_9_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_1_d_constant_9_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_1_d_constant_9_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_2_d_constant_9_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_2_d_constant_9_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_3_d_constant_9_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_3_d_constant_9_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_4_d_constant_9_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_4_d_constant_9_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_5_d_constant_9_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_5_d_constant_9_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_6_d_constant_9_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_6_d_constant_9_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_7_d_constant_9_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_7_d_constant_9_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_8_d_constant_9_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_8_d_constant_9_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_9_d_constant_9_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_9_d_constant_9_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_10_d_constant_9_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_10_d_constant_9_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_0_l_multiplier_3_sint_mul_gen_addends_io_long: std_logic_vector(28 downto 0);
    signal reg_0_l_multiplier_3_sint_mul_gen_addends_io_long: std_logic_vector(28 downto 0);
    signal reg_next_0_l_multiplier_3_sint_mul_gen_addends_io_short: std_logic_vector(28 downto 0);
    signal reg_0_l_multiplier_3_sint_mul_gen_addends_io_short: std_logic_vector(28 downto 0);
    signal reg_next_0_d_fract_3_io_o: std_logic_vector(28 downto 0);
    signal reg_0_d_fract_3_io_o: std_logic_vector(28 downto 0);
    signal reg_next_0_l_mux_io_i1: std_logic_vector(28 downto 0);
    signal reg_0_l_mux_io_i1: std_logic_vector(28 downto 0);
    signal reg_next_1_l_mux_io_i1: std_logic_vector(28 downto 0);
    signal reg_1_l_mux_io_i1: std_logic_vector(28 downto 0);
    signal reg_next_2_l_mux_io_i1: std_logic_vector(28 downto 0);
    signal reg_2_l_mux_io_i1: std_logic_vector(28 downto 0);
    signal reg_next_3_l_mux_io_i1: std_logic_vector(28 downto 0);
    signal reg_3_l_mux_io_i1: std_logic_vector(28 downto 0);
    signal reg_next_4_l_mux_io_i1: std_logic_vector(28 downto 0);
    signal reg_4_l_mux_io_i1: std_logic_vector(28 downto 0);
    signal reg_next_0_d_slicer_io_o: std_logic_vector(0 downto 0);
    signal reg_0_d_slicer_io_o: std_logic_vector(0 downto 0);
    signal reg_next_0_d_constant_10_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_0_d_constant_10_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_1_d_constant_10_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_1_d_constant_10_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_2_d_constant_10_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_2_d_constant_10_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_3_d_constant_10_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_3_d_constant_10_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_4_d_constant_10_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_4_d_constant_10_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_5_d_constant_10_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_5_d_constant_10_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_6_d_constant_10_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_6_d_constant_10_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_0_d_subtractor_9_io_r: std_logic_vector(28 downto 0);
    signal reg_0_d_subtractor_9_io_r: std_logic_vector(28 downto 0);
    signal reg_next_1_d_subtractor_9_io_r: std_logic_vector(28 downto 0);
    signal reg_1_d_subtractor_9_io_r: std_logic_vector(28 downto 0);
    signal reg_next_2_d_subtractor_9_io_r: std_logic_vector(28 downto 0);
    signal reg_2_d_subtractor_9_io_r: std_logic_vector(28 downto 0);
    signal reg_next_3_d_subtractor_9_io_r: std_logic_vector(28 downto 0);
    signal reg_3_d_subtractor_9_io_r: std_logic_vector(28 downto 0);
    signal reg_next_4_d_subtractor_9_io_r: std_logic_vector(28 downto 0);
    signal reg_4_d_subtractor_9_io_r: std_logic_vector(28 downto 0);
    signal reg_next_0_d_constant_11_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_0_d_constant_11_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_1_d_constant_11_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_1_d_constant_11_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_2_d_constant_11_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_2_d_constant_11_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_3_d_constant_11_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_3_d_constant_11_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_4_d_constant_11_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_4_d_constant_11_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_5_d_constant_11_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_5_d_constant_11_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_6_d_constant_11_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_6_d_constant_11_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_7_d_constant_11_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_7_d_constant_11_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_8_d_constant_11_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_8_d_constant_11_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_9_d_constant_11_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_9_d_constant_11_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_10_d_constant_11_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_10_d_constant_11_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_11_d_constant_11_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_11_d_constant_11_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_0_d_multiplier_2_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_2_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_2_sint_mul_adder_4_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_2_sint_mul_adder_4_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_2_sint_mul_adder_5_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_2_sint_mul_adder_5_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_2_sint_mul_adder_14_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_2_sint_mul_adder_14_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_2_sint_mul_adder_15_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_2_sint_mul_adder_15_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_2_sint_mul_adder_17_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_2_sint_mul_adder_17_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_2_sint_mul_adder_25_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_2_sint_mul_adder_25_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_2_tc_io_o: std_logic_vector(28 downto 0);
    signal reg_0_d_multiplier_2_tc_io_o: std_logic_vector(28 downto 0);
    signal reg_next_1_d_multiplier_2_tc_io_o: std_logic_vector(28 downto 0);
    signal reg_1_d_multiplier_2_tc_io_o: std_logic_vector(28 downto 0);
    signal reg_next_2_d_multiplier_2_tc_io_o: std_logic_vector(28 downto 0);
    signal reg_2_d_multiplier_2_tc_io_o: std_logic_vector(28 downto 0);
    signal reg_next_3_d_multiplier_2_tc_io_o: std_logic_vector(28 downto 0);
    signal reg_3_d_multiplier_2_tc_io_o: std_logic_vector(28 downto 0);
    signal reg_next_4_d_multiplier_2_tc_io_o: std_logic_vector(28 downto 0);
    signal reg_4_d_multiplier_2_tc_io_o: std_logic_vector(28 downto 0);
    signal reg_next_0_d_multiplier_3_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_3_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal reg_next_1_d_multiplier_3_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal reg_1_d_multiplier_3_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal reg_next_2_d_multiplier_3_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal reg_2_d_multiplier_3_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal reg_next_3_d_multiplier_3_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal reg_3_d_multiplier_3_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal reg_next_4_d_multiplier_3_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal reg_4_d_multiplier_3_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_3_sint_mul_adder_0_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_3_sint_mul_adder_0_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_3_sint_mul_adder_1_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_3_sint_mul_adder_1_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_3_sint_mul_adder_2_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_3_sint_mul_adder_2_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_3_sint_mul_adder_3_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_3_sint_mul_adder_3_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_3_sint_mul_adder_4_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_3_sint_mul_adder_4_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_3_sint_mul_adder_5_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_3_sint_mul_adder_5_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_3_sint_mul_adder_6_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_3_sint_mul_adder_6_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_3_sint_mul_adder_7_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_3_sint_mul_adder_7_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_3_sint_mul_adder_12_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_3_sint_mul_adder_12_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_3_sint_mul_adder_13_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_3_sint_mul_adder_13_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_3_sint_mul_adder_14_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_3_sint_mul_adder_14_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_3_sint_mul_adder_15_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_3_sint_mul_adder_15_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_3_sint_mul_adder_16_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_3_sint_mul_adder_16_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_3_sint_mul_adder_17_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_3_sint_mul_adder_17_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_3_sint_mul_adder_18_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_3_sint_mul_adder_18_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_3_sint_mul_adder_19_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_3_sint_mul_adder_19_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_3_sint_mul_adder_20_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_3_sint_mul_adder_20_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_3_sint_mul_adder_21_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_3_sint_mul_adder_21_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_3_sint_mul_adder_22_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_3_sint_mul_adder_22_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_3_sint_mul_adder_23_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_3_sint_mul_adder_23_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_3_sint_mul_adder_24_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_3_sint_mul_adder_24_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_3_sint_mul_adder_25_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_3_sint_mul_adder_25_io_r: std_logic_vector(57 downto 0);
    signal reg_next_1_d_multiplier_3_sint_mul_adder_25_io_r: std_logic_vector(57 downto 0);
    signal reg_1_d_multiplier_3_sint_mul_adder_25_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_3_sint_mul_adder_26_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_3_sint_mul_adder_26_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_3_tc_io_o: std_logic_vector(28 downto 0);
    signal reg_0_d_multiplier_3_tc_io_o: std_logic_vector(28 downto 0);
    signal reg_next_0_d_shifter_10_io_o: std_logic_vector(28 downto 0);
    signal reg_0_d_shifter_10_io_o: std_logic_vector(28 downto 0);
    signal reg_next_0_d_shifter_11_io_o: std_logic_vector(28 downto 0);
    signal reg_0_d_shifter_11_io_o: std_logic_vector(28 downto 0);
    signal reg_next_0_d_adder_7_io_r: std_logic_vector(28 downto 0);
    signal reg_0_d_adder_7_io_r: std_logic_vector(28 downto 0);
    signal reg_next_0_d_constant_12_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_0_d_constant_12_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_1_d_constant_12_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_1_d_constant_12_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_2_d_constant_12_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_2_d_constant_12_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_3_d_constant_12_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_3_d_constant_12_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_4_d_constant_12_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_4_d_constant_12_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_5_d_constant_12_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_5_d_constant_12_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_6_d_constant_12_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_6_d_constant_12_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_7_d_constant_12_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_7_d_constant_12_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_8_d_constant_12_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_8_d_constant_12_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_9_d_constant_12_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_9_d_constant_12_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_10_d_constant_12_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_10_d_constant_12_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_11_d_constant_12_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_11_d_constant_12_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_12_d_constant_12_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_12_d_constant_12_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_13_d_constant_12_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_13_d_constant_12_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_14_d_constant_12_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_14_d_constant_12_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_15_d_constant_12_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_15_d_constant_12_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_16_d_constant_12_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_16_d_constant_12_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_17_d_constant_12_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_17_d_constant_12_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_18_d_constant_12_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_18_d_constant_12_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_19_d_constant_12_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_19_d_constant_12_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_0_d_adder_8_io_r: std_logic_vector(28 downto 0);
    signal reg_0_d_adder_8_io_r: std_logic_vector(28 downto 0);
    signal reg_next_0_d_constant_13_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_0_d_constant_13_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_1_d_constant_13_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_1_d_constant_13_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_2_d_constant_13_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_2_d_constant_13_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_3_d_constant_13_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_3_d_constant_13_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_4_d_constant_13_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_4_d_constant_13_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_5_d_constant_13_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_5_d_constant_13_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_6_d_constant_13_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_6_d_constant_13_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_7_d_constant_13_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_7_d_constant_13_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_8_d_constant_13_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_8_d_constant_13_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_9_d_constant_13_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_9_d_constant_13_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_10_d_constant_13_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_10_d_constant_13_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_11_d_constant_13_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_11_d_constant_13_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_12_d_constant_13_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_12_d_constant_13_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_13_d_constant_13_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_13_d_constant_13_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_14_d_constant_13_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_14_d_constant_13_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_15_d_constant_13_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_15_d_constant_13_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_16_d_constant_13_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_16_d_constant_13_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_17_d_constant_13_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_17_d_constant_13_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_18_d_constant_13_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_18_d_constant_13_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_19_d_constant_13_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_19_d_constant_13_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_20_d_constant_13_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_20_d_constant_13_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_0_d_max_io_o: std_logic_vector(28 downto 0);
    signal reg_0_d_max_io_o: std_logic_vector(28 downto 0);
    signal reg_next_0_d_constant_14_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_0_d_constant_14_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_1_d_constant_14_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_1_d_constant_14_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_2_d_constant_14_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_2_d_constant_14_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_3_d_constant_14_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_3_d_constant_14_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_4_d_constant_14_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_4_d_constant_14_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_5_d_constant_14_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_5_d_constant_14_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_6_d_constant_14_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_6_d_constant_14_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_7_d_constant_14_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_7_d_constant_14_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_8_d_constant_14_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_8_d_constant_14_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_9_d_constant_14_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_9_d_constant_14_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_10_d_constant_14_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_10_d_constant_14_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_11_d_constant_14_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_11_d_constant_14_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_12_d_constant_14_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_12_d_constant_14_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_13_d_constant_14_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_13_d_constant_14_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_14_d_constant_14_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_14_d_constant_14_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_15_d_constant_14_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_15_d_constant_14_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_16_d_constant_14_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_16_d_constant_14_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_17_d_constant_14_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_17_d_constant_14_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_18_d_constant_14_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_18_d_constant_14_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_19_d_constant_14_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_19_d_constant_14_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_20_d_constant_14_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_20_d_constant_14_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_21_d_constant_14_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_21_d_constant_14_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_0_d_min_3_io_o: std_logic_vector(28 downto 0);
    signal reg_0_d_min_3_io_o: std_logic_vector(28 downto 0);
    signal reg_next_0_d_constant_15_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_0_d_constant_15_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_1_d_constant_15_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_1_d_constant_15_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_2_d_constant_15_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_2_d_constant_15_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_3_d_constant_15_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_3_d_constant_15_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_4_d_constant_15_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_4_d_constant_15_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_5_d_constant_15_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_5_d_constant_15_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_6_d_constant_15_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_6_d_constant_15_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_7_d_constant_15_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_7_d_constant_15_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_8_d_constant_15_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_8_d_constant_15_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_9_d_constant_15_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_9_d_constant_15_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_10_d_constant_15_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_10_d_constant_15_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_0_d_multiplier_4_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_4_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal reg_next_1_d_multiplier_4_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal reg_1_d_multiplier_4_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal reg_next_2_d_multiplier_4_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal reg_2_d_multiplier_4_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal reg_next_3_d_multiplier_4_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal reg_3_d_multiplier_4_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal reg_next_4_d_multiplier_4_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal reg_4_d_multiplier_4_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_4_sint_mul_adder_4_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_4_sint_mul_adder_4_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_4_sint_mul_adder_5_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_4_sint_mul_adder_5_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_4_sint_mul_adder_6_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_4_sint_mul_adder_6_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_4_sint_mul_adder_7_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_4_sint_mul_adder_7_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_4_sint_mul_adder_8_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_4_sint_mul_adder_8_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_4_sint_mul_adder_9_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_4_sint_mul_adder_9_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_4_sint_mul_adder_10_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_4_sint_mul_adder_10_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_4_sint_mul_adder_11_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_4_sint_mul_adder_11_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_4_sint_mul_adder_12_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_4_sint_mul_adder_12_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_4_sint_mul_adder_13_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_4_sint_mul_adder_13_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_4_sint_mul_adder_16_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_4_sint_mul_adder_16_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_4_sint_mul_adder_17_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_4_sint_mul_adder_17_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_4_sint_mul_adder_18_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_4_sint_mul_adder_18_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_4_sint_mul_adder_19_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_4_sint_mul_adder_19_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_4_sint_mul_adder_20_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_4_sint_mul_adder_20_io_r: std_logic_vector(57 downto 0);
    signal reg_next_1_d_multiplier_4_sint_mul_adder_20_io_r: std_logic_vector(57 downto 0);
    signal reg_1_d_multiplier_4_sint_mul_adder_20_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_4_sint_mul_adder_21_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_4_sint_mul_adder_21_io_r: std_logic_vector(57 downto 0);
    signal reg_next_1_d_multiplier_4_sint_mul_adder_21_io_r: std_logic_vector(57 downto 0);
    signal reg_1_d_multiplier_4_sint_mul_adder_21_io_r: std_logic_vector(57 downto 0);
    signal reg_next_2_d_multiplier_4_sint_mul_adder_21_io_r: std_logic_vector(57 downto 0);
    signal reg_2_d_multiplier_4_sint_mul_adder_21_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_4_sint_mul_adder_22_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_4_sint_mul_adder_22_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_4_sint_mul_adder_23_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_4_sint_mul_adder_23_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_4_sint_mul_adder_24_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_4_sint_mul_adder_24_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_4_sint_mul_adder_25_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_4_sint_mul_adder_25_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_4_sint_mul_adder_26_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplier_4_sint_mul_adder_26_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplier_4_tc_io_o: std_logic_vector(28 downto 0);
    signal reg_0_d_multiplier_4_tc_io_o: std_logic_vector(28 downto 0);
    signal reg_next_1_d_multiplier_4_tc_io_o: std_logic_vector(28 downto 0);
    signal reg_1_d_multiplier_4_tc_io_o: std_logic_vector(28 downto 0);
    signal reg_next_2_d_multiplier_4_tc_io_o: std_logic_vector(28 downto 0);
    signal reg_2_d_multiplier_4_tc_io_o: std_logic_vector(28 downto 0);
    signal reg_next_3_d_multiplier_4_tc_io_o: std_logic_vector(28 downto 0);
    signal reg_3_d_multiplier_4_tc_io_o: std_logic_vector(28 downto 0);
    signal reg_next_4_d_multiplier_4_tc_io_o: std_logic_vector(28 downto 0);
    signal reg_4_d_multiplier_4_tc_io_o: std_logic_vector(28 downto 0);
    signal reg_next_5_d_multiplier_4_tc_io_o: std_logic_vector(28 downto 0);
    signal reg_5_d_multiplier_4_tc_io_o: std_logic_vector(28 downto 0);
    signal reg_next_6_d_multiplier_4_tc_io_o: std_logic_vector(28 downto 0);
    signal reg_6_d_multiplier_4_tc_io_o: std_logic_vector(28 downto 0);
    signal reg_next_0_d_shifter_12_io_o: std_logic_vector(28 downto 0);
    signal reg_0_d_shifter_12_io_o: std_logic_vector(28 downto 0);
    signal reg_next_0_d_constant_16_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_0_d_constant_16_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_1_d_constant_16_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_1_d_constant_16_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_2_d_constant_16_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_2_d_constant_16_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_3_d_constant_16_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_3_d_constant_16_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_4_d_constant_16_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_4_d_constant_16_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_5_d_constant_16_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_5_d_constant_16_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_6_d_constant_16_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_6_d_constant_16_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_7_d_constant_16_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_7_d_constant_16_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_8_d_constant_16_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_8_d_constant_16_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_9_d_constant_16_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_9_d_constant_16_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_10_d_constant_16_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_10_d_constant_16_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_11_d_constant_16_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_11_d_constant_16_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_12_d_constant_16_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_12_d_constant_16_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_13_d_constant_16_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_13_d_constant_16_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_14_d_constant_16_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_14_d_constant_16_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_15_d_constant_16_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_15_d_constant_16_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_16_d_constant_16_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_16_d_constant_16_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_17_d_constant_16_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_17_d_constant_16_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_18_d_constant_16_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_18_d_constant_16_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_19_d_constant_16_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_19_d_constant_16_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_20_d_constant_16_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_20_d_constant_16_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_21_d_constant_16_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_21_d_constant_16_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_22_d_constant_16_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_22_d_constant_16_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_23_d_constant_16_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_23_d_constant_16_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_0_d_subtractor_11_io_r: std_logic_vector(28 downto 0);
    signal reg_0_d_subtractor_11_io_r: std_logic_vector(28 downto 0);
    signal reg_next_0_d_shifter_13_io_o: std_logic_vector(28 downto 0);
    signal reg_0_d_shifter_13_io_o: std_logic_vector(28 downto 0);
    signal reg_next_0_d_constant_17_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_0_d_constant_17_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_1_d_constant_17_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_1_d_constant_17_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_2_d_constant_17_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_2_d_constant_17_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_3_d_constant_17_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_3_d_constant_17_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_4_d_constant_17_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_4_d_constant_17_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_5_d_constant_17_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_5_d_constant_17_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_6_d_constant_17_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_6_d_constant_17_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_7_d_constant_17_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_7_d_constant_17_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_8_d_constant_17_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_8_d_constant_17_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_9_d_constant_17_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_9_d_constant_17_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_10_d_constant_17_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_10_d_constant_17_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_11_d_constant_17_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_11_d_constant_17_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_12_d_constant_17_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_12_d_constant_17_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_13_d_constant_17_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_13_d_constant_17_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_14_d_constant_17_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_14_d_constant_17_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_15_d_constant_17_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_15_d_constant_17_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_16_d_constant_17_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_16_d_constant_17_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_17_d_constant_17_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_17_d_constant_17_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_18_d_constant_17_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_18_d_constant_17_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_19_d_constant_17_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_19_d_constant_17_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_20_d_constant_17_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_20_d_constant_17_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_21_d_constant_17_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_21_d_constant_17_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_22_d_constant_17_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_22_d_constant_17_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_23_d_constant_17_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_23_d_constant_17_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_0_d_subtractor_12_io_r: std_logic_vector(28 downto 0);
    signal reg_0_d_subtractor_12_io_r: std_logic_vector(28 downto 0);
    signal reg_next_0_d_constant_18_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_0_d_constant_18_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_1_d_constant_18_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_1_d_constant_18_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_2_d_constant_18_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_2_d_constant_18_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_3_d_constant_18_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_3_d_constant_18_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_4_d_constant_18_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_4_d_constant_18_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_5_d_constant_18_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_5_d_constant_18_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_6_d_constant_18_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_6_d_constant_18_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_7_d_constant_18_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_7_d_constant_18_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_8_d_constant_18_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_8_d_constant_18_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_9_d_constant_18_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_9_d_constant_18_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_10_d_constant_18_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_10_d_constant_18_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_11_d_constant_18_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_11_d_constant_18_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_12_d_constant_18_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_12_d_constant_18_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_13_d_constant_18_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_13_d_constant_18_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_14_d_constant_18_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_14_d_constant_18_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_15_d_constant_18_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_15_d_constant_18_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_16_d_constant_18_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_16_d_constant_18_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_17_d_constant_18_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_17_d_constant_18_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_18_d_constant_18_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_18_d_constant_18_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_19_d_constant_18_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_19_d_constant_18_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_20_d_constant_18_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_20_d_constant_18_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_21_d_constant_18_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_21_d_constant_18_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_22_d_constant_18_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_22_d_constant_18_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_23_d_constant_18_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_23_d_constant_18_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_24_d_constant_18_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_24_d_constant_18_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_0_d_constant_19_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_0_d_constant_19_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_1_d_constant_19_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_1_d_constant_19_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_2_d_constant_19_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_2_d_constant_19_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_3_d_constant_19_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_3_d_constant_19_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_4_d_constant_19_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_4_d_constant_19_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_5_d_constant_19_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_5_d_constant_19_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_6_d_constant_19_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_6_d_constant_19_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_7_d_constant_19_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_7_d_constant_19_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_8_d_constant_19_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_8_d_constant_19_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_9_d_constant_19_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_9_d_constant_19_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_10_d_constant_19_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_10_d_constant_19_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_11_d_constant_19_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_11_d_constant_19_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_12_d_constant_19_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_12_d_constant_19_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_13_d_constant_19_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_13_d_constant_19_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_14_d_constant_19_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_14_d_constant_19_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_15_d_constant_19_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_15_d_constant_19_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_16_d_constant_19_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_16_d_constant_19_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_17_d_constant_19_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_17_d_constant_19_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_18_d_constant_19_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_18_d_constant_19_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_19_d_constant_19_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_19_d_constant_19_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_20_d_constant_19_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_20_d_constant_19_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_21_d_constant_19_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_21_d_constant_19_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_22_d_constant_19_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_22_d_constant_19_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_23_d_constant_19_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_23_d_constant_19_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_24_d_constant_19_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_24_d_constant_19_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_0_d_constant_20_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_0_d_constant_20_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_1_d_constant_20_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_1_d_constant_20_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_2_d_constant_20_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_2_d_constant_20_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_3_d_constant_20_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_3_d_constant_20_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_4_d_constant_20_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_4_d_constant_20_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_5_d_constant_20_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_5_d_constant_20_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_6_d_constant_20_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_6_d_constant_20_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_7_d_constant_20_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_7_d_constant_20_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_8_d_constant_20_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_8_d_constant_20_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_9_d_constant_20_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_9_d_constant_20_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_10_d_constant_20_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_10_d_constant_20_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_11_d_constant_20_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_11_d_constant_20_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_12_d_constant_20_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_12_d_constant_20_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_13_d_constant_20_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_13_d_constant_20_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_14_d_constant_20_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_14_d_constant_20_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_15_d_constant_20_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_15_d_constant_20_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_16_d_constant_20_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_16_d_constant_20_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_17_d_constant_20_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_17_d_constant_20_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_18_d_constant_20_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_18_d_constant_20_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_19_d_constant_20_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_19_d_constant_20_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_20_d_constant_20_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_20_d_constant_20_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_21_d_constant_20_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_21_d_constant_20_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_22_d_constant_20_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_22_d_constant_20_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_23_d_constant_20_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_23_d_constant_20_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_24_d_constant_20_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_24_d_constant_20_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_0_d_constant_21_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_0_d_constant_21_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_1_d_constant_21_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_1_d_constant_21_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_2_d_constant_21_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_2_d_constant_21_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_3_d_constant_21_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_3_d_constant_21_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_4_d_constant_21_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_4_d_constant_21_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_5_d_constant_21_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_5_d_constant_21_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_6_d_constant_21_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_6_d_constant_21_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_7_d_constant_21_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_7_d_constant_21_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_8_d_constant_21_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_8_d_constant_21_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_9_d_constant_21_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_9_d_constant_21_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_10_d_constant_21_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_10_d_constant_21_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_11_d_constant_21_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_11_d_constant_21_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_12_d_constant_21_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_12_d_constant_21_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_13_d_constant_21_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_13_d_constant_21_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_14_d_constant_21_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_14_d_constant_21_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_15_d_constant_21_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_15_d_constant_21_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_16_d_constant_21_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_16_d_constant_21_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_17_d_constant_21_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_17_d_constant_21_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_18_d_constant_21_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_18_d_constant_21_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_19_d_constant_21_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_19_d_constant_21_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_20_d_constant_21_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_20_d_constant_21_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_21_d_constant_21_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_21_d_constant_21_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_22_d_constant_21_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_22_d_constant_21_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_23_d_constant_21_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_23_d_constant_21_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_24_d_constant_21_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_24_d_constant_21_opt_io_o: std_logic_vector(28 downto 0);
    signal reg_next_0_d_concatenator_io_o: std_logic_vector(15 downto 0);
    signal reg_0_d_concatenator_io_o: std_logic_vector(15 downto 0);
    signal reg_next_0_d_constant_22_opt_io_o: std_logic_vector(7 downto 0);
    signal reg_0_d_constant_22_opt_io_o: std_logic_vector(7 downto 0);
    signal reg_next_1_d_constant_22_opt_io_o: std_logic_vector(7 downto 0);
    signal reg_1_d_constant_22_opt_io_o: std_logic_vector(7 downto 0);
    signal reg_next_2_d_constant_22_opt_io_o: std_logic_vector(7 downto 0);
    signal reg_2_d_constant_22_opt_io_o: std_logic_vector(7 downto 0);
    signal reg_next_3_d_constant_22_opt_io_o: std_logic_vector(7 downto 0);
    signal reg_3_d_constant_22_opt_io_o: std_logic_vector(7 downto 0);
    signal reg_next_4_d_constant_22_opt_io_o: std_logic_vector(7 downto 0);
    signal reg_4_d_constant_22_opt_io_o: std_logic_vector(7 downto 0);
    signal reg_next_5_d_constant_22_opt_io_o: std_logic_vector(7 downto 0);
    signal reg_5_d_constant_22_opt_io_o: std_logic_vector(7 downto 0);
    signal reg_next_6_d_constant_22_opt_io_o: std_logic_vector(7 downto 0);
    signal reg_6_d_constant_22_opt_io_o: std_logic_vector(7 downto 0);
    signal reg_next_7_d_constant_22_opt_io_o: std_logic_vector(7 downto 0);
    signal reg_7_d_constant_22_opt_io_o: std_logic_vector(7 downto 0);
    signal reg_next_8_d_constant_22_opt_io_o: std_logic_vector(7 downto 0);
    signal reg_8_d_constant_22_opt_io_o: std_logic_vector(7 downto 0);
    signal reg_next_9_d_constant_22_opt_io_o: std_logic_vector(7 downto 0);
    signal reg_9_d_constant_22_opt_io_o: std_logic_vector(7 downto 0);
    signal reg_next_10_d_constant_22_opt_io_o: std_logic_vector(7 downto 0);
    signal reg_10_d_constant_22_opt_io_o: std_logic_vector(7 downto 0);
    signal reg_next_11_d_constant_22_opt_io_o: std_logic_vector(7 downto 0);
    signal reg_11_d_constant_22_opt_io_o: std_logic_vector(7 downto 0);
    signal reg_next_12_d_constant_22_opt_io_o: std_logic_vector(7 downto 0);
    signal reg_12_d_constant_22_opt_io_o: std_logic_vector(7 downto 0);
    signal reg_next_13_d_constant_22_opt_io_o: std_logic_vector(7 downto 0);
    signal reg_13_d_constant_22_opt_io_o: std_logic_vector(7 downto 0);
    signal reg_next_14_d_constant_22_opt_io_o: std_logic_vector(7 downto 0);
    signal reg_14_d_constant_22_opt_io_o: std_logic_vector(7 downto 0);
    signal reg_next_15_d_constant_22_opt_io_o: std_logic_vector(7 downto 0);
    signal reg_15_d_constant_22_opt_io_o: std_logic_vector(7 downto 0);
    signal reg_next_16_d_constant_22_opt_io_o: std_logic_vector(7 downto 0);
    signal reg_16_d_constant_22_opt_io_o: std_logic_vector(7 downto 0);
    signal reg_next_17_d_constant_22_opt_io_o: std_logic_vector(7 downto 0);
    signal reg_17_d_constant_22_opt_io_o: std_logic_vector(7 downto 0);
    signal reg_next_18_d_constant_22_opt_io_o: std_logic_vector(7 downto 0);
    signal reg_18_d_constant_22_opt_io_o: std_logic_vector(7 downto 0);
    signal reg_next_19_d_constant_22_opt_io_o: std_logic_vector(7 downto 0);
    signal reg_19_d_constant_22_opt_io_o: std_logic_vector(7 downto 0);
    signal reg_next_20_d_constant_22_opt_io_o: std_logic_vector(7 downto 0);
    signal reg_20_d_constant_22_opt_io_o: std_logic_vector(7 downto 0);
    signal reg_next_21_d_constant_22_opt_io_o: std_logic_vector(7 downto 0);
    signal reg_21_d_constant_22_opt_io_o: std_logic_vector(7 downto 0);
    signal reg_next_22_d_constant_22_opt_io_o: std_logic_vector(7 downto 0);
    signal reg_22_d_constant_22_opt_io_o: std_logic_vector(7 downto 0);
    signal reg_next_23_d_constant_22_opt_io_o: std_logic_vector(7 downto 0);
    signal reg_23_d_constant_22_opt_io_o: std_logic_vector(7 downto 0);
    signal reg_next_24_d_constant_22_opt_io_o: std_logic_vector(7 downto 0);
    signal reg_24_d_constant_22_opt_io_o: std_logic_vector(7 downto 0);
    signal reg_next_25_d_constant_22_opt_io_o: std_logic_vector(7 downto 0);
    signal reg_25_d_constant_22_opt_io_o: std_logic_vector(7 downto 0);
    signal reg_next_0_valid_chain: std_logic_vector(0 downto 0);
    signal reg_0_valid_chain: std_logic_vector(0 downto 0);
    signal reg_next_1_valid_chain: std_logic_vector(0 downto 0);
    signal reg_1_valid_chain: std_logic_vector(0 downto 0);
    signal reg_next_2_valid_chain: std_logic_vector(0 downto 0);
    signal reg_2_valid_chain: std_logic_vector(0 downto 0);
    signal reg_next_3_valid_chain: std_logic_vector(0 downto 0);
    signal reg_3_valid_chain: std_logic_vector(0 downto 0);
    signal reg_next_4_valid_chain: std_logic_vector(0 downto 0);
    signal reg_4_valid_chain: std_logic_vector(0 downto 0);
    signal reg_next_5_valid_chain: std_logic_vector(0 downto 0);
    signal reg_5_valid_chain: std_logic_vector(0 downto 0);
    signal reg_next_6_valid_chain: std_logic_vector(0 downto 0);
    signal reg_6_valid_chain: std_logic_vector(0 downto 0);
    signal reg_next_7_valid_chain: std_logic_vector(0 downto 0);
    signal reg_7_valid_chain: std_logic_vector(0 downto 0);
    signal reg_next_8_valid_chain: std_logic_vector(0 downto 0);
    signal reg_8_valid_chain: std_logic_vector(0 downto 0);
    signal reg_next_9_valid_chain: std_logic_vector(0 downto 0);
    signal reg_9_valid_chain: std_logic_vector(0 downto 0);
    signal reg_next_10_valid_chain: std_logic_vector(0 downto 0);
    signal reg_10_valid_chain: std_logic_vector(0 downto 0);
    signal reg_next_11_valid_chain: std_logic_vector(0 downto 0);
    signal reg_11_valid_chain: std_logic_vector(0 downto 0);
    signal reg_next_12_valid_chain: std_logic_vector(0 downto 0);
    signal reg_12_valid_chain: std_logic_vector(0 downto 0);
    signal reg_next_13_valid_chain: std_logic_vector(0 downto 0);
    signal reg_13_valid_chain: std_logic_vector(0 downto 0);
    signal reg_next_14_valid_chain: std_logic_vector(0 downto 0);
    signal reg_14_valid_chain: std_logic_vector(0 downto 0);
    signal reg_next_15_valid_chain: std_logic_vector(0 downto 0);
    signal reg_15_valid_chain: std_logic_vector(0 downto 0);
    signal reg_next_16_valid_chain: std_logic_vector(0 downto 0);
    signal reg_16_valid_chain: std_logic_vector(0 downto 0);
    signal reg_next_17_valid_chain: std_logic_vector(0 downto 0);
    signal reg_17_valid_chain: std_logic_vector(0 downto 0);
    signal reg_next_18_valid_chain: std_logic_vector(0 downto 0);
    signal reg_18_valid_chain: std_logic_vector(0 downto 0);
    signal reg_next_19_valid_chain: std_logic_vector(0 downto 0);
    signal reg_19_valid_chain: std_logic_vector(0 downto 0);
    signal reg_next_20_valid_chain: std_logic_vector(0 downto 0);
    signal reg_20_valid_chain: std_logic_vector(0 downto 0);
    signal reg_next_21_valid_chain: std_logic_vector(0 downto 0);
    signal reg_21_valid_chain: std_logic_vector(0 downto 0);
    signal reg_next_22_valid_chain: std_logic_vector(0 downto 0);
    signal reg_22_valid_chain: std_logic_vector(0 downto 0);
    signal reg_next_23_valid_chain: std_logic_vector(0 downto 0);
    signal reg_23_valid_chain: std_logic_vector(0 downto 0);
    signal reg_next_24_valid_chain: std_logic_vector(0 downto 0);
    signal reg_24_valid_chain: std_logic_vector(0 downto 0);
    signal reg_next_25_valid_chain: std_logic_vector(0 downto 0);
    signal reg_25_valid_chain: std_logic_vector(0 downto 0);
    signal in_ready_buffer: std_logic_vector(0 downto 0);
    signal in_ready_and_in_valid: std_logic_vector(0 downto 0);
begin
    process (clock, reset) is
    begin
        if reset = '1' then
            reg_8_valid_chain <= (others => '0');
            reg_1_d_multiplier_4_sint_mul_adder_21_io_r <= (others => '0');
            reg_4_d_multiplier_2_tc_io_o <= (others => '0');
            reg_0_d_multiplier_3_sint_mul_adder_26_io_r <= (others => '0');
            reg_0_d_constant_16_opt_io_o <= (others => '0');
            reg_3_d_constant_9_opt_io_o <= (others => '0');
            reg_5_d_constant_22_opt_io_o <= (others => '0');
            reg_0_d_adder_io_r <= (others => '0');
            reg_5_d_constant_13_opt_io_o <= (others => '0');
            reg_23_d_constant_21_opt_io_o <= (others => '0');
            reg_0_d_to_sfixed_1_io_o <= (others => '0');
            reg_0_d_constant_7_opt_io_o <= (others => '0');
            reg_14_d_constant_12_opt_io_o <= (others => '0');
            reg_20_d_constant_13_opt_io_o <= (others => '0');
            reg_15_d_constant_12_opt_io_o <= (others => '0');
            reg_19_d_constant_14_opt_io_o <= (others => '0');
            reg_2_d_multiplier_1_sint_mul_gen_addends_io_subend <= (others => '0');
            reg_0_d_multiplier_3_sint_mul_adder_24_io_r <= (others => '0');
            reg_0_d_fract_1_io_o <= (others => '0');
            reg_0_d_multiplier_3_sint_mul_adder_16_io_r <= (others => '0');
            reg_4_d_constant_17_opt_io_o <= (others => '0');
            reg_22_d_constant_20_opt_io_o <= (others => '0');
            reg_0_d_multiplier_1_sint_mul_adder_20_io_r <= (others => '0');
            reg_0_d_shifter_5_io_o <= (others => '0');
            reg_0_d_multiplier_4_sint_mul_adder_6_io_r <= (others => '0');
            reg_6_d_constant_18_opt_io_o <= (others => '0');
            reg_0_d_multiplier_4_tc_io_o <= (others => '0');
            reg_0_d_multiplier_sint_mul_gen_addends_io_addend_21 <= (others => '0');
            reg_0_d_multiplier_sint_mul_gen_addends_io_addend_12 <= (others => '0');
            reg_0_d_subtractor_9_io_r <= (others => '0');
            reg_9_d_constant_20_opt_io_o <= (others => '0');
            reg_7_d_constant_22_opt_io_o <= (others => '0');
            reg_6_d_to_sfixed_1_io_o <= (others => '0');
            reg_0_d_multiplier_3_sint_mul_adder_19_io_r <= (others => '0');
            reg_0_d_multiplier_sint_mul_adder_18_io_r <= (others => '0');
            reg_1_d_constant_9_opt_io_o <= (others => '0');
            reg_9_d_constant_19_opt_io_o <= (others => '0');
            reg_5_d_constant_19_opt_io_o <= (others => '0');
            reg_1_d_multiplier_sint_mul_gen_addends_io_subend <= (others => '0');
            reg_0_valid_chain <= (others => '0');
            reg_13_d_constant_16_opt_io_o <= (others => '0');
            reg_1_d_multiplier_sint_mul_adder_19_io_r <= (others => '0');
            reg_0_d_multiplier_sint_mul_adder_20_io_r <= (others => '0');
            reg_9_d_constant_14_opt_io_o <= (others => '0');
            reg_20_d_constant_14_opt_io_o <= (others => '0');
            reg_1_d_constant_4_opt_io_o <= (others => '0');
            reg_22_d_constant_18_opt_io_o <= (others => '0');
            reg_0_d_multiplier_sint_mul_adder_16_io_r <= (others => '0');
            reg_1_d_constant_3_opt_io_o <= (others => '0');
            reg_0_d_multiplier_sint_mul_gen_addends_io_addend_26 <= (others => '0');
            reg_4_d_constant_12_opt_io_o <= (others => '0');
            reg_0_d_multiplier_3_sint_mul_adder_15_io_r <= (others => '0');
            reg_0_d_adder_1_io_r <= (others => '0');
            reg_0_d_multiplier_4_sint_mul_adder_24_io_r <= (others => '0');
            reg_0_d_multiplier_1_tc_io_o <= (others => '0');
            reg_8_d_constant_9_opt_io_o <= (others => '0');
            reg_22_d_constant_19_opt_io_o <= (others => '0');
            reg_0_d_multiplier_sint_mul_gen_addends_io_addend_27 <= (others => '0');
            reg_1_d_multiplier_1_sint_mul_adder_20_io_r <= (others => '0');
            reg_0_d_multiplier_4_sint_mul_adder_25_io_r <= (others => '0');
            reg_18_d_constant_20_opt_io_o <= (others => '0');
            reg_7_d_constant_12_opt_io_o <= (others => '0');
            reg_12_d_constant_12_opt_io_o <= (others => '0');
            reg_2_d_constant_15_opt_io_o <= (others => '0');
            reg_15_d_constant_18_opt_io_o <= (others => '0');
            reg_23_valid_chain <= (others => '0');
            reg_0_d_constant_5_opt_io_o <= (others => '0');
            reg_0_d_multiplier_sint_mul_adder_21_io_r <= (others => '0');
            reg_0_d_multiplier_3_sint_mul_adder_23_io_r <= (others => '0');
            reg_1_d_constant_21_opt_io_o <= (others => '0');
            reg_0_d_constant_14_opt_io_o <= (others => '0');
            reg_0_d_multiplier_3_sint_mul_adder_5_io_r <= (others => '0');
            reg_16_d_constant_13_opt_io_o <= (others => '0');
            reg_18_d_constant_14_opt_io_o <= (others => '0');
            reg_8_d_to_sfixed_1_io_o <= (others => '0');
            reg_19_d_constant_17_opt_io_o <= (others => '0');
            reg_1_valid_chain <= (others => '0');
            reg_0_d_multiplier_sint_mul_gen_addends_io_addend_22 <= (others => '0');
            reg_0_d_multiplier_4_sint_mul_adder_13_io_r <= (others => '0');
            reg_0_l_ceil_io_i <= (others => '0');
            reg_0_d_constant_2_opt_io_o <= (others => '0');
            reg_14_d_constant_17_opt_io_o <= (others => '0');
            reg_18_d_constant_12_opt_io_o <= (others => '0');
            reg_24_d_constant_18_opt_io_o <= (others => '0');
            reg_23_d_constant_17_opt_io_o <= (others => '0');
            reg_1_d_constant_13_opt_io_o <= (others => '0');
            reg_6_d_constant_11_opt_io_o <= (others => '0');
            reg_0_d_multiplier_4_sint_mul_adder_23_io_r <= (others => '0');
            reg_21_d_constant_14_opt_io_o <= (others => '0');
            reg_13_d_constant_20_opt_io_o <= (others => '0');
            reg_10_d_constant_19_opt_io_o <= (others => '0');
            reg_0_d_multiplier_1_sint_mul_adder_16_io_r <= (others => '0');
            reg_11_d_constant_11_opt_io_o <= (others => '0');
            reg_0_d_multiplier_4_sint_mul_adder_20_io_r <= (others => '0');
            reg_0_d_multiplier_sint_mul_adder_8_io_r <= (others => '0');
            reg_1_d_multiplier_1_sint_mul_adder_16_io_r <= (others => '0');
            reg_17_d_constant_19_opt_io_o <= (others => '0');
            reg_4_d_constant_11_opt_io_o <= (others => '0');
            reg_15_d_constant_17_opt_io_o <= (others => '0');
            reg_0_d_multiplier_1_sint_mul_adder_19_io_r <= (others => '0');
            reg_4_d_constant_18_opt_io_o <= (others => '0');
            reg_20_d_constant_18_opt_io_o <= (others => '0');
            reg_16_d_constant_20_opt_io_o <= (others => '0');
            reg_21_d_constant_22_opt_io_o <= (others => '0');
            reg_17_d_constant_22_opt_io_o <= (others => '0');
            reg_0_d_multiplier_1_sint_mul_gen_addends_io_addend_21 <= (others => '0');
            reg_4_d_multiplier_4_sint_mul_gen_addends_io_subend <= (others => '0');
            reg_15_d_constant_16_opt_io_o <= (others => '0');
            reg_20_d_constant_21_opt_io_o <= (others => '0');
            reg_0_d_multiplier_3_sint_mul_adder_4_io_r <= (others => '0');
            reg_14_valid_chain <= (others => '0');
            reg_3_d_to_sfixed_1_io_o <= (others => '0');
            reg_19_d_constant_16_opt_io_o <= (others => '0');
            reg_10_d_constant_16_opt_io_o <= (others => '0');
            reg_11_d_constant_12_opt_io_o <= (others => '0');
            reg_17_d_constant_14_opt_io_o <= (others => '0');
            reg_0_d_multiplier_sint_mul_gen_addends_io_addend_14 <= (others => '0');
            reg_0_d_constant_20_opt_io_o <= (others => '0');
            reg_4_d_constant_19_opt_io_o <= (others => '0');
            reg_1_d_constant_10_opt_io_o <= (others => '0');
            reg_21_d_constant_16_opt_io_o <= (others => '0');
            reg_3_d_constant_11_opt_io_o <= (others => '0');
            reg_3_d_constant_4_opt_io_o <= (others => '0');
            reg_0_d_multiplier_4_sint_mul_adder_16_io_r <= (others => '0');
            reg_0_d_multiplier_sint_mul_adder_19_io_r <= (others => '0');
            reg_6_d_constant_21_opt_io_o <= (others => '0');
            reg_5_d_constant_15_opt_io_o <= (others => '0');
            reg_9_d_constant_16_opt_io_o <= (others => '0');
            reg_0_d_multiplier_4_sint_mul_adder_12_io_r <= (others => '0');
            reg_0_d_multiplier_1_sint_mul_gen_addends_io_addend_25 <= (others => '0');
            reg_0_d_adder_7_io_r <= (others => '0');
            reg_8_d_constant_16_opt_io_o <= (others => '0');
            reg_15_d_constant_19_opt_io_o <= (others => '0');
            reg_2_d_constant_11_opt_io_o <= (others => '0');
            reg_2_d_multiplier_4_sint_mul_gen_addends_io_subend <= (others => '0');
            reg_10_d_constant_22_opt_io_o <= (others => '0');
            reg_0_d_multiplier_4_sint_mul_adder_18_io_r <= (others => '0');
            reg_5_d_constant_9_opt_io_o <= (others => '0');
            reg_24_d_constant_22_opt_io_o <= (others => '0');
            reg_22_d_constant_16_opt_io_o <= (others => '0');
            reg_0_d_subtractor_io_r <= (others => '0');
            reg_0_d_subtractor_11_io_r <= (others => '0');
            reg_0_d_multiplier_1_sint_mul_gen_addends_io_addend_15 <= (others => '0');
            reg_5_d_constant_20_opt_io_o <= (others => '0');
            reg_3_d_multiplier_2_tc_io_o <= (others => '0');
            reg_24_valid_chain <= (others => '0');
            reg_0_d_multiplier_sint_mul_gen_addends_io_addend_16 <= (others => '0');
            reg_6_d_constant_10_opt_io_o <= (others => '0');
            reg_8_d_constant_11_opt_io_o <= (others => '0');
            reg_8_d_constant_17_opt_io_o <= (others => '0');
            reg_10_d_constant_12_opt_io_o <= (others => '0');
            reg_6_d_constant_14_opt_io_o <= (others => '0');
            reg_0_d_constant_13_opt_io_o <= (others => '0');
            reg_2_d_multiplier_sint_mul_adder_16_io_r <= (others => '0');
            reg_0_d_multiplier_3_sint_mul_adder_0_io_r <= (others => '0');
            reg_1_d_constant_6_opt_io_o <= (others => '0');
            reg_2_d_multiplier_4_sint_mul_adder_21_io_r <= (others => '0');
            reg_0_d_multiplier_1_sint_mul_adder_9_io_r <= (others => '0');
            reg_2_l_mux_io_i1 <= (others => '0');
            reg_16_d_constant_14_opt_io_o <= (others => '0');
            reg_22_d_constant_21_opt_io_o <= (others => '0');
            reg_10_d_constant_13_opt_io_o <= (others => '0');
            reg_0_d_subtractor_2_io_r <= (others => '0');
            reg_1_d_multiplier_sint_mul_adder_20_io_r <= (others => '0');
            reg_13_d_constant_13_opt_io_o <= (others => '0');
            reg_0_d_multiplier_2_sint_mul_adder_14_io_r <= (others => '0');
            reg_0_d_multiplier_sint_mul_adder_24_io_r <= (others => '0');
            reg_0_d_multiplier_3_sint_mul_adder_18_io_r <= (others => '0');
            reg_7_d_constant_15_opt_io_o <= (others => '0');
            reg_0_d_multiplier_1_sint_mul_gen_addends_io_addend_13 <= (others => '0');
            reg_18_d_constant_19_opt_io_o <= (others => '0');
            reg_0_d_multiplier_2_sint_mul_adder_25_io_r <= (others => '0');
            reg_6_d_constant_9_opt_io_o <= (others => '0');
            reg_7_d_constant_18_opt_io_o <= (others => '0');
            reg_3_d_constant_14_opt_io_o <= (others => '0');
            reg_16_d_constant_18_opt_io_o <= (others => '0');
            reg_3_d_constant_19_opt_io_o <= (others => '0');
            reg_0_d_multiplier_1_sint_mul_gen_addends_io_addend_12 <= (others => '0');
            reg_0_d_multiplier_3_sint_mul_adder_25_io_r <= (others => '0');
            reg_0_l_mux_io_i1 <= (others => '0');
            reg_1_d_constant_12_opt_io_o <= (others => '0');
            reg_0_d_multiplier_1_sint_mul_gen_addends_io_addend_24 <= (others => '0');
            reg_0_d_multiplier_1_sint_mul_gen_addends_io_addend_23 <= (others => '0');
            reg_0_d_concatenator_io_o <= (others => '0');
            reg_0_d_multiplier_4_sint_mul_adder_22_io_r <= (others => '0');
            reg_9_d_constant_12_opt_io_o <= (others => '0');
            reg_0_d_multiplier_3_tc_io_o <= (others => '0');
            reg_1_d_constant_11_opt_io_o <= (others => '0');
            reg_0_d_multiplier_3_sint_mul_gen_addends_io_subend <= (others => '0');
            reg_23_d_constant_18_opt_io_o <= (others => '0');
            reg_3_d_constant_21_opt_io_o <= (others => '0');
            reg_13_d_constant_22_opt_io_o <= (others => '0');
            reg_0_d_multiplier_3_sint_mul_adder_12_io_r <= (others => '0');
            reg_12_valid_chain <= (others => '0');
            reg_4_l_mux_io_i1 <= (others => '0');
            reg_0_d_multiplier_sint_mul_gen_addends_io_addend_19 <= (others => '0');
            reg_8_d_constant_22_opt_io_o <= (others => '0');
            reg_0_d_min_io_o <= (others => '0');
            reg_0_d_multiplier_4_sint_mul_gen_addends_io_subend <= (others => '0');
            reg_0_d_slicer_io_o <= (others => '0');
            reg_9_d_constant_17_opt_io_o <= (others => '0');
            reg_2_d_constant_21_opt_io_o <= (others => '0');
            reg_13_valid_chain <= (others => '0');
            reg_15_d_constant_21_opt_io_o <= (others => '0');
            reg_22_d_constant_22_opt_io_o <= (others => '0');
            reg_0_d_multiplier_3_sint_mul_adder_17_io_r <= (others => '0');
            reg_1_d_constant_16_opt_io_o <= (others => '0');
            reg_4_d_constant_6_opt_io_o <= (others => '0');
            reg_0_d_constant_4_opt_io_o <= (others => '0');
            reg_0_d_subtractor_12_io_r <= (others => '0');
            reg_4_d_constant_21_opt_io_o <= (others => '0');
            reg_10_d_constant_11_opt_io_o <= (others => '0');
            reg_23_d_constant_22_opt_io_o <= (others => '0');
            reg_0_d_multiplier_1_sint_mul_gen_addends_io_addend_26 <= (others => '0');
            reg_24_d_constant_21_opt_io_o <= (others => '0');
            reg_0_l_min_io_a <= (others => '0');
            reg_1_d_multiplier_3_sint_mul_adder_25_io_r <= (others => '0');
            reg_10_d_constant_8_opt_io_o <= (others => '0');
            reg_22_d_constant_17_opt_io_o <= (others => '0');
            reg_0_d_multiplier_4_sint_mul_adder_10_io_r <= (others => '0');
            reg_3_d_constant_16_opt_io_o <= (others => '0');
            reg_21_d_constant_17_opt_io_o <= (others => '0');
            reg_21_d_constant_18_opt_io_o <= (others => '0');
            reg_2_d_multiplier_4_tc_io_o <= (others => '0');
            reg_1_d_to_sfixed_1_io_o <= (others => '0');
            reg_5_d_constant_11_opt_io_o <= (others => '0');
            reg_0_d_constant_15_opt_io_o <= (others => '0');
            reg_8_d_constant_20_opt_io_o <= (others => '0');
            reg_18_d_constant_21_opt_io_o <= (others => '0');
            reg_16_d_constant_12_opt_io_o <= (others => '0');
            reg_0_d_multiplier_sint_mul_gen_addends_io_addend_13 <= (others => '0');
            reg_1_d_multiplier_1_sint_mul_gen_addends_io_subend <= (others => '0');
            reg_3_d_constant_5_opt_io_o <= (others => '0');
            reg_0_d_multiplier_3_sint_mul_adder_6_io_r <= (others => '0');
            reg_11_d_constant_18_opt_io_o <= (others => '0');
            reg_2_d_constant_4_opt_io_o <= (others => '0');
            reg_0_d_constant_9_opt_io_o <= (others => '0');
            reg_7_d_to_sfixed_1_io_o <= (others => '0');
            reg_8_d_constant_15_opt_io_o <= (others => '0');
            reg_6_d_constant_12_opt_io_o <= (others => '0');
            reg_0_d_multiplier_2_sint_mul_adder_5_io_r <= (others => '0');
            reg_4_d_constant_10_opt_io_o <= (others => '0');
            reg_11_d_constant_22_opt_io_o <= (others => '0');
            reg_19_d_constant_21_opt_io_o <= (others => '0');
            reg_6_d_constant_13_opt_io_o <= (others => '0');
            reg_0_d_ceil_1_io_o <= (others => '0');
            reg_1_d_multiplier_4_sint_mul_gen_addends_io_subend <= (others => '0');
            reg_21_d_constant_19_opt_io_o <= (others => '0');
            reg_12_d_constant_14_opt_io_o <= (others => '0');
            reg_18_valid_chain <= (others => '0');
            reg_3_d_constant_6_opt_io_o <= (others => '0');
            reg_9_d_constant_11_opt_io_o <= (others => '0');
            reg_0_d_adder_3_io_r <= (others => '0');
            reg_13_d_constant_18_opt_io_o <= (others => '0');
            reg_0_d_shifter_10_io_o <= (others => '0');
            reg_19_d_constant_12_opt_io_o <= (others => '0');
            reg_17_d_constant_16_opt_io_o <= (others => '0');
            reg_21_valid_chain <= (others => '0');
            reg_0_d_multiplier_4_sint_mul_adder_9_io_r <= (others => '0');
            reg_0_d_multiplier_sint_mul_gen_addends_io_addend_18 <= (others => '0');
            reg_0_d_multiplier_3_sint_mul_adder_1_io_r <= (others => '0');
            reg_15_d_constant_13_opt_io_o <= (others => '0');
            reg_0_d_constant_opt_io_o <= (others => '0');
            reg_1_d_constant_20_opt_io_o <= (others => '0');
            reg_0_d_multiplier_3_sint_mul_adder_3_io_r <= (others => '0');
            reg_2_d_constant_13_opt_io_o <= (others => '0');
            reg_0_d_multiplier_4_sint_mul_adder_26_io_r <= (others => '0');
            reg_5_d_constant_21_opt_io_o <= (others => '0');
            reg_25_d_constant_22_opt_io_o <= (others => '0');
            reg_0_d_multiplier_sint_mul_gen_addends_io_addend_24 <= (others => '0');
            reg_3_d_multiplier_1_sint_mul_gen_addends_io_subend <= (others => '0');
            reg_0_d_multiplier_1_sint_mul_gen_addends_io_addend_19 <= (others => '0');
            reg_16_valid_chain <= (others => '0');
            reg_0_d_min_3_io_o <= (others => '0');
            reg_14_d_constant_22_opt_io_o <= (others => '0');
            reg_0_d_multiplier_3_sint_mul_adder_22_io_r <= (others => '0');
            reg_2_d_constant_22_opt_io_o <= (others => '0');
            reg_2_d_constant_16_opt_io_o <= (others => '0');
            reg_12_d_constant_21_opt_io_o <= (others => '0');
            reg_16_d_constant_16_opt_io_o <= (others => '0');
            reg_0_d_multiplier_sint_mul_adder_6_io_r <= (others => '0');
            reg_0_d_multiplier_1_sint_mul_adder_21_io_r <= (others => '0');
            reg_17_d_constant_18_opt_io_o <= (others => '0');
            reg_24_d_constant_19_opt_io_o <= (others => '0');
            reg_0_d_multiplier_1_sint_mul_adder_8_io_r <= (others => '0');
            reg_4_d_constant_20_opt_io_o <= (others => '0');
            reg_8_d_constant_19_opt_io_o <= (others => '0');
            reg_0_d_multiplier_1_sint_mul_gen_addends_io_addend_18 <= (others => '0');
            reg_13_d_constant_21_opt_io_o <= (others => '0');
            reg_21_d_constant_20_opt_io_o <= (others => '0');
            reg_0_d_subtractor_1_io_r <= (others => '0');
            reg_6_d_constant_15_opt_io_o <= (others => '0');
            reg_0_d_multiplier_1_sint_mul_adder_18_io_r <= (others => '0');
            reg_1_d_multiplier_sint_mul_adder_16_io_r <= (others => '0');
            reg_4_d_constant_9_opt_io_o <= (others => '0');
            reg_15_valid_chain <= (others => '0');
            reg_4_d_multiplier_4_tc_io_o <= (others => '0');
            reg_17_d_constant_17_opt_io_o <= (others => '0');
            reg_1_d_multiplier_sint_mul_adder_21_io_r <= (others => '0');
            reg_1_d_constant_17_opt_io_o <= (others => '0');
            reg_24_d_constant_20_opt_io_o <= (others => '0');
            reg_1_d_constant_8_opt_io_o <= (others => '0');
            reg_6_d_constant_22_opt_io_o <= (others => '0');
            reg_16_d_constant_17_opt_io_o <= (others => '0');
            reg_18_d_constant_17_opt_io_o <= (others => '0');
            reg_20_d_constant_22_opt_io_o <= (others => '0');
            reg_10_d_constant_14_opt_io_o <= (others => '0');
            reg_0_d_multiplier_3_sint_mul_adder_13_io_r <= (others => '0');
            reg_0_d_adder_8_io_r <= (others => '0');
            reg_7_d_constant_11_opt_io_o <= (others => '0');
            reg_0_l_multiplier_3_sint_mul_gen_addends_io_long <= (others => '0');
            reg_2_d_constant_14_opt_io_o <= (others => '0');
            reg_3_d_constant_8_opt_io_o <= (others => '0');
            reg_7_d_constant_19_opt_io_o <= (others => '0');
            reg_17_d_constant_13_opt_io_o <= (others => '0');
            reg_2_d_constant_5_opt_io_o <= (others => '0');
            reg_2_d_constant_10_opt_io_o <= (others => '0');
            reg_0_d_multiplier_3_sint_mul_adder_2_io_r <= (others => '0');
            reg_0_d_multiplier_4_sint_mul_adder_21_io_r <= (others => '0');
            reg_8_d_constant_13_opt_io_o <= (others => '0');
            reg_4_valid_chain <= (others => '0');
            reg_3_d_constant_13_opt_io_o <= (others => '0');
            reg_1_d_subtractor_9_io_r <= (others => '0');
            reg_9_valid_chain <= (others => '0');
            reg_10_valid_chain <= (others => '0');
            reg_2_d_multiplier_1_sint_mul_adder_21_io_r <= (others => '0');
            reg_0_d_constant_3_opt_io_o <= (others => '0');
            reg_15_d_constant_14_opt_io_o <= (others => '0');
            reg_6_valid_chain <= (others => '0');
            reg_6_d_constant_20_opt_io_o <= (others => '0');
            reg_0_d_constant_12_opt_io_o <= (others => '0');
            reg_1_d_multiplier_2_tc_io_o <= (others => '0');
            reg_0_d_constant_6_opt_io_o <= (others => '0');
            reg_10_d_constant_17_opt_io_o <= (others => '0');
            reg_8_d_constant_8_opt_io_o <= (others => '0');
            reg_12_d_constant_17_opt_io_o <= (others => '0');
            reg_20_d_constant_17_opt_io_o <= (others => '0');
            reg_3_d_constant_12_opt_io_o <= (others => '0');
            reg_0_l_multiplier_3_sint_mul_gen_addends_io_short <= (others => '0');
            reg_0_d_multiplier_sint_mul_gen_addends_io_addend_15 <= (others => '0');
            reg_0_d_subtractor_3_io_r <= (others => '0');
            reg_1_d_constant_22_opt_io_o <= (others => '0');
            reg_2_valid_chain <= (others => '0');
            reg_0_d_multiplier_1_sint_mul_gen_addends_io_subend <= (others => '0');
            reg_0_d_fract_3_io_o <= (others => '0');
            reg_0_d_multiplier_sint_mul_gen_addends_io_addend_23 <= (others => '0');
            reg_7_d_constant_20_opt_io_o <= (others => '0');
            reg_4_d_constant_13_opt_io_o <= (others => '0');
            reg_2_d_multiplier_2_tc_io_o <= (others => '0');
            reg_0_d_multiplier_4_sint_mul_adder_4_io_r <= (others => '0');
            reg_1_d_constant_2_opt_io_o <= (others => '0');
            reg_0_d_multiplier_3_sint_mul_adder_21_io_r <= (others => '0');
            reg_8_d_constant_14_opt_io_o <= (others => '0');
            reg_23_d_constant_16_opt_io_o <= (others => '0');
            reg_0_d_multiplier_4_sint_mul_adder_11_io_r <= (others => '0');
            reg_6_d_multiplier_4_tc_io_o <= (others => '0');
            reg_0_d_multiplier_2_sint_mul_gen_addends_io_subend <= (others => '0');
            reg_0_d_constant_22_opt_io_o <= (others => '0');
            reg_14_d_constant_14_opt_io_o <= (others => '0');
            reg_0_d_subtractor_4_io_r <= (others => '0');
            reg_3_d_multiplier_3_sint_mul_gen_addends_io_subend <= (others => '0');
            reg_10_d_constant_9_opt_io_o <= (others => '0');
            reg_19_d_constant_19_opt_io_o <= (others => '0');
            reg_1_d_constant_7_opt_io_o <= (others => '0');
            reg_2_d_constant_6_opt_io_o <= (others => '0');
            reg_5_d_multiplier_4_tc_io_o <= (others => '0');
            reg_0_d_multiplier_1_sint_mul_gen_addends_io_addend_27 <= (others => '0');
            reg_0_d_constant_19_opt_io_o <= (others => '0');
            reg_9_d_constant_18_opt_io_o <= (others => '0');
            reg_0_d_constant_17_opt_io_o <= (others => '0');
            reg_0_d_multiplier_4_sint_mul_adder_17_io_r <= (others => '0');
            reg_11_valid_chain <= (others => '0');
            reg_11_d_constant_17_opt_io_o <= (others => '0');
            reg_4_d_constant_16_opt_io_o <= (others => '0');
            reg_5_d_constant_8_opt_io_o <= (others => '0');
            reg_10_d_to_sfixed_1_io_o <= (others => '0');
            reg_13_d_constant_17_opt_io_o <= (others => '0');
            reg_5_d_constant_16_opt_io_o <= (others => '0');
            reg_1_d_multiplier_1_sint_mul_adder_21_io_r <= (others => '0');
            reg_0_d_ceil_io_o <= (others => '0');
            reg_0_d_multiplier_3_sint_mul_adder_14_io_r <= (others => '0');
            reg_0_d_multiplier_sint_mul_adder_7_io_r <= (others => '0');
            reg_0_d_multiplier_4_sint_mul_adder_19_io_r <= (others => '0');
            reg_0_d_multiplier_sint_mul_gen_addends_io_addend_20 <= (others => '0');
            reg_5_d_constant_17_opt_io_o <= (others => '0');
            reg_2_d_constant_19_opt_io_o <= (others => '0');
            reg_0_d_multiplier_2_tc_io_o <= (others => '0');
            reg_0_d_multiplier_sint_mul_adder_17_io_r <= (others => '0');
            reg_0_d_multiplier_4_sint_mul_adder_5_io_r <= (others => '0');
            reg_2_d_multiplier_sint_mul_gen_addends_io_subend <= (others => '0');
            reg_9_d_constant_13_opt_io_o <= (others => '0');
            reg_11_d_constant_21_opt_io_o <= (others => '0');
            reg_4_d_constant_8_opt_io_o <= (others => '0');
            reg_14_d_constant_20_opt_io_o <= (others => '0');
            reg_11_d_constant_14_opt_io_o <= (others => '0');
            reg_3_l_mux_io_i1 <= (others => '0');
            reg_23_d_constant_19_opt_io_o <= (others => '0');
            reg_19_d_constant_22_opt_io_o <= (others => '0');
            reg_8_d_constant_12_opt_io_o <= (others => '0');
            reg_17_d_constant_20_opt_io_o <= (others => '0');
            reg_0_d_multiplier_1_sint_mul_gen_addends_io_addend_17 <= (others => '0');
            reg_3_d_constant_17_opt_io_o <= (others => '0');
            reg_4_d_constant_7_opt_io_o <= (others => '0');
            reg_0_d_multiplier_3_sint_mul_adder_7_io_r <= (others => '0');
            reg_13_d_constant_12_opt_io_o <= (others => '0');
            reg_1_d_constant_19_opt_io_o <= (others => '0');
            reg_7_d_constant_16_opt_io_o <= (others => '0');
            reg_4_d_multiplier_3_sint_mul_gen_addends_io_subend <= (others => '0');
            reg_0_d_min_1_io_o <= (others => '0');
            reg_5_d_constant_12_opt_io_o <= (others => '0');
            reg_5_d_constant_14_opt_io_o <= (others => '0');
            reg_11_d_constant_19_opt_io_o <= (others => '0');
            reg_0_d_constant_11_opt_io_o <= (others => '0');
            reg_14_d_constant_16_opt_io_o <= (others => '0');
            reg_9_d_constant_21_opt_io_o <= (others => '0');
            reg_3_valid_chain <= (others => '0');
            reg_10_d_constant_15_opt_io_o <= (others => '0');
            reg_13_d_constant_14_opt_io_o <= (others => '0');
            reg_0_d_multiplier_sint_mul_gen_addends_io_addend_17 <= (others => '0');
            reg_0_d_shifter_13_io_o <= (others => '0');
            reg_0_d_constant_18_opt_io_o <= (others => '0');
            reg_4_d_to_sfixed_1_io_o <= (others => '0');
            reg_17_d_constant_12_opt_io_o <= (others => '0');
            reg_11_d_constant_13_opt_io_o <= (others => '0');
            reg_10_d_constant_18_opt_io_o <= (others => '0');
            reg_6_d_constant_19_opt_io_o <= (others => '0');
            reg_12_d_constant_22_opt_io_o <= (others => '0');
            reg_9_d_to_sfixed_1_io_o <= (others => '0');
            reg_2_d_constant_8_opt_io_o <= (others => '0');
            reg_1_d_constant_15_opt_io_o <= (others => '0');
            reg_4_d_constant_14_opt_io_o <= (others => '0');
            reg_1_l_mux_io_i1 <= (others => '0');
            reg_14_d_constant_18_opt_io_o <= (others => '0');
            reg_12_d_constant_13_opt_io_o <= (others => '0');
            reg_5_valid_chain <= (others => '0');
            reg_14_d_constant_19_opt_io_o <= (others => '0');
            reg_0_d_constant_1_opt_io_o <= (others => '0');
            reg_0_d_multiplier_1_sint_mul_gen_addends_io_addend_14 <= (others => '0');
            reg_0_d_constant_8_opt_io_o <= (others => '0');
            reg_0_d_multiplier_tc_io_o <= (others => '0');
            reg_7_valid_chain <= (others => '0');
            reg_25_valid_chain <= (others => '0');
            reg_3_d_multiplier_4_sint_mul_gen_addends_io_subend <= (others => '0');
            reg_12_d_constant_18_opt_io_o <= (others => '0');
            reg_0_d_multiplier_3_sint_mul_adder_20_io_r <= (others => '0');
            reg_4_d_subtractor_9_io_r <= (others => '0');
            reg_0_d_multiplier_sint_mul_gen_addends_io_subend <= (others => '0');
            reg_0_d_multiplier_1_sint_mul_adder_17_io_r <= (others => '0');
            reg_4_d_constant_15_opt_io_o <= (others => '0');
            reg_15_d_constant_20_opt_io_o <= (others => '0');
            reg_8_d_constant_21_opt_io_o <= (others => '0');
            reg_7_d_constant_21_opt_io_o <= (others => '0');
            reg_0_d_multiplier_2_sint_mul_adder_4_io_r <= (others => '0');
            reg_2_d_constant_20_opt_io_o <= (others => '0');
            reg_18_d_constant_13_opt_io_o <= (others => '0');
            reg_0_l_min_1_io_a <= (others => '0');
            reg_2_d_constant_12_opt_io_o <= (others => '0');
            reg_2_d_subtractor_9_io_r <= (others => '0');
            reg_3_d_constant_18_opt_io_o <= (others => '0');
            reg_2_d_multiplier_sint_mul_adder_21_io_r <= (others => '0');
            reg_16_d_constant_19_opt_io_o <= (others => '0');
            reg_21_d_constant_21_opt_io_o <= (others => '0');
            reg_2_d_constant_18_opt_io_o <= (others => '0');
            reg_12_d_constant_20_opt_io_o <= (others => '0');
            reg_3_d_constant_20_opt_io_o <= (others => '0');
            reg_1_d_constant_18_opt_io_o <= (others => '0');
            reg_2_d_constant_7_opt_io_o <= (others => '0');
            reg_1_d_multiplier_3_sint_mul_gen_addends_io_subend <= (others => '0');
            reg_11_d_constant_20_opt_io_o <= (others => '0');
            reg_14_d_constant_13_opt_io_o <= (others => '0');
            reg_20_d_constant_19_opt_io_o <= (others => '0');
            reg_9_d_constant_15_opt_io_o <= (others => '0');
            reg_3_d_constant_7_opt_io_o <= (others => '0');
            reg_1_d_constant_5_opt_io_o <= (others => '0');
            reg_9_d_constant_22_opt_io_o <= (others => '0');
            reg_23_d_constant_20_opt_io_o <= (others => '0');
            reg_5_d_constant_10_opt_io_o <= (others => '0');
            reg_20_valid_chain <= (others => '0');
            reg_1_d_multiplier_4_sint_mul_adder_20_io_r <= (others => '0');
            reg_0_d_multiplier_1_sint_mul_adder_6_io_r <= (others => '0');
            reg_0_d_multiplier_1_sint_mul_adder_25_io_r <= (others => '0');
            reg_7_d_constant_9_opt_io_o <= (others => '0');
            reg_13_d_constant_19_opt_io_o <= (others => '0');
            reg_5_d_constant_18_opt_io_o <= (others => '0');
            reg_15_d_constant_22_opt_io_o <= (others => '0');
            reg_12_d_constant_16_opt_io_o <= (others => '0');
            reg_6_d_constant_16_opt_io_o <= (others => '0');
            reg_22_valid_chain <= (others => '0');
            reg_10_d_constant_21_opt_io_o <= (others => '0');
            reg_2_d_constant_2_opt_io_o <= (others => '0');
            reg_0_d_multiplier_4_sint_mul_adder_7_io_r <= (others => '0');
            reg_4_d_constant_22_opt_io_o <= (others => '0');
            reg_6_d_constant_8_opt_io_o <= (others => '0');
            reg_0_d_multiplier_2_sint_mul_adder_15_io_r <= (others => '0');
            reg_20_d_constant_16_opt_io_o <= (others => '0');
            reg_12_d_constant_19_opt_io_o <= (others => '0');
            reg_5_d_to_sfixed_1_io_o <= (others => '0');
            reg_2_d_to_sfixed_1_io_o <= (others => '0');
            reg_3_d_constant_22_opt_io_o <= (others => '0');
            reg_6_d_constant_17_opt_io_o <= (others => '0');
            reg_7_d_constant_13_opt_io_o <= (others => '0');
            reg_19_d_constant_20_opt_io_o <= (others => '0');
            reg_0_d_multiplier_1_sint_mul_gen_addends_io_addend_16 <= (others => '0');
            reg_0_d_shifter_12_io_o <= (others => '0');
            reg_19_d_constant_13_opt_io_o <= (others => '0');
            reg_20_d_constant_20_opt_io_o <= (others => '0');
            reg_17_d_constant_21_opt_io_o <= (others => '0');
            reg_0_d_multiplier_4_sint_mul_adder_8_io_r <= (others => '0');
            reg_0_d_max_io_o <= (others => '0');
            reg_3_d_subtractor_9_io_r <= (others => '0');
            reg_16_d_constant_21_opt_io_o <= (others => '0');
            reg_0_d_multiplier_1_sint_mul_gen_addends_io_addend_20 <= (others => '0');
            reg_0_d_multiplier_2_sint_mul_adder_17_io_r <= (others => '0');
            reg_7_d_constant_8_opt_io_o <= (others => '0');
            reg_0_d_fract_io_o <= (others => '0');
            reg_1_d_multiplier_4_tc_io_o <= (others => '0');
            reg_14_d_constant_21_opt_io_o <= (others => '0');
            reg_2_d_constant_17_opt_io_o <= (others => '0');
            reg_0_d_multiplier_sint_mul_gen_addends_io_addend_25 <= (others => '0');
            reg_19_d_constant_18_opt_io_o <= (others => '0');
            reg_2_d_constant_3_opt_io_o <= (others => '0');
            reg_2_d_constant_9_opt_io_o <= (others => '0');
            reg_1_d_constant_14_opt_io_o <= (others => '0');
            reg_3_d_constant_15_opt_io_o <= (others => '0');
            reg_0_d_multiplier_1_sint_mul_gen_addends_io_addend_22 <= (others => '0');
            reg_19_valid_chain <= (others => '0');
            reg_0_d_multiplier_sint_mul_adder_25_io_r <= (others => '0');
            reg_16_d_constant_22_opt_io_o <= (others => '0');
            reg_0_d_constant_21_opt_io_o <= (others => '0');
            reg_7_d_constant_14_opt_io_o <= (others => '0');
            reg_18_d_constant_16_opt_io_o <= (others => '0');
            reg_7_d_constant_17_opt_io_o <= (others => '0');
            reg_0_l_ceil_1_io_i <= (others => '0');
            reg_3_d_multiplier_sint_mul_gen_addends_io_subend <= (others => '0');
            reg_3_d_multiplier_4_tc_io_o <= (others => '0');
            reg_1_d_multiplier_1_sint_mul_adder_19_io_r <= (others => '0');
            reg_18_d_constant_22_opt_io_o <= (others => '0');
            reg_0_d_multiplier_1_sint_mul_adder_24_io_r <= (others => '0');
            reg_0_d_shifter_11_io_o <= (others => '0');
            reg_18_d_constant_18_opt_io_o <= (others => '0');
            reg_9_d_constant_9_opt_io_o <= (others => '0');
            reg_3_d_constant_10_opt_io_o <= (others => '0');
            reg_9_d_constant_8_opt_io_o <= (others => '0');
            reg_11_d_constant_16_opt_io_o <= (others => '0');
            reg_10_d_constant_20_opt_io_o <= (others => '0');
            reg_2_d_multiplier_1_sint_mul_adder_16_io_r <= (others => '0');
            reg_17_valid_chain <= (others => '0');
            reg_0_d_multiplier_1_sint_mul_adder_7_io_r <= (others => '0');
            reg_8_d_constant_18_opt_io_o <= (others => '0');
            reg_0_d_multiplier_sint_mul_adder_9_io_r <= (others => '0');
            reg_2_d_multiplier_3_sint_mul_gen_addends_io_subend <= (others => '0');
            reg_0_d_constant_10_opt_io_o <= (others => '0');
        elsif rising_edge(clock) and in_ready_and_in_valid = "1" then
            reg_8_valid_chain <= reg_next_8_valid_chain;
            reg_1_d_multiplier_4_sint_mul_adder_21_io_r <= reg_next_1_d_multiplier_4_sint_mul_adder_21_io_r;
            reg_4_d_multiplier_2_tc_io_o <= reg_next_4_d_multiplier_2_tc_io_o;
            reg_0_d_multiplier_3_sint_mul_adder_26_io_r <= reg_next_0_d_multiplier_3_sint_mul_adder_26_io_r;
            reg_0_d_constant_16_opt_io_o <= reg_next_0_d_constant_16_opt_io_o;
            reg_3_d_constant_9_opt_io_o <= reg_next_3_d_constant_9_opt_io_o;
            reg_5_d_constant_22_opt_io_o <= reg_next_5_d_constant_22_opt_io_o;
            reg_0_d_adder_io_r <= reg_next_0_d_adder_io_r;
            reg_5_d_constant_13_opt_io_o <= reg_next_5_d_constant_13_opt_io_o;
            reg_23_d_constant_21_opt_io_o <= reg_next_23_d_constant_21_opt_io_o;
            reg_0_d_to_sfixed_1_io_o <= reg_next_0_d_to_sfixed_1_io_o;
            reg_0_d_constant_7_opt_io_o <= reg_next_0_d_constant_7_opt_io_o;
            reg_14_d_constant_12_opt_io_o <= reg_next_14_d_constant_12_opt_io_o;
            reg_20_d_constant_13_opt_io_o <= reg_next_20_d_constant_13_opt_io_o;
            reg_15_d_constant_12_opt_io_o <= reg_next_15_d_constant_12_opt_io_o;
            reg_19_d_constant_14_opt_io_o <= reg_next_19_d_constant_14_opt_io_o;
            reg_2_d_multiplier_1_sint_mul_gen_addends_io_subend <= reg_next_2_d_multiplier_1_sint_mul_gen_addends_io_subend;
            reg_0_d_multiplier_3_sint_mul_adder_24_io_r <= reg_next_0_d_multiplier_3_sint_mul_adder_24_io_r;
            reg_0_d_fract_1_io_o <= reg_next_0_d_fract_1_io_o;
            reg_0_d_multiplier_3_sint_mul_adder_16_io_r <= reg_next_0_d_multiplier_3_sint_mul_adder_16_io_r;
            reg_4_d_constant_17_opt_io_o <= reg_next_4_d_constant_17_opt_io_o;
            reg_22_d_constant_20_opt_io_o <= reg_next_22_d_constant_20_opt_io_o;
            reg_0_d_multiplier_1_sint_mul_adder_20_io_r <= reg_next_0_d_multiplier_1_sint_mul_adder_20_io_r;
            reg_0_d_shifter_5_io_o <= reg_next_0_d_shifter_5_io_o;
            reg_0_d_multiplier_4_sint_mul_adder_6_io_r <= reg_next_0_d_multiplier_4_sint_mul_adder_6_io_r;
            reg_6_d_constant_18_opt_io_o <= reg_next_6_d_constant_18_opt_io_o;
            reg_0_d_multiplier_4_tc_io_o <= reg_next_0_d_multiplier_4_tc_io_o;
            reg_0_d_multiplier_sint_mul_gen_addends_io_addend_21 <= reg_next_0_d_multiplier_sint_mul_gen_addends_io_addend_21;
            reg_0_d_multiplier_sint_mul_gen_addends_io_addend_12 <= reg_next_0_d_multiplier_sint_mul_gen_addends_io_addend_12;
            reg_0_d_subtractor_9_io_r <= reg_next_0_d_subtractor_9_io_r;
            reg_9_d_constant_20_opt_io_o <= reg_next_9_d_constant_20_opt_io_o;
            reg_7_d_constant_22_opt_io_o <= reg_next_7_d_constant_22_opt_io_o;
            reg_6_d_to_sfixed_1_io_o <= reg_next_6_d_to_sfixed_1_io_o;
            reg_0_d_multiplier_3_sint_mul_adder_19_io_r <= reg_next_0_d_multiplier_3_sint_mul_adder_19_io_r;
            reg_0_d_multiplier_sint_mul_adder_18_io_r <= reg_next_0_d_multiplier_sint_mul_adder_18_io_r;
            reg_1_d_constant_9_opt_io_o <= reg_next_1_d_constant_9_opt_io_o;
            reg_9_d_constant_19_opt_io_o <= reg_next_9_d_constant_19_opt_io_o;
            reg_5_d_constant_19_opt_io_o <= reg_next_5_d_constant_19_opt_io_o;
            reg_1_d_multiplier_sint_mul_gen_addends_io_subend <= reg_next_1_d_multiplier_sint_mul_gen_addends_io_subend;
            reg_0_valid_chain <= reg_next_0_valid_chain;
            reg_13_d_constant_16_opt_io_o <= reg_next_13_d_constant_16_opt_io_o;
            reg_1_d_multiplier_sint_mul_adder_19_io_r <= reg_next_1_d_multiplier_sint_mul_adder_19_io_r;
            reg_0_d_multiplier_sint_mul_adder_20_io_r <= reg_next_0_d_multiplier_sint_mul_adder_20_io_r;
            reg_9_d_constant_14_opt_io_o <= reg_next_9_d_constant_14_opt_io_o;
            reg_20_d_constant_14_opt_io_o <= reg_next_20_d_constant_14_opt_io_o;
            reg_1_d_constant_4_opt_io_o <= reg_next_1_d_constant_4_opt_io_o;
            reg_22_d_constant_18_opt_io_o <= reg_next_22_d_constant_18_opt_io_o;
            reg_0_d_multiplier_sint_mul_adder_16_io_r <= reg_next_0_d_multiplier_sint_mul_adder_16_io_r;
            reg_1_d_constant_3_opt_io_o <= reg_next_1_d_constant_3_opt_io_o;
            reg_0_d_multiplier_sint_mul_gen_addends_io_addend_26 <= reg_next_0_d_multiplier_sint_mul_gen_addends_io_addend_26;
            reg_4_d_constant_12_opt_io_o <= reg_next_4_d_constant_12_opt_io_o;
            reg_0_d_multiplier_3_sint_mul_adder_15_io_r <= reg_next_0_d_multiplier_3_sint_mul_adder_15_io_r;
            reg_0_d_adder_1_io_r <= reg_next_0_d_adder_1_io_r;
            reg_0_d_multiplier_4_sint_mul_adder_24_io_r <= reg_next_0_d_multiplier_4_sint_mul_adder_24_io_r;
            reg_0_d_multiplier_1_tc_io_o <= reg_next_0_d_multiplier_1_tc_io_o;
            reg_8_d_constant_9_opt_io_o <= reg_next_8_d_constant_9_opt_io_o;
            reg_22_d_constant_19_opt_io_o <= reg_next_22_d_constant_19_opt_io_o;
            reg_0_d_multiplier_sint_mul_gen_addends_io_addend_27 <= reg_next_0_d_multiplier_sint_mul_gen_addends_io_addend_27;
            reg_1_d_multiplier_1_sint_mul_adder_20_io_r <= reg_next_1_d_multiplier_1_sint_mul_adder_20_io_r;
            reg_0_d_multiplier_4_sint_mul_adder_25_io_r <= reg_next_0_d_multiplier_4_sint_mul_adder_25_io_r;
            reg_18_d_constant_20_opt_io_o <= reg_next_18_d_constant_20_opt_io_o;
            reg_7_d_constant_12_opt_io_o <= reg_next_7_d_constant_12_opt_io_o;
            reg_12_d_constant_12_opt_io_o <= reg_next_12_d_constant_12_opt_io_o;
            reg_2_d_constant_15_opt_io_o <= reg_next_2_d_constant_15_opt_io_o;
            reg_15_d_constant_18_opt_io_o <= reg_next_15_d_constant_18_opt_io_o;
            reg_23_valid_chain <= reg_next_23_valid_chain;
            reg_0_d_constant_5_opt_io_o <= reg_next_0_d_constant_5_opt_io_o;
            reg_0_d_multiplier_sint_mul_adder_21_io_r <= reg_next_0_d_multiplier_sint_mul_adder_21_io_r;
            reg_0_d_multiplier_3_sint_mul_adder_23_io_r <= reg_next_0_d_multiplier_3_sint_mul_adder_23_io_r;
            reg_1_d_constant_21_opt_io_o <= reg_next_1_d_constant_21_opt_io_o;
            reg_0_d_constant_14_opt_io_o <= reg_next_0_d_constant_14_opt_io_o;
            reg_0_d_multiplier_3_sint_mul_adder_5_io_r <= reg_next_0_d_multiplier_3_sint_mul_adder_5_io_r;
            reg_16_d_constant_13_opt_io_o <= reg_next_16_d_constant_13_opt_io_o;
            reg_18_d_constant_14_opt_io_o <= reg_next_18_d_constant_14_opt_io_o;
            reg_8_d_to_sfixed_1_io_o <= reg_next_8_d_to_sfixed_1_io_o;
            reg_19_d_constant_17_opt_io_o <= reg_next_19_d_constant_17_opt_io_o;
            reg_1_valid_chain <= reg_next_1_valid_chain;
            reg_0_d_multiplier_sint_mul_gen_addends_io_addend_22 <= reg_next_0_d_multiplier_sint_mul_gen_addends_io_addend_22;
            reg_0_d_multiplier_4_sint_mul_adder_13_io_r <= reg_next_0_d_multiplier_4_sint_mul_adder_13_io_r;
            reg_0_l_ceil_io_i <= reg_next_0_l_ceil_io_i;
            reg_0_d_constant_2_opt_io_o <= reg_next_0_d_constant_2_opt_io_o;
            reg_14_d_constant_17_opt_io_o <= reg_next_14_d_constant_17_opt_io_o;
            reg_18_d_constant_12_opt_io_o <= reg_next_18_d_constant_12_opt_io_o;
            reg_24_d_constant_18_opt_io_o <= reg_next_24_d_constant_18_opt_io_o;
            reg_23_d_constant_17_opt_io_o <= reg_next_23_d_constant_17_opt_io_o;
            reg_1_d_constant_13_opt_io_o <= reg_next_1_d_constant_13_opt_io_o;
            reg_6_d_constant_11_opt_io_o <= reg_next_6_d_constant_11_opt_io_o;
            reg_0_d_multiplier_4_sint_mul_adder_23_io_r <= reg_next_0_d_multiplier_4_sint_mul_adder_23_io_r;
            reg_21_d_constant_14_opt_io_o <= reg_next_21_d_constant_14_opt_io_o;
            reg_13_d_constant_20_opt_io_o <= reg_next_13_d_constant_20_opt_io_o;
            reg_10_d_constant_19_opt_io_o <= reg_next_10_d_constant_19_opt_io_o;
            reg_0_d_multiplier_1_sint_mul_adder_16_io_r <= reg_next_0_d_multiplier_1_sint_mul_adder_16_io_r;
            reg_11_d_constant_11_opt_io_o <= reg_next_11_d_constant_11_opt_io_o;
            reg_0_d_multiplier_4_sint_mul_adder_20_io_r <= reg_next_0_d_multiplier_4_sint_mul_adder_20_io_r;
            reg_0_d_multiplier_sint_mul_adder_8_io_r <= reg_next_0_d_multiplier_sint_mul_adder_8_io_r;
            reg_1_d_multiplier_1_sint_mul_adder_16_io_r <= reg_next_1_d_multiplier_1_sint_mul_adder_16_io_r;
            reg_17_d_constant_19_opt_io_o <= reg_next_17_d_constant_19_opt_io_o;
            reg_4_d_constant_11_opt_io_o <= reg_next_4_d_constant_11_opt_io_o;
            reg_15_d_constant_17_opt_io_o <= reg_next_15_d_constant_17_opt_io_o;
            reg_0_d_multiplier_1_sint_mul_adder_19_io_r <= reg_next_0_d_multiplier_1_sint_mul_adder_19_io_r;
            reg_4_d_constant_18_opt_io_o <= reg_next_4_d_constant_18_opt_io_o;
            reg_20_d_constant_18_opt_io_o <= reg_next_20_d_constant_18_opt_io_o;
            reg_16_d_constant_20_opt_io_o <= reg_next_16_d_constant_20_opt_io_o;
            reg_21_d_constant_22_opt_io_o <= reg_next_21_d_constant_22_opt_io_o;
            reg_17_d_constant_22_opt_io_o <= reg_next_17_d_constant_22_opt_io_o;
            reg_0_d_multiplier_1_sint_mul_gen_addends_io_addend_21 <= reg_next_0_d_multiplier_1_sint_mul_gen_addends_io_addend_21;
            reg_4_d_multiplier_4_sint_mul_gen_addends_io_subend <= reg_next_4_d_multiplier_4_sint_mul_gen_addends_io_subend;
            reg_15_d_constant_16_opt_io_o <= reg_next_15_d_constant_16_opt_io_o;
            reg_20_d_constant_21_opt_io_o <= reg_next_20_d_constant_21_opt_io_o;
            reg_0_d_multiplier_3_sint_mul_adder_4_io_r <= reg_next_0_d_multiplier_3_sint_mul_adder_4_io_r;
            reg_14_valid_chain <= reg_next_14_valid_chain;
            reg_3_d_to_sfixed_1_io_o <= reg_next_3_d_to_sfixed_1_io_o;
            reg_19_d_constant_16_opt_io_o <= reg_next_19_d_constant_16_opt_io_o;
            reg_10_d_constant_16_opt_io_o <= reg_next_10_d_constant_16_opt_io_o;
            reg_11_d_constant_12_opt_io_o <= reg_next_11_d_constant_12_opt_io_o;
            reg_17_d_constant_14_opt_io_o <= reg_next_17_d_constant_14_opt_io_o;
            reg_0_d_multiplier_sint_mul_gen_addends_io_addend_14 <= reg_next_0_d_multiplier_sint_mul_gen_addends_io_addend_14;
            reg_0_d_constant_20_opt_io_o <= reg_next_0_d_constant_20_opt_io_o;
            reg_4_d_constant_19_opt_io_o <= reg_next_4_d_constant_19_opt_io_o;
            reg_1_d_constant_10_opt_io_o <= reg_next_1_d_constant_10_opt_io_o;
            reg_21_d_constant_16_opt_io_o <= reg_next_21_d_constant_16_opt_io_o;
            reg_3_d_constant_11_opt_io_o <= reg_next_3_d_constant_11_opt_io_o;
            reg_3_d_constant_4_opt_io_o <= reg_next_3_d_constant_4_opt_io_o;
            reg_0_d_multiplier_4_sint_mul_adder_16_io_r <= reg_next_0_d_multiplier_4_sint_mul_adder_16_io_r;
            reg_0_d_multiplier_sint_mul_adder_19_io_r <= reg_next_0_d_multiplier_sint_mul_adder_19_io_r;
            reg_6_d_constant_21_opt_io_o <= reg_next_6_d_constant_21_opt_io_o;
            reg_5_d_constant_15_opt_io_o <= reg_next_5_d_constant_15_opt_io_o;
            reg_9_d_constant_16_opt_io_o <= reg_next_9_d_constant_16_opt_io_o;
            reg_0_d_multiplier_4_sint_mul_adder_12_io_r <= reg_next_0_d_multiplier_4_sint_mul_adder_12_io_r;
            reg_0_d_multiplier_1_sint_mul_gen_addends_io_addend_25 <= reg_next_0_d_multiplier_1_sint_mul_gen_addends_io_addend_25;
            reg_0_d_adder_7_io_r <= reg_next_0_d_adder_7_io_r;
            reg_8_d_constant_16_opt_io_o <= reg_next_8_d_constant_16_opt_io_o;
            reg_15_d_constant_19_opt_io_o <= reg_next_15_d_constant_19_opt_io_o;
            reg_2_d_constant_11_opt_io_o <= reg_next_2_d_constant_11_opt_io_o;
            reg_2_d_multiplier_4_sint_mul_gen_addends_io_subend <= reg_next_2_d_multiplier_4_sint_mul_gen_addends_io_subend;
            reg_10_d_constant_22_opt_io_o <= reg_next_10_d_constant_22_opt_io_o;
            reg_0_d_multiplier_4_sint_mul_adder_18_io_r <= reg_next_0_d_multiplier_4_sint_mul_adder_18_io_r;
            reg_5_d_constant_9_opt_io_o <= reg_next_5_d_constant_9_opt_io_o;
            reg_24_d_constant_22_opt_io_o <= reg_next_24_d_constant_22_opt_io_o;
            reg_22_d_constant_16_opt_io_o <= reg_next_22_d_constant_16_opt_io_o;
            reg_0_d_subtractor_io_r <= reg_next_0_d_subtractor_io_r;
            reg_0_d_subtractor_11_io_r <= reg_next_0_d_subtractor_11_io_r;
            reg_0_d_multiplier_1_sint_mul_gen_addends_io_addend_15 <= reg_next_0_d_multiplier_1_sint_mul_gen_addends_io_addend_15;
            reg_5_d_constant_20_opt_io_o <= reg_next_5_d_constant_20_opt_io_o;
            reg_3_d_multiplier_2_tc_io_o <= reg_next_3_d_multiplier_2_tc_io_o;
            reg_24_valid_chain <= reg_next_24_valid_chain;
            reg_0_d_multiplier_sint_mul_gen_addends_io_addend_16 <= reg_next_0_d_multiplier_sint_mul_gen_addends_io_addend_16;
            reg_6_d_constant_10_opt_io_o <= reg_next_6_d_constant_10_opt_io_o;
            reg_8_d_constant_11_opt_io_o <= reg_next_8_d_constant_11_opt_io_o;
            reg_8_d_constant_17_opt_io_o <= reg_next_8_d_constant_17_opt_io_o;
            reg_10_d_constant_12_opt_io_o <= reg_next_10_d_constant_12_opt_io_o;
            reg_6_d_constant_14_opt_io_o <= reg_next_6_d_constant_14_opt_io_o;
            reg_0_d_constant_13_opt_io_o <= reg_next_0_d_constant_13_opt_io_o;
            reg_2_d_multiplier_sint_mul_adder_16_io_r <= reg_next_2_d_multiplier_sint_mul_adder_16_io_r;
            reg_0_d_multiplier_3_sint_mul_adder_0_io_r <= reg_next_0_d_multiplier_3_sint_mul_adder_0_io_r;
            reg_1_d_constant_6_opt_io_o <= reg_next_1_d_constant_6_opt_io_o;
            reg_2_d_multiplier_4_sint_mul_adder_21_io_r <= reg_next_2_d_multiplier_4_sint_mul_adder_21_io_r;
            reg_0_d_multiplier_1_sint_mul_adder_9_io_r <= reg_next_0_d_multiplier_1_sint_mul_adder_9_io_r;
            reg_2_l_mux_io_i1 <= reg_next_2_l_mux_io_i1;
            reg_16_d_constant_14_opt_io_o <= reg_next_16_d_constant_14_opt_io_o;
            reg_22_d_constant_21_opt_io_o <= reg_next_22_d_constant_21_opt_io_o;
            reg_10_d_constant_13_opt_io_o <= reg_next_10_d_constant_13_opt_io_o;
            reg_0_d_subtractor_2_io_r <= reg_next_0_d_subtractor_2_io_r;
            reg_1_d_multiplier_sint_mul_adder_20_io_r <= reg_next_1_d_multiplier_sint_mul_adder_20_io_r;
            reg_13_d_constant_13_opt_io_o <= reg_next_13_d_constant_13_opt_io_o;
            reg_0_d_multiplier_2_sint_mul_adder_14_io_r <= reg_next_0_d_multiplier_2_sint_mul_adder_14_io_r;
            reg_0_d_multiplier_sint_mul_adder_24_io_r <= reg_next_0_d_multiplier_sint_mul_adder_24_io_r;
            reg_0_d_multiplier_3_sint_mul_adder_18_io_r <= reg_next_0_d_multiplier_3_sint_mul_adder_18_io_r;
            reg_7_d_constant_15_opt_io_o <= reg_next_7_d_constant_15_opt_io_o;
            reg_0_d_multiplier_1_sint_mul_gen_addends_io_addend_13 <= reg_next_0_d_multiplier_1_sint_mul_gen_addends_io_addend_13;
            reg_18_d_constant_19_opt_io_o <= reg_next_18_d_constant_19_opt_io_o;
            reg_0_d_multiplier_2_sint_mul_adder_25_io_r <= reg_next_0_d_multiplier_2_sint_mul_adder_25_io_r;
            reg_6_d_constant_9_opt_io_o <= reg_next_6_d_constant_9_opt_io_o;
            reg_7_d_constant_18_opt_io_o <= reg_next_7_d_constant_18_opt_io_o;
            reg_3_d_constant_14_opt_io_o <= reg_next_3_d_constant_14_opt_io_o;
            reg_16_d_constant_18_opt_io_o <= reg_next_16_d_constant_18_opt_io_o;
            reg_3_d_constant_19_opt_io_o <= reg_next_3_d_constant_19_opt_io_o;
            reg_0_d_multiplier_1_sint_mul_gen_addends_io_addend_12 <= reg_next_0_d_multiplier_1_sint_mul_gen_addends_io_addend_12;
            reg_0_d_multiplier_3_sint_mul_adder_25_io_r <= reg_next_0_d_multiplier_3_sint_mul_adder_25_io_r;
            reg_0_l_mux_io_i1 <= reg_next_0_l_mux_io_i1;
            reg_1_d_constant_12_opt_io_o <= reg_next_1_d_constant_12_opt_io_o;
            reg_0_d_multiplier_1_sint_mul_gen_addends_io_addend_24 <= reg_next_0_d_multiplier_1_sint_mul_gen_addends_io_addend_24;
            reg_0_d_multiplier_1_sint_mul_gen_addends_io_addend_23 <= reg_next_0_d_multiplier_1_sint_mul_gen_addends_io_addend_23;
            reg_0_d_concatenator_io_o <= reg_next_0_d_concatenator_io_o;
            reg_0_d_multiplier_4_sint_mul_adder_22_io_r <= reg_next_0_d_multiplier_4_sint_mul_adder_22_io_r;
            reg_9_d_constant_12_opt_io_o <= reg_next_9_d_constant_12_opt_io_o;
            reg_0_d_multiplier_3_tc_io_o <= reg_next_0_d_multiplier_3_tc_io_o;
            reg_1_d_constant_11_opt_io_o <= reg_next_1_d_constant_11_opt_io_o;
            reg_0_d_multiplier_3_sint_mul_gen_addends_io_subend <= reg_next_0_d_multiplier_3_sint_mul_gen_addends_io_subend;
            reg_23_d_constant_18_opt_io_o <= reg_next_23_d_constant_18_opt_io_o;
            reg_3_d_constant_21_opt_io_o <= reg_next_3_d_constant_21_opt_io_o;
            reg_13_d_constant_22_opt_io_o <= reg_next_13_d_constant_22_opt_io_o;
            reg_0_d_multiplier_3_sint_mul_adder_12_io_r <= reg_next_0_d_multiplier_3_sint_mul_adder_12_io_r;
            reg_12_valid_chain <= reg_next_12_valid_chain;
            reg_4_l_mux_io_i1 <= reg_next_4_l_mux_io_i1;
            reg_0_d_multiplier_sint_mul_gen_addends_io_addend_19 <= reg_next_0_d_multiplier_sint_mul_gen_addends_io_addend_19;
            reg_8_d_constant_22_opt_io_o <= reg_next_8_d_constant_22_opt_io_o;
            reg_0_d_min_io_o <= reg_next_0_d_min_io_o;
            reg_0_d_multiplier_4_sint_mul_gen_addends_io_subend <= reg_next_0_d_multiplier_4_sint_mul_gen_addends_io_subend;
            reg_0_d_slicer_io_o <= reg_next_0_d_slicer_io_o;
            reg_9_d_constant_17_opt_io_o <= reg_next_9_d_constant_17_opt_io_o;
            reg_2_d_constant_21_opt_io_o <= reg_next_2_d_constant_21_opt_io_o;
            reg_13_valid_chain <= reg_next_13_valid_chain;
            reg_15_d_constant_21_opt_io_o <= reg_next_15_d_constant_21_opt_io_o;
            reg_22_d_constant_22_opt_io_o <= reg_next_22_d_constant_22_opt_io_o;
            reg_0_d_multiplier_3_sint_mul_adder_17_io_r <= reg_next_0_d_multiplier_3_sint_mul_adder_17_io_r;
            reg_1_d_constant_16_opt_io_o <= reg_next_1_d_constant_16_opt_io_o;
            reg_4_d_constant_6_opt_io_o <= reg_next_4_d_constant_6_opt_io_o;
            reg_0_d_constant_4_opt_io_o <= reg_next_0_d_constant_4_opt_io_o;
            reg_0_d_subtractor_12_io_r <= reg_next_0_d_subtractor_12_io_r;
            reg_4_d_constant_21_opt_io_o <= reg_next_4_d_constant_21_opt_io_o;
            reg_10_d_constant_11_opt_io_o <= reg_next_10_d_constant_11_opt_io_o;
            reg_23_d_constant_22_opt_io_o <= reg_next_23_d_constant_22_opt_io_o;
            reg_0_d_multiplier_1_sint_mul_gen_addends_io_addend_26 <= reg_next_0_d_multiplier_1_sint_mul_gen_addends_io_addend_26;
            reg_24_d_constant_21_opt_io_o <= reg_next_24_d_constant_21_opt_io_o;
            reg_0_l_min_io_a <= reg_next_0_l_min_io_a;
            reg_1_d_multiplier_3_sint_mul_adder_25_io_r <= reg_next_1_d_multiplier_3_sint_mul_adder_25_io_r;
            reg_10_d_constant_8_opt_io_o <= reg_next_10_d_constant_8_opt_io_o;
            reg_22_d_constant_17_opt_io_o <= reg_next_22_d_constant_17_opt_io_o;
            reg_0_d_multiplier_4_sint_mul_adder_10_io_r <= reg_next_0_d_multiplier_4_sint_mul_adder_10_io_r;
            reg_3_d_constant_16_opt_io_o <= reg_next_3_d_constant_16_opt_io_o;
            reg_21_d_constant_17_opt_io_o <= reg_next_21_d_constant_17_opt_io_o;
            reg_21_d_constant_18_opt_io_o <= reg_next_21_d_constant_18_opt_io_o;
            reg_2_d_multiplier_4_tc_io_o <= reg_next_2_d_multiplier_4_tc_io_o;
            reg_1_d_to_sfixed_1_io_o <= reg_next_1_d_to_sfixed_1_io_o;
            reg_5_d_constant_11_opt_io_o <= reg_next_5_d_constant_11_opt_io_o;
            reg_0_d_constant_15_opt_io_o <= reg_next_0_d_constant_15_opt_io_o;
            reg_8_d_constant_20_opt_io_o <= reg_next_8_d_constant_20_opt_io_o;
            reg_18_d_constant_21_opt_io_o <= reg_next_18_d_constant_21_opt_io_o;
            reg_16_d_constant_12_opt_io_o <= reg_next_16_d_constant_12_opt_io_o;
            reg_0_d_multiplier_sint_mul_gen_addends_io_addend_13 <= reg_next_0_d_multiplier_sint_mul_gen_addends_io_addend_13;
            reg_1_d_multiplier_1_sint_mul_gen_addends_io_subend <= reg_next_1_d_multiplier_1_sint_mul_gen_addends_io_subend;
            reg_3_d_constant_5_opt_io_o <= reg_next_3_d_constant_5_opt_io_o;
            reg_0_d_multiplier_3_sint_mul_adder_6_io_r <= reg_next_0_d_multiplier_3_sint_mul_adder_6_io_r;
            reg_11_d_constant_18_opt_io_o <= reg_next_11_d_constant_18_opt_io_o;
            reg_2_d_constant_4_opt_io_o <= reg_next_2_d_constant_4_opt_io_o;
            reg_0_d_constant_9_opt_io_o <= reg_next_0_d_constant_9_opt_io_o;
            reg_7_d_to_sfixed_1_io_o <= reg_next_7_d_to_sfixed_1_io_o;
            reg_8_d_constant_15_opt_io_o <= reg_next_8_d_constant_15_opt_io_o;
            reg_6_d_constant_12_opt_io_o <= reg_next_6_d_constant_12_opt_io_o;
            reg_0_d_multiplier_2_sint_mul_adder_5_io_r <= reg_next_0_d_multiplier_2_sint_mul_adder_5_io_r;
            reg_4_d_constant_10_opt_io_o <= reg_next_4_d_constant_10_opt_io_o;
            reg_11_d_constant_22_opt_io_o <= reg_next_11_d_constant_22_opt_io_o;
            reg_19_d_constant_21_opt_io_o <= reg_next_19_d_constant_21_opt_io_o;
            reg_6_d_constant_13_opt_io_o <= reg_next_6_d_constant_13_opt_io_o;
            reg_0_d_ceil_1_io_o <= reg_next_0_d_ceil_1_io_o;
            reg_1_d_multiplier_4_sint_mul_gen_addends_io_subend <= reg_next_1_d_multiplier_4_sint_mul_gen_addends_io_subend;
            reg_21_d_constant_19_opt_io_o <= reg_next_21_d_constant_19_opt_io_o;
            reg_12_d_constant_14_opt_io_o <= reg_next_12_d_constant_14_opt_io_o;
            reg_18_valid_chain <= reg_next_18_valid_chain;
            reg_3_d_constant_6_opt_io_o <= reg_next_3_d_constant_6_opt_io_o;
            reg_9_d_constant_11_opt_io_o <= reg_next_9_d_constant_11_opt_io_o;
            reg_0_d_adder_3_io_r <= reg_next_0_d_adder_3_io_r;
            reg_13_d_constant_18_opt_io_o <= reg_next_13_d_constant_18_opt_io_o;
            reg_0_d_shifter_10_io_o <= reg_next_0_d_shifter_10_io_o;
            reg_19_d_constant_12_opt_io_o <= reg_next_19_d_constant_12_opt_io_o;
            reg_17_d_constant_16_opt_io_o <= reg_next_17_d_constant_16_opt_io_o;
            reg_21_valid_chain <= reg_next_21_valid_chain;
            reg_0_d_multiplier_4_sint_mul_adder_9_io_r <= reg_next_0_d_multiplier_4_sint_mul_adder_9_io_r;
            reg_0_d_multiplier_sint_mul_gen_addends_io_addend_18 <= reg_next_0_d_multiplier_sint_mul_gen_addends_io_addend_18;
            reg_0_d_multiplier_3_sint_mul_adder_1_io_r <= reg_next_0_d_multiplier_3_sint_mul_adder_1_io_r;
            reg_15_d_constant_13_opt_io_o <= reg_next_15_d_constant_13_opt_io_o;
            reg_0_d_constant_opt_io_o <= reg_next_0_d_constant_opt_io_o;
            reg_1_d_constant_20_opt_io_o <= reg_next_1_d_constant_20_opt_io_o;
            reg_0_d_multiplier_3_sint_mul_adder_3_io_r <= reg_next_0_d_multiplier_3_sint_mul_adder_3_io_r;
            reg_2_d_constant_13_opt_io_o <= reg_next_2_d_constant_13_opt_io_o;
            reg_0_d_multiplier_4_sint_mul_adder_26_io_r <= reg_next_0_d_multiplier_4_sint_mul_adder_26_io_r;
            reg_5_d_constant_21_opt_io_o <= reg_next_5_d_constant_21_opt_io_o;
            reg_25_d_constant_22_opt_io_o <= reg_next_25_d_constant_22_opt_io_o;
            reg_0_d_multiplier_sint_mul_gen_addends_io_addend_24 <= reg_next_0_d_multiplier_sint_mul_gen_addends_io_addend_24;
            reg_3_d_multiplier_1_sint_mul_gen_addends_io_subend <= reg_next_3_d_multiplier_1_sint_mul_gen_addends_io_subend;
            reg_0_d_multiplier_1_sint_mul_gen_addends_io_addend_19 <= reg_next_0_d_multiplier_1_sint_mul_gen_addends_io_addend_19;
            reg_16_valid_chain <= reg_next_16_valid_chain;
            reg_0_d_min_3_io_o <= reg_next_0_d_min_3_io_o;
            reg_14_d_constant_22_opt_io_o <= reg_next_14_d_constant_22_opt_io_o;
            reg_0_d_multiplier_3_sint_mul_adder_22_io_r <= reg_next_0_d_multiplier_3_sint_mul_adder_22_io_r;
            reg_2_d_constant_22_opt_io_o <= reg_next_2_d_constant_22_opt_io_o;
            reg_2_d_constant_16_opt_io_o <= reg_next_2_d_constant_16_opt_io_o;
            reg_12_d_constant_21_opt_io_o <= reg_next_12_d_constant_21_opt_io_o;
            reg_16_d_constant_16_opt_io_o <= reg_next_16_d_constant_16_opt_io_o;
            reg_0_d_multiplier_sint_mul_adder_6_io_r <= reg_next_0_d_multiplier_sint_mul_adder_6_io_r;
            reg_0_d_multiplier_1_sint_mul_adder_21_io_r <= reg_next_0_d_multiplier_1_sint_mul_adder_21_io_r;
            reg_17_d_constant_18_opt_io_o <= reg_next_17_d_constant_18_opt_io_o;
            reg_24_d_constant_19_opt_io_o <= reg_next_24_d_constant_19_opt_io_o;
            reg_0_d_multiplier_1_sint_mul_adder_8_io_r <= reg_next_0_d_multiplier_1_sint_mul_adder_8_io_r;
            reg_4_d_constant_20_opt_io_o <= reg_next_4_d_constant_20_opt_io_o;
            reg_8_d_constant_19_opt_io_o <= reg_next_8_d_constant_19_opt_io_o;
            reg_0_d_multiplier_1_sint_mul_gen_addends_io_addend_18 <= reg_next_0_d_multiplier_1_sint_mul_gen_addends_io_addend_18;
            reg_13_d_constant_21_opt_io_o <= reg_next_13_d_constant_21_opt_io_o;
            reg_21_d_constant_20_opt_io_o <= reg_next_21_d_constant_20_opt_io_o;
            reg_0_d_subtractor_1_io_r <= reg_next_0_d_subtractor_1_io_r;
            reg_6_d_constant_15_opt_io_o <= reg_next_6_d_constant_15_opt_io_o;
            reg_0_d_multiplier_1_sint_mul_adder_18_io_r <= reg_next_0_d_multiplier_1_sint_mul_adder_18_io_r;
            reg_1_d_multiplier_sint_mul_adder_16_io_r <= reg_next_1_d_multiplier_sint_mul_adder_16_io_r;
            reg_4_d_constant_9_opt_io_o <= reg_next_4_d_constant_9_opt_io_o;
            reg_15_valid_chain <= reg_next_15_valid_chain;
            reg_4_d_multiplier_4_tc_io_o <= reg_next_4_d_multiplier_4_tc_io_o;
            reg_17_d_constant_17_opt_io_o <= reg_next_17_d_constant_17_opt_io_o;
            reg_1_d_multiplier_sint_mul_adder_21_io_r <= reg_next_1_d_multiplier_sint_mul_adder_21_io_r;
            reg_1_d_constant_17_opt_io_o <= reg_next_1_d_constant_17_opt_io_o;
            reg_24_d_constant_20_opt_io_o <= reg_next_24_d_constant_20_opt_io_o;
            reg_1_d_constant_8_opt_io_o <= reg_next_1_d_constant_8_opt_io_o;
            reg_6_d_constant_22_opt_io_o <= reg_next_6_d_constant_22_opt_io_o;
            reg_16_d_constant_17_opt_io_o <= reg_next_16_d_constant_17_opt_io_o;
            reg_18_d_constant_17_opt_io_o <= reg_next_18_d_constant_17_opt_io_o;
            reg_20_d_constant_22_opt_io_o <= reg_next_20_d_constant_22_opt_io_o;
            reg_10_d_constant_14_opt_io_o <= reg_next_10_d_constant_14_opt_io_o;
            reg_0_d_multiplier_3_sint_mul_adder_13_io_r <= reg_next_0_d_multiplier_3_sint_mul_adder_13_io_r;
            reg_0_d_adder_8_io_r <= reg_next_0_d_adder_8_io_r;
            reg_7_d_constant_11_opt_io_o <= reg_next_7_d_constant_11_opt_io_o;
            reg_0_l_multiplier_3_sint_mul_gen_addends_io_long <= reg_next_0_l_multiplier_3_sint_mul_gen_addends_io_long;
            reg_2_d_constant_14_opt_io_o <= reg_next_2_d_constant_14_opt_io_o;
            reg_3_d_constant_8_opt_io_o <= reg_next_3_d_constant_8_opt_io_o;
            reg_7_d_constant_19_opt_io_o <= reg_next_7_d_constant_19_opt_io_o;
            reg_17_d_constant_13_opt_io_o <= reg_next_17_d_constant_13_opt_io_o;
            reg_2_d_constant_5_opt_io_o <= reg_next_2_d_constant_5_opt_io_o;
            reg_2_d_constant_10_opt_io_o <= reg_next_2_d_constant_10_opt_io_o;
            reg_0_d_multiplier_3_sint_mul_adder_2_io_r <= reg_next_0_d_multiplier_3_sint_mul_adder_2_io_r;
            reg_0_d_multiplier_4_sint_mul_adder_21_io_r <= reg_next_0_d_multiplier_4_sint_mul_adder_21_io_r;
            reg_8_d_constant_13_opt_io_o <= reg_next_8_d_constant_13_opt_io_o;
            reg_4_valid_chain <= reg_next_4_valid_chain;
            reg_3_d_constant_13_opt_io_o <= reg_next_3_d_constant_13_opt_io_o;
            reg_1_d_subtractor_9_io_r <= reg_next_1_d_subtractor_9_io_r;
            reg_9_valid_chain <= reg_next_9_valid_chain;
            reg_10_valid_chain <= reg_next_10_valid_chain;
            reg_2_d_multiplier_1_sint_mul_adder_21_io_r <= reg_next_2_d_multiplier_1_sint_mul_adder_21_io_r;
            reg_0_d_constant_3_opt_io_o <= reg_next_0_d_constant_3_opt_io_o;
            reg_15_d_constant_14_opt_io_o <= reg_next_15_d_constant_14_opt_io_o;
            reg_6_valid_chain <= reg_next_6_valid_chain;
            reg_6_d_constant_20_opt_io_o <= reg_next_6_d_constant_20_opt_io_o;
            reg_0_d_constant_12_opt_io_o <= reg_next_0_d_constant_12_opt_io_o;
            reg_1_d_multiplier_2_tc_io_o <= reg_next_1_d_multiplier_2_tc_io_o;
            reg_0_d_constant_6_opt_io_o <= reg_next_0_d_constant_6_opt_io_o;
            reg_10_d_constant_17_opt_io_o <= reg_next_10_d_constant_17_opt_io_o;
            reg_8_d_constant_8_opt_io_o <= reg_next_8_d_constant_8_opt_io_o;
            reg_12_d_constant_17_opt_io_o <= reg_next_12_d_constant_17_opt_io_o;
            reg_20_d_constant_17_opt_io_o <= reg_next_20_d_constant_17_opt_io_o;
            reg_3_d_constant_12_opt_io_o <= reg_next_3_d_constant_12_opt_io_o;
            reg_0_l_multiplier_3_sint_mul_gen_addends_io_short <= reg_next_0_l_multiplier_3_sint_mul_gen_addends_io_short;
            reg_0_d_multiplier_sint_mul_gen_addends_io_addend_15 <= reg_next_0_d_multiplier_sint_mul_gen_addends_io_addend_15;
            reg_0_d_subtractor_3_io_r <= reg_next_0_d_subtractor_3_io_r;
            reg_1_d_constant_22_opt_io_o <= reg_next_1_d_constant_22_opt_io_o;
            reg_2_valid_chain <= reg_next_2_valid_chain;
            reg_0_d_multiplier_1_sint_mul_gen_addends_io_subend <= reg_next_0_d_multiplier_1_sint_mul_gen_addends_io_subend;
            reg_0_d_fract_3_io_o <= reg_next_0_d_fract_3_io_o;
            reg_0_d_multiplier_sint_mul_gen_addends_io_addend_23 <= reg_next_0_d_multiplier_sint_mul_gen_addends_io_addend_23;
            reg_7_d_constant_20_opt_io_o <= reg_next_7_d_constant_20_opt_io_o;
            reg_4_d_constant_13_opt_io_o <= reg_next_4_d_constant_13_opt_io_o;
            reg_2_d_multiplier_2_tc_io_o <= reg_next_2_d_multiplier_2_tc_io_o;
            reg_0_d_multiplier_4_sint_mul_adder_4_io_r <= reg_next_0_d_multiplier_4_sint_mul_adder_4_io_r;
            reg_1_d_constant_2_opt_io_o <= reg_next_1_d_constant_2_opt_io_o;
            reg_0_d_multiplier_3_sint_mul_adder_21_io_r <= reg_next_0_d_multiplier_3_sint_mul_adder_21_io_r;
            reg_8_d_constant_14_opt_io_o <= reg_next_8_d_constant_14_opt_io_o;
            reg_23_d_constant_16_opt_io_o <= reg_next_23_d_constant_16_opt_io_o;
            reg_0_d_multiplier_4_sint_mul_adder_11_io_r <= reg_next_0_d_multiplier_4_sint_mul_adder_11_io_r;
            reg_6_d_multiplier_4_tc_io_o <= reg_next_6_d_multiplier_4_tc_io_o;
            reg_0_d_multiplier_2_sint_mul_gen_addends_io_subend <= reg_next_0_d_multiplier_2_sint_mul_gen_addends_io_subend;
            reg_0_d_constant_22_opt_io_o <= reg_next_0_d_constant_22_opt_io_o;
            reg_14_d_constant_14_opt_io_o <= reg_next_14_d_constant_14_opt_io_o;
            reg_0_d_subtractor_4_io_r <= reg_next_0_d_subtractor_4_io_r;
            reg_3_d_multiplier_3_sint_mul_gen_addends_io_subend <= reg_next_3_d_multiplier_3_sint_mul_gen_addends_io_subend;
            reg_10_d_constant_9_opt_io_o <= reg_next_10_d_constant_9_opt_io_o;
            reg_19_d_constant_19_opt_io_o <= reg_next_19_d_constant_19_opt_io_o;
            reg_1_d_constant_7_opt_io_o <= reg_next_1_d_constant_7_opt_io_o;
            reg_2_d_constant_6_opt_io_o <= reg_next_2_d_constant_6_opt_io_o;
            reg_5_d_multiplier_4_tc_io_o <= reg_next_5_d_multiplier_4_tc_io_o;
            reg_0_d_multiplier_1_sint_mul_gen_addends_io_addend_27 <= reg_next_0_d_multiplier_1_sint_mul_gen_addends_io_addend_27;
            reg_0_d_constant_19_opt_io_o <= reg_next_0_d_constant_19_opt_io_o;
            reg_9_d_constant_18_opt_io_o <= reg_next_9_d_constant_18_opt_io_o;
            reg_0_d_constant_17_opt_io_o <= reg_next_0_d_constant_17_opt_io_o;
            reg_0_d_multiplier_4_sint_mul_adder_17_io_r <= reg_next_0_d_multiplier_4_sint_mul_adder_17_io_r;
            reg_11_valid_chain <= reg_next_11_valid_chain;
            reg_11_d_constant_17_opt_io_o <= reg_next_11_d_constant_17_opt_io_o;
            reg_4_d_constant_16_opt_io_o <= reg_next_4_d_constant_16_opt_io_o;
            reg_5_d_constant_8_opt_io_o <= reg_next_5_d_constant_8_opt_io_o;
            reg_10_d_to_sfixed_1_io_o <= reg_next_10_d_to_sfixed_1_io_o;
            reg_13_d_constant_17_opt_io_o <= reg_next_13_d_constant_17_opt_io_o;
            reg_5_d_constant_16_opt_io_o <= reg_next_5_d_constant_16_opt_io_o;
            reg_1_d_multiplier_1_sint_mul_adder_21_io_r <= reg_next_1_d_multiplier_1_sint_mul_adder_21_io_r;
            reg_0_d_ceil_io_o <= reg_next_0_d_ceil_io_o;
            reg_0_d_multiplier_3_sint_mul_adder_14_io_r <= reg_next_0_d_multiplier_3_sint_mul_adder_14_io_r;
            reg_0_d_multiplier_sint_mul_adder_7_io_r <= reg_next_0_d_multiplier_sint_mul_adder_7_io_r;
            reg_0_d_multiplier_4_sint_mul_adder_19_io_r <= reg_next_0_d_multiplier_4_sint_mul_adder_19_io_r;
            reg_0_d_multiplier_sint_mul_gen_addends_io_addend_20 <= reg_next_0_d_multiplier_sint_mul_gen_addends_io_addend_20;
            reg_5_d_constant_17_opt_io_o <= reg_next_5_d_constant_17_opt_io_o;
            reg_2_d_constant_19_opt_io_o <= reg_next_2_d_constant_19_opt_io_o;
            reg_0_d_multiplier_2_tc_io_o <= reg_next_0_d_multiplier_2_tc_io_o;
            reg_0_d_multiplier_sint_mul_adder_17_io_r <= reg_next_0_d_multiplier_sint_mul_adder_17_io_r;
            reg_0_d_multiplier_4_sint_mul_adder_5_io_r <= reg_next_0_d_multiplier_4_sint_mul_adder_5_io_r;
            reg_2_d_multiplier_sint_mul_gen_addends_io_subend <= reg_next_2_d_multiplier_sint_mul_gen_addends_io_subend;
            reg_9_d_constant_13_opt_io_o <= reg_next_9_d_constant_13_opt_io_o;
            reg_11_d_constant_21_opt_io_o <= reg_next_11_d_constant_21_opt_io_o;
            reg_4_d_constant_8_opt_io_o <= reg_next_4_d_constant_8_opt_io_o;
            reg_14_d_constant_20_opt_io_o <= reg_next_14_d_constant_20_opt_io_o;
            reg_11_d_constant_14_opt_io_o <= reg_next_11_d_constant_14_opt_io_o;
            reg_3_l_mux_io_i1 <= reg_next_3_l_mux_io_i1;
            reg_23_d_constant_19_opt_io_o <= reg_next_23_d_constant_19_opt_io_o;
            reg_19_d_constant_22_opt_io_o <= reg_next_19_d_constant_22_opt_io_o;
            reg_8_d_constant_12_opt_io_o <= reg_next_8_d_constant_12_opt_io_o;
            reg_17_d_constant_20_opt_io_o <= reg_next_17_d_constant_20_opt_io_o;
            reg_0_d_multiplier_1_sint_mul_gen_addends_io_addend_17 <= reg_next_0_d_multiplier_1_sint_mul_gen_addends_io_addend_17;
            reg_3_d_constant_17_opt_io_o <= reg_next_3_d_constant_17_opt_io_o;
            reg_4_d_constant_7_opt_io_o <= reg_next_4_d_constant_7_opt_io_o;
            reg_0_d_multiplier_3_sint_mul_adder_7_io_r <= reg_next_0_d_multiplier_3_sint_mul_adder_7_io_r;
            reg_13_d_constant_12_opt_io_o <= reg_next_13_d_constant_12_opt_io_o;
            reg_1_d_constant_19_opt_io_o <= reg_next_1_d_constant_19_opt_io_o;
            reg_7_d_constant_16_opt_io_o <= reg_next_7_d_constant_16_opt_io_o;
            reg_4_d_multiplier_3_sint_mul_gen_addends_io_subend <= reg_next_4_d_multiplier_3_sint_mul_gen_addends_io_subend;
            reg_0_d_min_1_io_o <= reg_next_0_d_min_1_io_o;
            reg_5_d_constant_12_opt_io_o <= reg_next_5_d_constant_12_opt_io_o;
            reg_5_d_constant_14_opt_io_o <= reg_next_5_d_constant_14_opt_io_o;
            reg_11_d_constant_19_opt_io_o <= reg_next_11_d_constant_19_opt_io_o;
            reg_0_d_constant_11_opt_io_o <= reg_next_0_d_constant_11_opt_io_o;
            reg_14_d_constant_16_opt_io_o <= reg_next_14_d_constant_16_opt_io_o;
            reg_9_d_constant_21_opt_io_o <= reg_next_9_d_constant_21_opt_io_o;
            reg_3_valid_chain <= reg_next_3_valid_chain;
            reg_10_d_constant_15_opt_io_o <= reg_next_10_d_constant_15_opt_io_o;
            reg_13_d_constant_14_opt_io_o <= reg_next_13_d_constant_14_opt_io_o;
            reg_0_d_multiplier_sint_mul_gen_addends_io_addend_17 <= reg_next_0_d_multiplier_sint_mul_gen_addends_io_addend_17;
            reg_0_d_shifter_13_io_o <= reg_next_0_d_shifter_13_io_o;
            reg_0_d_constant_18_opt_io_o <= reg_next_0_d_constant_18_opt_io_o;
            reg_4_d_to_sfixed_1_io_o <= reg_next_4_d_to_sfixed_1_io_o;
            reg_17_d_constant_12_opt_io_o <= reg_next_17_d_constant_12_opt_io_o;
            reg_11_d_constant_13_opt_io_o <= reg_next_11_d_constant_13_opt_io_o;
            reg_10_d_constant_18_opt_io_o <= reg_next_10_d_constant_18_opt_io_o;
            reg_6_d_constant_19_opt_io_o <= reg_next_6_d_constant_19_opt_io_o;
            reg_12_d_constant_22_opt_io_o <= reg_next_12_d_constant_22_opt_io_o;
            reg_9_d_to_sfixed_1_io_o <= reg_next_9_d_to_sfixed_1_io_o;
            reg_2_d_constant_8_opt_io_o <= reg_next_2_d_constant_8_opt_io_o;
            reg_1_d_constant_15_opt_io_o <= reg_next_1_d_constant_15_opt_io_o;
            reg_4_d_constant_14_opt_io_o <= reg_next_4_d_constant_14_opt_io_o;
            reg_1_l_mux_io_i1 <= reg_next_1_l_mux_io_i1;
            reg_14_d_constant_18_opt_io_o <= reg_next_14_d_constant_18_opt_io_o;
            reg_12_d_constant_13_opt_io_o <= reg_next_12_d_constant_13_opt_io_o;
            reg_5_valid_chain <= reg_next_5_valid_chain;
            reg_14_d_constant_19_opt_io_o <= reg_next_14_d_constant_19_opt_io_o;
            reg_0_d_constant_1_opt_io_o <= reg_next_0_d_constant_1_opt_io_o;
            reg_0_d_multiplier_1_sint_mul_gen_addends_io_addend_14 <= reg_next_0_d_multiplier_1_sint_mul_gen_addends_io_addend_14;
            reg_0_d_constant_8_opt_io_o <= reg_next_0_d_constant_8_opt_io_o;
            reg_0_d_multiplier_tc_io_o <= reg_next_0_d_multiplier_tc_io_o;
            reg_7_valid_chain <= reg_next_7_valid_chain;
            reg_25_valid_chain <= reg_next_25_valid_chain;
            reg_3_d_multiplier_4_sint_mul_gen_addends_io_subend <= reg_next_3_d_multiplier_4_sint_mul_gen_addends_io_subend;
            reg_12_d_constant_18_opt_io_o <= reg_next_12_d_constant_18_opt_io_o;
            reg_0_d_multiplier_3_sint_mul_adder_20_io_r <= reg_next_0_d_multiplier_3_sint_mul_adder_20_io_r;
            reg_4_d_subtractor_9_io_r <= reg_next_4_d_subtractor_9_io_r;
            reg_0_d_multiplier_sint_mul_gen_addends_io_subend <= reg_next_0_d_multiplier_sint_mul_gen_addends_io_subend;
            reg_0_d_multiplier_1_sint_mul_adder_17_io_r <= reg_next_0_d_multiplier_1_sint_mul_adder_17_io_r;
            reg_4_d_constant_15_opt_io_o <= reg_next_4_d_constant_15_opt_io_o;
            reg_15_d_constant_20_opt_io_o <= reg_next_15_d_constant_20_opt_io_o;
            reg_8_d_constant_21_opt_io_o <= reg_next_8_d_constant_21_opt_io_o;
            reg_7_d_constant_21_opt_io_o <= reg_next_7_d_constant_21_opt_io_o;
            reg_0_d_multiplier_2_sint_mul_adder_4_io_r <= reg_next_0_d_multiplier_2_sint_mul_adder_4_io_r;
            reg_2_d_constant_20_opt_io_o <= reg_next_2_d_constant_20_opt_io_o;
            reg_18_d_constant_13_opt_io_o <= reg_next_18_d_constant_13_opt_io_o;
            reg_0_l_min_1_io_a <= reg_next_0_l_min_1_io_a;
            reg_2_d_constant_12_opt_io_o <= reg_next_2_d_constant_12_opt_io_o;
            reg_2_d_subtractor_9_io_r <= reg_next_2_d_subtractor_9_io_r;
            reg_3_d_constant_18_opt_io_o <= reg_next_3_d_constant_18_opt_io_o;
            reg_2_d_multiplier_sint_mul_adder_21_io_r <= reg_next_2_d_multiplier_sint_mul_adder_21_io_r;
            reg_16_d_constant_19_opt_io_o <= reg_next_16_d_constant_19_opt_io_o;
            reg_21_d_constant_21_opt_io_o <= reg_next_21_d_constant_21_opt_io_o;
            reg_2_d_constant_18_opt_io_o <= reg_next_2_d_constant_18_opt_io_o;
            reg_12_d_constant_20_opt_io_o <= reg_next_12_d_constant_20_opt_io_o;
            reg_3_d_constant_20_opt_io_o <= reg_next_3_d_constant_20_opt_io_o;
            reg_1_d_constant_18_opt_io_o <= reg_next_1_d_constant_18_opt_io_o;
            reg_2_d_constant_7_opt_io_o <= reg_next_2_d_constant_7_opt_io_o;
            reg_1_d_multiplier_3_sint_mul_gen_addends_io_subend <= reg_next_1_d_multiplier_3_sint_mul_gen_addends_io_subend;
            reg_11_d_constant_20_opt_io_o <= reg_next_11_d_constant_20_opt_io_o;
            reg_14_d_constant_13_opt_io_o <= reg_next_14_d_constant_13_opt_io_o;
            reg_20_d_constant_19_opt_io_o <= reg_next_20_d_constant_19_opt_io_o;
            reg_9_d_constant_15_opt_io_o <= reg_next_9_d_constant_15_opt_io_o;
            reg_3_d_constant_7_opt_io_o <= reg_next_3_d_constant_7_opt_io_o;
            reg_1_d_constant_5_opt_io_o <= reg_next_1_d_constant_5_opt_io_o;
            reg_9_d_constant_22_opt_io_o <= reg_next_9_d_constant_22_opt_io_o;
            reg_23_d_constant_20_opt_io_o <= reg_next_23_d_constant_20_opt_io_o;
            reg_5_d_constant_10_opt_io_o <= reg_next_5_d_constant_10_opt_io_o;
            reg_20_valid_chain <= reg_next_20_valid_chain;
            reg_1_d_multiplier_4_sint_mul_adder_20_io_r <= reg_next_1_d_multiplier_4_sint_mul_adder_20_io_r;
            reg_0_d_multiplier_1_sint_mul_adder_6_io_r <= reg_next_0_d_multiplier_1_sint_mul_adder_6_io_r;
            reg_0_d_multiplier_1_sint_mul_adder_25_io_r <= reg_next_0_d_multiplier_1_sint_mul_adder_25_io_r;
            reg_7_d_constant_9_opt_io_o <= reg_next_7_d_constant_9_opt_io_o;
            reg_13_d_constant_19_opt_io_o <= reg_next_13_d_constant_19_opt_io_o;
            reg_5_d_constant_18_opt_io_o <= reg_next_5_d_constant_18_opt_io_o;
            reg_15_d_constant_22_opt_io_o <= reg_next_15_d_constant_22_opt_io_o;
            reg_12_d_constant_16_opt_io_o <= reg_next_12_d_constant_16_opt_io_o;
            reg_6_d_constant_16_opt_io_o <= reg_next_6_d_constant_16_opt_io_o;
            reg_22_valid_chain <= reg_next_22_valid_chain;
            reg_10_d_constant_21_opt_io_o <= reg_next_10_d_constant_21_opt_io_o;
            reg_2_d_constant_2_opt_io_o <= reg_next_2_d_constant_2_opt_io_o;
            reg_0_d_multiplier_4_sint_mul_adder_7_io_r <= reg_next_0_d_multiplier_4_sint_mul_adder_7_io_r;
            reg_4_d_constant_22_opt_io_o <= reg_next_4_d_constant_22_opt_io_o;
            reg_6_d_constant_8_opt_io_o <= reg_next_6_d_constant_8_opt_io_o;
            reg_0_d_multiplier_2_sint_mul_adder_15_io_r <= reg_next_0_d_multiplier_2_sint_mul_adder_15_io_r;
            reg_20_d_constant_16_opt_io_o <= reg_next_20_d_constant_16_opt_io_o;
            reg_12_d_constant_19_opt_io_o <= reg_next_12_d_constant_19_opt_io_o;
            reg_5_d_to_sfixed_1_io_o <= reg_next_5_d_to_sfixed_1_io_o;
            reg_2_d_to_sfixed_1_io_o <= reg_next_2_d_to_sfixed_1_io_o;
            reg_3_d_constant_22_opt_io_o <= reg_next_3_d_constant_22_opt_io_o;
            reg_6_d_constant_17_opt_io_o <= reg_next_6_d_constant_17_opt_io_o;
            reg_7_d_constant_13_opt_io_o <= reg_next_7_d_constant_13_opt_io_o;
            reg_19_d_constant_20_opt_io_o <= reg_next_19_d_constant_20_opt_io_o;
            reg_0_d_multiplier_1_sint_mul_gen_addends_io_addend_16 <= reg_next_0_d_multiplier_1_sint_mul_gen_addends_io_addend_16;
            reg_0_d_shifter_12_io_o <= reg_next_0_d_shifter_12_io_o;
            reg_19_d_constant_13_opt_io_o <= reg_next_19_d_constant_13_opt_io_o;
            reg_20_d_constant_20_opt_io_o <= reg_next_20_d_constant_20_opt_io_o;
            reg_17_d_constant_21_opt_io_o <= reg_next_17_d_constant_21_opt_io_o;
            reg_0_d_multiplier_4_sint_mul_adder_8_io_r <= reg_next_0_d_multiplier_4_sint_mul_adder_8_io_r;
            reg_0_d_max_io_o <= reg_next_0_d_max_io_o;
            reg_3_d_subtractor_9_io_r <= reg_next_3_d_subtractor_9_io_r;
            reg_16_d_constant_21_opt_io_o <= reg_next_16_d_constant_21_opt_io_o;
            reg_0_d_multiplier_1_sint_mul_gen_addends_io_addend_20 <= reg_next_0_d_multiplier_1_sint_mul_gen_addends_io_addend_20;
            reg_0_d_multiplier_2_sint_mul_adder_17_io_r <= reg_next_0_d_multiplier_2_sint_mul_adder_17_io_r;
            reg_7_d_constant_8_opt_io_o <= reg_next_7_d_constant_8_opt_io_o;
            reg_0_d_fract_io_o <= reg_next_0_d_fract_io_o;
            reg_1_d_multiplier_4_tc_io_o <= reg_next_1_d_multiplier_4_tc_io_o;
            reg_14_d_constant_21_opt_io_o <= reg_next_14_d_constant_21_opt_io_o;
            reg_2_d_constant_17_opt_io_o <= reg_next_2_d_constant_17_opt_io_o;
            reg_0_d_multiplier_sint_mul_gen_addends_io_addend_25 <= reg_next_0_d_multiplier_sint_mul_gen_addends_io_addend_25;
            reg_19_d_constant_18_opt_io_o <= reg_next_19_d_constant_18_opt_io_o;
            reg_2_d_constant_3_opt_io_o <= reg_next_2_d_constant_3_opt_io_o;
            reg_2_d_constant_9_opt_io_o <= reg_next_2_d_constant_9_opt_io_o;
            reg_1_d_constant_14_opt_io_o <= reg_next_1_d_constant_14_opt_io_o;
            reg_3_d_constant_15_opt_io_o <= reg_next_3_d_constant_15_opt_io_o;
            reg_0_d_multiplier_1_sint_mul_gen_addends_io_addend_22 <= reg_next_0_d_multiplier_1_sint_mul_gen_addends_io_addend_22;
            reg_19_valid_chain <= reg_next_19_valid_chain;
            reg_0_d_multiplier_sint_mul_adder_25_io_r <= reg_next_0_d_multiplier_sint_mul_adder_25_io_r;
            reg_16_d_constant_22_opt_io_o <= reg_next_16_d_constant_22_opt_io_o;
            reg_0_d_constant_21_opt_io_o <= reg_next_0_d_constant_21_opt_io_o;
            reg_7_d_constant_14_opt_io_o <= reg_next_7_d_constant_14_opt_io_o;
            reg_18_d_constant_16_opt_io_o <= reg_next_18_d_constant_16_opt_io_o;
            reg_7_d_constant_17_opt_io_o <= reg_next_7_d_constant_17_opt_io_o;
            reg_0_l_ceil_1_io_i <= reg_next_0_l_ceil_1_io_i;
            reg_3_d_multiplier_sint_mul_gen_addends_io_subend <= reg_next_3_d_multiplier_sint_mul_gen_addends_io_subend;
            reg_3_d_multiplier_4_tc_io_o <= reg_next_3_d_multiplier_4_tc_io_o;
            reg_1_d_multiplier_1_sint_mul_adder_19_io_r <= reg_next_1_d_multiplier_1_sint_mul_adder_19_io_r;
            reg_18_d_constant_22_opt_io_o <= reg_next_18_d_constant_22_opt_io_o;
            reg_0_d_multiplier_1_sint_mul_adder_24_io_r <= reg_next_0_d_multiplier_1_sint_mul_adder_24_io_r;
            reg_0_d_shifter_11_io_o <= reg_next_0_d_shifter_11_io_o;
            reg_18_d_constant_18_opt_io_o <= reg_next_18_d_constant_18_opt_io_o;
            reg_9_d_constant_9_opt_io_o <= reg_next_9_d_constant_9_opt_io_o;
            reg_3_d_constant_10_opt_io_o <= reg_next_3_d_constant_10_opt_io_o;
            reg_9_d_constant_8_opt_io_o <= reg_next_9_d_constant_8_opt_io_o;
            reg_11_d_constant_16_opt_io_o <= reg_next_11_d_constant_16_opt_io_o;
            reg_10_d_constant_20_opt_io_o <= reg_next_10_d_constant_20_opt_io_o;
            reg_2_d_multiplier_1_sint_mul_adder_16_io_r <= reg_next_2_d_multiplier_1_sint_mul_adder_16_io_r;
            reg_17_valid_chain <= reg_next_17_valid_chain;
            reg_0_d_multiplier_1_sint_mul_adder_7_io_r <= reg_next_0_d_multiplier_1_sint_mul_adder_7_io_r;
            reg_8_d_constant_18_opt_io_o <= reg_next_8_d_constant_18_opt_io_o;
            reg_0_d_multiplier_sint_mul_adder_9_io_r <= reg_next_0_d_multiplier_sint_mul_adder_9_io_r;
            reg_2_d_multiplier_3_sint_mul_gen_addends_io_subend <= reg_next_2_d_multiplier_3_sint_mul_gen_addends_io_subend;
            reg_0_d_constant_10_opt_io_o <= reg_next_0_d_constant_10_opt_io_o;
        end if;
    end process;

    to_sfixed: Convert_UInt_64_SFixedPoint_36_12
        port map(
            i => to_sfixed_io_i,
            o => to_sfixed_io_o
        );

    shifter: Shift_Neg20_SFixedPoint_36_12
        port map(
            i => shifter_io_i,
            o => shifter_io_o
        );

    to_sfixed_1: Convert_SFixedPoint_36_12_SFixedPoint_16_12
        port map(
            i => to_sfixed_1_io_i,
            o => to_sfixed_1_io_o
        );

    to_sfixed_2: Convert_UInt_12_SFixedPoint_16_12
        port map(
            i => to_sfixed_2_io_i,
            o => to_sfixed_2_io_o
        );

    to_sfixed_3: Convert_UInt_12_SFixedPoint_16_12
        port map(
            i => to_sfixed_3_io_i,
            o => to_sfixed_3_io_o
        );

    shifter_1: Shift_Neg9_SFixedPoint_16_12
        port map(
            i => shifter_1_io_i,
            o => shifter_1_io_o
        );

    shifter_2: Shift_Neg7_SFixedPoint_16_12
        port map(
            i => shifter_2_io_i,
            o => shifter_2_io_o
        );

    adder: EqualTypesAdd_SFixedPoint_16_12_SFixedPoint_16_12
        port map(
            a => adder_io_a,
            b => adder_io_b,
            r => adder_io_r
        );

    constant_opt: Constants_e3cfae0963b7234f_Core
        port map(
            o => constant_opt_io_o
        );

    subtractor: EqualTypesSubtract_SFixedPoint_16_12_SFixedPoint_16_12
        port map(
            a => subtractor_io_a,
            b => subtractor_io_b,
            r => subtractor_io_r
        );

    shifter_3: Shift_Neg9_SFixedPoint_16_12
        port map(
            i => shifter_3_io_i,
            o => shifter_3_io_o
        );

    shifter_4: Shift_Neg7_SFixedPoint_16_12
        port map(
            i => shifter_4_io_i,
            o => shifter_4_io_o
        );

    adder_1: EqualTypesAdd_SFixedPoint_16_12_SFixedPoint_16_12
        port map(
            a => adder_1_io_a,
            b => adder_1_io_b,
            r => adder_1_io_r
        );

    constant_1_opt: Constants_31fa47991dc69fb6_Core
        port map(
            o => constant_1_opt_io_o
        );

    subtractor_1: EqualTypesSubtract_SFixedPoint_16_12_SFixedPoint_16_12
        port map(
            a => subtractor_1_io_a,
            b => subtractor_1_io_b,
            r => subtractor_1_io_r
        );

    subtractor_2: EqualTypesSubtract_SFixedPoint_16_12_SFixedPoint_16_12
        port map(
            a => subtractor_2_io_a,
            b => subtractor_2_io_b,
            r => subtractor_2_io_r
        );

    constant_2_opt: Constants_e3cfae0963b7234f_Core
        port map(
            o => constant_2_opt_io_o
        );

    adder_2: EqualTypesAdd_SFixedPoint_16_12_SFixedPoint_16_12
        port map(
            a => adder_2_io_a,
            b => adder_2_io_b,
            r => adder_2_io_r
        );

    adder_3: EqualTypesAdd_SFixedPoint_16_12_SFixedPoint_16_12
        port map(
            a => adder_3_io_a,
            b => adder_3_io_b,
            r => adder_3_io_r
        );

    constant_3_opt: Constants_e3cfae0963b7234f_Core
        port map(
            o => constant_3_opt_io_o
        );

    adder_4: EqualTypesAdd_SFixedPoint_16_12_SFixedPoint_16_12
        port map(
            a => adder_4_io_a,
            b => adder_4_io_b,
            r => adder_4_io_r
        );

    fract: Fract_SFixedPoint_16_12
        port map(
            i => fract_io_i,
            o => fract_io_o
        );

    fract_1: Fract_SFixedPoint_16_12
        port map(
            i => fract_1_io_i,
            o => fract_1_io_o
        );

    constant_4_opt: Constants_99e998fd468424c7_Core
        port map(
            o => constant_4_opt_io_o
        );

    subtractor_3: EqualTypesSubtract_SFixedPoint_16_12_SFixedPoint_16_12
        port map(
            a => subtractor_3_io_a,
            b => subtractor_3_io_b,
            r => subtractor_3_io_r
        );

    constant_5_opt: Constants_99e998fd468424c7_Core
        port map(
            o => constant_5_opt_io_o
        );

    subtractor_4: EqualTypesSubtract_SFixedPoint_16_12_SFixedPoint_16_12
        port map(
            a => subtractor_4_io_a,
            b => subtractor_4_io_b,
            r => subtractor_4_io_r
        );

    min: Min_SFixedPoint_16_12
        port map(
            a => min_io_a,
            b => min_io_b,
            o => min_io_o
        );

    min_1: Min_SFixedPoint_16_12
        port map(
            a => min_1_io_a,
            b => min_1_io_b,
            o => min_1_io_o
        );

    ceil: Ceil_SFixedPoint_16_12
        port map(
            i => ceil_io_i,
            o => ceil_io_o
        );

    ceil_1: Ceil_SFixedPoint_16_12
        port map(
            i => ceil_1_io_i,
            o => ceil_1_io_o
        );

    constant_6_opt: Constants_ed453308e8a82f66_Core
        port map(
            o => constant_6_opt_io_o
        );

    subtractor_5: EqualTypesSubtract_SFixedPoint_16_12_SFixedPoint_16_12
        port map(
            a => subtractor_5_io_a,
            b => subtractor_5_io_b,
            r => subtractor_5_io_r
        );

    constant_7_opt: Constants_ed453308e8a82f66_Core
        port map(
            o => constant_7_opt_io_o
        );

    subtractor_6: EqualTypesSubtract_SFixedPoint_16_12_SFixedPoint_16_12
        port map(
            a => subtractor_6_io_a,
            b => subtractor_6_io_b,
            r => subtractor_6_io_r
        );

    multiplier_sint_mul_gen_addends: Multiply_SInt_29_SInt_29_AddendsGenerator
        port map(
            long => multiplier_sint_mul_gen_addends_io_long,
            short => multiplier_sint_mul_gen_addends_io_short,
            addend_0 => multiplier_sint_mul_gen_addends_io_addend_0,
            addend_1 => multiplier_sint_mul_gen_addends_io_addend_1,
            addend_2 => multiplier_sint_mul_gen_addends_io_addend_2,
            addend_3 => multiplier_sint_mul_gen_addends_io_addend_3,
            addend_4 => multiplier_sint_mul_gen_addends_io_addend_4,
            addend_5 => multiplier_sint_mul_gen_addends_io_addend_5,
            addend_6 => multiplier_sint_mul_gen_addends_io_addend_6,
            addend_7 => multiplier_sint_mul_gen_addends_io_addend_7,
            addend_8 => multiplier_sint_mul_gen_addends_io_addend_8,
            addend_9 => multiplier_sint_mul_gen_addends_io_addend_9,
            addend_10 => multiplier_sint_mul_gen_addends_io_addend_10,
            addend_11 => multiplier_sint_mul_gen_addends_io_addend_11,
            addend_12 => multiplier_sint_mul_gen_addends_io_addend_12,
            addend_13 => multiplier_sint_mul_gen_addends_io_addend_13,
            addend_14 => multiplier_sint_mul_gen_addends_io_addend_14,
            addend_15 => multiplier_sint_mul_gen_addends_io_addend_15,
            addend_16 => multiplier_sint_mul_gen_addends_io_addend_16,
            addend_17 => multiplier_sint_mul_gen_addends_io_addend_17,
            addend_18 => multiplier_sint_mul_gen_addends_io_addend_18,
            addend_19 => multiplier_sint_mul_gen_addends_io_addend_19,
            addend_20 => multiplier_sint_mul_gen_addends_io_addend_20,
            addend_21 => multiplier_sint_mul_gen_addends_io_addend_21,
            addend_22 => multiplier_sint_mul_gen_addends_io_addend_22,
            addend_23 => multiplier_sint_mul_gen_addends_io_addend_23,
            addend_24 => multiplier_sint_mul_gen_addends_io_addend_24,
            addend_25 => multiplier_sint_mul_gen_addends_io_addend_25,
            addend_26 => multiplier_sint_mul_gen_addends_io_addend_26,
            addend_27 => multiplier_sint_mul_gen_addends_io_addend_27,
            subend => multiplier_sint_mul_gen_addends_io_subend
        );

    multiplier_sint_mul_adder_0: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_sint_mul_adder_0_io_a,
            b => multiplier_sint_mul_adder_0_io_b,
            r => multiplier_sint_mul_adder_0_io_r
        );

    multiplier_sint_mul_adder_1: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_sint_mul_adder_1_io_a,
            b => multiplier_sint_mul_adder_1_io_b,
            r => multiplier_sint_mul_adder_1_io_r
        );

    multiplier_sint_mul_adder_2: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_sint_mul_adder_2_io_a,
            b => multiplier_sint_mul_adder_2_io_b,
            r => multiplier_sint_mul_adder_2_io_r
        );

    multiplier_sint_mul_adder_3: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_sint_mul_adder_3_io_a,
            b => multiplier_sint_mul_adder_3_io_b,
            r => multiplier_sint_mul_adder_3_io_r
        );

    multiplier_sint_mul_adder_4: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_sint_mul_adder_4_io_a,
            b => multiplier_sint_mul_adder_4_io_b,
            r => multiplier_sint_mul_adder_4_io_r
        );

    multiplier_sint_mul_adder_5: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_sint_mul_adder_5_io_a,
            b => multiplier_sint_mul_adder_5_io_b,
            r => multiplier_sint_mul_adder_5_io_r
        );

    multiplier_sint_mul_adder_6: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_sint_mul_adder_6_io_a,
            b => multiplier_sint_mul_adder_6_io_b,
            r => multiplier_sint_mul_adder_6_io_r
        );

    multiplier_sint_mul_adder_7: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_sint_mul_adder_7_io_a,
            b => multiplier_sint_mul_adder_7_io_b,
            r => multiplier_sint_mul_adder_7_io_r
        );

    multiplier_sint_mul_adder_8: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_sint_mul_adder_8_io_a,
            b => multiplier_sint_mul_adder_8_io_b,
            r => multiplier_sint_mul_adder_8_io_r
        );

    multiplier_sint_mul_adder_9: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_sint_mul_adder_9_io_a,
            b => multiplier_sint_mul_adder_9_io_b,
            r => multiplier_sint_mul_adder_9_io_r
        );

    multiplier_sint_mul_adder_10: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_sint_mul_adder_10_io_a,
            b => multiplier_sint_mul_adder_10_io_b,
            r => multiplier_sint_mul_adder_10_io_r
        );

    multiplier_sint_mul_adder_11: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_sint_mul_adder_11_io_a,
            b => multiplier_sint_mul_adder_11_io_b,
            r => multiplier_sint_mul_adder_11_io_r
        );

    multiplier_sint_mul_adder_12: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_sint_mul_adder_12_io_a,
            b => multiplier_sint_mul_adder_12_io_b,
            r => multiplier_sint_mul_adder_12_io_r
        );

    multiplier_sint_mul_adder_13: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_sint_mul_adder_13_io_a,
            b => multiplier_sint_mul_adder_13_io_b,
            r => multiplier_sint_mul_adder_13_io_r
        );

    multiplier_sint_mul_adder_14: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_sint_mul_adder_14_io_a,
            b => multiplier_sint_mul_adder_14_io_b,
            r => multiplier_sint_mul_adder_14_io_r
        );

    multiplier_sint_mul_adder_15: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_sint_mul_adder_15_io_a,
            b => multiplier_sint_mul_adder_15_io_b,
            r => multiplier_sint_mul_adder_15_io_r
        );

    multiplier_sint_mul_adder_16: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_sint_mul_adder_16_io_a,
            b => multiplier_sint_mul_adder_16_io_b,
            r => multiplier_sint_mul_adder_16_io_r
        );

    multiplier_sint_mul_adder_17: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_sint_mul_adder_17_io_a,
            b => multiplier_sint_mul_adder_17_io_b,
            r => multiplier_sint_mul_adder_17_io_r
        );

    multiplier_sint_mul_adder_18: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_sint_mul_adder_18_io_a,
            b => multiplier_sint_mul_adder_18_io_b,
            r => multiplier_sint_mul_adder_18_io_r
        );

    multiplier_sint_mul_adder_19: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_sint_mul_adder_19_io_a,
            b => multiplier_sint_mul_adder_19_io_b,
            r => multiplier_sint_mul_adder_19_io_r
        );

    multiplier_sint_mul_adder_20: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_sint_mul_adder_20_io_a,
            b => multiplier_sint_mul_adder_20_io_b,
            r => multiplier_sint_mul_adder_20_io_r
        );

    multiplier_sint_mul_adder_21: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_sint_mul_adder_21_io_a,
            b => multiplier_sint_mul_adder_21_io_b,
            r => multiplier_sint_mul_adder_21_io_r
        );

    multiplier_sint_mul_adder_22: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_sint_mul_adder_22_io_a,
            b => multiplier_sint_mul_adder_22_io_b,
            r => multiplier_sint_mul_adder_22_io_r
        );

    multiplier_sint_mul_adder_23: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_sint_mul_adder_23_io_a,
            b => multiplier_sint_mul_adder_23_io_b,
            r => multiplier_sint_mul_adder_23_io_r
        );

    multiplier_sint_mul_adder_24: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_sint_mul_adder_24_io_a,
            b => multiplier_sint_mul_adder_24_io_b,
            r => multiplier_sint_mul_adder_24_io_r
        );

    multiplier_sint_mul_adder_25: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_sint_mul_adder_25_io_a,
            b => multiplier_sint_mul_adder_25_io_b,
            r => multiplier_sint_mul_adder_25_io_r
        );

    multiplier_sint_mul_adder_26: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_sint_mul_adder_26_io_a,
            b => multiplier_sint_mul_adder_26_io_b,
            r => multiplier_sint_mul_adder_26_io_r
        );

    multiplier_sint_mul_subtractor: BitsSubtract_SInt_58_SInt_58
        port map(
            a => multiplier_sint_mul_subtractor_io_a,
            b => multiplier_sint_mul_subtractor_io_b,
            r => multiplier_sint_mul_subtractor_io_r
        );

    multiplier_tc: Multiply_SFixedPoint_16_12_SFixedPoint_16_12_Truncated_Truncator
        port map(
            i => multiplier_tc_io_i,
            o => multiplier_tc_io_o
        );

    multiplier_1_sint_mul_gen_addends: Multiply_SInt_29_SInt_29_AddendsGenerator
        port map(
            long => multiplier_1_sint_mul_gen_addends_io_long,
            short => multiplier_1_sint_mul_gen_addends_io_short,
            addend_0 => multiplier_1_sint_mul_gen_addends_io_addend_0,
            addend_1 => multiplier_1_sint_mul_gen_addends_io_addend_1,
            addend_2 => multiplier_1_sint_mul_gen_addends_io_addend_2,
            addend_3 => multiplier_1_sint_mul_gen_addends_io_addend_3,
            addend_4 => multiplier_1_sint_mul_gen_addends_io_addend_4,
            addend_5 => multiplier_1_sint_mul_gen_addends_io_addend_5,
            addend_6 => multiplier_1_sint_mul_gen_addends_io_addend_6,
            addend_7 => multiplier_1_sint_mul_gen_addends_io_addend_7,
            addend_8 => multiplier_1_sint_mul_gen_addends_io_addend_8,
            addend_9 => multiplier_1_sint_mul_gen_addends_io_addend_9,
            addend_10 => multiplier_1_sint_mul_gen_addends_io_addend_10,
            addend_11 => multiplier_1_sint_mul_gen_addends_io_addend_11,
            addend_12 => multiplier_1_sint_mul_gen_addends_io_addend_12,
            addend_13 => multiplier_1_sint_mul_gen_addends_io_addend_13,
            addend_14 => multiplier_1_sint_mul_gen_addends_io_addend_14,
            addend_15 => multiplier_1_sint_mul_gen_addends_io_addend_15,
            addend_16 => multiplier_1_sint_mul_gen_addends_io_addend_16,
            addend_17 => multiplier_1_sint_mul_gen_addends_io_addend_17,
            addend_18 => multiplier_1_sint_mul_gen_addends_io_addend_18,
            addend_19 => multiplier_1_sint_mul_gen_addends_io_addend_19,
            addend_20 => multiplier_1_sint_mul_gen_addends_io_addend_20,
            addend_21 => multiplier_1_sint_mul_gen_addends_io_addend_21,
            addend_22 => multiplier_1_sint_mul_gen_addends_io_addend_22,
            addend_23 => multiplier_1_sint_mul_gen_addends_io_addend_23,
            addend_24 => multiplier_1_sint_mul_gen_addends_io_addend_24,
            addend_25 => multiplier_1_sint_mul_gen_addends_io_addend_25,
            addend_26 => multiplier_1_sint_mul_gen_addends_io_addend_26,
            addend_27 => multiplier_1_sint_mul_gen_addends_io_addend_27,
            subend => multiplier_1_sint_mul_gen_addends_io_subend
        );

    multiplier_1_sint_mul_adder_0: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_1_sint_mul_adder_0_io_a,
            b => multiplier_1_sint_mul_adder_0_io_b,
            r => multiplier_1_sint_mul_adder_0_io_r
        );

    multiplier_1_sint_mul_adder_1: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_1_sint_mul_adder_1_io_a,
            b => multiplier_1_sint_mul_adder_1_io_b,
            r => multiplier_1_sint_mul_adder_1_io_r
        );

    multiplier_1_sint_mul_adder_2: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_1_sint_mul_adder_2_io_a,
            b => multiplier_1_sint_mul_adder_2_io_b,
            r => multiplier_1_sint_mul_adder_2_io_r
        );

    multiplier_1_sint_mul_adder_3: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_1_sint_mul_adder_3_io_a,
            b => multiplier_1_sint_mul_adder_3_io_b,
            r => multiplier_1_sint_mul_adder_3_io_r
        );

    multiplier_1_sint_mul_adder_4: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_1_sint_mul_adder_4_io_a,
            b => multiplier_1_sint_mul_adder_4_io_b,
            r => multiplier_1_sint_mul_adder_4_io_r
        );

    multiplier_1_sint_mul_adder_5: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_1_sint_mul_adder_5_io_a,
            b => multiplier_1_sint_mul_adder_5_io_b,
            r => multiplier_1_sint_mul_adder_5_io_r
        );

    multiplier_1_sint_mul_adder_6: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_1_sint_mul_adder_6_io_a,
            b => multiplier_1_sint_mul_adder_6_io_b,
            r => multiplier_1_sint_mul_adder_6_io_r
        );

    multiplier_1_sint_mul_adder_7: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_1_sint_mul_adder_7_io_a,
            b => multiplier_1_sint_mul_adder_7_io_b,
            r => multiplier_1_sint_mul_adder_7_io_r
        );

    multiplier_1_sint_mul_adder_8: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_1_sint_mul_adder_8_io_a,
            b => multiplier_1_sint_mul_adder_8_io_b,
            r => multiplier_1_sint_mul_adder_8_io_r
        );

    multiplier_1_sint_mul_adder_9: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_1_sint_mul_adder_9_io_a,
            b => multiplier_1_sint_mul_adder_9_io_b,
            r => multiplier_1_sint_mul_adder_9_io_r
        );

    multiplier_1_sint_mul_adder_10: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_1_sint_mul_adder_10_io_a,
            b => multiplier_1_sint_mul_adder_10_io_b,
            r => multiplier_1_sint_mul_adder_10_io_r
        );

    multiplier_1_sint_mul_adder_11: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_1_sint_mul_adder_11_io_a,
            b => multiplier_1_sint_mul_adder_11_io_b,
            r => multiplier_1_sint_mul_adder_11_io_r
        );

    multiplier_1_sint_mul_adder_12: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_1_sint_mul_adder_12_io_a,
            b => multiplier_1_sint_mul_adder_12_io_b,
            r => multiplier_1_sint_mul_adder_12_io_r
        );

    multiplier_1_sint_mul_adder_13: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_1_sint_mul_adder_13_io_a,
            b => multiplier_1_sint_mul_adder_13_io_b,
            r => multiplier_1_sint_mul_adder_13_io_r
        );

    multiplier_1_sint_mul_adder_14: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_1_sint_mul_adder_14_io_a,
            b => multiplier_1_sint_mul_adder_14_io_b,
            r => multiplier_1_sint_mul_adder_14_io_r
        );

    multiplier_1_sint_mul_adder_15: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_1_sint_mul_adder_15_io_a,
            b => multiplier_1_sint_mul_adder_15_io_b,
            r => multiplier_1_sint_mul_adder_15_io_r
        );

    multiplier_1_sint_mul_adder_16: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_1_sint_mul_adder_16_io_a,
            b => multiplier_1_sint_mul_adder_16_io_b,
            r => multiplier_1_sint_mul_adder_16_io_r
        );

    multiplier_1_sint_mul_adder_17: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_1_sint_mul_adder_17_io_a,
            b => multiplier_1_sint_mul_adder_17_io_b,
            r => multiplier_1_sint_mul_adder_17_io_r
        );

    multiplier_1_sint_mul_adder_18: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_1_sint_mul_adder_18_io_a,
            b => multiplier_1_sint_mul_adder_18_io_b,
            r => multiplier_1_sint_mul_adder_18_io_r
        );

    multiplier_1_sint_mul_adder_19: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_1_sint_mul_adder_19_io_a,
            b => multiplier_1_sint_mul_adder_19_io_b,
            r => multiplier_1_sint_mul_adder_19_io_r
        );

    multiplier_1_sint_mul_adder_20: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_1_sint_mul_adder_20_io_a,
            b => multiplier_1_sint_mul_adder_20_io_b,
            r => multiplier_1_sint_mul_adder_20_io_r
        );

    multiplier_1_sint_mul_adder_21: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_1_sint_mul_adder_21_io_a,
            b => multiplier_1_sint_mul_adder_21_io_b,
            r => multiplier_1_sint_mul_adder_21_io_r
        );

    multiplier_1_sint_mul_adder_22: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_1_sint_mul_adder_22_io_a,
            b => multiplier_1_sint_mul_adder_22_io_b,
            r => multiplier_1_sint_mul_adder_22_io_r
        );

    multiplier_1_sint_mul_adder_23: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_1_sint_mul_adder_23_io_a,
            b => multiplier_1_sint_mul_adder_23_io_b,
            r => multiplier_1_sint_mul_adder_23_io_r
        );

    multiplier_1_sint_mul_adder_24: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_1_sint_mul_adder_24_io_a,
            b => multiplier_1_sint_mul_adder_24_io_b,
            r => multiplier_1_sint_mul_adder_24_io_r
        );

    multiplier_1_sint_mul_adder_25: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_1_sint_mul_adder_25_io_a,
            b => multiplier_1_sint_mul_adder_25_io_b,
            r => multiplier_1_sint_mul_adder_25_io_r
        );

    multiplier_1_sint_mul_adder_26: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_1_sint_mul_adder_26_io_a,
            b => multiplier_1_sint_mul_adder_26_io_b,
            r => multiplier_1_sint_mul_adder_26_io_r
        );

    multiplier_1_sint_mul_subtractor: BitsSubtract_SInt_58_SInt_58
        port map(
            a => multiplier_1_sint_mul_subtractor_io_a,
            b => multiplier_1_sint_mul_subtractor_io_b,
            r => multiplier_1_sint_mul_subtractor_io_r
        );

    multiplier_1_tc: Multiply_SFixedPoint_16_12_SFixedPoint_16_12_Truncated_Truncator
        port map(
            i => multiplier_1_tc_io_i,
            o => multiplier_1_tc_io_o
        );

    adder_5: EqualTypesAdd_SFixedPoint_16_12_SFixedPoint_16_12
        port map(
            a => adder_5_io_a,
            b => adder_5_io_b,
            r => adder_5_io_r
        );

    shifter_5: Shift_Neg3_SFixedPoint_16_12
        port map(
            i => shifter_5_io_i,
            o => shifter_5_io_o
        );

    constant_8_opt: Constants_99e998fd468424c7_Core
        port map(
            o => constant_8_opt_io_o
        );

    adder_6: EqualTypesAdd_SFixedPoint_16_12_SFixedPoint_16_12
        port map(
            a => adder_6_io_a,
            b => adder_6_io_b,
            r => adder_6_io_r
        );

    shifter_6: Shift_Neg1_SFixedPoint_16_12
        port map(
            i => shifter_6_io_i,
            o => shifter_6_io_o
        );

    subtractor_7: EqualTypesSubtract_SFixedPoint_16_12_SFixedPoint_16_12
        port map(
            a => subtractor_7_io_a,
            b => subtractor_7_io_b,
            r => subtractor_7_io_r
        );

    shifter_7: Shift_Neg2_SFixedPoint_16_12
        port map(
            i => shifter_7_io_i,
            o => shifter_7_io_o
        );

    fract_2: Fract_SFixedPoint_16_12
        port map(
            i => fract_2_io_i,
            o => fract_2_io_o
        );

    shifter_8: Shift_1_SFixedPoint_16_12
        port map(
            i => shifter_8_io_i,
            o => shifter_8_io_o
        );

    constant_9_opt: Constants_99e998fd468424c7_Core
        port map(
            o => constant_9_opt_io_o
        );

    subtractor_8: EqualTypesSubtract_SFixedPoint_16_12_SFixedPoint_16_12
        port map(
            a => subtractor_8_io_a,
            b => subtractor_8_io_b,
            r => subtractor_8_io_r
        );

    min_2: Min_SFixedPoint_16_12
        port map(
            a => min_2_io_a,
            b => min_2_io_b,
            o => min_2_io_o
        );

    shifter_9: Shift_2_SFixedPoint_16_12
        port map(
            i => shifter_9_io_i,
            o => shifter_9_io_o
        );

    fract_3: Fract_SFixedPoint_16_12
        port map(
            i => fract_3_io_i,
            o => fract_3_io_o
        );

    slicer: Slice_28
        port map(
            i => slicer_io_i,
            o => slicer_io_o
        );

    constant_10_opt: Constants_99e998fd468424c7_Core
        port map(
            o => constant_10_opt_io_o
        );

    subtractor_9: EqualTypesSubtract_SFixedPoint_16_12_SFixedPoint_16_12
        port map(
            a => subtractor_9_io_a,
            b => subtractor_9_io_b,
            r => subtractor_9_io_r
        );

    mux: BinaryMultiplexer_SFixedPoint_16_12
        port map(
            i0 => mux_io_i0,
            i1 => mux_io_i1,
            sel => mux_io_sel,
            o => mux_io_o
        );

    constant_11_opt: Constants_22096c00982b9179_Core
        port map(
            o => constant_11_opt_io_o
        );

    multiplier_2_sint_mul_gen_addends: Multiply_SInt_29_SInt_29_AddendsGenerator
        port map(
            long => multiplier_2_sint_mul_gen_addends_io_long,
            short => multiplier_2_sint_mul_gen_addends_io_short,
            addend_0 => multiplier_2_sint_mul_gen_addends_io_addend_0,
            addend_1 => multiplier_2_sint_mul_gen_addends_io_addend_1,
            addend_2 => multiplier_2_sint_mul_gen_addends_io_addend_2,
            addend_3 => multiplier_2_sint_mul_gen_addends_io_addend_3,
            addend_4 => multiplier_2_sint_mul_gen_addends_io_addend_4,
            addend_5 => multiplier_2_sint_mul_gen_addends_io_addend_5,
            addend_6 => multiplier_2_sint_mul_gen_addends_io_addend_6,
            addend_7 => multiplier_2_sint_mul_gen_addends_io_addend_7,
            addend_8 => multiplier_2_sint_mul_gen_addends_io_addend_8,
            addend_9 => multiplier_2_sint_mul_gen_addends_io_addend_9,
            addend_10 => multiplier_2_sint_mul_gen_addends_io_addend_10,
            addend_11 => multiplier_2_sint_mul_gen_addends_io_addend_11,
            addend_12 => multiplier_2_sint_mul_gen_addends_io_addend_12,
            addend_13 => multiplier_2_sint_mul_gen_addends_io_addend_13,
            addend_14 => multiplier_2_sint_mul_gen_addends_io_addend_14,
            addend_15 => multiplier_2_sint_mul_gen_addends_io_addend_15,
            addend_16 => multiplier_2_sint_mul_gen_addends_io_addend_16,
            addend_17 => multiplier_2_sint_mul_gen_addends_io_addend_17,
            addend_18 => multiplier_2_sint_mul_gen_addends_io_addend_18,
            addend_19 => multiplier_2_sint_mul_gen_addends_io_addend_19,
            addend_20 => multiplier_2_sint_mul_gen_addends_io_addend_20,
            addend_21 => multiplier_2_sint_mul_gen_addends_io_addend_21,
            addend_22 => multiplier_2_sint_mul_gen_addends_io_addend_22,
            addend_23 => multiplier_2_sint_mul_gen_addends_io_addend_23,
            addend_24 => multiplier_2_sint_mul_gen_addends_io_addend_24,
            addend_25 => multiplier_2_sint_mul_gen_addends_io_addend_25,
            addend_26 => multiplier_2_sint_mul_gen_addends_io_addend_26,
            addend_27 => multiplier_2_sint_mul_gen_addends_io_addend_27,
            subend => multiplier_2_sint_mul_gen_addends_io_subend
        );

    multiplier_2_sint_mul_adder_0: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_2_sint_mul_adder_0_io_a,
            b => multiplier_2_sint_mul_adder_0_io_b,
            r => multiplier_2_sint_mul_adder_0_io_r
        );

    multiplier_2_sint_mul_adder_1: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_2_sint_mul_adder_1_io_a,
            b => multiplier_2_sint_mul_adder_1_io_b,
            r => multiplier_2_sint_mul_adder_1_io_r
        );

    multiplier_2_sint_mul_adder_2: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_2_sint_mul_adder_2_io_a,
            b => multiplier_2_sint_mul_adder_2_io_b,
            r => multiplier_2_sint_mul_adder_2_io_r
        );

    multiplier_2_sint_mul_adder_3: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_2_sint_mul_adder_3_io_a,
            b => multiplier_2_sint_mul_adder_3_io_b,
            r => multiplier_2_sint_mul_adder_3_io_r
        );

    multiplier_2_sint_mul_adder_4: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_2_sint_mul_adder_4_io_a,
            b => multiplier_2_sint_mul_adder_4_io_b,
            r => multiplier_2_sint_mul_adder_4_io_r
        );

    multiplier_2_sint_mul_adder_5: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_2_sint_mul_adder_5_io_a,
            b => multiplier_2_sint_mul_adder_5_io_b,
            r => multiplier_2_sint_mul_adder_5_io_r
        );

    multiplier_2_sint_mul_adder_6: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_2_sint_mul_adder_6_io_a,
            b => multiplier_2_sint_mul_adder_6_io_b,
            r => multiplier_2_sint_mul_adder_6_io_r
        );

    multiplier_2_sint_mul_adder_7: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_2_sint_mul_adder_7_io_a,
            b => multiplier_2_sint_mul_adder_7_io_b,
            r => multiplier_2_sint_mul_adder_7_io_r
        );

    multiplier_2_sint_mul_adder_8: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_2_sint_mul_adder_8_io_a,
            b => multiplier_2_sint_mul_adder_8_io_b,
            r => multiplier_2_sint_mul_adder_8_io_r
        );

    multiplier_2_sint_mul_adder_9: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_2_sint_mul_adder_9_io_a,
            b => multiplier_2_sint_mul_adder_9_io_b,
            r => multiplier_2_sint_mul_adder_9_io_r
        );

    multiplier_2_sint_mul_adder_10: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_2_sint_mul_adder_10_io_a,
            b => multiplier_2_sint_mul_adder_10_io_b,
            r => multiplier_2_sint_mul_adder_10_io_r
        );

    multiplier_2_sint_mul_adder_11: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_2_sint_mul_adder_11_io_a,
            b => multiplier_2_sint_mul_adder_11_io_b,
            r => multiplier_2_sint_mul_adder_11_io_r
        );

    multiplier_2_sint_mul_adder_12: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_2_sint_mul_adder_12_io_a,
            b => multiplier_2_sint_mul_adder_12_io_b,
            r => multiplier_2_sint_mul_adder_12_io_r
        );

    multiplier_2_sint_mul_adder_13: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_2_sint_mul_adder_13_io_a,
            b => multiplier_2_sint_mul_adder_13_io_b,
            r => multiplier_2_sint_mul_adder_13_io_r
        );

    multiplier_2_sint_mul_adder_14: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_2_sint_mul_adder_14_io_a,
            b => multiplier_2_sint_mul_adder_14_io_b,
            r => multiplier_2_sint_mul_adder_14_io_r
        );

    multiplier_2_sint_mul_adder_15: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_2_sint_mul_adder_15_io_a,
            b => multiplier_2_sint_mul_adder_15_io_b,
            r => multiplier_2_sint_mul_adder_15_io_r
        );

    multiplier_2_sint_mul_adder_16: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_2_sint_mul_adder_16_io_a,
            b => multiplier_2_sint_mul_adder_16_io_b,
            r => multiplier_2_sint_mul_adder_16_io_r
        );

    multiplier_2_sint_mul_adder_17: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_2_sint_mul_adder_17_io_a,
            b => multiplier_2_sint_mul_adder_17_io_b,
            r => multiplier_2_sint_mul_adder_17_io_r
        );

    multiplier_2_sint_mul_adder_18: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_2_sint_mul_adder_18_io_a,
            b => multiplier_2_sint_mul_adder_18_io_b,
            r => multiplier_2_sint_mul_adder_18_io_r
        );

    multiplier_2_sint_mul_adder_19: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_2_sint_mul_adder_19_io_a,
            b => multiplier_2_sint_mul_adder_19_io_b,
            r => multiplier_2_sint_mul_adder_19_io_r
        );

    multiplier_2_sint_mul_adder_20: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_2_sint_mul_adder_20_io_a,
            b => multiplier_2_sint_mul_adder_20_io_b,
            r => multiplier_2_sint_mul_adder_20_io_r
        );

    multiplier_2_sint_mul_adder_21: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_2_sint_mul_adder_21_io_a,
            b => multiplier_2_sint_mul_adder_21_io_b,
            r => multiplier_2_sint_mul_adder_21_io_r
        );

    multiplier_2_sint_mul_adder_22: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_2_sint_mul_adder_22_io_a,
            b => multiplier_2_sint_mul_adder_22_io_b,
            r => multiplier_2_sint_mul_adder_22_io_r
        );

    multiplier_2_sint_mul_adder_23: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_2_sint_mul_adder_23_io_a,
            b => multiplier_2_sint_mul_adder_23_io_b,
            r => multiplier_2_sint_mul_adder_23_io_r
        );

    multiplier_2_sint_mul_adder_24: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_2_sint_mul_adder_24_io_a,
            b => multiplier_2_sint_mul_adder_24_io_b,
            r => multiplier_2_sint_mul_adder_24_io_r
        );

    multiplier_2_sint_mul_adder_25: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_2_sint_mul_adder_25_io_a,
            b => multiplier_2_sint_mul_adder_25_io_b,
            r => multiplier_2_sint_mul_adder_25_io_r
        );

    multiplier_2_sint_mul_adder_26: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_2_sint_mul_adder_26_io_a,
            b => multiplier_2_sint_mul_adder_26_io_b,
            r => multiplier_2_sint_mul_adder_26_io_r
        );

    multiplier_2_sint_mul_subtractor: BitsSubtract_SInt_58_SInt_58
        port map(
            a => multiplier_2_sint_mul_subtractor_io_a,
            b => multiplier_2_sint_mul_subtractor_io_b,
            r => multiplier_2_sint_mul_subtractor_io_r
        );

    multiplier_2_tc: Multiply_SFixedPoint_16_12_SFixedPoint_16_12_Truncated_Truncator
        port map(
            i => multiplier_2_tc_io_i,
            o => multiplier_2_tc_io_o
        );

    multiplier_3_sint_mul_gen_addends: Multiply_SInt_29_SInt_29_AddendsGenerator
        port map(
            long => multiplier_3_sint_mul_gen_addends_io_long,
            short => multiplier_3_sint_mul_gen_addends_io_short,
            addend_0 => multiplier_3_sint_mul_gen_addends_io_addend_0,
            addend_1 => multiplier_3_sint_mul_gen_addends_io_addend_1,
            addend_2 => multiplier_3_sint_mul_gen_addends_io_addend_2,
            addend_3 => multiplier_3_sint_mul_gen_addends_io_addend_3,
            addend_4 => multiplier_3_sint_mul_gen_addends_io_addend_4,
            addend_5 => multiplier_3_sint_mul_gen_addends_io_addend_5,
            addend_6 => multiplier_3_sint_mul_gen_addends_io_addend_6,
            addend_7 => multiplier_3_sint_mul_gen_addends_io_addend_7,
            addend_8 => multiplier_3_sint_mul_gen_addends_io_addend_8,
            addend_9 => multiplier_3_sint_mul_gen_addends_io_addend_9,
            addend_10 => multiplier_3_sint_mul_gen_addends_io_addend_10,
            addend_11 => multiplier_3_sint_mul_gen_addends_io_addend_11,
            addend_12 => multiplier_3_sint_mul_gen_addends_io_addend_12,
            addend_13 => multiplier_3_sint_mul_gen_addends_io_addend_13,
            addend_14 => multiplier_3_sint_mul_gen_addends_io_addend_14,
            addend_15 => multiplier_3_sint_mul_gen_addends_io_addend_15,
            addend_16 => multiplier_3_sint_mul_gen_addends_io_addend_16,
            addend_17 => multiplier_3_sint_mul_gen_addends_io_addend_17,
            addend_18 => multiplier_3_sint_mul_gen_addends_io_addend_18,
            addend_19 => multiplier_3_sint_mul_gen_addends_io_addend_19,
            addend_20 => multiplier_3_sint_mul_gen_addends_io_addend_20,
            addend_21 => multiplier_3_sint_mul_gen_addends_io_addend_21,
            addend_22 => multiplier_3_sint_mul_gen_addends_io_addend_22,
            addend_23 => multiplier_3_sint_mul_gen_addends_io_addend_23,
            addend_24 => multiplier_3_sint_mul_gen_addends_io_addend_24,
            addend_25 => multiplier_3_sint_mul_gen_addends_io_addend_25,
            addend_26 => multiplier_3_sint_mul_gen_addends_io_addend_26,
            addend_27 => multiplier_3_sint_mul_gen_addends_io_addend_27,
            subend => multiplier_3_sint_mul_gen_addends_io_subend
        );

    multiplier_3_sint_mul_adder_0: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_3_sint_mul_adder_0_io_a,
            b => multiplier_3_sint_mul_adder_0_io_b,
            r => multiplier_3_sint_mul_adder_0_io_r
        );

    multiplier_3_sint_mul_adder_1: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_3_sint_mul_adder_1_io_a,
            b => multiplier_3_sint_mul_adder_1_io_b,
            r => multiplier_3_sint_mul_adder_1_io_r
        );

    multiplier_3_sint_mul_adder_2: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_3_sint_mul_adder_2_io_a,
            b => multiplier_3_sint_mul_adder_2_io_b,
            r => multiplier_3_sint_mul_adder_2_io_r
        );

    multiplier_3_sint_mul_adder_3: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_3_sint_mul_adder_3_io_a,
            b => multiplier_3_sint_mul_adder_3_io_b,
            r => multiplier_3_sint_mul_adder_3_io_r
        );

    multiplier_3_sint_mul_adder_4: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_3_sint_mul_adder_4_io_a,
            b => multiplier_3_sint_mul_adder_4_io_b,
            r => multiplier_3_sint_mul_adder_4_io_r
        );

    multiplier_3_sint_mul_adder_5: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_3_sint_mul_adder_5_io_a,
            b => multiplier_3_sint_mul_adder_5_io_b,
            r => multiplier_3_sint_mul_adder_5_io_r
        );

    multiplier_3_sint_mul_adder_6: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_3_sint_mul_adder_6_io_a,
            b => multiplier_3_sint_mul_adder_6_io_b,
            r => multiplier_3_sint_mul_adder_6_io_r
        );

    multiplier_3_sint_mul_adder_7: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_3_sint_mul_adder_7_io_a,
            b => multiplier_3_sint_mul_adder_7_io_b,
            r => multiplier_3_sint_mul_adder_7_io_r
        );

    multiplier_3_sint_mul_adder_8: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_3_sint_mul_adder_8_io_a,
            b => multiplier_3_sint_mul_adder_8_io_b,
            r => multiplier_3_sint_mul_adder_8_io_r
        );

    multiplier_3_sint_mul_adder_9: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_3_sint_mul_adder_9_io_a,
            b => multiplier_3_sint_mul_adder_9_io_b,
            r => multiplier_3_sint_mul_adder_9_io_r
        );

    multiplier_3_sint_mul_adder_10: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_3_sint_mul_adder_10_io_a,
            b => multiplier_3_sint_mul_adder_10_io_b,
            r => multiplier_3_sint_mul_adder_10_io_r
        );

    multiplier_3_sint_mul_adder_11: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_3_sint_mul_adder_11_io_a,
            b => multiplier_3_sint_mul_adder_11_io_b,
            r => multiplier_3_sint_mul_adder_11_io_r
        );

    multiplier_3_sint_mul_adder_12: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_3_sint_mul_adder_12_io_a,
            b => multiplier_3_sint_mul_adder_12_io_b,
            r => multiplier_3_sint_mul_adder_12_io_r
        );

    multiplier_3_sint_mul_adder_13: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_3_sint_mul_adder_13_io_a,
            b => multiplier_3_sint_mul_adder_13_io_b,
            r => multiplier_3_sint_mul_adder_13_io_r
        );

    multiplier_3_sint_mul_adder_14: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_3_sint_mul_adder_14_io_a,
            b => multiplier_3_sint_mul_adder_14_io_b,
            r => multiplier_3_sint_mul_adder_14_io_r
        );

    multiplier_3_sint_mul_adder_15: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_3_sint_mul_adder_15_io_a,
            b => multiplier_3_sint_mul_adder_15_io_b,
            r => multiplier_3_sint_mul_adder_15_io_r
        );

    multiplier_3_sint_mul_adder_16: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_3_sint_mul_adder_16_io_a,
            b => multiplier_3_sint_mul_adder_16_io_b,
            r => multiplier_3_sint_mul_adder_16_io_r
        );

    multiplier_3_sint_mul_adder_17: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_3_sint_mul_adder_17_io_a,
            b => multiplier_3_sint_mul_adder_17_io_b,
            r => multiplier_3_sint_mul_adder_17_io_r
        );

    multiplier_3_sint_mul_adder_18: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_3_sint_mul_adder_18_io_a,
            b => multiplier_3_sint_mul_adder_18_io_b,
            r => multiplier_3_sint_mul_adder_18_io_r
        );

    multiplier_3_sint_mul_adder_19: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_3_sint_mul_adder_19_io_a,
            b => multiplier_3_sint_mul_adder_19_io_b,
            r => multiplier_3_sint_mul_adder_19_io_r
        );

    multiplier_3_sint_mul_adder_20: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_3_sint_mul_adder_20_io_a,
            b => multiplier_3_sint_mul_adder_20_io_b,
            r => multiplier_3_sint_mul_adder_20_io_r
        );

    multiplier_3_sint_mul_adder_21: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_3_sint_mul_adder_21_io_a,
            b => multiplier_3_sint_mul_adder_21_io_b,
            r => multiplier_3_sint_mul_adder_21_io_r
        );

    multiplier_3_sint_mul_adder_22: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_3_sint_mul_adder_22_io_a,
            b => multiplier_3_sint_mul_adder_22_io_b,
            r => multiplier_3_sint_mul_adder_22_io_r
        );

    multiplier_3_sint_mul_adder_23: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_3_sint_mul_adder_23_io_a,
            b => multiplier_3_sint_mul_adder_23_io_b,
            r => multiplier_3_sint_mul_adder_23_io_r
        );

    multiplier_3_sint_mul_adder_24: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_3_sint_mul_adder_24_io_a,
            b => multiplier_3_sint_mul_adder_24_io_b,
            r => multiplier_3_sint_mul_adder_24_io_r
        );

    multiplier_3_sint_mul_adder_25: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_3_sint_mul_adder_25_io_a,
            b => multiplier_3_sint_mul_adder_25_io_b,
            r => multiplier_3_sint_mul_adder_25_io_r
        );

    multiplier_3_sint_mul_adder_26: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_3_sint_mul_adder_26_io_a,
            b => multiplier_3_sint_mul_adder_26_io_b,
            r => multiplier_3_sint_mul_adder_26_io_r
        );

    multiplier_3_sint_mul_subtractor: BitsSubtract_SInt_58_SInt_58
        port map(
            a => multiplier_3_sint_mul_subtractor_io_a,
            b => multiplier_3_sint_mul_subtractor_io_b,
            r => multiplier_3_sint_mul_subtractor_io_r
        );

    multiplier_3_tc: Multiply_SFixedPoint_16_12_SFixedPoint_16_12_Truncated_Truncator
        port map(
            i => multiplier_3_tc_io_i,
            o => multiplier_3_tc_io_o
        );

    subtractor_10: EqualTypesSubtract_SFixedPoint_16_12_SFixedPoint_16_12
        port map(
            a => subtractor_10_io_a,
            b => subtractor_10_io_b,
            r => subtractor_10_io_r
        );

    shifter_10: Shift_4_SFixedPoint_16_12
        port map(
            i => shifter_10_io_i,
            o => shifter_10_io_o
        );

    shifter_11: Shift_2_SFixedPoint_16_12
        port map(
            i => shifter_11_io_i,
            o => shifter_11_io_o
        );

    adder_7: EqualTypesAdd_SFixedPoint_16_12_SFixedPoint_16_12
        port map(
            a => adder_7_io_a,
            b => adder_7_io_b,
            r => adder_7_io_r
        );

    constant_12_opt: Constants_99e998fd468424c7_Core
        port map(
            o => constant_12_opt_io_o
        );

    adder_8: EqualTypesAdd_SFixedPoint_16_12_SFixedPoint_16_12
        port map(
            a => adder_8_io_a,
            b => adder_8_io_b,
            r => adder_8_io_r
        );

    constant_13_opt: Constants_de92917d4133a7ee_Core
        port map(
            o => constant_13_opt_io_o
        );

    max: Max_SFixedPoint_16_12
        port map(
            a => max_io_a,
            b => max_io_b,
            o => max_io_o
        );

    constant_14_opt: Constants_13749133a7754138_Core
        port map(
            o => constant_14_opt_io_o
        );

    min_3: Min_SFixedPoint_16_12
        port map(
            a => min_3_io_a,
            b => min_3_io_b,
            o => min_3_io_o
        );

    constant_15_opt: Constants_6b991d5b30977123_Core
        port map(
            o => constant_15_opt_io_o
        );

    multiplier_4_sint_mul_gen_addends: Multiply_SInt_29_SInt_29_AddendsGenerator
        port map(
            long => multiplier_4_sint_mul_gen_addends_io_long,
            short => multiplier_4_sint_mul_gen_addends_io_short,
            addend_0 => multiplier_4_sint_mul_gen_addends_io_addend_0,
            addend_1 => multiplier_4_sint_mul_gen_addends_io_addend_1,
            addend_2 => multiplier_4_sint_mul_gen_addends_io_addend_2,
            addend_3 => multiplier_4_sint_mul_gen_addends_io_addend_3,
            addend_4 => multiplier_4_sint_mul_gen_addends_io_addend_4,
            addend_5 => multiplier_4_sint_mul_gen_addends_io_addend_5,
            addend_6 => multiplier_4_sint_mul_gen_addends_io_addend_6,
            addend_7 => multiplier_4_sint_mul_gen_addends_io_addend_7,
            addend_8 => multiplier_4_sint_mul_gen_addends_io_addend_8,
            addend_9 => multiplier_4_sint_mul_gen_addends_io_addend_9,
            addend_10 => multiplier_4_sint_mul_gen_addends_io_addend_10,
            addend_11 => multiplier_4_sint_mul_gen_addends_io_addend_11,
            addend_12 => multiplier_4_sint_mul_gen_addends_io_addend_12,
            addend_13 => multiplier_4_sint_mul_gen_addends_io_addend_13,
            addend_14 => multiplier_4_sint_mul_gen_addends_io_addend_14,
            addend_15 => multiplier_4_sint_mul_gen_addends_io_addend_15,
            addend_16 => multiplier_4_sint_mul_gen_addends_io_addend_16,
            addend_17 => multiplier_4_sint_mul_gen_addends_io_addend_17,
            addend_18 => multiplier_4_sint_mul_gen_addends_io_addend_18,
            addend_19 => multiplier_4_sint_mul_gen_addends_io_addend_19,
            addend_20 => multiplier_4_sint_mul_gen_addends_io_addend_20,
            addend_21 => multiplier_4_sint_mul_gen_addends_io_addend_21,
            addend_22 => multiplier_4_sint_mul_gen_addends_io_addend_22,
            addend_23 => multiplier_4_sint_mul_gen_addends_io_addend_23,
            addend_24 => multiplier_4_sint_mul_gen_addends_io_addend_24,
            addend_25 => multiplier_4_sint_mul_gen_addends_io_addend_25,
            addend_26 => multiplier_4_sint_mul_gen_addends_io_addend_26,
            addend_27 => multiplier_4_sint_mul_gen_addends_io_addend_27,
            subend => multiplier_4_sint_mul_gen_addends_io_subend
        );

    multiplier_4_sint_mul_adder_0: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_4_sint_mul_adder_0_io_a,
            b => multiplier_4_sint_mul_adder_0_io_b,
            r => multiplier_4_sint_mul_adder_0_io_r
        );

    multiplier_4_sint_mul_adder_1: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_4_sint_mul_adder_1_io_a,
            b => multiplier_4_sint_mul_adder_1_io_b,
            r => multiplier_4_sint_mul_adder_1_io_r
        );

    multiplier_4_sint_mul_adder_2: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_4_sint_mul_adder_2_io_a,
            b => multiplier_4_sint_mul_adder_2_io_b,
            r => multiplier_4_sint_mul_adder_2_io_r
        );

    multiplier_4_sint_mul_adder_3: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_4_sint_mul_adder_3_io_a,
            b => multiplier_4_sint_mul_adder_3_io_b,
            r => multiplier_4_sint_mul_adder_3_io_r
        );

    multiplier_4_sint_mul_adder_4: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_4_sint_mul_adder_4_io_a,
            b => multiplier_4_sint_mul_adder_4_io_b,
            r => multiplier_4_sint_mul_adder_4_io_r
        );

    multiplier_4_sint_mul_adder_5: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_4_sint_mul_adder_5_io_a,
            b => multiplier_4_sint_mul_adder_5_io_b,
            r => multiplier_4_sint_mul_adder_5_io_r
        );

    multiplier_4_sint_mul_adder_6: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_4_sint_mul_adder_6_io_a,
            b => multiplier_4_sint_mul_adder_6_io_b,
            r => multiplier_4_sint_mul_adder_6_io_r
        );

    multiplier_4_sint_mul_adder_7: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_4_sint_mul_adder_7_io_a,
            b => multiplier_4_sint_mul_adder_7_io_b,
            r => multiplier_4_sint_mul_adder_7_io_r
        );

    multiplier_4_sint_mul_adder_8: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_4_sint_mul_adder_8_io_a,
            b => multiplier_4_sint_mul_adder_8_io_b,
            r => multiplier_4_sint_mul_adder_8_io_r
        );

    multiplier_4_sint_mul_adder_9: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_4_sint_mul_adder_9_io_a,
            b => multiplier_4_sint_mul_adder_9_io_b,
            r => multiplier_4_sint_mul_adder_9_io_r
        );

    multiplier_4_sint_mul_adder_10: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_4_sint_mul_adder_10_io_a,
            b => multiplier_4_sint_mul_adder_10_io_b,
            r => multiplier_4_sint_mul_adder_10_io_r
        );

    multiplier_4_sint_mul_adder_11: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_4_sint_mul_adder_11_io_a,
            b => multiplier_4_sint_mul_adder_11_io_b,
            r => multiplier_4_sint_mul_adder_11_io_r
        );

    multiplier_4_sint_mul_adder_12: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_4_sint_mul_adder_12_io_a,
            b => multiplier_4_sint_mul_adder_12_io_b,
            r => multiplier_4_sint_mul_adder_12_io_r
        );

    multiplier_4_sint_mul_adder_13: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_4_sint_mul_adder_13_io_a,
            b => multiplier_4_sint_mul_adder_13_io_b,
            r => multiplier_4_sint_mul_adder_13_io_r
        );

    multiplier_4_sint_mul_adder_14: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_4_sint_mul_adder_14_io_a,
            b => multiplier_4_sint_mul_adder_14_io_b,
            r => multiplier_4_sint_mul_adder_14_io_r
        );

    multiplier_4_sint_mul_adder_15: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_4_sint_mul_adder_15_io_a,
            b => multiplier_4_sint_mul_adder_15_io_b,
            r => multiplier_4_sint_mul_adder_15_io_r
        );

    multiplier_4_sint_mul_adder_16: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_4_sint_mul_adder_16_io_a,
            b => multiplier_4_sint_mul_adder_16_io_b,
            r => multiplier_4_sint_mul_adder_16_io_r
        );

    multiplier_4_sint_mul_adder_17: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_4_sint_mul_adder_17_io_a,
            b => multiplier_4_sint_mul_adder_17_io_b,
            r => multiplier_4_sint_mul_adder_17_io_r
        );

    multiplier_4_sint_mul_adder_18: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_4_sint_mul_adder_18_io_a,
            b => multiplier_4_sint_mul_adder_18_io_b,
            r => multiplier_4_sint_mul_adder_18_io_r
        );

    multiplier_4_sint_mul_adder_19: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_4_sint_mul_adder_19_io_a,
            b => multiplier_4_sint_mul_adder_19_io_b,
            r => multiplier_4_sint_mul_adder_19_io_r
        );

    multiplier_4_sint_mul_adder_20: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_4_sint_mul_adder_20_io_a,
            b => multiplier_4_sint_mul_adder_20_io_b,
            r => multiplier_4_sint_mul_adder_20_io_r
        );

    multiplier_4_sint_mul_adder_21: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_4_sint_mul_adder_21_io_a,
            b => multiplier_4_sint_mul_adder_21_io_b,
            r => multiplier_4_sint_mul_adder_21_io_r
        );

    multiplier_4_sint_mul_adder_22: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_4_sint_mul_adder_22_io_a,
            b => multiplier_4_sint_mul_adder_22_io_b,
            r => multiplier_4_sint_mul_adder_22_io_r
        );

    multiplier_4_sint_mul_adder_23: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_4_sint_mul_adder_23_io_a,
            b => multiplier_4_sint_mul_adder_23_io_b,
            r => multiplier_4_sint_mul_adder_23_io_r
        );

    multiplier_4_sint_mul_adder_24: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_4_sint_mul_adder_24_io_a,
            b => multiplier_4_sint_mul_adder_24_io_b,
            r => multiplier_4_sint_mul_adder_24_io_r
        );

    multiplier_4_sint_mul_adder_25: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_4_sint_mul_adder_25_io_a,
            b => multiplier_4_sint_mul_adder_25_io_b,
            r => multiplier_4_sint_mul_adder_25_io_r
        );

    multiplier_4_sint_mul_adder_26: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplier_4_sint_mul_adder_26_io_a,
            b => multiplier_4_sint_mul_adder_26_io_b,
            r => multiplier_4_sint_mul_adder_26_io_r
        );

    multiplier_4_sint_mul_subtractor: BitsSubtract_SInt_58_SInt_58
        port map(
            a => multiplier_4_sint_mul_subtractor_io_a,
            b => multiplier_4_sint_mul_subtractor_io_b,
            r => multiplier_4_sint_mul_subtractor_io_r
        );

    multiplier_4_tc: Multiply_SFixedPoint_16_12_SFixedPoint_16_12_Truncated_Truncator
        port map(
            i => multiplier_4_tc_io_i,
            o => multiplier_4_tc_io_o
        );

    adder_9: EqualTypesAdd_SFixedPoint_16_12_SFixedPoint_16_12
        port map(
            a => adder_9_io_a,
            b => adder_9_io_b,
            r => adder_9_io_r
        );

    shifter_12: Shift_Neg1_SFixedPoint_16_12
        port map(
            i => shifter_12_io_i,
            o => shifter_12_io_o
        );

    constant_16_opt: Constants_99e998fd468424c7_Core
        port map(
            o => constant_16_opt_io_o
        );

    subtractor_11: EqualTypesSubtract_SFixedPoint_16_12_SFixedPoint_16_12
        port map(
            a => subtractor_11_io_a,
            b => subtractor_11_io_b,
            r => subtractor_11_io_r
        );

    shifter_13: Shift_Neg2_SFixedPoint_16_12
        port map(
            i => shifter_13_io_i,
            o => shifter_13_io_o
        );

    constant_17_opt: Constants_99e998fd468424c7_Core
        port map(
            o => constant_17_opt_io_o
        );

    subtractor_12: EqualTypesSubtract_SFixedPoint_16_12_SFixedPoint_16_12
        port map(
            a => subtractor_12_io_a,
            b => subtractor_12_io_b,
            r => subtractor_12_io_r
        );

    constant_18_opt: Constants_de92917d4133a7ee_Core
        port map(
            o => constant_18_opt_io_o
        );

    max_1: Max_SFixedPoint_16_12
        port map(
            a => max_1_io_a,
            b => max_1_io_b,
            o => max_1_io_o
        );

    constant_19_opt: Constants_de92917d4133a7ee_Core
        port map(
            o => constant_19_opt_io_o
        );

    max_2: Max_SFixedPoint_16_12
        port map(
            a => max_2_io_a,
            b => max_2_io_b,
            o => max_2_io_o
        );

    constant_20_opt: Constants_13749133a7754138_Core
        port map(
            o => constant_20_opt_io_o
        );

    min_4: Min_SFixedPoint_16_12
        port map(
            a => min_4_io_a,
            b => min_4_io_b,
            o => min_4_io_o
        );

    constant_21_opt: Constants_13749133a7754138_Core
        port map(
            o => constant_21_opt_io_o
        );

    min_5: Min_SFixedPoint_16_12
        port map(
            a => min_5_io_a,
            b => min_5_io_b,
            o => min_5_io_o
        );

    shifter_14: Shift_8_SFixedPoint_16_12
        port map(
            i => shifter_14_io_i,
            o => shifter_14_io_o
        );

    to_sfixed_4: Convert_SFixedPoint_16_12_UFixedPoint_8_0
        port map(
            i => to_sfixed_4_io_i,
            o => to_sfixed_4_io_o
        );

    shifter_15: Shift_8_SFixedPoint_16_12
        port map(
            i => shifter_15_io_i,
            o => shifter_15_io_o
        );

    to_sfixed_5: Convert_SFixedPoint_16_12_UFixedPoint_8_0
        port map(
            i => to_sfixed_5_io_i,
            o => to_sfixed_5_io_o
        );

    concatenator: Concatenate_UFixedPoint_8_0_UFixedPoint_8_0
        port map(
            a => concatenator_io_a,
            b => concatenator_io_b,
            o => concatenator_io_o
        );

    constant_22_opt: Constants_e22224e03e3e720f_Core
        port map(
            o => constant_22_opt_io_o
        );

    concatenator_1: Concatenate_Bits_16_Bits_8
        port map(
            a => concatenator_1_io_a,
            b => concatenator_1_io_b,
            o => concatenator_1_io_o
        );

    to_sfixed_io_i <= itime_us;
    to_sfixed_2_io_i <= frag_x;
    to_sfixed_3_io_i <= frag_y;
    frag_color <= concatenator_1_io_o;
    shifter_io_i <= to_sfixed_io_o;
    to_sfixed_1_io_i <= shifter_io_o;
    reg_next_1_d_to_sfixed_1_io_o <= reg_0_d_to_sfixed_1_io_o;
    reg_next_2_d_to_sfixed_1_io_o <= reg_1_d_to_sfixed_1_io_o;
    reg_next_3_d_to_sfixed_1_io_o <= reg_2_d_to_sfixed_1_io_o;
    reg_next_4_d_to_sfixed_1_io_o <= reg_3_d_to_sfixed_1_io_o;
    reg_next_5_d_to_sfixed_1_io_o <= reg_4_d_to_sfixed_1_io_o;
    reg_next_6_d_to_sfixed_1_io_o <= reg_5_d_to_sfixed_1_io_o;
    reg_next_7_d_to_sfixed_1_io_o <= reg_6_d_to_sfixed_1_io_o;
    reg_next_8_d_to_sfixed_1_io_o <= reg_7_d_to_sfixed_1_io_o;
    reg_next_9_d_to_sfixed_1_io_o <= reg_8_d_to_sfixed_1_io_o;
    reg_next_10_d_to_sfixed_1_io_o <= reg_9_d_to_sfixed_1_io_o;
    reg_next_0_d_to_sfixed_1_io_o <= to_sfixed_1_io_o;
    subtractor_7_io_a <= reg_10_d_to_sfixed_1_io_o;
    shifter_1_io_i <= to_sfixed_2_io_o;
    shifter_2_io_i <= to_sfixed_2_io_o;
    shifter_3_io_i <= to_sfixed_3_io_o;
    shifter_4_io_i <= to_sfixed_3_io_o;
    adder_io_a <= shifter_1_io_o;
    adder_io_b <= shifter_2_io_o;
    reg_next_0_d_adder_io_r <= adder_io_r;
    subtractor_io_a <= reg_0_d_adder_io_r;
    reg_next_0_d_constant_opt_io_o <= constant_opt_io_o;
    subtractor_io_b <= reg_0_d_constant_opt_io_o;
    reg_next_0_d_subtractor_io_r <= subtractor_io_r;
    subtractor_2_io_a <= reg_0_d_subtractor_io_r;
    adder_3_io_a <= reg_0_d_subtractor_io_r;
    adder_1_io_a <= shifter_3_io_o;
    adder_1_io_b <= shifter_4_io_o;
    reg_next_0_d_adder_1_io_r <= adder_1_io_r;
    subtractor_1_io_a <= reg_0_d_adder_1_io_r;
    reg_next_0_d_constant_1_opt_io_o <= constant_1_opt_io_o;
    subtractor_1_io_b <= reg_0_d_constant_1_opt_io_o;
    reg_next_0_d_subtractor_1_io_r <= subtractor_1_io_r;
    subtractor_2_io_b <= reg_0_d_subtractor_1_io_r;
    adder_3_io_b <= reg_0_d_subtractor_1_io_r;
    reg_next_0_d_subtractor_2_io_r <= subtractor_2_io_r;
    adder_2_io_a <= reg_0_d_subtractor_2_io_r;
    reg_next_1_d_constant_2_opt_io_o <= reg_0_d_constant_2_opt_io_o;
    reg_next_2_d_constant_2_opt_io_o <= reg_1_d_constant_2_opt_io_o;
    reg_next_0_d_constant_2_opt_io_o <= constant_2_opt_io_o;
    adder_2_io_b <= reg_2_d_constant_2_opt_io_o;
    fract_io_i <= adder_2_io_r;
    reg_next_0_l_ceil_io_i <= adder_2_io_r;
    ceil_io_i <= reg_0_l_ceil_io_i;
    reg_next_0_d_adder_3_io_r <= adder_3_io_r;
    adder_4_io_a <= reg_0_d_adder_3_io_r;
    reg_next_1_d_constant_3_opt_io_o <= reg_0_d_constant_3_opt_io_o;
    reg_next_2_d_constant_3_opt_io_o <= reg_1_d_constant_3_opt_io_o;
    reg_next_0_d_constant_3_opt_io_o <= constant_3_opt_io_o;
    adder_4_io_b <= reg_2_d_constant_3_opt_io_o;
    fract_1_io_i <= adder_4_io_r;
    reg_next_0_l_ceil_1_io_i <= adder_4_io_r;
    ceil_1_io_i <= reg_0_l_ceil_1_io_i;
    reg_next_0_d_fract_io_o <= fract_io_o;
    subtractor_3_io_b <= reg_0_d_fract_io_o;
    reg_next_0_l_min_io_a <= reg_0_d_fract_io_o;
    min_io_a <= reg_0_l_min_io_a;
    reg_next_0_d_fract_1_io_o <= fract_1_io_o;
    subtractor_4_io_b <= reg_0_d_fract_1_io_o;
    reg_next_0_l_min_1_io_a <= reg_0_d_fract_1_io_o;
    min_1_io_a <= reg_0_l_min_1_io_a;
    reg_next_1_d_constant_4_opt_io_o <= reg_0_d_constant_4_opt_io_o;
    reg_next_2_d_constant_4_opt_io_o <= reg_1_d_constant_4_opt_io_o;
    reg_next_3_d_constant_4_opt_io_o <= reg_2_d_constant_4_opt_io_o;
    reg_next_0_d_constant_4_opt_io_o <= constant_4_opt_io_o;
    subtractor_3_io_a <= reg_3_d_constant_4_opt_io_o;
    reg_next_0_d_subtractor_3_io_r <= subtractor_3_io_r;
    min_io_b <= reg_0_d_subtractor_3_io_r;
    reg_next_1_d_constant_5_opt_io_o <= reg_0_d_constant_5_opt_io_o;
    reg_next_2_d_constant_5_opt_io_o <= reg_1_d_constant_5_opt_io_o;
    reg_next_3_d_constant_5_opt_io_o <= reg_2_d_constant_5_opt_io_o;
    reg_next_0_d_constant_5_opt_io_o <= constant_5_opt_io_o;
    subtractor_4_io_a <= reg_3_d_constant_5_opt_io_o;
    reg_next_0_d_subtractor_4_io_r <= subtractor_4_io_r;
    min_1_io_b <= reg_0_d_subtractor_4_io_r;
    reg_next_0_d_min_io_o <= min_io_o;
    min_2_io_a <= reg_0_d_min_io_o;
    reg_next_0_d_min_1_io_o <= min_1_io_o;
    min_2_io_b <= reg_0_d_min_1_io_o;
    reg_next_0_d_ceil_io_o <= ceil_io_o;
    subtractor_5_io_a <= reg_0_d_ceil_io_o;
    reg_next_0_d_ceil_1_io_o <= ceil_1_io_o;
    subtractor_6_io_a <= reg_0_d_ceil_1_io_o;
    reg_next_1_d_constant_6_opt_io_o <= reg_0_d_constant_6_opt_io_o;
    reg_next_2_d_constant_6_opt_io_o <= reg_1_d_constant_6_opt_io_o;
    reg_next_3_d_constant_6_opt_io_o <= reg_2_d_constant_6_opt_io_o;
    reg_next_4_d_constant_6_opt_io_o <= reg_3_d_constant_6_opt_io_o;
    reg_next_0_d_constant_6_opt_io_o <= constant_6_opt_io_o;
    subtractor_5_io_b <= reg_4_d_constant_6_opt_io_o;
    multiplier_sint_mul_gen_addends_io_long <= subtractor_5_io_r;
    multiplier_sint_mul_gen_addends_io_short <= subtractor_5_io_r;
    reg_next_1_d_constant_7_opt_io_o <= reg_0_d_constant_7_opt_io_o;
    reg_next_2_d_constant_7_opt_io_o <= reg_1_d_constant_7_opt_io_o;
    reg_next_3_d_constant_7_opt_io_o <= reg_2_d_constant_7_opt_io_o;
    reg_next_4_d_constant_7_opt_io_o <= reg_3_d_constant_7_opt_io_o;
    reg_next_0_d_constant_7_opt_io_o <= constant_7_opt_io_o;
    subtractor_6_io_b <= reg_4_d_constant_7_opt_io_o;
    multiplier_1_sint_mul_gen_addends_io_long <= subtractor_6_io_r;
    multiplier_1_sint_mul_gen_addends_io_short <= subtractor_6_io_r;
    multiplier_sint_mul_adder_0_io_a <= multiplier_sint_mul_gen_addends_io_addend_0;
    multiplier_sint_mul_adder_0_io_b <= multiplier_sint_mul_gen_addends_io_addend_1;
    multiplier_sint_mul_adder_1_io_a <= multiplier_sint_mul_gen_addends_io_addend_2;
    multiplier_sint_mul_adder_1_io_b <= multiplier_sint_mul_gen_addends_io_addend_3;
    multiplier_sint_mul_adder_2_io_a <= multiplier_sint_mul_gen_addends_io_addend_4;
    multiplier_sint_mul_adder_2_io_b <= multiplier_sint_mul_gen_addends_io_addend_5;
    multiplier_sint_mul_adder_3_io_a <= multiplier_sint_mul_gen_addends_io_addend_6;
    multiplier_sint_mul_adder_3_io_b <= multiplier_sint_mul_gen_addends_io_addend_7;
    multiplier_sint_mul_adder_4_io_a <= multiplier_sint_mul_gen_addends_io_addend_8;
    multiplier_sint_mul_adder_4_io_b <= multiplier_sint_mul_gen_addends_io_addend_9;
    multiplier_sint_mul_adder_5_io_a <= multiplier_sint_mul_gen_addends_io_addend_10;
    multiplier_sint_mul_adder_5_io_b <= multiplier_sint_mul_gen_addends_io_addend_11;
    reg_next_0_d_multiplier_sint_mul_gen_addends_io_addend_12 <= multiplier_sint_mul_gen_addends_io_addend_12;
    multiplier_sint_mul_adder_6_io_a <= reg_0_d_multiplier_sint_mul_gen_addends_io_addend_12;
    reg_next_0_d_multiplier_sint_mul_gen_addends_io_addend_13 <= multiplier_sint_mul_gen_addends_io_addend_13;
    multiplier_sint_mul_adder_6_io_b <= reg_0_d_multiplier_sint_mul_gen_addends_io_addend_13;
    reg_next_0_d_multiplier_sint_mul_gen_addends_io_addend_14 <= multiplier_sint_mul_gen_addends_io_addend_14;
    multiplier_sint_mul_adder_7_io_a <= reg_0_d_multiplier_sint_mul_gen_addends_io_addend_14;
    reg_next_0_d_multiplier_sint_mul_gen_addends_io_addend_15 <= multiplier_sint_mul_gen_addends_io_addend_15;
    multiplier_sint_mul_adder_7_io_b <= reg_0_d_multiplier_sint_mul_gen_addends_io_addend_15;
    reg_next_0_d_multiplier_sint_mul_gen_addends_io_addend_16 <= multiplier_sint_mul_gen_addends_io_addend_16;
    multiplier_sint_mul_adder_8_io_a <= reg_0_d_multiplier_sint_mul_gen_addends_io_addend_16;
    reg_next_0_d_multiplier_sint_mul_gen_addends_io_addend_17 <= multiplier_sint_mul_gen_addends_io_addend_17;
    multiplier_sint_mul_adder_8_io_b <= reg_0_d_multiplier_sint_mul_gen_addends_io_addend_17;
    reg_next_0_d_multiplier_sint_mul_gen_addends_io_addend_18 <= multiplier_sint_mul_gen_addends_io_addend_18;
    multiplier_sint_mul_adder_9_io_a <= reg_0_d_multiplier_sint_mul_gen_addends_io_addend_18;
    reg_next_0_d_multiplier_sint_mul_gen_addends_io_addend_19 <= multiplier_sint_mul_gen_addends_io_addend_19;
    multiplier_sint_mul_adder_9_io_b <= reg_0_d_multiplier_sint_mul_gen_addends_io_addend_19;
    reg_next_0_d_multiplier_sint_mul_gen_addends_io_addend_20 <= multiplier_sint_mul_gen_addends_io_addend_20;
    multiplier_sint_mul_adder_10_io_a <= reg_0_d_multiplier_sint_mul_gen_addends_io_addend_20;
    reg_next_0_d_multiplier_sint_mul_gen_addends_io_addend_21 <= multiplier_sint_mul_gen_addends_io_addend_21;
    multiplier_sint_mul_adder_10_io_b <= reg_0_d_multiplier_sint_mul_gen_addends_io_addend_21;
    reg_next_0_d_multiplier_sint_mul_gen_addends_io_addend_22 <= multiplier_sint_mul_gen_addends_io_addend_22;
    multiplier_sint_mul_adder_11_io_a <= reg_0_d_multiplier_sint_mul_gen_addends_io_addend_22;
    reg_next_0_d_multiplier_sint_mul_gen_addends_io_addend_23 <= multiplier_sint_mul_gen_addends_io_addend_23;
    multiplier_sint_mul_adder_11_io_b <= reg_0_d_multiplier_sint_mul_gen_addends_io_addend_23;
    reg_next_0_d_multiplier_sint_mul_gen_addends_io_addend_24 <= multiplier_sint_mul_gen_addends_io_addend_24;
    multiplier_sint_mul_adder_12_io_a <= reg_0_d_multiplier_sint_mul_gen_addends_io_addend_24;
    reg_next_0_d_multiplier_sint_mul_gen_addends_io_addend_25 <= multiplier_sint_mul_gen_addends_io_addend_25;
    multiplier_sint_mul_adder_12_io_b <= reg_0_d_multiplier_sint_mul_gen_addends_io_addend_25;
    reg_next_0_d_multiplier_sint_mul_gen_addends_io_addend_26 <= multiplier_sint_mul_gen_addends_io_addend_26;
    multiplier_sint_mul_adder_13_io_a <= reg_0_d_multiplier_sint_mul_gen_addends_io_addend_26;
    reg_next_0_d_multiplier_sint_mul_gen_addends_io_addend_27 <= multiplier_sint_mul_gen_addends_io_addend_27;
    multiplier_sint_mul_adder_13_io_b <= reg_0_d_multiplier_sint_mul_gen_addends_io_addend_27;
    reg_next_1_d_multiplier_sint_mul_gen_addends_io_subend <= reg_0_d_multiplier_sint_mul_gen_addends_io_subend;
    reg_next_2_d_multiplier_sint_mul_gen_addends_io_subend <= reg_1_d_multiplier_sint_mul_gen_addends_io_subend;
    reg_next_3_d_multiplier_sint_mul_gen_addends_io_subend <= reg_2_d_multiplier_sint_mul_gen_addends_io_subend;
    reg_next_0_d_multiplier_sint_mul_gen_addends_io_subend <= multiplier_sint_mul_gen_addends_io_subend;
    multiplier_sint_mul_subtractor_io_b <= reg_3_d_multiplier_sint_mul_gen_addends_io_subend;
    multiplier_sint_mul_adder_14_io_a <= multiplier_sint_mul_adder_0_io_r;
    multiplier_sint_mul_adder_14_io_b <= multiplier_sint_mul_adder_1_io_r;
    multiplier_sint_mul_adder_15_io_a <= multiplier_sint_mul_adder_2_io_r;
    multiplier_sint_mul_adder_15_io_b <= multiplier_sint_mul_adder_3_io_r;
    multiplier_sint_mul_adder_16_io_a <= multiplier_sint_mul_adder_4_io_r;
    multiplier_sint_mul_adder_16_io_b <= multiplier_sint_mul_adder_5_io_r;
    reg_next_0_d_multiplier_sint_mul_adder_6_io_r <= multiplier_sint_mul_adder_6_io_r;
    multiplier_sint_mul_adder_17_io_a <= reg_0_d_multiplier_sint_mul_adder_6_io_r;
    reg_next_0_d_multiplier_sint_mul_adder_7_io_r <= multiplier_sint_mul_adder_7_io_r;
    multiplier_sint_mul_adder_17_io_b <= reg_0_d_multiplier_sint_mul_adder_7_io_r;
    reg_next_0_d_multiplier_sint_mul_adder_8_io_r <= multiplier_sint_mul_adder_8_io_r;
    multiplier_sint_mul_adder_18_io_a <= reg_0_d_multiplier_sint_mul_adder_8_io_r;
    reg_next_0_d_multiplier_sint_mul_adder_9_io_r <= multiplier_sint_mul_adder_9_io_r;
    multiplier_sint_mul_adder_18_io_b <= reg_0_d_multiplier_sint_mul_adder_9_io_r;
    multiplier_sint_mul_adder_19_io_a <= multiplier_sint_mul_adder_10_io_r;
    multiplier_sint_mul_adder_19_io_b <= multiplier_sint_mul_adder_11_io_r;
    multiplier_sint_mul_adder_20_io_a <= multiplier_sint_mul_adder_12_io_r;
    multiplier_sint_mul_adder_20_io_b <= multiplier_sint_mul_adder_13_io_r;
    multiplier_sint_mul_adder_21_io_a <= multiplier_sint_mul_adder_14_io_r;
    multiplier_sint_mul_adder_21_io_b <= multiplier_sint_mul_adder_15_io_r;
    reg_next_1_d_multiplier_sint_mul_adder_16_io_r <= reg_0_d_multiplier_sint_mul_adder_16_io_r;
    reg_next_2_d_multiplier_sint_mul_adder_16_io_r <= reg_1_d_multiplier_sint_mul_adder_16_io_r;
    reg_next_0_d_multiplier_sint_mul_adder_16_io_r <= multiplier_sint_mul_adder_16_io_r;
    multiplier_sint_mul_adder_22_io_a <= reg_2_d_multiplier_sint_mul_adder_16_io_r;
    reg_next_0_d_multiplier_sint_mul_adder_17_io_r <= multiplier_sint_mul_adder_17_io_r;
    multiplier_sint_mul_adder_22_io_b <= reg_0_d_multiplier_sint_mul_adder_17_io_r;
    reg_next_0_d_multiplier_sint_mul_adder_18_io_r <= multiplier_sint_mul_adder_18_io_r;
    multiplier_sint_mul_adder_23_io_a <= reg_0_d_multiplier_sint_mul_adder_18_io_r;
    reg_next_1_d_multiplier_sint_mul_adder_19_io_r <= reg_0_d_multiplier_sint_mul_adder_19_io_r;
    reg_next_0_d_multiplier_sint_mul_adder_19_io_r <= multiplier_sint_mul_adder_19_io_r;
    multiplier_sint_mul_adder_23_io_b <= reg_1_d_multiplier_sint_mul_adder_19_io_r;
    reg_next_1_d_multiplier_sint_mul_adder_20_io_r <= reg_0_d_multiplier_sint_mul_adder_20_io_r;
    reg_next_0_d_multiplier_sint_mul_adder_20_io_r <= multiplier_sint_mul_adder_20_io_r;
    multiplier_sint_mul_adder_25_io_b <= reg_1_d_multiplier_sint_mul_adder_20_io_r;
    reg_next_1_d_multiplier_sint_mul_adder_21_io_r <= reg_0_d_multiplier_sint_mul_adder_21_io_r;
    reg_next_2_d_multiplier_sint_mul_adder_21_io_r <= reg_1_d_multiplier_sint_mul_adder_21_io_r;
    reg_next_0_d_multiplier_sint_mul_adder_21_io_r <= multiplier_sint_mul_adder_21_io_r;
    multiplier_sint_mul_adder_24_io_a <= reg_2_d_multiplier_sint_mul_adder_21_io_r;
    multiplier_sint_mul_adder_24_io_b <= multiplier_sint_mul_adder_22_io_r;
    multiplier_sint_mul_adder_25_io_a <= multiplier_sint_mul_adder_23_io_r;
    reg_next_0_d_multiplier_sint_mul_adder_24_io_r <= multiplier_sint_mul_adder_24_io_r;
    multiplier_sint_mul_adder_26_io_a <= reg_0_d_multiplier_sint_mul_adder_24_io_r;
    reg_next_0_d_multiplier_sint_mul_adder_25_io_r <= multiplier_sint_mul_adder_25_io_r;
    multiplier_sint_mul_adder_26_io_b <= reg_0_d_multiplier_sint_mul_adder_25_io_r;
    multiplier_sint_mul_subtractor_io_a <= multiplier_sint_mul_adder_26_io_r;
    multiplier_tc_io_i <= multiplier_sint_mul_subtractor_io_r;
    reg_next_0_d_multiplier_tc_io_o <= multiplier_tc_io_o;
    adder_5_io_a <= reg_0_d_multiplier_tc_io_o;
    multiplier_1_sint_mul_adder_0_io_a <= multiplier_1_sint_mul_gen_addends_io_addend_0;
    multiplier_1_sint_mul_adder_0_io_b <= multiplier_1_sint_mul_gen_addends_io_addend_1;
    multiplier_1_sint_mul_adder_1_io_a <= multiplier_1_sint_mul_gen_addends_io_addend_2;
    multiplier_1_sint_mul_adder_1_io_b <= multiplier_1_sint_mul_gen_addends_io_addend_3;
    multiplier_1_sint_mul_adder_2_io_a <= multiplier_1_sint_mul_gen_addends_io_addend_4;
    multiplier_1_sint_mul_adder_2_io_b <= multiplier_1_sint_mul_gen_addends_io_addend_5;
    multiplier_1_sint_mul_adder_3_io_a <= multiplier_1_sint_mul_gen_addends_io_addend_6;
    multiplier_1_sint_mul_adder_3_io_b <= multiplier_1_sint_mul_gen_addends_io_addend_7;
    multiplier_1_sint_mul_adder_4_io_a <= multiplier_1_sint_mul_gen_addends_io_addend_8;
    multiplier_1_sint_mul_adder_4_io_b <= multiplier_1_sint_mul_gen_addends_io_addend_9;
    multiplier_1_sint_mul_adder_5_io_a <= multiplier_1_sint_mul_gen_addends_io_addend_10;
    multiplier_1_sint_mul_adder_5_io_b <= multiplier_1_sint_mul_gen_addends_io_addend_11;
    reg_next_0_d_multiplier_1_sint_mul_gen_addends_io_addend_12 <= multiplier_1_sint_mul_gen_addends_io_addend_12;
    multiplier_1_sint_mul_adder_6_io_a <= reg_0_d_multiplier_1_sint_mul_gen_addends_io_addend_12;
    reg_next_0_d_multiplier_1_sint_mul_gen_addends_io_addend_13 <= multiplier_1_sint_mul_gen_addends_io_addend_13;
    multiplier_1_sint_mul_adder_6_io_b <= reg_0_d_multiplier_1_sint_mul_gen_addends_io_addend_13;
    reg_next_0_d_multiplier_1_sint_mul_gen_addends_io_addend_14 <= multiplier_1_sint_mul_gen_addends_io_addend_14;
    multiplier_1_sint_mul_adder_7_io_a <= reg_0_d_multiplier_1_sint_mul_gen_addends_io_addend_14;
    reg_next_0_d_multiplier_1_sint_mul_gen_addends_io_addend_15 <= multiplier_1_sint_mul_gen_addends_io_addend_15;
    multiplier_1_sint_mul_adder_7_io_b <= reg_0_d_multiplier_1_sint_mul_gen_addends_io_addend_15;
    reg_next_0_d_multiplier_1_sint_mul_gen_addends_io_addend_16 <= multiplier_1_sint_mul_gen_addends_io_addend_16;
    multiplier_1_sint_mul_adder_8_io_a <= reg_0_d_multiplier_1_sint_mul_gen_addends_io_addend_16;
    reg_next_0_d_multiplier_1_sint_mul_gen_addends_io_addend_17 <= multiplier_1_sint_mul_gen_addends_io_addend_17;
    multiplier_1_sint_mul_adder_8_io_b <= reg_0_d_multiplier_1_sint_mul_gen_addends_io_addend_17;
    reg_next_0_d_multiplier_1_sint_mul_gen_addends_io_addend_18 <= multiplier_1_sint_mul_gen_addends_io_addend_18;
    multiplier_1_sint_mul_adder_9_io_a <= reg_0_d_multiplier_1_sint_mul_gen_addends_io_addend_18;
    reg_next_0_d_multiplier_1_sint_mul_gen_addends_io_addend_19 <= multiplier_1_sint_mul_gen_addends_io_addend_19;
    multiplier_1_sint_mul_adder_9_io_b <= reg_0_d_multiplier_1_sint_mul_gen_addends_io_addend_19;
    reg_next_0_d_multiplier_1_sint_mul_gen_addends_io_addend_20 <= multiplier_1_sint_mul_gen_addends_io_addend_20;
    multiplier_1_sint_mul_adder_10_io_a <= reg_0_d_multiplier_1_sint_mul_gen_addends_io_addend_20;
    reg_next_0_d_multiplier_1_sint_mul_gen_addends_io_addend_21 <= multiplier_1_sint_mul_gen_addends_io_addend_21;
    multiplier_1_sint_mul_adder_10_io_b <= reg_0_d_multiplier_1_sint_mul_gen_addends_io_addend_21;
    reg_next_0_d_multiplier_1_sint_mul_gen_addends_io_addend_22 <= multiplier_1_sint_mul_gen_addends_io_addend_22;
    multiplier_1_sint_mul_adder_11_io_a <= reg_0_d_multiplier_1_sint_mul_gen_addends_io_addend_22;
    reg_next_0_d_multiplier_1_sint_mul_gen_addends_io_addend_23 <= multiplier_1_sint_mul_gen_addends_io_addend_23;
    multiplier_1_sint_mul_adder_11_io_b <= reg_0_d_multiplier_1_sint_mul_gen_addends_io_addend_23;
    reg_next_0_d_multiplier_1_sint_mul_gen_addends_io_addend_24 <= multiplier_1_sint_mul_gen_addends_io_addend_24;
    multiplier_1_sint_mul_adder_12_io_a <= reg_0_d_multiplier_1_sint_mul_gen_addends_io_addend_24;
    reg_next_0_d_multiplier_1_sint_mul_gen_addends_io_addend_25 <= multiplier_1_sint_mul_gen_addends_io_addend_25;
    multiplier_1_sint_mul_adder_12_io_b <= reg_0_d_multiplier_1_sint_mul_gen_addends_io_addend_25;
    reg_next_0_d_multiplier_1_sint_mul_gen_addends_io_addend_26 <= multiplier_1_sint_mul_gen_addends_io_addend_26;
    multiplier_1_sint_mul_adder_13_io_a <= reg_0_d_multiplier_1_sint_mul_gen_addends_io_addend_26;
    reg_next_0_d_multiplier_1_sint_mul_gen_addends_io_addend_27 <= multiplier_1_sint_mul_gen_addends_io_addend_27;
    multiplier_1_sint_mul_adder_13_io_b <= reg_0_d_multiplier_1_sint_mul_gen_addends_io_addend_27;
    reg_next_1_d_multiplier_1_sint_mul_gen_addends_io_subend <= reg_0_d_multiplier_1_sint_mul_gen_addends_io_subend;
    reg_next_2_d_multiplier_1_sint_mul_gen_addends_io_subend <= reg_1_d_multiplier_1_sint_mul_gen_addends_io_subend;
    reg_next_3_d_multiplier_1_sint_mul_gen_addends_io_subend <= reg_2_d_multiplier_1_sint_mul_gen_addends_io_subend;
    reg_next_0_d_multiplier_1_sint_mul_gen_addends_io_subend <= multiplier_1_sint_mul_gen_addends_io_subend;
    multiplier_1_sint_mul_subtractor_io_b <= reg_3_d_multiplier_1_sint_mul_gen_addends_io_subend;
    multiplier_1_sint_mul_adder_14_io_a <= multiplier_1_sint_mul_adder_0_io_r;
    multiplier_1_sint_mul_adder_14_io_b <= multiplier_1_sint_mul_adder_1_io_r;
    multiplier_1_sint_mul_adder_15_io_a <= multiplier_1_sint_mul_adder_2_io_r;
    multiplier_1_sint_mul_adder_15_io_b <= multiplier_1_sint_mul_adder_3_io_r;
    multiplier_1_sint_mul_adder_16_io_a <= multiplier_1_sint_mul_adder_4_io_r;
    multiplier_1_sint_mul_adder_16_io_b <= multiplier_1_sint_mul_adder_5_io_r;
    reg_next_0_d_multiplier_1_sint_mul_adder_6_io_r <= multiplier_1_sint_mul_adder_6_io_r;
    multiplier_1_sint_mul_adder_17_io_a <= reg_0_d_multiplier_1_sint_mul_adder_6_io_r;
    reg_next_0_d_multiplier_1_sint_mul_adder_7_io_r <= multiplier_1_sint_mul_adder_7_io_r;
    multiplier_1_sint_mul_adder_17_io_b <= reg_0_d_multiplier_1_sint_mul_adder_7_io_r;
    reg_next_0_d_multiplier_1_sint_mul_adder_8_io_r <= multiplier_1_sint_mul_adder_8_io_r;
    multiplier_1_sint_mul_adder_18_io_a <= reg_0_d_multiplier_1_sint_mul_adder_8_io_r;
    reg_next_0_d_multiplier_1_sint_mul_adder_9_io_r <= multiplier_1_sint_mul_adder_9_io_r;
    multiplier_1_sint_mul_adder_18_io_b <= reg_0_d_multiplier_1_sint_mul_adder_9_io_r;
    multiplier_1_sint_mul_adder_19_io_a <= multiplier_1_sint_mul_adder_10_io_r;
    multiplier_1_sint_mul_adder_19_io_b <= multiplier_1_sint_mul_adder_11_io_r;
    multiplier_1_sint_mul_adder_20_io_a <= multiplier_1_sint_mul_adder_12_io_r;
    multiplier_1_sint_mul_adder_20_io_b <= multiplier_1_sint_mul_adder_13_io_r;
    multiplier_1_sint_mul_adder_21_io_a <= multiplier_1_sint_mul_adder_14_io_r;
    multiplier_1_sint_mul_adder_21_io_b <= multiplier_1_sint_mul_adder_15_io_r;
    reg_next_1_d_multiplier_1_sint_mul_adder_16_io_r <= reg_0_d_multiplier_1_sint_mul_adder_16_io_r;
    reg_next_2_d_multiplier_1_sint_mul_adder_16_io_r <= reg_1_d_multiplier_1_sint_mul_adder_16_io_r;
    reg_next_0_d_multiplier_1_sint_mul_adder_16_io_r <= multiplier_1_sint_mul_adder_16_io_r;
    multiplier_1_sint_mul_adder_22_io_a <= reg_2_d_multiplier_1_sint_mul_adder_16_io_r;
    reg_next_0_d_multiplier_1_sint_mul_adder_17_io_r <= multiplier_1_sint_mul_adder_17_io_r;
    multiplier_1_sint_mul_adder_22_io_b <= reg_0_d_multiplier_1_sint_mul_adder_17_io_r;
    reg_next_0_d_multiplier_1_sint_mul_adder_18_io_r <= multiplier_1_sint_mul_adder_18_io_r;
    multiplier_1_sint_mul_adder_23_io_a <= reg_0_d_multiplier_1_sint_mul_adder_18_io_r;
    reg_next_1_d_multiplier_1_sint_mul_adder_19_io_r <= reg_0_d_multiplier_1_sint_mul_adder_19_io_r;
    reg_next_0_d_multiplier_1_sint_mul_adder_19_io_r <= multiplier_1_sint_mul_adder_19_io_r;
    multiplier_1_sint_mul_adder_23_io_b <= reg_1_d_multiplier_1_sint_mul_adder_19_io_r;
    reg_next_1_d_multiplier_1_sint_mul_adder_20_io_r <= reg_0_d_multiplier_1_sint_mul_adder_20_io_r;
    reg_next_0_d_multiplier_1_sint_mul_adder_20_io_r <= multiplier_1_sint_mul_adder_20_io_r;
    multiplier_1_sint_mul_adder_25_io_b <= reg_1_d_multiplier_1_sint_mul_adder_20_io_r;
    reg_next_1_d_multiplier_1_sint_mul_adder_21_io_r <= reg_0_d_multiplier_1_sint_mul_adder_21_io_r;
    reg_next_2_d_multiplier_1_sint_mul_adder_21_io_r <= reg_1_d_multiplier_1_sint_mul_adder_21_io_r;
    reg_next_0_d_multiplier_1_sint_mul_adder_21_io_r <= multiplier_1_sint_mul_adder_21_io_r;
    multiplier_1_sint_mul_adder_24_io_a <= reg_2_d_multiplier_1_sint_mul_adder_21_io_r;
    multiplier_1_sint_mul_adder_24_io_b <= multiplier_1_sint_mul_adder_22_io_r;
    multiplier_1_sint_mul_adder_25_io_a <= multiplier_1_sint_mul_adder_23_io_r;
    reg_next_0_d_multiplier_1_sint_mul_adder_24_io_r <= multiplier_1_sint_mul_adder_24_io_r;
    multiplier_1_sint_mul_adder_26_io_a <= reg_0_d_multiplier_1_sint_mul_adder_24_io_r;
    reg_next_0_d_multiplier_1_sint_mul_adder_25_io_r <= multiplier_1_sint_mul_adder_25_io_r;
    multiplier_1_sint_mul_adder_26_io_b <= reg_0_d_multiplier_1_sint_mul_adder_25_io_r;
    multiplier_1_sint_mul_subtractor_io_a <= multiplier_1_sint_mul_adder_26_io_r;
    multiplier_1_tc_io_i <= multiplier_1_sint_mul_subtractor_io_r;
    reg_next_0_d_multiplier_1_tc_io_o <= multiplier_1_tc_io_o;
    adder_5_io_b <= reg_0_d_multiplier_1_tc_io_o;
    shifter_5_io_i <= adder_5_io_r;
    reg_next_0_d_shifter_5_io_o <= shifter_5_io_o;
    adder_6_io_b <= reg_0_d_shifter_5_io_o;
    reg_next_1_d_constant_8_opt_io_o <= reg_0_d_constant_8_opt_io_o;
    reg_next_2_d_constant_8_opt_io_o <= reg_1_d_constant_8_opt_io_o;
    reg_next_3_d_constant_8_opt_io_o <= reg_2_d_constant_8_opt_io_o;
    reg_next_4_d_constant_8_opt_io_o <= reg_3_d_constant_8_opt_io_o;
    reg_next_5_d_constant_8_opt_io_o <= reg_4_d_constant_8_opt_io_o;
    reg_next_6_d_constant_8_opt_io_o <= reg_5_d_constant_8_opt_io_o;
    reg_next_7_d_constant_8_opt_io_o <= reg_6_d_constant_8_opt_io_o;
    reg_next_8_d_constant_8_opt_io_o <= reg_7_d_constant_8_opt_io_o;
    reg_next_9_d_constant_8_opt_io_o <= reg_8_d_constant_8_opt_io_o;
    reg_next_10_d_constant_8_opt_io_o <= reg_9_d_constant_8_opt_io_o;
    reg_next_0_d_constant_8_opt_io_o <= constant_8_opt_io_o;
    adder_6_io_a <= reg_10_d_constant_8_opt_io_o;
    shifter_6_io_i <= adder_6_io_r;
    multiplier_4_sint_mul_gen_addends_io_short <= adder_6_io_r;
    subtractor_7_io_b <= shifter_6_io_o;
    shifter_7_io_i <= subtractor_7_io_r;
    fract_2_io_i <= shifter_7_io_o;
    shifter_8_io_i <= fract_2_io_o;
    subtractor_8_io_a <= shifter_8_io_o;
    reg_next_1_d_constant_9_opt_io_o <= reg_0_d_constant_9_opt_io_o;
    reg_next_2_d_constant_9_opt_io_o <= reg_1_d_constant_9_opt_io_o;
    reg_next_3_d_constant_9_opt_io_o <= reg_2_d_constant_9_opt_io_o;
    reg_next_4_d_constant_9_opt_io_o <= reg_3_d_constant_9_opt_io_o;
    reg_next_5_d_constant_9_opt_io_o <= reg_4_d_constant_9_opt_io_o;
    reg_next_6_d_constant_9_opt_io_o <= reg_5_d_constant_9_opt_io_o;
    reg_next_7_d_constant_9_opt_io_o <= reg_6_d_constant_9_opt_io_o;
    reg_next_8_d_constant_9_opt_io_o <= reg_7_d_constant_9_opt_io_o;
    reg_next_9_d_constant_9_opt_io_o <= reg_8_d_constant_9_opt_io_o;
    reg_next_10_d_constant_9_opt_io_o <= reg_9_d_constant_9_opt_io_o;
    reg_next_0_d_constant_9_opt_io_o <= constant_9_opt_io_o;
    subtractor_8_io_b <= reg_10_d_constant_9_opt_io_o;
    slicer_io_i <= subtractor_8_io_r;
    reg_next_0_l_multiplier_3_sint_mul_gen_addends_io_long <= subtractor_8_io_r;
    multiplier_3_sint_mul_gen_addends_io_long <= reg_0_l_multiplier_3_sint_mul_gen_addends_io_long;
    reg_next_0_l_multiplier_3_sint_mul_gen_addends_io_short <= subtractor_8_io_r;
    multiplier_3_sint_mul_gen_addends_io_short <= reg_0_l_multiplier_3_sint_mul_gen_addends_io_short;
    shifter_9_io_i <= min_2_io_o;
    fract_3_io_i <= shifter_9_io_o;
    reg_next_0_d_fract_3_io_o <= fract_3_io_o;
    subtractor_9_io_b <= reg_0_d_fract_3_io_o;
    reg_next_1_l_mux_io_i1 <= reg_0_l_mux_io_i1;
    reg_next_2_l_mux_io_i1 <= reg_1_l_mux_io_i1;
    reg_next_3_l_mux_io_i1 <= reg_2_l_mux_io_i1;
    reg_next_4_l_mux_io_i1 <= reg_3_l_mux_io_i1;
    reg_next_0_l_mux_io_i1 <= reg_0_d_fract_3_io_o;
    mux_io_i1 <= reg_4_l_mux_io_i1;
    reg_next_0_d_slicer_io_o <= slicer_io_o;
    mux_io_sel <= reg_0_d_slicer_io_o;
    reg_next_1_d_constant_10_opt_io_o <= reg_0_d_constant_10_opt_io_o;
    reg_next_2_d_constant_10_opt_io_o <= reg_1_d_constant_10_opt_io_o;
    reg_next_3_d_constant_10_opt_io_o <= reg_2_d_constant_10_opt_io_o;
    reg_next_4_d_constant_10_opt_io_o <= reg_3_d_constant_10_opt_io_o;
    reg_next_5_d_constant_10_opt_io_o <= reg_4_d_constant_10_opt_io_o;
    reg_next_6_d_constant_10_opt_io_o <= reg_5_d_constant_10_opt_io_o;
    reg_next_0_d_constant_10_opt_io_o <= constant_10_opt_io_o;
    subtractor_9_io_a <= reg_6_d_constant_10_opt_io_o;
    reg_next_1_d_subtractor_9_io_r <= reg_0_d_subtractor_9_io_r;
    reg_next_2_d_subtractor_9_io_r <= reg_1_d_subtractor_9_io_r;
    reg_next_3_d_subtractor_9_io_r <= reg_2_d_subtractor_9_io_r;
    reg_next_4_d_subtractor_9_io_r <= reg_3_d_subtractor_9_io_r;
    reg_next_0_d_subtractor_9_io_r <= subtractor_9_io_r;
    mux_io_i0 <= reg_4_d_subtractor_9_io_r;
    multiplier_2_sint_mul_gen_addends_io_long <= mux_io_o;
    reg_next_1_d_constant_11_opt_io_o <= reg_0_d_constant_11_opt_io_o;
    reg_next_2_d_constant_11_opt_io_o <= reg_1_d_constant_11_opt_io_o;
    reg_next_3_d_constant_11_opt_io_o <= reg_2_d_constant_11_opt_io_o;
    reg_next_4_d_constant_11_opt_io_o <= reg_3_d_constant_11_opt_io_o;
    reg_next_5_d_constant_11_opt_io_o <= reg_4_d_constant_11_opt_io_o;
    reg_next_6_d_constant_11_opt_io_o <= reg_5_d_constant_11_opt_io_o;
    reg_next_7_d_constant_11_opt_io_o <= reg_6_d_constant_11_opt_io_o;
    reg_next_8_d_constant_11_opt_io_o <= reg_7_d_constant_11_opt_io_o;
    reg_next_9_d_constant_11_opt_io_o <= reg_8_d_constant_11_opt_io_o;
    reg_next_10_d_constant_11_opt_io_o <= reg_9_d_constant_11_opt_io_o;
    reg_next_11_d_constant_11_opt_io_o <= reg_10_d_constant_11_opt_io_o;
    reg_next_0_d_constant_11_opt_io_o <= constant_11_opt_io_o;
    multiplier_2_sint_mul_gen_addends_io_short <= reg_11_d_constant_11_opt_io_o;
    multiplier_2_sint_mul_adder_0_io_a <= multiplier_2_sint_mul_gen_addends_io_addend_0;
    multiplier_2_sint_mul_adder_0_io_b <= multiplier_2_sint_mul_gen_addends_io_addend_1;
    multiplier_2_sint_mul_adder_1_io_a <= multiplier_2_sint_mul_gen_addends_io_addend_2;
    multiplier_2_sint_mul_adder_1_io_b <= multiplier_2_sint_mul_gen_addends_io_addend_3;
    multiplier_2_sint_mul_adder_2_io_a <= multiplier_2_sint_mul_gen_addends_io_addend_4;
    multiplier_2_sint_mul_adder_2_io_b <= multiplier_2_sint_mul_gen_addends_io_addend_5;
    multiplier_2_sint_mul_adder_3_io_a <= multiplier_2_sint_mul_gen_addends_io_addend_6;
    multiplier_2_sint_mul_adder_3_io_b <= multiplier_2_sint_mul_gen_addends_io_addend_7;
    multiplier_2_sint_mul_adder_4_io_a <= multiplier_2_sint_mul_gen_addends_io_addend_8;
    multiplier_2_sint_mul_adder_4_io_b <= multiplier_2_sint_mul_gen_addends_io_addend_9;
    multiplier_2_sint_mul_adder_5_io_a <= multiplier_2_sint_mul_gen_addends_io_addend_10;
    multiplier_2_sint_mul_adder_5_io_b <= multiplier_2_sint_mul_gen_addends_io_addend_11;
    multiplier_2_sint_mul_adder_6_io_a <= multiplier_2_sint_mul_gen_addends_io_addend_12;
    multiplier_2_sint_mul_adder_6_io_b <= multiplier_2_sint_mul_gen_addends_io_addend_13;
    multiplier_2_sint_mul_adder_7_io_a <= multiplier_2_sint_mul_gen_addends_io_addend_14;
    multiplier_2_sint_mul_adder_7_io_b <= multiplier_2_sint_mul_gen_addends_io_addend_15;
    multiplier_2_sint_mul_adder_8_io_a <= multiplier_2_sint_mul_gen_addends_io_addend_16;
    multiplier_2_sint_mul_adder_8_io_b <= multiplier_2_sint_mul_gen_addends_io_addend_17;
    multiplier_2_sint_mul_adder_9_io_a <= multiplier_2_sint_mul_gen_addends_io_addend_18;
    multiplier_2_sint_mul_adder_9_io_b <= multiplier_2_sint_mul_gen_addends_io_addend_19;
    multiplier_2_sint_mul_adder_10_io_a <= multiplier_2_sint_mul_gen_addends_io_addend_20;
    multiplier_2_sint_mul_adder_10_io_b <= multiplier_2_sint_mul_gen_addends_io_addend_21;
    multiplier_2_sint_mul_adder_11_io_a <= multiplier_2_sint_mul_gen_addends_io_addend_22;
    multiplier_2_sint_mul_adder_11_io_b <= multiplier_2_sint_mul_gen_addends_io_addend_23;
    multiplier_2_sint_mul_adder_12_io_a <= multiplier_2_sint_mul_gen_addends_io_addend_24;
    multiplier_2_sint_mul_adder_12_io_b <= multiplier_2_sint_mul_gen_addends_io_addend_25;
    multiplier_2_sint_mul_adder_13_io_a <= multiplier_2_sint_mul_gen_addends_io_addend_26;
    multiplier_2_sint_mul_adder_13_io_b <= multiplier_2_sint_mul_gen_addends_io_addend_27;
    reg_next_0_d_multiplier_2_sint_mul_gen_addends_io_subend <= multiplier_2_sint_mul_gen_addends_io_subend;
    multiplier_2_sint_mul_subtractor_io_b <= reg_0_d_multiplier_2_sint_mul_gen_addends_io_subend;
    multiplier_2_sint_mul_adder_14_io_a <= multiplier_2_sint_mul_adder_0_io_r;
    multiplier_2_sint_mul_adder_14_io_b <= multiplier_2_sint_mul_adder_1_io_r;
    multiplier_2_sint_mul_adder_15_io_a <= multiplier_2_sint_mul_adder_2_io_r;
    multiplier_2_sint_mul_adder_15_io_b <= multiplier_2_sint_mul_adder_3_io_r;
    reg_next_0_d_multiplier_2_sint_mul_adder_4_io_r <= multiplier_2_sint_mul_adder_4_io_r;
    multiplier_2_sint_mul_adder_16_io_a <= reg_0_d_multiplier_2_sint_mul_adder_4_io_r;
    reg_next_0_d_multiplier_2_sint_mul_adder_5_io_r <= multiplier_2_sint_mul_adder_5_io_r;
    multiplier_2_sint_mul_adder_16_io_b <= reg_0_d_multiplier_2_sint_mul_adder_5_io_r;
    multiplier_2_sint_mul_adder_17_io_a <= multiplier_2_sint_mul_adder_6_io_r;
    multiplier_2_sint_mul_adder_17_io_b <= multiplier_2_sint_mul_adder_7_io_r;
    multiplier_2_sint_mul_adder_18_io_a <= multiplier_2_sint_mul_adder_8_io_r;
    multiplier_2_sint_mul_adder_18_io_b <= multiplier_2_sint_mul_adder_9_io_r;
    multiplier_2_sint_mul_adder_19_io_a <= multiplier_2_sint_mul_adder_10_io_r;
    multiplier_2_sint_mul_adder_19_io_b <= multiplier_2_sint_mul_adder_11_io_r;
    multiplier_2_sint_mul_adder_20_io_a <= multiplier_2_sint_mul_adder_12_io_r;
    multiplier_2_sint_mul_adder_20_io_b <= multiplier_2_sint_mul_adder_13_io_r;
    reg_next_0_d_multiplier_2_sint_mul_adder_14_io_r <= multiplier_2_sint_mul_adder_14_io_r;
    multiplier_2_sint_mul_adder_21_io_a <= reg_0_d_multiplier_2_sint_mul_adder_14_io_r;
    reg_next_0_d_multiplier_2_sint_mul_adder_15_io_r <= multiplier_2_sint_mul_adder_15_io_r;
    multiplier_2_sint_mul_adder_21_io_b <= reg_0_d_multiplier_2_sint_mul_adder_15_io_r;
    multiplier_2_sint_mul_adder_22_io_a <= multiplier_2_sint_mul_adder_16_io_r;
    reg_next_0_d_multiplier_2_sint_mul_adder_17_io_r <= multiplier_2_sint_mul_adder_17_io_r;
    multiplier_2_sint_mul_adder_22_io_b <= reg_0_d_multiplier_2_sint_mul_adder_17_io_r;
    multiplier_2_sint_mul_adder_23_io_a <= multiplier_2_sint_mul_adder_18_io_r;
    multiplier_2_sint_mul_adder_23_io_b <= multiplier_2_sint_mul_adder_19_io_r;
    multiplier_2_sint_mul_adder_25_io_b <= multiplier_2_sint_mul_adder_20_io_r;
    multiplier_2_sint_mul_adder_24_io_a <= multiplier_2_sint_mul_adder_21_io_r;
    multiplier_2_sint_mul_adder_24_io_b <= multiplier_2_sint_mul_adder_22_io_r;
    multiplier_2_sint_mul_adder_25_io_a <= multiplier_2_sint_mul_adder_23_io_r;
    multiplier_2_sint_mul_adder_26_io_a <= multiplier_2_sint_mul_adder_24_io_r;
    reg_next_0_d_multiplier_2_sint_mul_adder_25_io_r <= multiplier_2_sint_mul_adder_25_io_r;
    multiplier_2_sint_mul_adder_26_io_b <= reg_0_d_multiplier_2_sint_mul_adder_25_io_r;
    multiplier_2_sint_mul_subtractor_io_a <= multiplier_2_sint_mul_adder_26_io_r;
    multiplier_2_tc_io_i <= multiplier_2_sint_mul_subtractor_io_r;
    reg_next_1_d_multiplier_2_tc_io_o <= reg_0_d_multiplier_2_tc_io_o;
    reg_next_2_d_multiplier_2_tc_io_o <= reg_1_d_multiplier_2_tc_io_o;
    reg_next_3_d_multiplier_2_tc_io_o <= reg_2_d_multiplier_2_tc_io_o;
    reg_next_4_d_multiplier_2_tc_io_o <= reg_3_d_multiplier_2_tc_io_o;
    reg_next_0_d_multiplier_2_tc_io_o <= multiplier_2_tc_io_o;
    subtractor_10_io_a <= reg_4_d_multiplier_2_tc_io_o;
    multiplier_3_sint_mul_adder_0_io_a <= multiplier_3_sint_mul_gen_addends_io_addend_0;
    multiplier_3_sint_mul_adder_0_io_b <= multiplier_3_sint_mul_gen_addends_io_addend_1;
    multiplier_3_sint_mul_adder_1_io_a <= multiplier_3_sint_mul_gen_addends_io_addend_2;
    multiplier_3_sint_mul_adder_1_io_b <= multiplier_3_sint_mul_gen_addends_io_addend_3;
    multiplier_3_sint_mul_adder_2_io_a <= multiplier_3_sint_mul_gen_addends_io_addend_4;
    multiplier_3_sint_mul_adder_2_io_b <= multiplier_3_sint_mul_gen_addends_io_addend_5;
    multiplier_3_sint_mul_adder_3_io_a <= multiplier_3_sint_mul_gen_addends_io_addend_6;
    multiplier_3_sint_mul_adder_3_io_b <= multiplier_3_sint_mul_gen_addends_io_addend_7;
    multiplier_3_sint_mul_adder_4_io_a <= multiplier_3_sint_mul_gen_addends_io_addend_8;
    multiplier_3_sint_mul_adder_4_io_b <= multiplier_3_sint_mul_gen_addends_io_addend_9;
    multiplier_3_sint_mul_adder_5_io_a <= multiplier_3_sint_mul_gen_addends_io_addend_10;
    multiplier_3_sint_mul_adder_5_io_b <= multiplier_3_sint_mul_gen_addends_io_addend_11;
    multiplier_3_sint_mul_adder_6_io_a <= multiplier_3_sint_mul_gen_addends_io_addend_12;
    multiplier_3_sint_mul_adder_6_io_b <= multiplier_3_sint_mul_gen_addends_io_addend_13;
    multiplier_3_sint_mul_adder_7_io_a <= multiplier_3_sint_mul_gen_addends_io_addend_14;
    multiplier_3_sint_mul_adder_7_io_b <= multiplier_3_sint_mul_gen_addends_io_addend_15;
    multiplier_3_sint_mul_adder_8_io_a <= multiplier_3_sint_mul_gen_addends_io_addend_16;
    multiplier_3_sint_mul_adder_8_io_b <= multiplier_3_sint_mul_gen_addends_io_addend_17;
    multiplier_3_sint_mul_adder_9_io_a <= multiplier_3_sint_mul_gen_addends_io_addend_18;
    multiplier_3_sint_mul_adder_9_io_b <= multiplier_3_sint_mul_gen_addends_io_addend_19;
    multiplier_3_sint_mul_adder_10_io_a <= multiplier_3_sint_mul_gen_addends_io_addend_20;
    multiplier_3_sint_mul_adder_10_io_b <= multiplier_3_sint_mul_gen_addends_io_addend_21;
    multiplier_3_sint_mul_adder_11_io_a <= multiplier_3_sint_mul_gen_addends_io_addend_22;
    multiplier_3_sint_mul_adder_11_io_b <= multiplier_3_sint_mul_gen_addends_io_addend_23;
    multiplier_3_sint_mul_adder_12_io_a <= multiplier_3_sint_mul_gen_addends_io_addend_24;
    multiplier_3_sint_mul_adder_12_io_b <= multiplier_3_sint_mul_gen_addends_io_addend_25;
    multiplier_3_sint_mul_adder_13_io_a <= multiplier_3_sint_mul_gen_addends_io_addend_26;
    multiplier_3_sint_mul_adder_13_io_b <= multiplier_3_sint_mul_gen_addends_io_addend_27;
    reg_next_1_d_multiplier_3_sint_mul_gen_addends_io_subend <= reg_0_d_multiplier_3_sint_mul_gen_addends_io_subend;
    reg_next_2_d_multiplier_3_sint_mul_gen_addends_io_subend <= reg_1_d_multiplier_3_sint_mul_gen_addends_io_subend;
    reg_next_3_d_multiplier_3_sint_mul_gen_addends_io_subend <= reg_2_d_multiplier_3_sint_mul_gen_addends_io_subend;
    reg_next_4_d_multiplier_3_sint_mul_gen_addends_io_subend <= reg_3_d_multiplier_3_sint_mul_gen_addends_io_subend;
    reg_next_0_d_multiplier_3_sint_mul_gen_addends_io_subend <= multiplier_3_sint_mul_gen_addends_io_subend;
    multiplier_3_sint_mul_subtractor_io_b <= reg_4_d_multiplier_3_sint_mul_gen_addends_io_subend;
    reg_next_0_d_multiplier_3_sint_mul_adder_0_io_r <= multiplier_3_sint_mul_adder_0_io_r;
    multiplier_3_sint_mul_adder_14_io_a <= reg_0_d_multiplier_3_sint_mul_adder_0_io_r;
    reg_next_0_d_multiplier_3_sint_mul_adder_1_io_r <= multiplier_3_sint_mul_adder_1_io_r;
    multiplier_3_sint_mul_adder_14_io_b <= reg_0_d_multiplier_3_sint_mul_adder_1_io_r;
    reg_next_0_d_multiplier_3_sint_mul_adder_2_io_r <= multiplier_3_sint_mul_adder_2_io_r;
    multiplier_3_sint_mul_adder_15_io_a <= reg_0_d_multiplier_3_sint_mul_adder_2_io_r;
    reg_next_0_d_multiplier_3_sint_mul_adder_3_io_r <= multiplier_3_sint_mul_adder_3_io_r;
    multiplier_3_sint_mul_adder_15_io_b <= reg_0_d_multiplier_3_sint_mul_adder_3_io_r;
    reg_next_0_d_multiplier_3_sint_mul_adder_4_io_r <= multiplier_3_sint_mul_adder_4_io_r;
    multiplier_3_sint_mul_adder_16_io_a <= reg_0_d_multiplier_3_sint_mul_adder_4_io_r;
    reg_next_0_d_multiplier_3_sint_mul_adder_5_io_r <= multiplier_3_sint_mul_adder_5_io_r;
    multiplier_3_sint_mul_adder_16_io_b <= reg_0_d_multiplier_3_sint_mul_adder_5_io_r;
    reg_next_0_d_multiplier_3_sint_mul_adder_6_io_r <= multiplier_3_sint_mul_adder_6_io_r;
    multiplier_3_sint_mul_adder_17_io_a <= reg_0_d_multiplier_3_sint_mul_adder_6_io_r;
    reg_next_0_d_multiplier_3_sint_mul_adder_7_io_r <= multiplier_3_sint_mul_adder_7_io_r;
    multiplier_3_sint_mul_adder_17_io_b <= reg_0_d_multiplier_3_sint_mul_adder_7_io_r;
    multiplier_3_sint_mul_adder_18_io_a <= multiplier_3_sint_mul_adder_8_io_r;
    multiplier_3_sint_mul_adder_18_io_b <= multiplier_3_sint_mul_adder_9_io_r;
    multiplier_3_sint_mul_adder_19_io_a <= multiplier_3_sint_mul_adder_10_io_r;
    multiplier_3_sint_mul_adder_19_io_b <= multiplier_3_sint_mul_adder_11_io_r;
    reg_next_0_d_multiplier_3_sint_mul_adder_12_io_r <= multiplier_3_sint_mul_adder_12_io_r;
    multiplier_3_sint_mul_adder_20_io_a <= reg_0_d_multiplier_3_sint_mul_adder_12_io_r;
    reg_next_0_d_multiplier_3_sint_mul_adder_13_io_r <= multiplier_3_sint_mul_adder_13_io_r;
    multiplier_3_sint_mul_adder_20_io_b <= reg_0_d_multiplier_3_sint_mul_adder_13_io_r;
    reg_next_0_d_multiplier_3_sint_mul_adder_14_io_r <= multiplier_3_sint_mul_adder_14_io_r;
    multiplier_3_sint_mul_adder_21_io_a <= reg_0_d_multiplier_3_sint_mul_adder_14_io_r;
    reg_next_0_d_multiplier_3_sint_mul_adder_15_io_r <= multiplier_3_sint_mul_adder_15_io_r;
    multiplier_3_sint_mul_adder_21_io_b <= reg_0_d_multiplier_3_sint_mul_adder_15_io_r;
    reg_next_0_d_multiplier_3_sint_mul_adder_16_io_r <= multiplier_3_sint_mul_adder_16_io_r;
    multiplier_3_sint_mul_adder_22_io_a <= reg_0_d_multiplier_3_sint_mul_adder_16_io_r;
    reg_next_0_d_multiplier_3_sint_mul_adder_17_io_r <= multiplier_3_sint_mul_adder_17_io_r;
    multiplier_3_sint_mul_adder_22_io_b <= reg_0_d_multiplier_3_sint_mul_adder_17_io_r;
    reg_next_0_d_multiplier_3_sint_mul_adder_18_io_r <= multiplier_3_sint_mul_adder_18_io_r;
    multiplier_3_sint_mul_adder_23_io_a <= reg_0_d_multiplier_3_sint_mul_adder_18_io_r;
    reg_next_0_d_multiplier_3_sint_mul_adder_19_io_r <= multiplier_3_sint_mul_adder_19_io_r;
    multiplier_3_sint_mul_adder_23_io_b <= reg_0_d_multiplier_3_sint_mul_adder_19_io_r;
    reg_next_0_d_multiplier_3_sint_mul_adder_20_io_r <= multiplier_3_sint_mul_adder_20_io_r;
    multiplier_3_sint_mul_adder_25_io_b <= reg_0_d_multiplier_3_sint_mul_adder_20_io_r;
    reg_next_0_d_multiplier_3_sint_mul_adder_21_io_r <= multiplier_3_sint_mul_adder_21_io_r;
    multiplier_3_sint_mul_adder_24_io_a <= reg_0_d_multiplier_3_sint_mul_adder_21_io_r;
    reg_next_0_d_multiplier_3_sint_mul_adder_22_io_r <= multiplier_3_sint_mul_adder_22_io_r;
    multiplier_3_sint_mul_adder_24_io_b <= reg_0_d_multiplier_3_sint_mul_adder_22_io_r;
    reg_next_0_d_multiplier_3_sint_mul_adder_23_io_r <= multiplier_3_sint_mul_adder_23_io_r;
    multiplier_3_sint_mul_adder_25_io_a <= reg_0_d_multiplier_3_sint_mul_adder_23_io_r;
    reg_next_0_d_multiplier_3_sint_mul_adder_24_io_r <= multiplier_3_sint_mul_adder_24_io_r;
    multiplier_3_sint_mul_adder_26_io_a <= reg_0_d_multiplier_3_sint_mul_adder_24_io_r;
    reg_next_1_d_multiplier_3_sint_mul_adder_25_io_r <= reg_0_d_multiplier_3_sint_mul_adder_25_io_r;
    reg_next_0_d_multiplier_3_sint_mul_adder_25_io_r <= multiplier_3_sint_mul_adder_25_io_r;
    multiplier_3_sint_mul_adder_26_io_b <= reg_1_d_multiplier_3_sint_mul_adder_25_io_r;
    reg_next_0_d_multiplier_3_sint_mul_adder_26_io_r <= multiplier_3_sint_mul_adder_26_io_r;
    multiplier_3_sint_mul_subtractor_io_a <= reg_0_d_multiplier_3_sint_mul_adder_26_io_r;
    multiplier_3_tc_io_i <= multiplier_3_sint_mul_subtractor_io_r;
    reg_next_0_d_multiplier_3_tc_io_o <= multiplier_3_tc_io_o;
    subtractor_10_io_b <= reg_0_d_multiplier_3_tc_io_o;
    shifter_10_io_i <= subtractor_10_io_r;
    shifter_11_io_i <= subtractor_10_io_r;
    reg_next_0_d_shifter_10_io_o <= shifter_10_io_o;
    adder_7_io_a <= reg_0_d_shifter_10_io_o;
    reg_next_0_d_shifter_11_io_o <= shifter_11_io_o;
    adder_7_io_b <= reg_0_d_shifter_11_io_o;
    reg_next_0_d_adder_7_io_r <= adder_7_io_r;
    adder_8_io_a <= reg_0_d_adder_7_io_r;
    reg_next_1_d_constant_12_opt_io_o <= reg_0_d_constant_12_opt_io_o;
    reg_next_2_d_constant_12_opt_io_o <= reg_1_d_constant_12_opt_io_o;
    reg_next_3_d_constant_12_opt_io_o <= reg_2_d_constant_12_opt_io_o;
    reg_next_4_d_constant_12_opt_io_o <= reg_3_d_constant_12_opt_io_o;
    reg_next_5_d_constant_12_opt_io_o <= reg_4_d_constant_12_opt_io_o;
    reg_next_6_d_constant_12_opt_io_o <= reg_5_d_constant_12_opt_io_o;
    reg_next_7_d_constant_12_opt_io_o <= reg_6_d_constant_12_opt_io_o;
    reg_next_8_d_constant_12_opt_io_o <= reg_7_d_constant_12_opt_io_o;
    reg_next_9_d_constant_12_opt_io_o <= reg_8_d_constant_12_opt_io_o;
    reg_next_10_d_constant_12_opt_io_o <= reg_9_d_constant_12_opt_io_o;
    reg_next_11_d_constant_12_opt_io_o <= reg_10_d_constant_12_opt_io_o;
    reg_next_12_d_constant_12_opt_io_o <= reg_11_d_constant_12_opt_io_o;
    reg_next_13_d_constant_12_opt_io_o <= reg_12_d_constant_12_opt_io_o;
    reg_next_14_d_constant_12_opt_io_o <= reg_13_d_constant_12_opt_io_o;
    reg_next_15_d_constant_12_opt_io_o <= reg_14_d_constant_12_opt_io_o;
    reg_next_16_d_constant_12_opt_io_o <= reg_15_d_constant_12_opt_io_o;
    reg_next_17_d_constant_12_opt_io_o <= reg_16_d_constant_12_opt_io_o;
    reg_next_18_d_constant_12_opt_io_o <= reg_17_d_constant_12_opt_io_o;
    reg_next_19_d_constant_12_opt_io_o <= reg_18_d_constant_12_opt_io_o;
    reg_next_0_d_constant_12_opt_io_o <= constant_12_opt_io_o;
    adder_8_io_b <= reg_19_d_constant_12_opt_io_o;
    reg_next_0_d_adder_8_io_r <= adder_8_io_r;
    max_io_a <= reg_0_d_adder_8_io_r;
    reg_next_1_d_constant_13_opt_io_o <= reg_0_d_constant_13_opt_io_o;
    reg_next_2_d_constant_13_opt_io_o <= reg_1_d_constant_13_opt_io_o;
    reg_next_3_d_constant_13_opt_io_o <= reg_2_d_constant_13_opt_io_o;
    reg_next_4_d_constant_13_opt_io_o <= reg_3_d_constant_13_opt_io_o;
    reg_next_5_d_constant_13_opt_io_o <= reg_4_d_constant_13_opt_io_o;
    reg_next_6_d_constant_13_opt_io_o <= reg_5_d_constant_13_opt_io_o;
    reg_next_7_d_constant_13_opt_io_o <= reg_6_d_constant_13_opt_io_o;
    reg_next_8_d_constant_13_opt_io_o <= reg_7_d_constant_13_opt_io_o;
    reg_next_9_d_constant_13_opt_io_o <= reg_8_d_constant_13_opt_io_o;
    reg_next_10_d_constant_13_opt_io_o <= reg_9_d_constant_13_opt_io_o;
    reg_next_11_d_constant_13_opt_io_o <= reg_10_d_constant_13_opt_io_o;
    reg_next_12_d_constant_13_opt_io_o <= reg_11_d_constant_13_opt_io_o;
    reg_next_13_d_constant_13_opt_io_o <= reg_12_d_constant_13_opt_io_o;
    reg_next_14_d_constant_13_opt_io_o <= reg_13_d_constant_13_opt_io_o;
    reg_next_15_d_constant_13_opt_io_o <= reg_14_d_constant_13_opt_io_o;
    reg_next_16_d_constant_13_opt_io_o <= reg_15_d_constant_13_opt_io_o;
    reg_next_17_d_constant_13_opt_io_o <= reg_16_d_constant_13_opt_io_o;
    reg_next_18_d_constant_13_opt_io_o <= reg_17_d_constant_13_opt_io_o;
    reg_next_19_d_constant_13_opt_io_o <= reg_18_d_constant_13_opt_io_o;
    reg_next_20_d_constant_13_opt_io_o <= reg_19_d_constant_13_opt_io_o;
    reg_next_0_d_constant_13_opt_io_o <= constant_13_opt_io_o;
    max_io_b <= reg_20_d_constant_13_opt_io_o;
    reg_next_0_d_max_io_o <= max_io_o;
    min_3_io_a <= reg_0_d_max_io_o;
    reg_next_1_d_constant_14_opt_io_o <= reg_0_d_constant_14_opt_io_o;
    reg_next_2_d_constant_14_opt_io_o <= reg_1_d_constant_14_opt_io_o;
    reg_next_3_d_constant_14_opt_io_o <= reg_2_d_constant_14_opt_io_o;
    reg_next_4_d_constant_14_opt_io_o <= reg_3_d_constant_14_opt_io_o;
    reg_next_5_d_constant_14_opt_io_o <= reg_4_d_constant_14_opt_io_o;
    reg_next_6_d_constant_14_opt_io_o <= reg_5_d_constant_14_opt_io_o;
    reg_next_7_d_constant_14_opt_io_o <= reg_6_d_constant_14_opt_io_o;
    reg_next_8_d_constant_14_opt_io_o <= reg_7_d_constant_14_opt_io_o;
    reg_next_9_d_constant_14_opt_io_o <= reg_8_d_constant_14_opt_io_o;
    reg_next_10_d_constant_14_opt_io_o <= reg_9_d_constant_14_opt_io_o;
    reg_next_11_d_constant_14_opt_io_o <= reg_10_d_constant_14_opt_io_o;
    reg_next_12_d_constant_14_opt_io_o <= reg_11_d_constant_14_opt_io_o;
    reg_next_13_d_constant_14_opt_io_o <= reg_12_d_constant_14_opt_io_o;
    reg_next_14_d_constant_14_opt_io_o <= reg_13_d_constant_14_opt_io_o;
    reg_next_15_d_constant_14_opt_io_o <= reg_14_d_constant_14_opt_io_o;
    reg_next_16_d_constant_14_opt_io_o <= reg_15_d_constant_14_opt_io_o;
    reg_next_17_d_constant_14_opt_io_o <= reg_16_d_constant_14_opt_io_o;
    reg_next_18_d_constant_14_opt_io_o <= reg_17_d_constant_14_opt_io_o;
    reg_next_19_d_constant_14_opt_io_o <= reg_18_d_constant_14_opt_io_o;
    reg_next_20_d_constant_14_opt_io_o <= reg_19_d_constant_14_opt_io_o;
    reg_next_21_d_constant_14_opt_io_o <= reg_20_d_constant_14_opt_io_o;
    reg_next_0_d_constant_14_opt_io_o <= constant_14_opt_io_o;
    min_3_io_b <= reg_21_d_constant_14_opt_io_o;
    reg_next_0_d_min_3_io_o <= min_3_io_o;
    adder_9_io_a <= reg_0_d_min_3_io_o;
    reg_next_1_d_constant_15_opt_io_o <= reg_0_d_constant_15_opt_io_o;
    reg_next_2_d_constant_15_opt_io_o <= reg_1_d_constant_15_opt_io_o;
    reg_next_3_d_constant_15_opt_io_o <= reg_2_d_constant_15_opt_io_o;
    reg_next_4_d_constant_15_opt_io_o <= reg_3_d_constant_15_opt_io_o;
    reg_next_5_d_constant_15_opt_io_o <= reg_4_d_constant_15_opt_io_o;
    reg_next_6_d_constant_15_opt_io_o <= reg_5_d_constant_15_opt_io_o;
    reg_next_7_d_constant_15_opt_io_o <= reg_6_d_constant_15_opt_io_o;
    reg_next_8_d_constant_15_opt_io_o <= reg_7_d_constant_15_opt_io_o;
    reg_next_9_d_constant_15_opt_io_o <= reg_8_d_constant_15_opt_io_o;
    reg_next_10_d_constant_15_opt_io_o <= reg_9_d_constant_15_opt_io_o;
    reg_next_0_d_constant_15_opt_io_o <= constant_15_opt_io_o;
    multiplier_4_sint_mul_gen_addends_io_long <= reg_10_d_constant_15_opt_io_o;
    multiplier_4_sint_mul_adder_0_io_a <= multiplier_4_sint_mul_gen_addends_io_addend_0;
    multiplier_4_sint_mul_adder_0_io_b <= multiplier_4_sint_mul_gen_addends_io_addend_1;
    multiplier_4_sint_mul_adder_1_io_a <= multiplier_4_sint_mul_gen_addends_io_addend_2;
    multiplier_4_sint_mul_adder_1_io_b <= multiplier_4_sint_mul_gen_addends_io_addend_3;
    multiplier_4_sint_mul_adder_2_io_a <= multiplier_4_sint_mul_gen_addends_io_addend_4;
    multiplier_4_sint_mul_adder_2_io_b <= multiplier_4_sint_mul_gen_addends_io_addend_5;
    multiplier_4_sint_mul_adder_3_io_a <= multiplier_4_sint_mul_gen_addends_io_addend_6;
    multiplier_4_sint_mul_adder_3_io_b <= multiplier_4_sint_mul_gen_addends_io_addend_7;
    multiplier_4_sint_mul_adder_4_io_a <= multiplier_4_sint_mul_gen_addends_io_addend_8;
    multiplier_4_sint_mul_adder_4_io_b <= multiplier_4_sint_mul_gen_addends_io_addend_9;
    multiplier_4_sint_mul_adder_5_io_a <= multiplier_4_sint_mul_gen_addends_io_addend_10;
    multiplier_4_sint_mul_adder_5_io_b <= multiplier_4_sint_mul_gen_addends_io_addend_11;
    multiplier_4_sint_mul_adder_6_io_a <= multiplier_4_sint_mul_gen_addends_io_addend_12;
    multiplier_4_sint_mul_adder_6_io_b <= multiplier_4_sint_mul_gen_addends_io_addend_13;
    multiplier_4_sint_mul_adder_7_io_a <= multiplier_4_sint_mul_gen_addends_io_addend_14;
    multiplier_4_sint_mul_adder_7_io_b <= multiplier_4_sint_mul_gen_addends_io_addend_15;
    multiplier_4_sint_mul_adder_8_io_a <= multiplier_4_sint_mul_gen_addends_io_addend_16;
    multiplier_4_sint_mul_adder_8_io_b <= multiplier_4_sint_mul_gen_addends_io_addend_17;
    multiplier_4_sint_mul_adder_9_io_a <= multiplier_4_sint_mul_gen_addends_io_addend_18;
    multiplier_4_sint_mul_adder_9_io_b <= multiplier_4_sint_mul_gen_addends_io_addend_19;
    multiplier_4_sint_mul_adder_10_io_a <= multiplier_4_sint_mul_gen_addends_io_addend_20;
    multiplier_4_sint_mul_adder_10_io_b <= multiplier_4_sint_mul_gen_addends_io_addend_21;
    multiplier_4_sint_mul_adder_11_io_a <= multiplier_4_sint_mul_gen_addends_io_addend_22;
    multiplier_4_sint_mul_adder_11_io_b <= multiplier_4_sint_mul_gen_addends_io_addend_23;
    multiplier_4_sint_mul_adder_12_io_a <= multiplier_4_sint_mul_gen_addends_io_addend_24;
    multiplier_4_sint_mul_adder_12_io_b <= multiplier_4_sint_mul_gen_addends_io_addend_25;
    multiplier_4_sint_mul_adder_13_io_a <= multiplier_4_sint_mul_gen_addends_io_addend_26;
    multiplier_4_sint_mul_adder_13_io_b <= multiplier_4_sint_mul_gen_addends_io_addend_27;
    reg_next_1_d_multiplier_4_sint_mul_gen_addends_io_subend <= reg_0_d_multiplier_4_sint_mul_gen_addends_io_subend;
    reg_next_2_d_multiplier_4_sint_mul_gen_addends_io_subend <= reg_1_d_multiplier_4_sint_mul_gen_addends_io_subend;
    reg_next_3_d_multiplier_4_sint_mul_gen_addends_io_subend <= reg_2_d_multiplier_4_sint_mul_gen_addends_io_subend;
    reg_next_4_d_multiplier_4_sint_mul_gen_addends_io_subend <= reg_3_d_multiplier_4_sint_mul_gen_addends_io_subend;
    reg_next_0_d_multiplier_4_sint_mul_gen_addends_io_subend <= multiplier_4_sint_mul_gen_addends_io_subend;
    multiplier_4_sint_mul_subtractor_io_b <= reg_4_d_multiplier_4_sint_mul_gen_addends_io_subend;
    multiplier_4_sint_mul_adder_14_io_a <= multiplier_4_sint_mul_adder_0_io_r;
    multiplier_4_sint_mul_adder_14_io_b <= multiplier_4_sint_mul_adder_1_io_r;
    multiplier_4_sint_mul_adder_15_io_a <= multiplier_4_sint_mul_adder_2_io_r;
    multiplier_4_sint_mul_adder_15_io_b <= multiplier_4_sint_mul_adder_3_io_r;
    reg_next_0_d_multiplier_4_sint_mul_adder_4_io_r <= multiplier_4_sint_mul_adder_4_io_r;
    multiplier_4_sint_mul_adder_16_io_a <= reg_0_d_multiplier_4_sint_mul_adder_4_io_r;
    reg_next_0_d_multiplier_4_sint_mul_adder_5_io_r <= multiplier_4_sint_mul_adder_5_io_r;
    multiplier_4_sint_mul_adder_16_io_b <= reg_0_d_multiplier_4_sint_mul_adder_5_io_r;
    reg_next_0_d_multiplier_4_sint_mul_adder_6_io_r <= multiplier_4_sint_mul_adder_6_io_r;
    multiplier_4_sint_mul_adder_17_io_a <= reg_0_d_multiplier_4_sint_mul_adder_6_io_r;
    reg_next_0_d_multiplier_4_sint_mul_adder_7_io_r <= multiplier_4_sint_mul_adder_7_io_r;
    multiplier_4_sint_mul_adder_17_io_b <= reg_0_d_multiplier_4_sint_mul_adder_7_io_r;
    reg_next_0_d_multiplier_4_sint_mul_adder_8_io_r <= multiplier_4_sint_mul_adder_8_io_r;
    multiplier_4_sint_mul_adder_18_io_a <= reg_0_d_multiplier_4_sint_mul_adder_8_io_r;
    reg_next_0_d_multiplier_4_sint_mul_adder_9_io_r <= multiplier_4_sint_mul_adder_9_io_r;
    multiplier_4_sint_mul_adder_18_io_b <= reg_0_d_multiplier_4_sint_mul_adder_9_io_r;
    reg_next_0_d_multiplier_4_sint_mul_adder_10_io_r <= multiplier_4_sint_mul_adder_10_io_r;
    multiplier_4_sint_mul_adder_19_io_a <= reg_0_d_multiplier_4_sint_mul_adder_10_io_r;
    reg_next_0_d_multiplier_4_sint_mul_adder_11_io_r <= multiplier_4_sint_mul_adder_11_io_r;
    multiplier_4_sint_mul_adder_19_io_b <= reg_0_d_multiplier_4_sint_mul_adder_11_io_r;
    reg_next_0_d_multiplier_4_sint_mul_adder_12_io_r <= multiplier_4_sint_mul_adder_12_io_r;
    multiplier_4_sint_mul_adder_20_io_a <= reg_0_d_multiplier_4_sint_mul_adder_12_io_r;
    reg_next_0_d_multiplier_4_sint_mul_adder_13_io_r <= multiplier_4_sint_mul_adder_13_io_r;
    multiplier_4_sint_mul_adder_20_io_b <= reg_0_d_multiplier_4_sint_mul_adder_13_io_r;
    multiplier_4_sint_mul_adder_21_io_a <= multiplier_4_sint_mul_adder_14_io_r;
    multiplier_4_sint_mul_adder_21_io_b <= multiplier_4_sint_mul_adder_15_io_r;
    reg_next_0_d_multiplier_4_sint_mul_adder_16_io_r <= multiplier_4_sint_mul_adder_16_io_r;
    multiplier_4_sint_mul_adder_22_io_a <= reg_0_d_multiplier_4_sint_mul_adder_16_io_r;
    reg_next_0_d_multiplier_4_sint_mul_adder_17_io_r <= multiplier_4_sint_mul_adder_17_io_r;
    multiplier_4_sint_mul_adder_22_io_b <= reg_0_d_multiplier_4_sint_mul_adder_17_io_r;
    reg_next_0_d_multiplier_4_sint_mul_adder_18_io_r <= multiplier_4_sint_mul_adder_18_io_r;
    multiplier_4_sint_mul_adder_23_io_a <= reg_0_d_multiplier_4_sint_mul_adder_18_io_r;
    reg_next_0_d_multiplier_4_sint_mul_adder_19_io_r <= multiplier_4_sint_mul_adder_19_io_r;
    multiplier_4_sint_mul_adder_23_io_b <= reg_0_d_multiplier_4_sint_mul_adder_19_io_r;
    reg_next_1_d_multiplier_4_sint_mul_adder_20_io_r <= reg_0_d_multiplier_4_sint_mul_adder_20_io_r;
    reg_next_0_d_multiplier_4_sint_mul_adder_20_io_r <= multiplier_4_sint_mul_adder_20_io_r;
    multiplier_4_sint_mul_adder_25_io_b <= reg_1_d_multiplier_4_sint_mul_adder_20_io_r;
    reg_next_1_d_multiplier_4_sint_mul_adder_21_io_r <= reg_0_d_multiplier_4_sint_mul_adder_21_io_r;
    reg_next_2_d_multiplier_4_sint_mul_adder_21_io_r <= reg_1_d_multiplier_4_sint_mul_adder_21_io_r;
    reg_next_0_d_multiplier_4_sint_mul_adder_21_io_r <= multiplier_4_sint_mul_adder_21_io_r;
    multiplier_4_sint_mul_adder_24_io_a <= reg_2_d_multiplier_4_sint_mul_adder_21_io_r;
    reg_next_0_d_multiplier_4_sint_mul_adder_22_io_r <= multiplier_4_sint_mul_adder_22_io_r;
    multiplier_4_sint_mul_adder_24_io_b <= reg_0_d_multiplier_4_sint_mul_adder_22_io_r;
    reg_next_0_d_multiplier_4_sint_mul_adder_23_io_r <= multiplier_4_sint_mul_adder_23_io_r;
    multiplier_4_sint_mul_adder_25_io_a <= reg_0_d_multiplier_4_sint_mul_adder_23_io_r;
    reg_next_0_d_multiplier_4_sint_mul_adder_24_io_r <= multiplier_4_sint_mul_adder_24_io_r;
    multiplier_4_sint_mul_adder_26_io_a <= reg_0_d_multiplier_4_sint_mul_adder_24_io_r;
    reg_next_0_d_multiplier_4_sint_mul_adder_25_io_r <= multiplier_4_sint_mul_adder_25_io_r;
    multiplier_4_sint_mul_adder_26_io_b <= reg_0_d_multiplier_4_sint_mul_adder_25_io_r;
    reg_next_0_d_multiplier_4_sint_mul_adder_26_io_r <= multiplier_4_sint_mul_adder_26_io_r;
    multiplier_4_sint_mul_subtractor_io_a <= reg_0_d_multiplier_4_sint_mul_adder_26_io_r;
    multiplier_4_tc_io_i <= multiplier_4_sint_mul_subtractor_io_r;
    reg_next_1_d_multiplier_4_tc_io_o <= reg_0_d_multiplier_4_tc_io_o;
    reg_next_2_d_multiplier_4_tc_io_o <= reg_1_d_multiplier_4_tc_io_o;
    reg_next_3_d_multiplier_4_tc_io_o <= reg_2_d_multiplier_4_tc_io_o;
    reg_next_4_d_multiplier_4_tc_io_o <= reg_3_d_multiplier_4_tc_io_o;
    reg_next_5_d_multiplier_4_tc_io_o <= reg_4_d_multiplier_4_tc_io_o;
    reg_next_6_d_multiplier_4_tc_io_o <= reg_5_d_multiplier_4_tc_io_o;
    reg_next_0_d_multiplier_4_tc_io_o <= multiplier_4_tc_io_o;
    adder_9_io_b <= reg_6_d_multiplier_4_tc_io_o;
    shifter_12_io_i <= adder_9_io_r;
    shifter_13_io_i <= adder_9_io_r;
    reg_next_0_d_shifter_12_io_o <= shifter_12_io_o;
    subtractor_11_io_b <= reg_0_d_shifter_12_io_o;
    reg_next_1_d_constant_16_opt_io_o <= reg_0_d_constant_16_opt_io_o;
    reg_next_2_d_constant_16_opt_io_o <= reg_1_d_constant_16_opt_io_o;
    reg_next_3_d_constant_16_opt_io_o <= reg_2_d_constant_16_opt_io_o;
    reg_next_4_d_constant_16_opt_io_o <= reg_3_d_constant_16_opt_io_o;
    reg_next_5_d_constant_16_opt_io_o <= reg_4_d_constant_16_opt_io_o;
    reg_next_6_d_constant_16_opt_io_o <= reg_5_d_constant_16_opt_io_o;
    reg_next_7_d_constant_16_opt_io_o <= reg_6_d_constant_16_opt_io_o;
    reg_next_8_d_constant_16_opt_io_o <= reg_7_d_constant_16_opt_io_o;
    reg_next_9_d_constant_16_opt_io_o <= reg_8_d_constant_16_opt_io_o;
    reg_next_10_d_constant_16_opt_io_o <= reg_9_d_constant_16_opt_io_o;
    reg_next_11_d_constant_16_opt_io_o <= reg_10_d_constant_16_opt_io_o;
    reg_next_12_d_constant_16_opt_io_o <= reg_11_d_constant_16_opt_io_o;
    reg_next_13_d_constant_16_opt_io_o <= reg_12_d_constant_16_opt_io_o;
    reg_next_14_d_constant_16_opt_io_o <= reg_13_d_constant_16_opt_io_o;
    reg_next_15_d_constant_16_opt_io_o <= reg_14_d_constant_16_opt_io_o;
    reg_next_16_d_constant_16_opt_io_o <= reg_15_d_constant_16_opt_io_o;
    reg_next_17_d_constant_16_opt_io_o <= reg_16_d_constant_16_opt_io_o;
    reg_next_18_d_constant_16_opt_io_o <= reg_17_d_constant_16_opt_io_o;
    reg_next_19_d_constant_16_opt_io_o <= reg_18_d_constant_16_opt_io_o;
    reg_next_20_d_constant_16_opt_io_o <= reg_19_d_constant_16_opt_io_o;
    reg_next_21_d_constant_16_opt_io_o <= reg_20_d_constant_16_opt_io_o;
    reg_next_22_d_constant_16_opt_io_o <= reg_21_d_constant_16_opt_io_o;
    reg_next_23_d_constant_16_opt_io_o <= reg_22_d_constant_16_opt_io_o;
    reg_next_0_d_constant_16_opt_io_o <= constant_16_opt_io_o;
    subtractor_11_io_a <= reg_23_d_constant_16_opt_io_o;
    reg_next_0_d_subtractor_11_io_r <= subtractor_11_io_r;
    max_1_io_a <= reg_0_d_subtractor_11_io_r;
    reg_next_0_d_shifter_13_io_o <= shifter_13_io_o;
    subtractor_12_io_b <= reg_0_d_shifter_13_io_o;
    reg_next_1_d_constant_17_opt_io_o <= reg_0_d_constant_17_opt_io_o;
    reg_next_2_d_constant_17_opt_io_o <= reg_1_d_constant_17_opt_io_o;
    reg_next_3_d_constant_17_opt_io_o <= reg_2_d_constant_17_opt_io_o;
    reg_next_4_d_constant_17_opt_io_o <= reg_3_d_constant_17_opt_io_o;
    reg_next_5_d_constant_17_opt_io_o <= reg_4_d_constant_17_opt_io_o;
    reg_next_6_d_constant_17_opt_io_o <= reg_5_d_constant_17_opt_io_o;
    reg_next_7_d_constant_17_opt_io_o <= reg_6_d_constant_17_opt_io_o;
    reg_next_8_d_constant_17_opt_io_o <= reg_7_d_constant_17_opt_io_o;
    reg_next_9_d_constant_17_opt_io_o <= reg_8_d_constant_17_opt_io_o;
    reg_next_10_d_constant_17_opt_io_o <= reg_9_d_constant_17_opt_io_o;
    reg_next_11_d_constant_17_opt_io_o <= reg_10_d_constant_17_opt_io_o;
    reg_next_12_d_constant_17_opt_io_o <= reg_11_d_constant_17_opt_io_o;
    reg_next_13_d_constant_17_opt_io_o <= reg_12_d_constant_17_opt_io_o;
    reg_next_14_d_constant_17_opt_io_o <= reg_13_d_constant_17_opt_io_o;
    reg_next_15_d_constant_17_opt_io_o <= reg_14_d_constant_17_opt_io_o;
    reg_next_16_d_constant_17_opt_io_o <= reg_15_d_constant_17_opt_io_o;
    reg_next_17_d_constant_17_opt_io_o <= reg_16_d_constant_17_opt_io_o;
    reg_next_18_d_constant_17_opt_io_o <= reg_17_d_constant_17_opt_io_o;
    reg_next_19_d_constant_17_opt_io_o <= reg_18_d_constant_17_opt_io_o;
    reg_next_20_d_constant_17_opt_io_o <= reg_19_d_constant_17_opt_io_o;
    reg_next_21_d_constant_17_opt_io_o <= reg_20_d_constant_17_opt_io_o;
    reg_next_22_d_constant_17_opt_io_o <= reg_21_d_constant_17_opt_io_o;
    reg_next_23_d_constant_17_opt_io_o <= reg_22_d_constant_17_opt_io_o;
    reg_next_0_d_constant_17_opt_io_o <= constant_17_opt_io_o;
    subtractor_12_io_a <= reg_23_d_constant_17_opt_io_o;
    reg_next_0_d_subtractor_12_io_r <= subtractor_12_io_r;
    max_2_io_a <= reg_0_d_subtractor_12_io_r;
    reg_next_1_d_constant_18_opt_io_o <= reg_0_d_constant_18_opt_io_o;
    reg_next_2_d_constant_18_opt_io_o <= reg_1_d_constant_18_opt_io_o;
    reg_next_3_d_constant_18_opt_io_o <= reg_2_d_constant_18_opt_io_o;
    reg_next_4_d_constant_18_opt_io_o <= reg_3_d_constant_18_opt_io_o;
    reg_next_5_d_constant_18_opt_io_o <= reg_4_d_constant_18_opt_io_o;
    reg_next_6_d_constant_18_opt_io_o <= reg_5_d_constant_18_opt_io_o;
    reg_next_7_d_constant_18_opt_io_o <= reg_6_d_constant_18_opt_io_o;
    reg_next_8_d_constant_18_opt_io_o <= reg_7_d_constant_18_opt_io_o;
    reg_next_9_d_constant_18_opt_io_o <= reg_8_d_constant_18_opt_io_o;
    reg_next_10_d_constant_18_opt_io_o <= reg_9_d_constant_18_opt_io_o;
    reg_next_11_d_constant_18_opt_io_o <= reg_10_d_constant_18_opt_io_o;
    reg_next_12_d_constant_18_opt_io_o <= reg_11_d_constant_18_opt_io_o;
    reg_next_13_d_constant_18_opt_io_o <= reg_12_d_constant_18_opt_io_o;
    reg_next_14_d_constant_18_opt_io_o <= reg_13_d_constant_18_opt_io_o;
    reg_next_15_d_constant_18_opt_io_o <= reg_14_d_constant_18_opt_io_o;
    reg_next_16_d_constant_18_opt_io_o <= reg_15_d_constant_18_opt_io_o;
    reg_next_17_d_constant_18_opt_io_o <= reg_16_d_constant_18_opt_io_o;
    reg_next_18_d_constant_18_opt_io_o <= reg_17_d_constant_18_opt_io_o;
    reg_next_19_d_constant_18_opt_io_o <= reg_18_d_constant_18_opt_io_o;
    reg_next_20_d_constant_18_opt_io_o <= reg_19_d_constant_18_opt_io_o;
    reg_next_21_d_constant_18_opt_io_o <= reg_20_d_constant_18_opt_io_o;
    reg_next_22_d_constant_18_opt_io_o <= reg_21_d_constant_18_opt_io_o;
    reg_next_23_d_constant_18_opt_io_o <= reg_22_d_constant_18_opt_io_o;
    reg_next_24_d_constant_18_opt_io_o <= reg_23_d_constant_18_opt_io_o;
    reg_next_0_d_constant_18_opt_io_o <= constant_18_opt_io_o;
    max_1_io_b <= reg_24_d_constant_18_opt_io_o;
    min_4_io_a <= max_1_io_o;
    reg_next_1_d_constant_19_opt_io_o <= reg_0_d_constant_19_opt_io_o;
    reg_next_2_d_constant_19_opt_io_o <= reg_1_d_constant_19_opt_io_o;
    reg_next_3_d_constant_19_opt_io_o <= reg_2_d_constant_19_opt_io_o;
    reg_next_4_d_constant_19_opt_io_o <= reg_3_d_constant_19_opt_io_o;
    reg_next_5_d_constant_19_opt_io_o <= reg_4_d_constant_19_opt_io_o;
    reg_next_6_d_constant_19_opt_io_o <= reg_5_d_constant_19_opt_io_o;
    reg_next_7_d_constant_19_opt_io_o <= reg_6_d_constant_19_opt_io_o;
    reg_next_8_d_constant_19_opt_io_o <= reg_7_d_constant_19_opt_io_o;
    reg_next_9_d_constant_19_opt_io_o <= reg_8_d_constant_19_opt_io_o;
    reg_next_10_d_constant_19_opt_io_o <= reg_9_d_constant_19_opt_io_o;
    reg_next_11_d_constant_19_opt_io_o <= reg_10_d_constant_19_opt_io_o;
    reg_next_12_d_constant_19_opt_io_o <= reg_11_d_constant_19_opt_io_o;
    reg_next_13_d_constant_19_opt_io_o <= reg_12_d_constant_19_opt_io_o;
    reg_next_14_d_constant_19_opt_io_o <= reg_13_d_constant_19_opt_io_o;
    reg_next_15_d_constant_19_opt_io_o <= reg_14_d_constant_19_opt_io_o;
    reg_next_16_d_constant_19_opt_io_o <= reg_15_d_constant_19_opt_io_o;
    reg_next_17_d_constant_19_opt_io_o <= reg_16_d_constant_19_opt_io_o;
    reg_next_18_d_constant_19_opt_io_o <= reg_17_d_constant_19_opt_io_o;
    reg_next_19_d_constant_19_opt_io_o <= reg_18_d_constant_19_opt_io_o;
    reg_next_20_d_constant_19_opt_io_o <= reg_19_d_constant_19_opt_io_o;
    reg_next_21_d_constant_19_opt_io_o <= reg_20_d_constant_19_opt_io_o;
    reg_next_22_d_constant_19_opt_io_o <= reg_21_d_constant_19_opt_io_o;
    reg_next_23_d_constant_19_opt_io_o <= reg_22_d_constant_19_opt_io_o;
    reg_next_24_d_constant_19_opt_io_o <= reg_23_d_constant_19_opt_io_o;
    reg_next_0_d_constant_19_opt_io_o <= constant_19_opt_io_o;
    max_2_io_b <= reg_24_d_constant_19_opt_io_o;
    min_5_io_a <= max_2_io_o;
    reg_next_1_d_constant_20_opt_io_o <= reg_0_d_constant_20_opt_io_o;
    reg_next_2_d_constant_20_opt_io_o <= reg_1_d_constant_20_opt_io_o;
    reg_next_3_d_constant_20_opt_io_o <= reg_2_d_constant_20_opt_io_o;
    reg_next_4_d_constant_20_opt_io_o <= reg_3_d_constant_20_opt_io_o;
    reg_next_5_d_constant_20_opt_io_o <= reg_4_d_constant_20_opt_io_o;
    reg_next_6_d_constant_20_opt_io_o <= reg_5_d_constant_20_opt_io_o;
    reg_next_7_d_constant_20_opt_io_o <= reg_6_d_constant_20_opt_io_o;
    reg_next_8_d_constant_20_opt_io_o <= reg_7_d_constant_20_opt_io_o;
    reg_next_9_d_constant_20_opt_io_o <= reg_8_d_constant_20_opt_io_o;
    reg_next_10_d_constant_20_opt_io_o <= reg_9_d_constant_20_opt_io_o;
    reg_next_11_d_constant_20_opt_io_o <= reg_10_d_constant_20_opt_io_o;
    reg_next_12_d_constant_20_opt_io_o <= reg_11_d_constant_20_opt_io_o;
    reg_next_13_d_constant_20_opt_io_o <= reg_12_d_constant_20_opt_io_o;
    reg_next_14_d_constant_20_opt_io_o <= reg_13_d_constant_20_opt_io_o;
    reg_next_15_d_constant_20_opt_io_o <= reg_14_d_constant_20_opt_io_o;
    reg_next_16_d_constant_20_opt_io_o <= reg_15_d_constant_20_opt_io_o;
    reg_next_17_d_constant_20_opt_io_o <= reg_16_d_constant_20_opt_io_o;
    reg_next_18_d_constant_20_opt_io_o <= reg_17_d_constant_20_opt_io_o;
    reg_next_19_d_constant_20_opt_io_o <= reg_18_d_constant_20_opt_io_o;
    reg_next_20_d_constant_20_opt_io_o <= reg_19_d_constant_20_opt_io_o;
    reg_next_21_d_constant_20_opt_io_o <= reg_20_d_constant_20_opt_io_o;
    reg_next_22_d_constant_20_opt_io_o <= reg_21_d_constant_20_opt_io_o;
    reg_next_23_d_constant_20_opt_io_o <= reg_22_d_constant_20_opt_io_o;
    reg_next_24_d_constant_20_opt_io_o <= reg_23_d_constant_20_opt_io_o;
    reg_next_0_d_constant_20_opt_io_o <= constant_20_opt_io_o;
    min_4_io_b <= reg_24_d_constant_20_opt_io_o;
    shifter_14_io_i <= min_4_io_o;
    reg_next_1_d_constant_21_opt_io_o <= reg_0_d_constant_21_opt_io_o;
    reg_next_2_d_constant_21_opt_io_o <= reg_1_d_constant_21_opt_io_o;
    reg_next_3_d_constant_21_opt_io_o <= reg_2_d_constant_21_opt_io_o;
    reg_next_4_d_constant_21_opt_io_o <= reg_3_d_constant_21_opt_io_o;
    reg_next_5_d_constant_21_opt_io_o <= reg_4_d_constant_21_opt_io_o;
    reg_next_6_d_constant_21_opt_io_o <= reg_5_d_constant_21_opt_io_o;
    reg_next_7_d_constant_21_opt_io_o <= reg_6_d_constant_21_opt_io_o;
    reg_next_8_d_constant_21_opt_io_o <= reg_7_d_constant_21_opt_io_o;
    reg_next_9_d_constant_21_opt_io_o <= reg_8_d_constant_21_opt_io_o;
    reg_next_10_d_constant_21_opt_io_o <= reg_9_d_constant_21_opt_io_o;
    reg_next_11_d_constant_21_opt_io_o <= reg_10_d_constant_21_opt_io_o;
    reg_next_12_d_constant_21_opt_io_o <= reg_11_d_constant_21_opt_io_o;
    reg_next_13_d_constant_21_opt_io_o <= reg_12_d_constant_21_opt_io_o;
    reg_next_14_d_constant_21_opt_io_o <= reg_13_d_constant_21_opt_io_o;
    reg_next_15_d_constant_21_opt_io_o <= reg_14_d_constant_21_opt_io_o;
    reg_next_16_d_constant_21_opt_io_o <= reg_15_d_constant_21_opt_io_o;
    reg_next_17_d_constant_21_opt_io_o <= reg_16_d_constant_21_opt_io_o;
    reg_next_18_d_constant_21_opt_io_o <= reg_17_d_constant_21_opt_io_o;
    reg_next_19_d_constant_21_opt_io_o <= reg_18_d_constant_21_opt_io_o;
    reg_next_20_d_constant_21_opt_io_o <= reg_19_d_constant_21_opt_io_o;
    reg_next_21_d_constant_21_opt_io_o <= reg_20_d_constant_21_opt_io_o;
    reg_next_22_d_constant_21_opt_io_o <= reg_21_d_constant_21_opt_io_o;
    reg_next_23_d_constant_21_opt_io_o <= reg_22_d_constant_21_opt_io_o;
    reg_next_24_d_constant_21_opt_io_o <= reg_23_d_constant_21_opt_io_o;
    reg_next_0_d_constant_21_opt_io_o <= constant_21_opt_io_o;
    min_5_io_b <= reg_24_d_constant_21_opt_io_o;
    shifter_15_io_i <= min_5_io_o;
    to_sfixed_4_io_i <= shifter_14_io_o;
    concatenator_io_a <= to_sfixed_4_io_o;
    to_sfixed_5_io_i <= shifter_15_io_o;
    concatenator_io_b <= to_sfixed_5_io_o;
    reg_next_0_d_concatenator_io_o <= concatenator_io_o;
    concatenator_1_io_a <= reg_0_d_concatenator_io_o;
    reg_next_1_d_constant_22_opt_io_o <= reg_0_d_constant_22_opt_io_o;
    reg_next_2_d_constant_22_opt_io_o <= reg_1_d_constant_22_opt_io_o;
    reg_next_3_d_constant_22_opt_io_o <= reg_2_d_constant_22_opt_io_o;
    reg_next_4_d_constant_22_opt_io_o <= reg_3_d_constant_22_opt_io_o;
    reg_next_5_d_constant_22_opt_io_o <= reg_4_d_constant_22_opt_io_o;
    reg_next_6_d_constant_22_opt_io_o <= reg_5_d_constant_22_opt_io_o;
    reg_next_7_d_constant_22_opt_io_o <= reg_6_d_constant_22_opt_io_o;
    reg_next_8_d_constant_22_opt_io_o <= reg_7_d_constant_22_opt_io_o;
    reg_next_9_d_constant_22_opt_io_o <= reg_8_d_constant_22_opt_io_o;
    reg_next_10_d_constant_22_opt_io_o <= reg_9_d_constant_22_opt_io_o;
    reg_next_11_d_constant_22_opt_io_o <= reg_10_d_constant_22_opt_io_o;
    reg_next_12_d_constant_22_opt_io_o <= reg_11_d_constant_22_opt_io_o;
    reg_next_13_d_constant_22_opt_io_o <= reg_12_d_constant_22_opt_io_o;
    reg_next_14_d_constant_22_opt_io_o <= reg_13_d_constant_22_opt_io_o;
    reg_next_15_d_constant_22_opt_io_o <= reg_14_d_constant_22_opt_io_o;
    reg_next_16_d_constant_22_opt_io_o <= reg_15_d_constant_22_opt_io_o;
    reg_next_17_d_constant_22_opt_io_o <= reg_16_d_constant_22_opt_io_o;
    reg_next_18_d_constant_22_opt_io_o <= reg_17_d_constant_22_opt_io_o;
    reg_next_19_d_constant_22_opt_io_o <= reg_18_d_constant_22_opt_io_o;
    reg_next_20_d_constant_22_opt_io_o <= reg_19_d_constant_22_opt_io_o;
    reg_next_21_d_constant_22_opt_io_o <= reg_20_d_constant_22_opt_io_o;
    reg_next_22_d_constant_22_opt_io_o <= reg_21_d_constant_22_opt_io_o;
    reg_next_23_d_constant_22_opt_io_o <= reg_22_d_constant_22_opt_io_o;
    reg_next_24_d_constant_22_opt_io_o <= reg_23_d_constant_22_opt_io_o;
    reg_next_25_d_constant_22_opt_io_o <= reg_24_d_constant_22_opt_io_o;
    reg_next_0_d_constant_22_opt_io_o <= constant_22_opt_io_o;
    concatenator_1_io_b <= reg_25_d_constant_22_opt_io_o;
    reg_next_1_valid_chain <= reg_0_valid_chain;
    reg_next_2_valid_chain <= reg_1_valid_chain;
    reg_next_3_valid_chain <= reg_2_valid_chain;
    reg_next_4_valid_chain <= reg_3_valid_chain;
    reg_next_5_valid_chain <= reg_4_valid_chain;
    reg_next_6_valid_chain <= reg_5_valid_chain;
    reg_next_7_valid_chain <= reg_6_valid_chain;
    reg_next_8_valid_chain <= reg_7_valid_chain;
    reg_next_9_valid_chain <= reg_8_valid_chain;
    reg_next_10_valid_chain <= reg_9_valid_chain;
    reg_next_11_valid_chain <= reg_10_valid_chain;
    reg_next_12_valid_chain <= reg_11_valid_chain;
    reg_next_13_valid_chain <= reg_12_valid_chain;
    reg_next_14_valid_chain <= reg_13_valid_chain;
    reg_next_15_valid_chain <= reg_14_valid_chain;
    reg_next_16_valid_chain <= reg_15_valid_chain;
    reg_next_17_valid_chain <= reg_16_valid_chain;
    reg_next_18_valid_chain <= reg_17_valid_chain;
    reg_next_19_valid_chain <= reg_18_valid_chain;
    reg_next_20_valid_chain <= reg_19_valid_chain;
    reg_next_21_valid_chain <= reg_20_valid_chain;
    reg_next_22_valid_chain <= reg_21_valid_chain;
    reg_next_23_valid_chain <= reg_22_valid_chain;
    reg_next_24_valid_chain <= reg_23_valid_chain;
    reg_next_25_valid_chain <= reg_24_valid_chain;
    reg_next_0_valid_chain <= in_valid;
    out_valid <= reg_25_valid_chain;
    in_ready_buffer <= (not reg_25_valid_chain) or out_ready;
    in_ready <= in_ready_buffer;
    in_ready_and_in_valid <= in_ready_buffer and in_valid;
end architecture;