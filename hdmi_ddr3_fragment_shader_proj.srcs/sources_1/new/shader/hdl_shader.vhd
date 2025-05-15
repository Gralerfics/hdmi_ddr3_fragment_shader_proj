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
    component ITimeConvertor_UInt_64_SFixedPoint_16_12 is
        port (
            i: in std_logic_vector(63 downto 0);
            o: out std_logic_vector(28 downto 0)
        );
    end component;

    component FragCoordValueConvertor_UInt_12_SFixedPoint_16_12 is
        port (
            i: in std_logic_vector(11 downto 0);
            o: out std_logic_vector(28 downto 0)
        );
    end component;

    component Constants_ba508eb47443af17_Core is
        port (
            c0_1: out std_logic_vector(28 downto 0);
            c0_95: out std_logic_vector(28 downto 0);
            c1: out std_logic_vector(28 downto 0);
            c3_75: out std_logic_vector(28 downto 0);
            c5: out std_logic_vector(28 downto 0);
            c5_5: out std_logic_vector(28 downto 0);
            c384: out std_logic_vector(28 downto 0)
        );
    end component;

    component ArithShifter_NEG9_SFixedPoint_16_12 is
        port (
            i: in std_logic_vector(28 downto 0);
            o: out std_logic_vector(28 downto 0)
        );
    end component;

    component ArithShifter_NEG7_SFixedPoint_16_12 is
        port (
            i: in std_logic_vector(28 downto 0);
            o: out std_logic_vector(28 downto 0)
        );
    end component;

    component BitsAdd_SFixedPoint_16_12_SFixedPoint_16_12 is
        port (
            a: in std_logic_vector(28 downto 0);
            b: in std_logic_vector(28 downto 0);
            r: out std_logic_vector(28 downto 0)
        );
    end component;

    component BitsSubtract_SFixedPoint_16_12_SFixedPoint_16_12 is
        port (
            a: in std_logic_vector(28 downto 0);
            b: in std_logic_vector(28 downto 0);
            r: out std_logic_vector(28 downto 0)
        );
    end component;

    component Fract_SFixedPoint_16_12 is
        port (
            i: in std_logic_vector(28 downto 0);
            o: out std_logic_vector(28 downto 0)
        );
    end component;

    component MinPositiveXandOneMinusX_SFixedPoint_16_12 is
        port (
            i: in std_logic_vector(28 downto 0);
            o: out std_logic_vector(28 downto 0)
        );
    end component;

    component Ceil_SFixedPoint_16_12 is
        port (
            i: in std_logic_vector(28 downto 0);
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

    component ArithShifter_NEG3_SFixedPoint_16_12 is
        port (
            i: in std_logic_vector(28 downto 0);
            o: out std_logic_vector(28 downto 0)
        );
    end component;

    component ArithShifter_NEG1_SFixedPoint_16_12 is
        port (
            i: in std_logic_vector(28 downto 0);
            o: out std_logic_vector(28 downto 0)
        );
    end component;

    component ArithShifter_NEG2_SFixedPoint_16_12 is
        port (
            i: in std_logic_vector(28 downto 0);
            o: out std_logic_vector(28 downto 0)
        );
    end component;

    component ArithShifter_1_SFixedPoint_16_12 is
        port (
            i: in std_logic_vector(28 downto 0);
            o: out std_logic_vector(28 downto 0)
        );
    end component;

    component Min_SFixedPoint_16_12_SFixedPoint_16_12 is
        port (
            a: in std_logic_vector(28 downto 0);
            b: in std_logic_vector(28 downto 0);
            o: out std_logic_vector(28 downto 0)
        );
    end component;

    component ArithShifter_2_SFixedPoint_16_12 is
        port (
            i: in std_logic_vector(28 downto 0);
            o: out std_logic_vector(28 downto 0)
        );
    end component;

    component CustomVHDLOperator_447d1b8997193967 is
        port (
            ee: in std_logic_vector(28 downto 0);
            vv: in std_logic_vector(28 downto 0);
            o: out std_logic_vector(28 downto 0)
        );
    end component;

    component ArithShifter_4_SFixedPoint_16_12 is
        port (
            i: in std_logic_vector(28 downto 0);
            o: out std_logic_vector(28 downto 0)
        );
    end component;

    component Clamp0To1_SFixedPoint_16_12 is
        port (
            i: in std_logic_vector(28 downto 0);
            o: out std_logic_vector(28 downto 0)
        );
    end component;

    component To8bitConvertor_SFixedPoint_16_12 is
        port (
            i_clamped: in std_logic_vector(28 downto 0);
            o: out std_logic_vector(7 downto 0)
        );
    end component;

    component Concatenate_Bits_8_Bits_8_Bits_8 is
        port (
            r: in std_logic_vector(7 downto 0);
            g: in std_logic_vector(7 downto 0);
            b: in std_logic_vector(7 downto 0);
            o: out std_logic_vector(23 downto 0)
        );
    end component;

    signal itime_convertor_0_io_i: std_logic_vector(63 downto 0);
    signal itime_convertor_0_io_o: std_logic_vector(28 downto 0);
    signal fragcoord_value_convertor_1_io_i: std_logic_vector(11 downto 0);
    signal fragcoord_value_convertor_1_io_o: std_logic_vector(28 downto 0);
    signal fragcoord_value_convertor_2_io_i: std_logic_vector(11 downto 0);
    signal fragcoord_value_convertor_2_io_o: std_logic_vector(28 downto 0);
    signal consts_opt_io_c0_1: std_logic_vector(28 downto 0);
    signal consts_opt_io_c0_95: std_logic_vector(28 downto 0);
    signal consts_opt_io_c1: std_logic_vector(28 downto 0);
    signal consts_opt_io_c3_75: std_logic_vector(28 downto 0);
    signal consts_opt_io_c5: std_logic_vector(28 downto 0);
    signal consts_opt_io_c5_5: std_logic_vector(28 downto 0);
    signal consts_opt_io_c384: std_logic_vector(28 downto 0);
    signal arith_shifter_3_io_i: std_logic_vector(28 downto 0);
    signal arith_shifter_3_io_o: std_logic_vector(28 downto 0);
    signal arith_shifter_4_io_i: std_logic_vector(28 downto 0);
    signal arith_shifter_4_io_o: std_logic_vector(28 downto 0);
    signal addition_5_io_a: std_logic_vector(28 downto 0);
    signal addition_5_io_b: std_logic_vector(28 downto 0);
    signal addition_5_io_r: std_logic_vector(28 downto 0);
    signal subtraction_6_io_a: std_logic_vector(28 downto 0);
    signal subtraction_6_io_b: std_logic_vector(28 downto 0);
    signal subtraction_6_io_r: std_logic_vector(28 downto 0);
    signal arith_shifter_7_io_i: std_logic_vector(28 downto 0);
    signal arith_shifter_7_io_o: std_logic_vector(28 downto 0);
    signal arith_shifter_8_io_i: std_logic_vector(28 downto 0);
    signal arith_shifter_8_io_o: std_logic_vector(28 downto 0);
    signal addition_9_io_a: std_logic_vector(28 downto 0);
    signal addition_9_io_b: std_logic_vector(28 downto 0);
    signal addition_9_io_r: std_logic_vector(28 downto 0);
    signal subtraction_10_io_a: std_logic_vector(28 downto 0);
    signal subtraction_10_io_b: std_logic_vector(28 downto 0);
    signal subtraction_10_io_r: std_logic_vector(28 downto 0);
    signal subtraction_11_io_a: std_logic_vector(28 downto 0);
    signal subtraction_11_io_b: std_logic_vector(28 downto 0);
    signal subtraction_11_io_r: std_logic_vector(28 downto 0);
    signal addition_12_io_a: std_logic_vector(28 downto 0);
    signal addition_12_io_b: std_logic_vector(28 downto 0);
    signal addition_12_io_r: std_logic_vector(28 downto 0);
    signal addition_13_io_a: std_logic_vector(28 downto 0);
    signal addition_13_io_b: std_logic_vector(28 downto 0);
    signal addition_13_io_r: std_logic_vector(28 downto 0);
    signal addition_14_io_a: std_logic_vector(28 downto 0);
    signal addition_14_io_b: std_logic_vector(28 downto 0);
    signal addition_14_io_r: std_logic_vector(28 downto 0);
    signal fract_15_io_i: std_logic_vector(28 downto 0);
    signal fract_15_io_o: std_logic_vector(28 downto 0);
    signal minx1mx_16_io_i: std_logic_vector(28 downto 0);
    signal minx1mx_16_io_o: std_logic_vector(28 downto 0);
    signal fract_17_io_i: std_logic_vector(28 downto 0);
    signal fract_17_io_o: std_logic_vector(28 downto 0);
    signal minx1mx_18_io_i: std_logic_vector(28 downto 0);
    signal minx1mx_18_io_o: std_logic_vector(28 downto 0);
    signal ceil_19_io_i: std_logic_vector(28 downto 0);
    signal ceil_19_io_o: std_logic_vector(28 downto 0);
    signal subtraction_20_io_a: std_logic_vector(28 downto 0);
    signal subtraction_20_io_b: std_logic_vector(28 downto 0);
    signal subtraction_20_io_r: std_logic_vector(28 downto 0);
    signal ceil_21_io_i: std_logic_vector(28 downto 0);
    signal ceil_21_io_o: std_logic_vector(28 downto 0);
    signal subtraction_22_io_a: std_logic_vector(28 downto 0);
    signal subtraction_22_io_b: std_logic_vector(28 downto 0);
    signal subtraction_22_io_r: std_logic_vector(28 downto 0);
    signal multiplication_23_sint_mul_gen_addends_io_long: std_logic_vector(28 downto 0);
    signal multiplication_23_sint_mul_gen_addends_io_short: std_logic_vector(28 downto 0);
    signal multiplication_23_sint_mul_gen_addends_io_addend_0: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_gen_addends_io_addend_1: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_gen_addends_io_addend_2: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_gen_addends_io_addend_3: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_gen_addends_io_addend_4: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_gen_addends_io_addend_5: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_gen_addends_io_addend_6: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_gen_addends_io_addend_7: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_gen_addends_io_addend_8: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_gen_addends_io_addend_9: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_gen_addends_io_addend_10: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_gen_addends_io_addend_11: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_gen_addends_io_addend_12: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_gen_addends_io_addend_13: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_gen_addends_io_addend_14: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_gen_addends_io_addend_15: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_gen_addends_io_addend_16: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_gen_addends_io_addend_17: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_gen_addends_io_addend_18: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_gen_addends_io_addend_19: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_gen_addends_io_addend_20: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_gen_addends_io_addend_21: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_gen_addends_io_addend_22: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_gen_addends_io_addend_23: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_gen_addends_io_addend_24: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_gen_addends_io_addend_25: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_gen_addends_io_addend_26: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_gen_addends_io_addend_27: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_0_io_a: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_0_io_b: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_0_io_r: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_1_io_a: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_1_io_b: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_1_io_r: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_2_io_a: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_2_io_b: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_2_io_r: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_3_io_a: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_3_io_b: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_3_io_r: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_4_io_a: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_4_io_b: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_4_io_r: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_5_io_a: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_5_io_b: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_5_io_r: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_6_io_a: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_6_io_b: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_6_io_r: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_7_io_a: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_7_io_b: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_7_io_r: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_8_io_a: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_8_io_b: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_8_io_r: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_9_io_a: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_9_io_b: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_9_io_r: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_10_io_a: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_10_io_b: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_10_io_r: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_11_io_a: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_11_io_b: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_11_io_r: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_12_io_a: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_12_io_b: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_12_io_r: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_13_io_a: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_13_io_b: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_13_io_r: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_14_io_a: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_14_io_b: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_14_io_r: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_15_io_a: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_15_io_b: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_15_io_r: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_16_io_a: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_16_io_b: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_16_io_r: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_17_io_a: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_17_io_b: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_17_io_r: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_18_io_a: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_18_io_b: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_18_io_r: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_19_io_a: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_19_io_b: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_19_io_r: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_20_io_a: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_20_io_b: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_20_io_r: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_21_io_a: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_21_io_b: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_21_io_r: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_22_io_a: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_22_io_b: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_22_io_r: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_23_io_a: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_23_io_b: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_23_io_r: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_24_io_a: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_24_io_b: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_24_io_r: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_25_io_a: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_25_io_b: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_25_io_r: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_26_io_a: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_26_io_b: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_adder_26_io_r: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_subtractor_io_a: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_subtractor_io_b: std_logic_vector(57 downto 0);
    signal multiplication_23_sint_mul_subtractor_io_r: std_logic_vector(57 downto 0);
    signal multiplication_23_tc_io_i: std_logic_vector(57 downto 0);
    signal multiplication_23_tc_io_o: std_logic_vector(28 downto 0);
    signal multiplication_24_sint_mul_gen_addends_io_long: std_logic_vector(28 downto 0);
    signal multiplication_24_sint_mul_gen_addends_io_short: std_logic_vector(28 downto 0);
    signal multiplication_24_sint_mul_gen_addends_io_addend_0: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_gen_addends_io_addend_1: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_gen_addends_io_addend_2: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_gen_addends_io_addend_3: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_gen_addends_io_addend_4: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_gen_addends_io_addend_5: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_gen_addends_io_addend_6: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_gen_addends_io_addend_7: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_gen_addends_io_addend_8: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_gen_addends_io_addend_9: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_gen_addends_io_addend_10: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_gen_addends_io_addend_11: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_gen_addends_io_addend_12: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_gen_addends_io_addend_13: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_gen_addends_io_addend_14: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_gen_addends_io_addend_15: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_gen_addends_io_addend_16: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_gen_addends_io_addend_17: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_gen_addends_io_addend_18: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_gen_addends_io_addend_19: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_gen_addends_io_addend_20: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_gen_addends_io_addend_21: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_gen_addends_io_addend_22: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_gen_addends_io_addend_23: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_gen_addends_io_addend_24: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_gen_addends_io_addend_25: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_gen_addends_io_addend_26: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_gen_addends_io_addend_27: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_0_io_a: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_0_io_b: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_0_io_r: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_1_io_a: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_1_io_b: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_1_io_r: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_2_io_a: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_2_io_b: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_2_io_r: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_3_io_a: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_3_io_b: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_3_io_r: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_4_io_a: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_4_io_b: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_4_io_r: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_5_io_a: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_5_io_b: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_5_io_r: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_6_io_a: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_6_io_b: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_6_io_r: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_7_io_a: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_7_io_b: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_7_io_r: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_8_io_a: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_8_io_b: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_8_io_r: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_9_io_a: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_9_io_b: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_9_io_r: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_10_io_a: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_10_io_b: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_10_io_r: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_11_io_a: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_11_io_b: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_11_io_r: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_12_io_a: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_12_io_b: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_12_io_r: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_13_io_a: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_13_io_b: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_13_io_r: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_14_io_a: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_14_io_b: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_14_io_r: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_15_io_a: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_15_io_b: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_15_io_r: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_16_io_a: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_16_io_b: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_16_io_r: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_17_io_a: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_17_io_b: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_17_io_r: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_18_io_a: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_18_io_b: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_18_io_r: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_19_io_a: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_19_io_b: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_19_io_r: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_20_io_a: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_20_io_b: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_20_io_r: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_21_io_a: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_21_io_b: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_21_io_r: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_22_io_a: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_22_io_b: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_22_io_r: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_23_io_a: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_23_io_b: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_23_io_r: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_24_io_a: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_24_io_b: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_24_io_r: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_25_io_a: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_25_io_b: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_25_io_r: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_26_io_a: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_26_io_b: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_adder_26_io_r: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_subtractor_io_a: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_subtractor_io_b: std_logic_vector(57 downto 0);
    signal multiplication_24_sint_mul_subtractor_io_r: std_logic_vector(57 downto 0);
    signal multiplication_24_tc_io_i: std_logic_vector(57 downto 0);
    signal multiplication_24_tc_io_o: std_logic_vector(28 downto 0);
    signal addition_25_io_a: std_logic_vector(28 downto 0);
    signal addition_25_io_b: std_logic_vector(28 downto 0);
    signal addition_25_io_r: std_logic_vector(28 downto 0);
    signal arith_shifter_26_io_i: std_logic_vector(28 downto 0);
    signal arith_shifter_26_io_o: std_logic_vector(28 downto 0);
    signal addition_27_io_a: std_logic_vector(28 downto 0);
    signal addition_27_io_b: std_logic_vector(28 downto 0);
    signal addition_27_io_r: std_logic_vector(28 downto 0);
    signal arith_shifter_28_io_i: std_logic_vector(28 downto 0);
    signal arith_shifter_28_io_o: std_logic_vector(28 downto 0);
    signal subtraction_29_io_a: std_logic_vector(28 downto 0);
    signal subtraction_29_io_b: std_logic_vector(28 downto 0);
    signal subtraction_29_io_r: std_logic_vector(28 downto 0);
    signal arith_shifter_30_io_i: std_logic_vector(28 downto 0);
    signal arith_shifter_30_io_o: std_logic_vector(28 downto 0);
    signal fract_31_io_i: std_logic_vector(28 downto 0);
    signal fract_31_io_o: std_logic_vector(28 downto 0);
    signal arith_shifter_32_io_i: std_logic_vector(28 downto 0);
    signal arith_shifter_32_io_o: std_logic_vector(28 downto 0);
    signal subtraction_33_io_a: std_logic_vector(28 downto 0);
    signal subtraction_33_io_b: std_logic_vector(28 downto 0);
    signal subtraction_33_io_r: std_logic_vector(28 downto 0);
    signal min_34_io_a: std_logic_vector(28 downto 0);
    signal min_34_io_b: std_logic_vector(28 downto 0);
    signal min_34_io_o: std_logic_vector(28 downto 0);
    signal arith_shifter_35_io_i: std_logic_vector(28 downto 0);
    signal arith_shifter_35_io_o: std_logic_vector(28 downto 0);
    signal fract_36_io_i: std_logic_vector(28 downto 0);
    signal fract_36_io_o: std_logic_vector(28 downto 0);
    signal mux_calc_io_ee: std_logic_vector(28 downto 0);
    signal mux_calc_io_vv: std_logic_vector(28 downto 0);
    signal mux_calc_io_o: std_logic_vector(28 downto 0);
    signal multiplication_37_sint_mul_gen_addends_io_long: std_logic_vector(28 downto 0);
    signal multiplication_37_sint_mul_gen_addends_io_short: std_logic_vector(28 downto 0);
    signal multiplication_37_sint_mul_gen_addends_io_addend_0: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_gen_addends_io_addend_1: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_gen_addends_io_addend_2: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_gen_addends_io_addend_3: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_gen_addends_io_addend_4: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_gen_addends_io_addend_5: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_gen_addends_io_addend_6: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_gen_addends_io_addend_7: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_gen_addends_io_addend_8: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_gen_addends_io_addend_9: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_gen_addends_io_addend_10: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_gen_addends_io_addend_11: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_gen_addends_io_addend_12: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_gen_addends_io_addend_13: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_gen_addends_io_addend_14: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_gen_addends_io_addend_15: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_gen_addends_io_addend_16: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_gen_addends_io_addend_17: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_gen_addends_io_addend_18: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_gen_addends_io_addend_19: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_gen_addends_io_addend_20: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_gen_addends_io_addend_21: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_gen_addends_io_addend_22: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_gen_addends_io_addend_23: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_gen_addends_io_addend_24: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_gen_addends_io_addend_25: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_gen_addends_io_addend_26: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_gen_addends_io_addend_27: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_0_io_a: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_0_io_b: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_0_io_r: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_1_io_a: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_1_io_b: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_1_io_r: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_2_io_a: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_2_io_b: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_2_io_r: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_3_io_a: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_3_io_b: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_3_io_r: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_4_io_a: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_4_io_b: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_4_io_r: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_5_io_a: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_5_io_b: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_5_io_r: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_6_io_a: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_6_io_b: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_6_io_r: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_7_io_a: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_7_io_b: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_7_io_r: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_8_io_a: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_8_io_b: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_8_io_r: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_9_io_a: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_9_io_b: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_9_io_r: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_10_io_a: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_10_io_b: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_10_io_r: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_11_io_a: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_11_io_b: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_11_io_r: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_12_io_a: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_12_io_b: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_12_io_r: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_13_io_a: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_13_io_b: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_13_io_r: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_14_io_a: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_14_io_b: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_14_io_r: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_15_io_a: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_15_io_b: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_15_io_r: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_16_io_a: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_16_io_b: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_16_io_r: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_17_io_a: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_17_io_b: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_17_io_r: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_18_io_a: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_18_io_b: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_18_io_r: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_19_io_a: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_19_io_b: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_19_io_r: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_20_io_a: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_20_io_b: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_20_io_r: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_21_io_a: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_21_io_b: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_21_io_r: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_22_io_a: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_22_io_b: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_22_io_r: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_23_io_a: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_23_io_b: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_23_io_r: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_24_io_a: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_24_io_b: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_24_io_r: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_25_io_a: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_25_io_b: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_25_io_r: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_26_io_a: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_26_io_b: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_adder_26_io_r: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_subtractor_io_a: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_subtractor_io_b: std_logic_vector(57 downto 0);
    signal multiplication_37_sint_mul_subtractor_io_r: std_logic_vector(57 downto 0);
    signal multiplication_37_tc_io_i: std_logic_vector(57 downto 0);
    signal multiplication_37_tc_io_o: std_logic_vector(28 downto 0);
    signal multiplication_38_sint_mul_gen_addends_io_long: std_logic_vector(28 downto 0);
    signal multiplication_38_sint_mul_gen_addends_io_short: std_logic_vector(28 downto 0);
    signal multiplication_38_sint_mul_gen_addends_io_addend_0: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_gen_addends_io_addend_1: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_gen_addends_io_addend_2: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_gen_addends_io_addend_3: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_gen_addends_io_addend_4: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_gen_addends_io_addend_5: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_gen_addends_io_addend_6: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_gen_addends_io_addend_7: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_gen_addends_io_addend_8: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_gen_addends_io_addend_9: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_gen_addends_io_addend_10: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_gen_addends_io_addend_11: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_gen_addends_io_addend_12: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_gen_addends_io_addend_13: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_gen_addends_io_addend_14: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_gen_addends_io_addend_15: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_gen_addends_io_addend_16: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_gen_addends_io_addend_17: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_gen_addends_io_addend_18: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_gen_addends_io_addend_19: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_gen_addends_io_addend_20: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_gen_addends_io_addend_21: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_gen_addends_io_addend_22: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_gen_addends_io_addend_23: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_gen_addends_io_addend_24: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_gen_addends_io_addend_25: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_gen_addends_io_addend_26: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_gen_addends_io_addend_27: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_0_io_a: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_0_io_b: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_0_io_r: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_1_io_a: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_1_io_b: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_1_io_r: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_2_io_a: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_2_io_b: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_2_io_r: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_3_io_a: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_3_io_b: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_3_io_r: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_4_io_a: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_4_io_b: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_4_io_r: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_5_io_a: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_5_io_b: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_5_io_r: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_6_io_a: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_6_io_b: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_6_io_r: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_7_io_a: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_7_io_b: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_7_io_r: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_8_io_a: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_8_io_b: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_8_io_r: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_9_io_a: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_9_io_b: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_9_io_r: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_10_io_a: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_10_io_b: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_10_io_r: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_11_io_a: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_11_io_b: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_11_io_r: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_12_io_a: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_12_io_b: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_12_io_r: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_13_io_a: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_13_io_b: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_13_io_r: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_14_io_a: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_14_io_b: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_14_io_r: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_15_io_a: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_15_io_b: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_15_io_r: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_16_io_a: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_16_io_b: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_16_io_r: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_17_io_a: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_17_io_b: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_17_io_r: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_18_io_a: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_18_io_b: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_18_io_r: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_19_io_a: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_19_io_b: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_19_io_r: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_20_io_a: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_20_io_b: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_20_io_r: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_21_io_a: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_21_io_b: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_21_io_r: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_22_io_a: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_22_io_b: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_22_io_r: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_23_io_a: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_23_io_b: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_23_io_r: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_24_io_a: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_24_io_b: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_24_io_r: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_25_io_a: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_25_io_b: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_25_io_r: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_26_io_a: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_26_io_b: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_adder_26_io_r: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_subtractor_io_a: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_subtractor_io_b: std_logic_vector(57 downto 0);
    signal multiplication_38_sint_mul_subtractor_io_r: std_logic_vector(57 downto 0);
    signal multiplication_38_tc_io_i: std_logic_vector(57 downto 0);
    signal multiplication_38_tc_io_o: std_logic_vector(28 downto 0);
    signal subtraction_39_io_a: std_logic_vector(28 downto 0);
    signal subtraction_39_io_b: std_logic_vector(28 downto 0);
    signal subtraction_39_io_r: std_logic_vector(28 downto 0);
    signal arith_shifter_40_io_i: std_logic_vector(28 downto 0);
    signal arith_shifter_40_io_o: std_logic_vector(28 downto 0);
    signal arith_shifter_41_io_i: std_logic_vector(28 downto 0);
    signal arith_shifter_41_io_o: std_logic_vector(28 downto 0);
    signal addition_42_io_a: std_logic_vector(28 downto 0);
    signal addition_42_io_b: std_logic_vector(28 downto 0);
    signal addition_42_io_r: std_logic_vector(28 downto 0);
    signal addition_43_io_a: std_logic_vector(28 downto 0);
    signal addition_43_io_b: std_logic_vector(28 downto 0);
    signal addition_43_io_r: std_logic_vector(28 downto 0);
    signal clamp01_44_io_i: std_logic_vector(28 downto 0);
    signal clamp01_44_io_o: std_logic_vector(28 downto 0);
    signal multiplication_45_sint_mul_gen_addends_io_long: std_logic_vector(28 downto 0);
    signal multiplication_45_sint_mul_gen_addends_io_short: std_logic_vector(28 downto 0);
    signal multiplication_45_sint_mul_gen_addends_io_addend_0: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_gen_addends_io_addend_1: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_gen_addends_io_addend_2: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_gen_addends_io_addend_3: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_gen_addends_io_addend_4: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_gen_addends_io_addend_5: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_gen_addends_io_addend_6: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_gen_addends_io_addend_7: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_gen_addends_io_addend_8: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_gen_addends_io_addend_9: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_gen_addends_io_addend_10: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_gen_addends_io_addend_11: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_gen_addends_io_addend_12: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_gen_addends_io_addend_13: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_gen_addends_io_addend_14: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_gen_addends_io_addend_15: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_gen_addends_io_addend_16: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_gen_addends_io_addend_17: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_gen_addends_io_addend_18: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_gen_addends_io_addend_19: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_gen_addends_io_addend_20: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_gen_addends_io_addend_21: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_gen_addends_io_addend_22: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_gen_addends_io_addend_23: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_gen_addends_io_addend_24: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_gen_addends_io_addend_25: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_gen_addends_io_addend_26: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_gen_addends_io_addend_27: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_0_io_a: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_0_io_b: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_0_io_r: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_1_io_a: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_1_io_b: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_1_io_r: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_2_io_a: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_2_io_b: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_2_io_r: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_3_io_a: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_3_io_b: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_3_io_r: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_4_io_a: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_4_io_b: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_4_io_r: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_5_io_a: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_5_io_b: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_5_io_r: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_6_io_a: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_6_io_b: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_6_io_r: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_7_io_a: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_7_io_b: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_7_io_r: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_8_io_a: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_8_io_b: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_8_io_r: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_9_io_a: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_9_io_b: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_9_io_r: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_10_io_a: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_10_io_b: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_10_io_r: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_11_io_a: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_11_io_b: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_11_io_r: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_12_io_a: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_12_io_b: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_12_io_r: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_13_io_a: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_13_io_b: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_13_io_r: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_14_io_a: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_14_io_b: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_14_io_r: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_15_io_a: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_15_io_b: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_15_io_r: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_16_io_a: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_16_io_b: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_16_io_r: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_17_io_a: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_17_io_b: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_17_io_r: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_18_io_a: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_18_io_b: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_18_io_r: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_19_io_a: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_19_io_b: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_19_io_r: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_20_io_a: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_20_io_b: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_20_io_r: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_21_io_a: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_21_io_b: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_21_io_r: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_22_io_a: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_22_io_b: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_22_io_r: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_23_io_a: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_23_io_b: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_23_io_r: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_24_io_a: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_24_io_b: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_24_io_r: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_25_io_a: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_25_io_b: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_25_io_r: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_26_io_a: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_26_io_b: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_adder_26_io_r: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_subtractor_io_a: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_subtractor_io_b: std_logic_vector(57 downto 0);
    signal multiplication_45_sint_mul_subtractor_io_r: std_logic_vector(57 downto 0);
    signal multiplication_45_tc_io_i: std_logic_vector(57 downto 0);
    signal multiplication_45_tc_io_o: std_logic_vector(28 downto 0);
    signal addition_46_io_a: std_logic_vector(28 downto 0);
    signal addition_46_io_b: std_logic_vector(28 downto 0);
    signal addition_46_io_r: std_logic_vector(28 downto 0);
    signal arith_shifter_47_io_i: std_logic_vector(28 downto 0);
    signal arith_shifter_47_io_o: std_logic_vector(28 downto 0);
    signal subtraction_48_io_a: std_logic_vector(28 downto 0);
    signal subtraction_48_io_b: std_logic_vector(28 downto 0);
    signal subtraction_48_io_r: std_logic_vector(28 downto 0);
    signal to8bit_cvt_49_io_i_clamped: std_logic_vector(28 downto 0);
    signal to8bit_cvt_49_io_o: std_logic_vector(7 downto 0);
    signal clamp01_49_io_i: std_logic_vector(28 downto 0);
    signal clamp01_49_io_o: std_logic_vector(28 downto 0);
    signal arith_shifter_51_io_i: std_logic_vector(28 downto 0);
    signal arith_shifter_51_io_o: std_logic_vector(28 downto 0);
    signal subtraction_52_io_a: std_logic_vector(28 downto 0);
    signal subtraction_52_io_b: std_logic_vector(28 downto 0);
    signal subtraction_52_io_r: std_logic_vector(28 downto 0);
    signal to8bit_cvt_53_io_i_clamped: std_logic_vector(28 downto 0);
    signal to8bit_cvt_53_io_o: std_logic_vector(7 downto 0);
    signal clamp01_53_io_i: std_logic_vector(28 downto 0);
    signal clamp01_53_io_o: std_logic_vector(28 downto 0);
    signal to8bit_cvt_55_io_i_clamped: std_logic_vector(28 downto 0);
    signal to8bit_cvt_55_io_o: std_logic_vector(7 downto 0);
    signal clamp01_55_io_i: std_logic_vector(28 downto 0);
    signal clamp01_55_io_o: std_logic_vector(28 downto 0);
    signal color_24bit_cvt_io_r: std_logic_vector(7 downto 0);
    signal color_24bit_cvt_io_g: std_logic_vector(7 downto 0);
    signal color_24bit_cvt_io_b: std_logic_vector(7 downto 0);
    signal color_24bit_cvt_io_o: std_logic_vector(23 downto 0);
    signal reg_next_0_d_itime_us: std_logic_vector(63 downto 0);
    signal reg_0_d_itime_us: std_logic_vector(63 downto 0);
    signal reg_next_0_d_frag_x: std_logic_vector(11 downto 0);
    signal reg_0_d_frag_x: std_logic_vector(11 downto 0);
    signal reg_next_0_d_frag_y: std_logic_vector(11 downto 0);
    signal reg_0_d_frag_y: std_logic_vector(11 downto 0);
    signal reg_next_0_d_itime_convertor_0_io_o: std_logic_vector(28 downto 0);
    signal reg_0_d_itime_convertor_0_io_o: std_logic_vector(28 downto 0);
    signal reg_next_1_d_itime_convertor_0_io_o: std_logic_vector(28 downto 0);
    signal reg_1_d_itime_convertor_0_io_o: std_logic_vector(28 downto 0);
    signal reg_next_2_d_itime_convertor_0_io_o: std_logic_vector(28 downto 0);
    signal reg_2_d_itime_convertor_0_io_o: std_logic_vector(28 downto 0);
    signal reg_next_3_d_itime_convertor_0_io_o: std_logic_vector(28 downto 0);
    signal reg_3_d_itime_convertor_0_io_o: std_logic_vector(28 downto 0);
    signal reg_next_4_d_itime_convertor_0_io_o: std_logic_vector(28 downto 0);
    signal reg_4_d_itime_convertor_0_io_o: std_logic_vector(28 downto 0);
    signal reg_next_5_d_itime_convertor_0_io_o: std_logic_vector(28 downto 0);
    signal reg_5_d_itime_convertor_0_io_o: std_logic_vector(28 downto 0);
    signal reg_next_6_d_itime_convertor_0_io_o: std_logic_vector(28 downto 0);
    signal reg_6_d_itime_convertor_0_io_o: std_logic_vector(28 downto 0);
    signal reg_next_7_d_itime_convertor_0_io_o: std_logic_vector(28 downto 0);
    signal reg_7_d_itime_convertor_0_io_o: std_logic_vector(28 downto 0);
    signal reg_next_8_d_itime_convertor_0_io_o: std_logic_vector(28 downto 0);
    signal reg_8_d_itime_convertor_0_io_o: std_logic_vector(28 downto 0);
    signal reg_next_9_d_itime_convertor_0_io_o: std_logic_vector(28 downto 0);
    signal reg_9_d_itime_convertor_0_io_o: std_logic_vector(28 downto 0);
    signal reg_next_0_d_consts_opt_io_c0_1: std_logic_vector(28 downto 0);
    signal reg_0_d_consts_opt_io_c0_1: std_logic_vector(28 downto 0);
    signal reg_next_1_d_consts_opt_io_c0_1: std_logic_vector(28 downto 0);
    signal reg_1_d_consts_opt_io_c0_1: std_logic_vector(28 downto 0);
    signal reg_next_2_d_consts_opt_io_c0_1: std_logic_vector(28 downto 0);
    signal reg_2_d_consts_opt_io_c0_1: std_logic_vector(28 downto 0);
    signal reg_next_3_d_consts_opt_io_c0_1: std_logic_vector(28 downto 0);
    signal reg_3_d_consts_opt_io_c0_1: std_logic_vector(28 downto 0);
    signal reg_next_4_d_consts_opt_io_c0_1: std_logic_vector(28 downto 0);
    signal reg_4_d_consts_opt_io_c0_1: std_logic_vector(28 downto 0);
    signal reg_next_5_d_consts_opt_io_c0_1: std_logic_vector(28 downto 0);
    signal reg_5_d_consts_opt_io_c0_1: std_logic_vector(28 downto 0);
    signal reg_next_6_d_consts_opt_io_c0_1: std_logic_vector(28 downto 0);
    signal reg_6_d_consts_opt_io_c0_1: std_logic_vector(28 downto 0);
    signal reg_next_7_d_consts_opt_io_c0_1: std_logic_vector(28 downto 0);
    signal reg_7_d_consts_opt_io_c0_1: std_logic_vector(28 downto 0);
    signal reg_next_8_d_consts_opt_io_c0_1: std_logic_vector(28 downto 0);
    signal reg_8_d_consts_opt_io_c0_1: std_logic_vector(28 downto 0);
    signal reg_next_9_d_consts_opt_io_c0_1: std_logic_vector(28 downto 0);
    signal reg_9_d_consts_opt_io_c0_1: std_logic_vector(28 downto 0);
    signal reg_next_0_d_consts_opt_io_c0_95: std_logic_vector(28 downto 0);
    signal reg_0_d_consts_opt_io_c0_95: std_logic_vector(28 downto 0);
    signal reg_next_1_d_consts_opt_io_c0_95: std_logic_vector(28 downto 0);
    signal reg_1_d_consts_opt_io_c0_95: std_logic_vector(28 downto 0);
    signal reg_next_2_d_consts_opt_io_c0_95: std_logic_vector(28 downto 0);
    signal reg_2_d_consts_opt_io_c0_95: std_logic_vector(28 downto 0);
    signal reg_next_3_d_consts_opt_io_c0_95: std_logic_vector(28 downto 0);
    signal reg_3_d_consts_opt_io_c0_95: std_logic_vector(28 downto 0);
    signal reg_next_4_d_consts_opt_io_c0_95: std_logic_vector(28 downto 0);
    signal reg_4_d_consts_opt_io_c0_95: std_logic_vector(28 downto 0);
    signal reg_next_5_d_consts_opt_io_c0_95: std_logic_vector(28 downto 0);
    signal reg_5_d_consts_opt_io_c0_95: std_logic_vector(28 downto 0);
    signal reg_next_6_d_consts_opt_io_c0_95: std_logic_vector(28 downto 0);
    signal reg_6_d_consts_opt_io_c0_95: std_logic_vector(28 downto 0);
    signal reg_next_7_d_consts_opt_io_c0_95: std_logic_vector(28 downto 0);
    signal reg_7_d_consts_opt_io_c0_95: std_logic_vector(28 downto 0);
    signal reg_next_8_d_consts_opt_io_c0_95: std_logic_vector(28 downto 0);
    signal reg_8_d_consts_opt_io_c0_95: std_logic_vector(28 downto 0);
    signal reg_next_9_d_consts_opt_io_c0_95: std_logic_vector(28 downto 0);
    signal reg_9_d_consts_opt_io_c0_95: std_logic_vector(28 downto 0);
    signal reg_next_10_d_consts_opt_io_c0_95: std_logic_vector(28 downto 0);
    signal reg_10_d_consts_opt_io_c0_95: std_logic_vector(28 downto 0);
    signal reg_next_11_d_consts_opt_io_c0_95: std_logic_vector(28 downto 0);
    signal reg_11_d_consts_opt_io_c0_95: std_logic_vector(28 downto 0);
    signal reg_next_0_l_addition_27_io_a: std_logic_vector(28 downto 0);
    signal reg_0_l_addition_27_io_a: std_logic_vector(28 downto 0);
    signal reg_next_1_l_addition_27_io_a: std_logic_vector(28 downto 0);
    signal reg_1_l_addition_27_io_a: std_logic_vector(28 downto 0);
    signal reg_next_2_l_addition_27_io_a: std_logic_vector(28 downto 0);
    signal reg_2_l_addition_27_io_a: std_logic_vector(28 downto 0);
    signal reg_next_3_l_addition_27_io_a: std_logic_vector(28 downto 0);
    signal reg_3_l_addition_27_io_a: std_logic_vector(28 downto 0);
    signal reg_next_4_l_addition_27_io_a: std_logic_vector(28 downto 0);
    signal reg_4_l_addition_27_io_a: std_logic_vector(28 downto 0);
    signal reg_next_5_l_addition_27_io_a: std_logic_vector(28 downto 0);
    signal reg_5_l_addition_27_io_a: std_logic_vector(28 downto 0);
    signal reg_next_6_l_addition_27_io_a: std_logic_vector(28 downto 0);
    signal reg_6_l_addition_27_io_a: std_logic_vector(28 downto 0);
    signal reg_next_7_l_addition_27_io_a: std_logic_vector(28 downto 0);
    signal reg_7_l_addition_27_io_a: std_logic_vector(28 downto 0);
    signal reg_next_8_l_addition_27_io_a: std_logic_vector(28 downto 0);
    signal reg_8_l_addition_27_io_a: std_logic_vector(28 downto 0);
    signal reg_next_9_l_addition_27_io_a: std_logic_vector(28 downto 0);
    signal reg_9_l_addition_27_io_a: std_logic_vector(28 downto 0);
    signal reg_next_0_l_subtraction_33_io_b: std_logic_vector(28 downto 0);
    signal reg_0_l_subtraction_33_io_b: std_logic_vector(28 downto 0);
    signal reg_next_1_l_subtraction_33_io_b: std_logic_vector(28 downto 0);
    signal reg_1_l_subtraction_33_io_b: std_logic_vector(28 downto 0);
    signal reg_next_2_l_subtraction_33_io_b: std_logic_vector(28 downto 0);
    signal reg_2_l_subtraction_33_io_b: std_logic_vector(28 downto 0);
    signal reg_next_3_l_subtraction_33_io_b: std_logic_vector(28 downto 0);
    signal reg_3_l_subtraction_33_io_b: std_logic_vector(28 downto 0);
    signal reg_next_4_l_subtraction_33_io_b: std_logic_vector(28 downto 0);
    signal reg_4_l_subtraction_33_io_b: std_logic_vector(28 downto 0);
    signal reg_next_5_l_subtraction_33_io_b: std_logic_vector(28 downto 0);
    signal reg_5_l_subtraction_33_io_b: std_logic_vector(28 downto 0);
    signal reg_next_6_l_subtraction_33_io_b: std_logic_vector(28 downto 0);
    signal reg_6_l_subtraction_33_io_b: std_logic_vector(28 downto 0);
    signal reg_next_7_l_subtraction_33_io_b: std_logic_vector(28 downto 0);
    signal reg_7_l_subtraction_33_io_b: std_logic_vector(28 downto 0);
    signal reg_next_8_l_subtraction_33_io_b: std_logic_vector(28 downto 0);
    signal reg_8_l_subtraction_33_io_b: std_logic_vector(28 downto 0);
    signal reg_next_9_l_subtraction_33_io_b: std_logic_vector(28 downto 0);
    signal reg_9_l_subtraction_33_io_b: std_logic_vector(28 downto 0);
    signal reg_next_0_l_addition_43_io_b: std_logic_vector(28 downto 0);
    signal reg_0_l_addition_43_io_b: std_logic_vector(28 downto 0);
    signal reg_next_1_l_addition_43_io_b: std_logic_vector(28 downto 0);
    signal reg_1_l_addition_43_io_b: std_logic_vector(28 downto 0);
    signal reg_next_2_l_addition_43_io_b: std_logic_vector(28 downto 0);
    signal reg_2_l_addition_43_io_b: std_logic_vector(28 downto 0);
    signal reg_next_3_l_addition_43_io_b: std_logic_vector(28 downto 0);
    signal reg_3_l_addition_43_io_b: std_logic_vector(28 downto 0);
    signal reg_next_4_l_addition_43_io_b: std_logic_vector(28 downto 0);
    signal reg_4_l_addition_43_io_b: std_logic_vector(28 downto 0);
    signal reg_next_5_l_addition_43_io_b: std_logic_vector(28 downto 0);
    signal reg_5_l_addition_43_io_b: std_logic_vector(28 downto 0);
    signal reg_next_6_l_addition_43_io_b: std_logic_vector(28 downto 0);
    signal reg_6_l_addition_43_io_b: std_logic_vector(28 downto 0);
    signal reg_next_7_l_addition_43_io_b: std_logic_vector(28 downto 0);
    signal reg_7_l_addition_43_io_b: std_logic_vector(28 downto 0);
    signal reg_next_8_l_addition_43_io_b: std_logic_vector(28 downto 0);
    signal reg_8_l_addition_43_io_b: std_logic_vector(28 downto 0);
    signal reg_next_9_l_addition_43_io_b: std_logic_vector(28 downto 0);
    signal reg_9_l_addition_43_io_b: std_logic_vector(28 downto 0);
    signal reg_next_10_l_addition_43_io_b: std_logic_vector(28 downto 0);
    signal reg_10_l_addition_43_io_b: std_logic_vector(28 downto 0);
    signal reg_next_11_l_addition_43_io_b: std_logic_vector(28 downto 0);
    signal reg_11_l_addition_43_io_b: std_logic_vector(28 downto 0);
    signal reg_next_12_l_addition_43_io_b: std_logic_vector(28 downto 0);
    signal reg_12_l_addition_43_io_b: std_logic_vector(28 downto 0);
    signal reg_next_13_l_addition_43_io_b: std_logic_vector(28 downto 0);
    signal reg_13_l_addition_43_io_b: std_logic_vector(28 downto 0);
    signal reg_next_14_l_addition_43_io_b: std_logic_vector(28 downto 0);
    signal reg_14_l_addition_43_io_b: std_logic_vector(28 downto 0);
    signal reg_next_15_l_addition_43_io_b: std_logic_vector(28 downto 0);
    signal reg_15_l_addition_43_io_b: std_logic_vector(28 downto 0);
    signal reg_next_16_l_addition_43_io_b: std_logic_vector(28 downto 0);
    signal reg_16_l_addition_43_io_b: std_logic_vector(28 downto 0);
    signal reg_next_17_l_addition_43_io_b: std_logic_vector(28 downto 0);
    signal reg_17_l_addition_43_io_b: std_logic_vector(28 downto 0);
    signal reg_next_18_l_addition_43_io_b: std_logic_vector(28 downto 0);
    signal reg_18_l_addition_43_io_b: std_logic_vector(28 downto 0);
    signal reg_next_0_l_subtraction_48_io_a: std_logic_vector(28 downto 0);
    signal reg_0_l_subtraction_48_io_a: std_logic_vector(28 downto 0);
    signal reg_next_1_l_subtraction_48_io_a: std_logic_vector(28 downto 0);
    signal reg_1_l_subtraction_48_io_a: std_logic_vector(28 downto 0);
    signal reg_next_2_l_subtraction_48_io_a: std_logic_vector(28 downto 0);
    signal reg_2_l_subtraction_48_io_a: std_logic_vector(28 downto 0);
    signal reg_next_3_l_subtraction_48_io_a: std_logic_vector(28 downto 0);
    signal reg_3_l_subtraction_48_io_a: std_logic_vector(28 downto 0);
    signal reg_next_4_l_subtraction_48_io_a: std_logic_vector(28 downto 0);
    signal reg_4_l_subtraction_48_io_a: std_logic_vector(28 downto 0);
    signal reg_next_5_l_subtraction_48_io_a: std_logic_vector(28 downto 0);
    signal reg_5_l_subtraction_48_io_a: std_logic_vector(28 downto 0);
    signal reg_next_6_l_subtraction_48_io_a: std_logic_vector(28 downto 0);
    signal reg_6_l_subtraction_48_io_a: std_logic_vector(28 downto 0);
    signal reg_next_7_l_subtraction_48_io_a: std_logic_vector(28 downto 0);
    signal reg_7_l_subtraction_48_io_a: std_logic_vector(28 downto 0);
    signal reg_next_8_l_subtraction_48_io_a: std_logic_vector(28 downto 0);
    signal reg_8_l_subtraction_48_io_a: std_logic_vector(28 downto 0);
    signal reg_next_9_l_subtraction_48_io_a: std_logic_vector(28 downto 0);
    signal reg_9_l_subtraction_48_io_a: std_logic_vector(28 downto 0);
    signal reg_next_10_l_subtraction_48_io_a: std_logic_vector(28 downto 0);
    signal reg_10_l_subtraction_48_io_a: std_logic_vector(28 downto 0);
    signal reg_next_11_l_subtraction_48_io_a: std_logic_vector(28 downto 0);
    signal reg_11_l_subtraction_48_io_a: std_logic_vector(28 downto 0);
    signal reg_next_12_l_subtraction_48_io_a: std_logic_vector(28 downto 0);
    signal reg_12_l_subtraction_48_io_a: std_logic_vector(28 downto 0);
    signal reg_next_13_l_subtraction_48_io_a: std_logic_vector(28 downto 0);
    signal reg_13_l_subtraction_48_io_a: std_logic_vector(28 downto 0);
    signal reg_next_14_l_subtraction_48_io_a: std_logic_vector(28 downto 0);
    signal reg_14_l_subtraction_48_io_a: std_logic_vector(28 downto 0);
    signal reg_next_15_l_subtraction_48_io_a: std_logic_vector(28 downto 0);
    signal reg_15_l_subtraction_48_io_a: std_logic_vector(28 downto 0);
    signal reg_next_16_l_subtraction_48_io_a: std_logic_vector(28 downto 0);
    signal reg_16_l_subtraction_48_io_a: std_logic_vector(28 downto 0);
    signal reg_next_17_l_subtraction_48_io_a: std_logic_vector(28 downto 0);
    signal reg_17_l_subtraction_48_io_a: std_logic_vector(28 downto 0);
    signal reg_next_18_l_subtraction_48_io_a: std_logic_vector(28 downto 0);
    signal reg_18_l_subtraction_48_io_a: std_logic_vector(28 downto 0);
    signal reg_next_19_l_subtraction_48_io_a: std_logic_vector(28 downto 0);
    signal reg_19_l_subtraction_48_io_a: std_logic_vector(28 downto 0);
    signal reg_next_20_l_subtraction_48_io_a: std_logic_vector(28 downto 0);
    signal reg_20_l_subtraction_48_io_a: std_logic_vector(28 downto 0);
    signal reg_next_21_l_subtraction_48_io_a: std_logic_vector(28 downto 0);
    signal reg_21_l_subtraction_48_io_a: std_logic_vector(28 downto 0);
    signal reg_next_0_l_subtraction_52_io_a: std_logic_vector(28 downto 0);
    signal reg_0_l_subtraction_52_io_a: std_logic_vector(28 downto 0);
    signal reg_next_1_l_subtraction_52_io_a: std_logic_vector(28 downto 0);
    signal reg_1_l_subtraction_52_io_a: std_logic_vector(28 downto 0);
    signal reg_next_2_l_subtraction_52_io_a: std_logic_vector(28 downto 0);
    signal reg_2_l_subtraction_52_io_a: std_logic_vector(28 downto 0);
    signal reg_next_3_l_subtraction_52_io_a: std_logic_vector(28 downto 0);
    signal reg_3_l_subtraction_52_io_a: std_logic_vector(28 downto 0);
    signal reg_next_4_l_subtraction_52_io_a: std_logic_vector(28 downto 0);
    signal reg_4_l_subtraction_52_io_a: std_logic_vector(28 downto 0);
    signal reg_next_5_l_subtraction_52_io_a: std_logic_vector(28 downto 0);
    signal reg_5_l_subtraction_52_io_a: std_logic_vector(28 downto 0);
    signal reg_next_6_l_subtraction_52_io_a: std_logic_vector(28 downto 0);
    signal reg_6_l_subtraction_52_io_a: std_logic_vector(28 downto 0);
    signal reg_next_7_l_subtraction_52_io_a: std_logic_vector(28 downto 0);
    signal reg_7_l_subtraction_52_io_a: std_logic_vector(28 downto 0);
    signal reg_next_8_l_subtraction_52_io_a: std_logic_vector(28 downto 0);
    signal reg_8_l_subtraction_52_io_a: std_logic_vector(28 downto 0);
    signal reg_next_9_l_subtraction_52_io_a: std_logic_vector(28 downto 0);
    signal reg_9_l_subtraction_52_io_a: std_logic_vector(28 downto 0);
    signal reg_next_10_l_subtraction_52_io_a: std_logic_vector(28 downto 0);
    signal reg_10_l_subtraction_52_io_a: std_logic_vector(28 downto 0);
    signal reg_next_11_l_subtraction_52_io_a: std_logic_vector(28 downto 0);
    signal reg_11_l_subtraction_52_io_a: std_logic_vector(28 downto 0);
    signal reg_next_12_l_subtraction_52_io_a: std_logic_vector(28 downto 0);
    signal reg_12_l_subtraction_52_io_a: std_logic_vector(28 downto 0);
    signal reg_next_13_l_subtraction_52_io_a: std_logic_vector(28 downto 0);
    signal reg_13_l_subtraction_52_io_a: std_logic_vector(28 downto 0);
    signal reg_next_14_l_subtraction_52_io_a: std_logic_vector(28 downto 0);
    signal reg_14_l_subtraction_52_io_a: std_logic_vector(28 downto 0);
    signal reg_next_15_l_subtraction_52_io_a: std_logic_vector(28 downto 0);
    signal reg_15_l_subtraction_52_io_a: std_logic_vector(28 downto 0);
    signal reg_next_16_l_subtraction_52_io_a: std_logic_vector(28 downto 0);
    signal reg_16_l_subtraction_52_io_a: std_logic_vector(28 downto 0);
    signal reg_next_17_l_subtraction_52_io_a: std_logic_vector(28 downto 0);
    signal reg_17_l_subtraction_52_io_a: std_logic_vector(28 downto 0);
    signal reg_next_18_l_subtraction_52_io_a: std_logic_vector(28 downto 0);
    signal reg_18_l_subtraction_52_io_a: std_logic_vector(28 downto 0);
    signal reg_next_19_l_subtraction_52_io_a: std_logic_vector(28 downto 0);
    signal reg_19_l_subtraction_52_io_a: std_logic_vector(28 downto 0);
    signal reg_next_20_l_subtraction_52_io_a: std_logic_vector(28 downto 0);
    signal reg_20_l_subtraction_52_io_a: std_logic_vector(28 downto 0);
    signal reg_next_21_l_subtraction_52_io_a: std_logic_vector(28 downto 0);
    signal reg_21_l_subtraction_52_io_a: std_logic_vector(28 downto 0);
    signal reg_next_0_l_addition_12_io_b: std_logic_vector(28 downto 0);
    signal reg_0_l_addition_12_io_b: std_logic_vector(28 downto 0);
    signal reg_next_1_l_addition_12_io_b: std_logic_vector(28 downto 0);
    signal reg_1_l_addition_12_io_b: std_logic_vector(28 downto 0);
    signal reg_next_0_l_addition_14_io_b: std_logic_vector(28 downto 0);
    signal reg_0_l_addition_14_io_b: std_logic_vector(28 downto 0);
    signal reg_next_1_l_addition_14_io_b: std_logic_vector(28 downto 0);
    signal reg_1_l_addition_14_io_b: std_logic_vector(28 downto 0);
    signal reg_next_0_d_consts_opt_io_c5_5: std_logic_vector(28 downto 0);
    signal reg_0_d_consts_opt_io_c5_5: std_logic_vector(28 downto 0);
    signal reg_next_1_d_consts_opt_io_c5_5: std_logic_vector(28 downto 0);
    signal reg_1_d_consts_opt_io_c5_5: std_logic_vector(28 downto 0);
    signal reg_next_2_d_consts_opt_io_c5_5: std_logic_vector(28 downto 0);
    signal reg_2_d_consts_opt_io_c5_5: std_logic_vector(28 downto 0);
    signal reg_next_3_d_consts_opt_io_c5_5: std_logic_vector(28 downto 0);
    signal reg_3_d_consts_opt_io_c5_5: std_logic_vector(28 downto 0);
    signal reg_next_0_d_subtraction_6_io_r: std_logic_vector(28 downto 0);
    signal reg_0_d_subtraction_6_io_r: std_logic_vector(28 downto 0);
    signal reg_next_0_d_subtraction_10_io_r: std_logic_vector(28 downto 0);
    signal reg_0_d_subtraction_10_io_r: std_logic_vector(28 downto 0);
    signal reg_next_0_d_subtraction_11_io_r: std_logic_vector(28 downto 0);
    signal reg_0_d_subtraction_11_io_r: std_logic_vector(28 downto 0);
    signal reg_next_0_l_ceil_19_io_i: std_logic_vector(28 downto 0);
    signal reg_0_l_ceil_19_io_i: std_logic_vector(28 downto 0);
    signal reg_next_0_d_addition_13_io_r: std_logic_vector(28 downto 0);
    signal reg_0_d_addition_13_io_r: std_logic_vector(28 downto 0);
    signal reg_next_0_l_ceil_21_io_i: std_logic_vector(28 downto 0);
    signal reg_0_l_ceil_21_io_i: std_logic_vector(28 downto 0);
    signal reg_next_0_d_fract_15_io_o: std_logic_vector(28 downto 0);
    signal reg_0_d_fract_15_io_o: std_logic_vector(28 downto 0);
    signal reg_next_0_d_minx1mx_16_io_o: std_logic_vector(28 downto 0);
    signal reg_0_d_minx1mx_16_io_o: std_logic_vector(28 downto 0);
    signal reg_next_0_d_fract_17_io_o: std_logic_vector(28 downto 0);
    signal reg_0_d_fract_17_io_o: std_logic_vector(28 downto 0);
    signal reg_next_0_d_minx1mx_18_io_o: std_logic_vector(28 downto 0);
    signal reg_0_d_minx1mx_18_io_o: std_logic_vector(28 downto 0);
    signal reg_next_0_d_ceil_19_io_o: std_logic_vector(28 downto 0);
    signal reg_0_d_ceil_19_io_o: std_logic_vector(28 downto 0);
    signal reg_next_0_d_ceil_21_io_o: std_logic_vector(28 downto 0);
    signal reg_0_d_ceil_21_io_o: std_logic_vector(28 downto 0);
    signal reg_next_0_d_multiplication_23_sint_mul_gen_addends_io_addend_12: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_23_sint_mul_gen_addends_io_addend_12: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_23_sint_mul_gen_addends_io_addend_13: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_23_sint_mul_gen_addends_io_addend_13: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_23_sint_mul_gen_addends_io_addend_14: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_23_sint_mul_gen_addends_io_addend_14: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_23_sint_mul_gen_addends_io_addend_15: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_23_sint_mul_gen_addends_io_addend_15: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_23_sint_mul_gen_addends_io_addend_16: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_23_sint_mul_gen_addends_io_addend_16: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_23_sint_mul_gen_addends_io_addend_17: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_23_sint_mul_gen_addends_io_addend_17: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_23_sint_mul_gen_addends_io_addend_18: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_23_sint_mul_gen_addends_io_addend_18: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_23_sint_mul_gen_addends_io_addend_19: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_23_sint_mul_gen_addends_io_addend_19: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_23_sint_mul_gen_addends_io_addend_20: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_23_sint_mul_gen_addends_io_addend_20: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_23_sint_mul_gen_addends_io_addend_21: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_23_sint_mul_gen_addends_io_addend_21: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_23_sint_mul_gen_addends_io_addend_22: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_23_sint_mul_gen_addends_io_addend_22: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_23_sint_mul_gen_addends_io_addend_23: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_23_sint_mul_gen_addends_io_addend_23: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_23_sint_mul_gen_addends_io_addend_24: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_23_sint_mul_gen_addends_io_addend_24: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_23_sint_mul_gen_addends_io_addend_25: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_23_sint_mul_gen_addends_io_addend_25: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_23_sint_mul_gen_addends_io_addend_26: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_23_sint_mul_gen_addends_io_addend_26: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_23_sint_mul_gen_addends_io_addend_27: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_23_sint_mul_gen_addends_io_addend_27: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_23_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_23_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal reg_next_1_d_multiplication_23_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal reg_1_d_multiplication_23_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal reg_next_2_d_multiplication_23_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal reg_2_d_multiplication_23_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal reg_next_3_d_multiplication_23_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal reg_3_d_multiplication_23_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_23_sint_mul_adder_6_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_23_sint_mul_adder_6_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_23_sint_mul_adder_7_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_23_sint_mul_adder_7_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_23_sint_mul_adder_8_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_23_sint_mul_adder_8_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_23_sint_mul_adder_9_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_23_sint_mul_adder_9_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_23_sint_mul_adder_16_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_23_sint_mul_adder_16_io_r: std_logic_vector(57 downto 0);
    signal reg_next_1_d_multiplication_23_sint_mul_adder_16_io_r: std_logic_vector(57 downto 0);
    signal reg_1_d_multiplication_23_sint_mul_adder_16_io_r: std_logic_vector(57 downto 0);
    signal reg_next_2_d_multiplication_23_sint_mul_adder_16_io_r: std_logic_vector(57 downto 0);
    signal reg_2_d_multiplication_23_sint_mul_adder_16_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_23_sint_mul_adder_17_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_23_sint_mul_adder_17_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_23_sint_mul_adder_18_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_23_sint_mul_adder_18_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_23_sint_mul_adder_19_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_23_sint_mul_adder_19_io_r: std_logic_vector(57 downto 0);
    signal reg_next_1_d_multiplication_23_sint_mul_adder_19_io_r: std_logic_vector(57 downto 0);
    signal reg_1_d_multiplication_23_sint_mul_adder_19_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_23_sint_mul_adder_20_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_23_sint_mul_adder_20_io_r: std_logic_vector(57 downto 0);
    signal reg_next_1_d_multiplication_23_sint_mul_adder_20_io_r: std_logic_vector(57 downto 0);
    signal reg_1_d_multiplication_23_sint_mul_adder_20_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_23_sint_mul_adder_21_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_23_sint_mul_adder_21_io_r: std_logic_vector(57 downto 0);
    signal reg_next_1_d_multiplication_23_sint_mul_adder_21_io_r: std_logic_vector(57 downto 0);
    signal reg_1_d_multiplication_23_sint_mul_adder_21_io_r: std_logic_vector(57 downto 0);
    signal reg_next_2_d_multiplication_23_sint_mul_adder_21_io_r: std_logic_vector(57 downto 0);
    signal reg_2_d_multiplication_23_sint_mul_adder_21_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_23_sint_mul_adder_24_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_23_sint_mul_adder_24_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_23_sint_mul_adder_25_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_23_sint_mul_adder_25_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_23_tc_io_o: std_logic_vector(28 downto 0);
    signal reg_0_d_multiplication_23_tc_io_o: std_logic_vector(28 downto 0);
    signal reg_next_0_d_multiplication_24_sint_mul_gen_addends_io_addend_12: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_24_sint_mul_gen_addends_io_addend_12: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_24_sint_mul_gen_addends_io_addend_13: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_24_sint_mul_gen_addends_io_addend_13: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_24_sint_mul_gen_addends_io_addend_14: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_24_sint_mul_gen_addends_io_addend_14: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_24_sint_mul_gen_addends_io_addend_15: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_24_sint_mul_gen_addends_io_addend_15: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_24_sint_mul_gen_addends_io_addend_16: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_24_sint_mul_gen_addends_io_addend_16: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_24_sint_mul_gen_addends_io_addend_17: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_24_sint_mul_gen_addends_io_addend_17: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_24_sint_mul_gen_addends_io_addend_18: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_24_sint_mul_gen_addends_io_addend_18: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_24_sint_mul_gen_addends_io_addend_19: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_24_sint_mul_gen_addends_io_addend_19: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_24_sint_mul_gen_addends_io_addend_20: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_24_sint_mul_gen_addends_io_addend_20: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_24_sint_mul_gen_addends_io_addend_21: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_24_sint_mul_gen_addends_io_addend_21: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_24_sint_mul_gen_addends_io_addend_22: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_24_sint_mul_gen_addends_io_addend_22: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_24_sint_mul_gen_addends_io_addend_23: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_24_sint_mul_gen_addends_io_addend_23: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_24_sint_mul_gen_addends_io_addend_24: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_24_sint_mul_gen_addends_io_addend_24: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_24_sint_mul_gen_addends_io_addend_25: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_24_sint_mul_gen_addends_io_addend_25: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_24_sint_mul_gen_addends_io_addend_26: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_24_sint_mul_gen_addends_io_addend_26: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_24_sint_mul_gen_addends_io_addend_27: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_24_sint_mul_gen_addends_io_addend_27: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_24_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_24_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal reg_next_1_d_multiplication_24_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal reg_1_d_multiplication_24_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal reg_next_2_d_multiplication_24_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal reg_2_d_multiplication_24_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal reg_next_3_d_multiplication_24_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal reg_3_d_multiplication_24_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_24_sint_mul_adder_6_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_24_sint_mul_adder_6_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_24_sint_mul_adder_7_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_24_sint_mul_adder_7_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_24_sint_mul_adder_8_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_24_sint_mul_adder_8_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_24_sint_mul_adder_9_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_24_sint_mul_adder_9_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_24_sint_mul_adder_16_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_24_sint_mul_adder_16_io_r: std_logic_vector(57 downto 0);
    signal reg_next_1_d_multiplication_24_sint_mul_adder_16_io_r: std_logic_vector(57 downto 0);
    signal reg_1_d_multiplication_24_sint_mul_adder_16_io_r: std_logic_vector(57 downto 0);
    signal reg_next_2_d_multiplication_24_sint_mul_adder_16_io_r: std_logic_vector(57 downto 0);
    signal reg_2_d_multiplication_24_sint_mul_adder_16_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_24_sint_mul_adder_17_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_24_sint_mul_adder_17_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_24_sint_mul_adder_18_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_24_sint_mul_adder_18_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_24_sint_mul_adder_19_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_24_sint_mul_adder_19_io_r: std_logic_vector(57 downto 0);
    signal reg_next_1_d_multiplication_24_sint_mul_adder_19_io_r: std_logic_vector(57 downto 0);
    signal reg_1_d_multiplication_24_sint_mul_adder_19_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_24_sint_mul_adder_20_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_24_sint_mul_adder_20_io_r: std_logic_vector(57 downto 0);
    signal reg_next_1_d_multiplication_24_sint_mul_adder_20_io_r: std_logic_vector(57 downto 0);
    signal reg_1_d_multiplication_24_sint_mul_adder_20_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_24_sint_mul_adder_21_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_24_sint_mul_adder_21_io_r: std_logic_vector(57 downto 0);
    signal reg_next_1_d_multiplication_24_sint_mul_adder_21_io_r: std_logic_vector(57 downto 0);
    signal reg_1_d_multiplication_24_sint_mul_adder_21_io_r: std_logic_vector(57 downto 0);
    signal reg_next_2_d_multiplication_24_sint_mul_adder_21_io_r: std_logic_vector(57 downto 0);
    signal reg_2_d_multiplication_24_sint_mul_adder_21_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_24_sint_mul_adder_24_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_24_sint_mul_adder_24_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_24_sint_mul_adder_25_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_24_sint_mul_adder_25_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_24_tc_io_o: std_logic_vector(28 downto 0);
    signal reg_0_d_multiplication_24_tc_io_o: std_logic_vector(28 downto 0);
    signal reg_next_0_d_arith_shifter_26_io_o: std_logic_vector(28 downto 0);
    signal reg_0_d_arith_shifter_26_io_o: std_logic_vector(28 downto 0);
    signal reg_next_0_d_subtraction_33_io_r: std_logic_vector(28 downto 0);
    signal reg_0_d_subtraction_33_io_r: std_logic_vector(28 downto 0);
    signal reg_next_0_d_fract_36_io_o: std_logic_vector(28 downto 0);
    signal reg_0_d_fract_36_io_o: std_logic_vector(28 downto 0);
    signal reg_next_1_d_fract_36_io_o: std_logic_vector(28 downto 0);
    signal reg_1_d_fract_36_io_o: std_logic_vector(28 downto 0);
    signal reg_next_2_d_fract_36_io_o: std_logic_vector(28 downto 0);
    signal reg_2_d_fract_36_io_o: std_logic_vector(28 downto 0);
    signal reg_next_3_d_fract_36_io_o: std_logic_vector(28 downto 0);
    signal reg_3_d_fract_36_io_o: std_logic_vector(28 downto 0);
    signal reg_next_4_d_fract_36_io_o: std_logic_vector(28 downto 0);
    signal reg_4_d_fract_36_io_o: std_logic_vector(28 downto 0);
    signal reg_next_5_d_fract_36_io_o: std_logic_vector(28 downto 0);
    signal reg_5_d_fract_36_io_o: std_logic_vector(28 downto 0);
    signal reg_next_6_d_fract_36_io_o: std_logic_vector(28 downto 0);
    signal reg_6_d_fract_36_io_o: std_logic_vector(28 downto 0);
    signal reg_next_0_d_mux_calc_io_o: std_logic_vector(28 downto 0);
    signal reg_0_d_mux_calc_io_o: std_logic_vector(28 downto 0);
    signal reg_next_0_d_multiplication_37_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_37_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_37_sint_mul_adder_4_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_37_sint_mul_adder_4_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_37_sint_mul_adder_5_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_37_sint_mul_adder_5_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_37_sint_mul_adder_14_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_37_sint_mul_adder_14_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_37_sint_mul_adder_15_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_37_sint_mul_adder_15_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_37_sint_mul_adder_17_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_37_sint_mul_adder_17_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_37_sint_mul_adder_25_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_37_sint_mul_adder_25_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_37_tc_io_o: std_logic_vector(28 downto 0);
    signal reg_0_d_multiplication_37_tc_io_o: std_logic_vector(28 downto 0);
    signal reg_next_1_d_multiplication_37_tc_io_o: std_logic_vector(28 downto 0);
    signal reg_1_d_multiplication_37_tc_io_o: std_logic_vector(28 downto 0);
    signal reg_next_2_d_multiplication_37_tc_io_o: std_logic_vector(28 downto 0);
    signal reg_2_d_multiplication_37_tc_io_o: std_logic_vector(28 downto 0);
    signal reg_next_3_d_multiplication_37_tc_io_o: std_logic_vector(28 downto 0);
    signal reg_3_d_multiplication_37_tc_io_o: std_logic_vector(28 downto 0);
    signal reg_next_0_d_multiplication_38_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_38_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal reg_next_1_d_multiplication_38_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal reg_1_d_multiplication_38_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal reg_next_2_d_multiplication_38_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal reg_2_d_multiplication_38_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal reg_next_3_d_multiplication_38_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal reg_3_d_multiplication_38_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal reg_next_4_d_multiplication_38_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal reg_4_d_multiplication_38_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_38_sint_mul_adder_0_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_38_sint_mul_adder_0_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_38_sint_mul_adder_1_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_38_sint_mul_adder_1_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_38_sint_mul_adder_2_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_38_sint_mul_adder_2_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_38_sint_mul_adder_3_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_38_sint_mul_adder_3_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_38_sint_mul_adder_4_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_38_sint_mul_adder_4_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_38_sint_mul_adder_5_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_38_sint_mul_adder_5_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_38_sint_mul_adder_6_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_38_sint_mul_adder_6_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_38_sint_mul_adder_7_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_38_sint_mul_adder_7_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_38_sint_mul_adder_12_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_38_sint_mul_adder_12_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_38_sint_mul_adder_13_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_38_sint_mul_adder_13_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_38_sint_mul_adder_14_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_38_sint_mul_adder_14_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_38_sint_mul_adder_15_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_38_sint_mul_adder_15_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_38_sint_mul_adder_16_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_38_sint_mul_adder_16_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_38_sint_mul_adder_17_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_38_sint_mul_adder_17_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_38_sint_mul_adder_18_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_38_sint_mul_adder_18_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_38_sint_mul_adder_19_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_38_sint_mul_adder_19_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_38_sint_mul_adder_20_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_38_sint_mul_adder_20_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_38_sint_mul_adder_21_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_38_sint_mul_adder_21_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_38_sint_mul_adder_22_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_38_sint_mul_adder_22_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_38_sint_mul_adder_23_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_38_sint_mul_adder_23_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_38_sint_mul_adder_24_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_38_sint_mul_adder_24_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_38_sint_mul_adder_25_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_38_sint_mul_adder_25_io_r: std_logic_vector(57 downto 0);
    signal reg_next_1_d_multiplication_38_sint_mul_adder_25_io_r: std_logic_vector(57 downto 0);
    signal reg_1_d_multiplication_38_sint_mul_adder_25_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_38_sint_mul_adder_26_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_38_sint_mul_adder_26_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_38_tc_io_o: std_logic_vector(28 downto 0);
    signal reg_0_d_multiplication_38_tc_io_o: std_logic_vector(28 downto 0);
    signal reg_next_0_d_arith_shifter_40_io_o: std_logic_vector(28 downto 0);
    signal reg_0_d_arith_shifter_40_io_o: std_logic_vector(28 downto 0);
    signal reg_next_0_d_arith_shifter_41_io_o: std_logic_vector(28 downto 0);
    signal reg_0_d_arith_shifter_41_io_o: std_logic_vector(28 downto 0);
    signal reg_next_0_d_addition_42_io_r: std_logic_vector(28 downto 0);
    signal reg_0_d_addition_42_io_r: std_logic_vector(28 downto 0);
    signal reg_next_0_d_addition_43_io_r: std_logic_vector(28 downto 0);
    signal reg_0_d_addition_43_io_r: std_logic_vector(28 downto 0);
    signal reg_next_0_d_clamp01_44_io_o: std_logic_vector(28 downto 0);
    signal reg_0_d_clamp01_44_io_o: std_logic_vector(28 downto 0);
    signal reg_next_0_d_multiplication_45_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_45_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal reg_next_1_d_multiplication_45_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal reg_1_d_multiplication_45_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal reg_next_2_d_multiplication_45_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal reg_2_d_multiplication_45_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal reg_next_3_d_multiplication_45_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal reg_3_d_multiplication_45_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal reg_next_4_d_multiplication_45_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal reg_4_d_multiplication_45_sint_mul_gen_addends_io_subend: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_45_sint_mul_adder_4_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_45_sint_mul_adder_4_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_45_sint_mul_adder_5_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_45_sint_mul_adder_5_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_45_sint_mul_adder_6_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_45_sint_mul_adder_6_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_45_sint_mul_adder_7_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_45_sint_mul_adder_7_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_45_sint_mul_adder_8_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_45_sint_mul_adder_8_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_45_sint_mul_adder_9_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_45_sint_mul_adder_9_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_45_sint_mul_adder_10_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_45_sint_mul_adder_10_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_45_sint_mul_adder_11_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_45_sint_mul_adder_11_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_45_sint_mul_adder_12_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_45_sint_mul_adder_12_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_45_sint_mul_adder_13_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_45_sint_mul_adder_13_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_45_sint_mul_adder_16_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_45_sint_mul_adder_16_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_45_sint_mul_adder_17_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_45_sint_mul_adder_17_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_45_sint_mul_adder_18_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_45_sint_mul_adder_18_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_45_sint_mul_adder_19_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_45_sint_mul_adder_19_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_45_sint_mul_adder_20_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_45_sint_mul_adder_20_io_r: std_logic_vector(57 downto 0);
    signal reg_next_1_d_multiplication_45_sint_mul_adder_20_io_r: std_logic_vector(57 downto 0);
    signal reg_1_d_multiplication_45_sint_mul_adder_20_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_45_sint_mul_adder_21_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_45_sint_mul_adder_21_io_r: std_logic_vector(57 downto 0);
    signal reg_next_1_d_multiplication_45_sint_mul_adder_21_io_r: std_logic_vector(57 downto 0);
    signal reg_1_d_multiplication_45_sint_mul_adder_21_io_r: std_logic_vector(57 downto 0);
    signal reg_next_2_d_multiplication_45_sint_mul_adder_21_io_r: std_logic_vector(57 downto 0);
    signal reg_2_d_multiplication_45_sint_mul_adder_21_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_45_sint_mul_adder_22_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_45_sint_mul_adder_22_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_45_sint_mul_adder_23_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_45_sint_mul_adder_23_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_45_sint_mul_adder_24_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_45_sint_mul_adder_24_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_45_sint_mul_adder_25_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_45_sint_mul_adder_25_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_45_sint_mul_adder_26_io_r: std_logic_vector(57 downto 0);
    signal reg_0_d_multiplication_45_sint_mul_adder_26_io_r: std_logic_vector(57 downto 0);
    signal reg_next_0_d_multiplication_45_tc_io_o: std_logic_vector(28 downto 0);
    signal reg_0_d_multiplication_45_tc_io_o: std_logic_vector(28 downto 0);
    signal reg_next_1_d_multiplication_45_tc_io_o: std_logic_vector(28 downto 0);
    signal reg_1_d_multiplication_45_tc_io_o: std_logic_vector(28 downto 0);
    signal reg_next_2_d_multiplication_45_tc_io_o: std_logic_vector(28 downto 0);
    signal reg_2_d_multiplication_45_tc_io_o: std_logic_vector(28 downto 0);
    signal reg_next_3_d_multiplication_45_tc_io_o: std_logic_vector(28 downto 0);
    signal reg_3_d_multiplication_45_tc_io_o: std_logic_vector(28 downto 0);
    signal reg_next_4_d_multiplication_45_tc_io_o: std_logic_vector(28 downto 0);
    signal reg_4_d_multiplication_45_tc_io_o: std_logic_vector(28 downto 0);
    signal reg_next_5_d_multiplication_45_tc_io_o: std_logic_vector(28 downto 0);
    signal reg_5_d_multiplication_45_tc_io_o: std_logic_vector(28 downto 0);
    signal reg_next_0_d_arith_shifter_47_io_o: std_logic_vector(28 downto 0);
    signal reg_0_d_arith_shifter_47_io_o: std_logic_vector(28 downto 0);
    signal reg_next_0_d_subtraction_48_io_r: std_logic_vector(28 downto 0);
    signal reg_0_d_subtraction_48_io_r: std_logic_vector(28 downto 0);
    signal reg_next_0_d_arith_shifter_51_io_o: std_logic_vector(28 downto 0);
    signal reg_0_d_arith_shifter_51_io_o: std_logic_vector(28 downto 0);
    signal reg_next_0_d_subtraction_52_io_r: std_logic_vector(28 downto 0);
    signal reg_0_d_subtraction_52_io_r: std_logic_vector(28 downto 0);
    signal reg_next_0_d_to8bit_cvt_55_io_o: std_logic_vector(7 downto 0);
    signal reg_0_d_to8bit_cvt_55_io_o: std_logic_vector(7 downto 0);
    signal reg_next_1_d_to8bit_cvt_55_io_o: std_logic_vector(7 downto 0);
    signal reg_1_d_to8bit_cvt_55_io_o: std_logic_vector(7 downto 0);
    signal reg_next_2_d_to8bit_cvt_55_io_o: std_logic_vector(7 downto 0);
    signal reg_2_d_to8bit_cvt_55_io_o: std_logic_vector(7 downto 0);
    signal reg_next_3_d_to8bit_cvt_55_io_o: std_logic_vector(7 downto 0);
    signal reg_3_d_to8bit_cvt_55_io_o: std_logic_vector(7 downto 0);
    signal reg_next_4_d_to8bit_cvt_55_io_o: std_logic_vector(7 downto 0);
    signal reg_4_d_to8bit_cvt_55_io_o: std_logic_vector(7 downto 0);
    signal reg_next_5_d_to8bit_cvt_55_io_o: std_logic_vector(7 downto 0);
    signal reg_5_d_to8bit_cvt_55_io_o: std_logic_vector(7 downto 0);
    signal reg_next_6_d_to8bit_cvt_55_io_o: std_logic_vector(7 downto 0);
    signal reg_6_d_to8bit_cvt_55_io_o: std_logic_vector(7 downto 0);
    signal reg_next_7_d_to8bit_cvt_55_io_o: std_logic_vector(7 downto 0);
    signal reg_7_d_to8bit_cvt_55_io_o: std_logic_vector(7 downto 0);
    signal reg_next_8_d_to8bit_cvt_55_io_o: std_logic_vector(7 downto 0);
    signal reg_8_d_to8bit_cvt_55_io_o: std_logic_vector(7 downto 0);
    signal reg_next_9_d_to8bit_cvt_55_io_o: std_logic_vector(7 downto 0);
    signal reg_9_d_to8bit_cvt_55_io_o: std_logic_vector(7 downto 0);
    signal reg_next_10_d_to8bit_cvt_55_io_o: std_logic_vector(7 downto 0);
    signal reg_10_d_to8bit_cvt_55_io_o: std_logic_vector(7 downto 0);
    signal reg_next_11_d_to8bit_cvt_55_io_o: std_logic_vector(7 downto 0);
    signal reg_11_d_to8bit_cvt_55_io_o: std_logic_vector(7 downto 0);
    signal reg_next_12_d_to8bit_cvt_55_io_o: std_logic_vector(7 downto 0);
    signal reg_12_d_to8bit_cvt_55_io_o: std_logic_vector(7 downto 0);
    signal reg_next_13_d_to8bit_cvt_55_io_o: std_logic_vector(7 downto 0);
    signal reg_13_d_to8bit_cvt_55_io_o: std_logic_vector(7 downto 0);
    signal reg_next_14_d_to8bit_cvt_55_io_o: std_logic_vector(7 downto 0);
    signal reg_14_d_to8bit_cvt_55_io_o: std_logic_vector(7 downto 0);
    signal reg_next_15_d_to8bit_cvt_55_io_o: std_logic_vector(7 downto 0);
    signal reg_15_d_to8bit_cvt_55_io_o: std_logic_vector(7 downto 0);
    signal reg_next_16_d_to8bit_cvt_55_io_o: std_logic_vector(7 downto 0);
    signal reg_16_d_to8bit_cvt_55_io_o: std_logic_vector(7 downto 0);
    signal reg_next_17_d_to8bit_cvt_55_io_o: std_logic_vector(7 downto 0);
    signal reg_17_d_to8bit_cvt_55_io_o: std_logic_vector(7 downto 0);
    signal reg_next_18_d_to8bit_cvt_55_io_o: std_logic_vector(7 downto 0);
    signal reg_18_d_to8bit_cvt_55_io_o: std_logic_vector(7 downto 0);
    signal reg_next_19_d_to8bit_cvt_55_io_o: std_logic_vector(7 downto 0);
    signal reg_19_d_to8bit_cvt_55_io_o: std_logic_vector(7 downto 0);
    signal reg_next_20_d_to8bit_cvt_55_io_o: std_logic_vector(7 downto 0);
    signal reg_20_d_to8bit_cvt_55_io_o: std_logic_vector(7 downto 0);
    signal reg_next_21_d_to8bit_cvt_55_io_o: std_logic_vector(7 downto 0);
    signal reg_21_d_to8bit_cvt_55_io_o: std_logic_vector(7 downto 0);
    signal reg_next_22_d_to8bit_cvt_55_io_o: std_logic_vector(7 downto 0);
    signal reg_22_d_to8bit_cvt_55_io_o: std_logic_vector(7 downto 0);
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
    signal in_ready_buffer: std_logic_vector(0 downto 0);
    signal in_ready_and_in_valid: std_logic_vector(0 downto 0);
begin
    process (clock, reset) is
    begin
        if reset = '1' then
            reg_0_d_multiplication_23_sint_mul_gen_addends_io_addend_12 <= (others => '0');
            reg_0_d_addition_13_io_r <= (others => '0');
            reg_9_valid_chain <= (others => '0');
            reg_0_d_multiplication_45_sint_mul_adder_13_io_r <= (others => '0');
            reg_0_d_multiplication_24_sint_mul_adder_19_io_r <= (others => '0');
            reg_4_d_fract_36_io_o <= (others => '0');
            reg_20_valid_chain <= (others => '0');
            reg_0_d_multiplication_23_sint_mul_gen_addends_io_addend_13 <= (others => '0');
            reg_15_l_addition_43_io_b <= (others => '0');
            reg_2_valid_chain <= (others => '0');
            reg_0_d_frag_y <= (others => '0');
            reg_21_valid_chain <= (others => '0');
            reg_1_valid_chain <= (others => '0');
            reg_22_valid_chain <= (others => '0');
            reg_5_d_consts_opt_io_c0_1 <= (others => '0');
            reg_7_valid_chain <= (others => '0');
            reg_0_d_multiplication_37_sint_mul_adder_5_io_r <= (others => '0');
            reg_2_d_multiplication_45_sint_mul_gen_addends_io_subend <= (others => '0');
            reg_12_valid_chain <= (others => '0');
            reg_0_d_multiplication_24_sint_mul_gen_addends_io_addend_18 <= (others => '0');
            reg_0_d_multiplication_24_sint_mul_gen_addends_io_addend_17 <= (others => '0');
            reg_6_l_subtraction_52_io_a <= (others => '0');
            reg_0_d_multiplication_23_sint_mul_adder_25_io_r <= (others => '0');
            reg_0_d_subtraction_10_io_r <= (others => '0');
            reg_0_d_fract_15_io_o <= (others => '0');
            reg_0_d_multiplication_45_sint_mul_gen_addends_io_subend <= (others => '0');
            reg_8_l_addition_43_io_b <= (others => '0');
            reg_0_d_arith_shifter_40_io_o <= (others => '0');
            reg_1_l_addition_27_io_a <= (others => '0');
            reg_15_l_subtraction_48_io_a <= (others => '0');
            reg_5_l_addition_43_io_b <= (others => '0');
            reg_1_d_multiplication_24_sint_mul_gen_addends_io_subend <= (others => '0');
            reg_5_valid_chain <= (others => '0');
            reg_17_valid_chain <= (others => '0');
            reg_6_l_subtraction_48_io_a <= (others => '0');
            reg_8_d_consts_opt_io_c0_95 <= (others => '0');
            reg_0_d_multiplication_23_sint_mul_gen_addends_io_addend_14 <= (others => '0');
            reg_6_d_fract_36_io_o <= (others => '0');
            reg_3_d_itime_convertor_0_io_o <= (others => '0');
            reg_12_l_addition_43_io_b <= (others => '0');
            reg_0_d_multiplication_24_sint_mul_adder_17_io_r <= (others => '0');
            reg_1_d_consts_opt_io_c0_95 <= (others => '0');
            reg_1_d_fract_36_io_o <= (others => '0');
            reg_3_d_to8bit_cvt_55_io_o <= (others => '0');
            reg_0_d_multiplication_24_sint_mul_gen_addends_io_addend_19 <= (others => '0');
            reg_0_d_multiplication_37_sint_mul_adder_25_io_r <= (others => '0');
            reg_1_l_subtraction_52_io_a <= (others => '0');
            reg_13_l_subtraction_52_io_a <= (others => '0');
            reg_0_d_multiplication_38_sint_mul_adder_13_io_r <= (others => '0');
            reg_0_d_multiplication_45_sint_mul_adder_24_io_r <= (others => '0');
            reg_1_d_multiplication_45_sint_mul_adder_21_io_r <= (others => '0');
            reg_2_l_subtraction_48_io_a <= (others => '0');
            reg_8_l_subtraction_52_io_a <= (others => '0');
            reg_0_d_multiplication_45_sint_mul_adder_6_io_r <= (others => '0');
            reg_0_d_ceil_19_io_o <= (others => '0');
            reg_0_d_arith_shifter_47_io_o <= (others => '0');
            reg_2_d_multiplication_23_sint_mul_adder_21_io_r <= (others => '0');
            reg_0_d_multiplication_38_sint_mul_gen_addends_io_subend <= (others => '0');
            reg_1_d_multiplication_45_tc_io_o <= (others => '0');
            reg_1_l_subtraction_48_io_a <= (others => '0');
            reg_0_d_multiplication_45_sint_mul_adder_9_io_r <= (others => '0');
            reg_20_l_subtraction_52_io_a <= (others => '0');
            reg_18_l_addition_43_io_b <= (others => '0');
            reg_5_l_subtraction_48_io_a <= (others => '0');
            reg_0_d_itime_convertor_0_io_o <= (others => '0');
            reg_1_d_multiplication_24_sint_mul_adder_21_io_r <= (others => '0');
            reg_0_d_multiplication_38_sint_mul_adder_16_io_r <= (others => '0');
            reg_0_d_multiplication_24_sint_mul_gen_addends_io_addend_24 <= (others => '0');
            reg_6_l_addition_43_io_b <= (others => '0');
            reg_11_d_to8bit_cvt_55_io_o <= (others => '0');
            reg_9_l_addition_27_io_a <= (others => '0');
            reg_1_d_itime_convertor_0_io_o <= (others => '0');
            reg_0_d_subtraction_11_io_r <= (others => '0');
            reg_0_d_multiplication_45_sint_mul_adder_26_io_r <= (others => '0');
            reg_6_d_to8bit_cvt_55_io_o <= (others => '0');
            reg_9_d_itime_convertor_0_io_o <= (others => '0');
            reg_0_d_multiplication_38_sint_mul_adder_4_io_r <= (others => '0');
            reg_6_d_consts_opt_io_c0_95 <= (others => '0');
            reg_0_d_multiplication_45_sint_mul_adder_17_io_r <= (others => '0');
            reg_19_valid_chain <= (others => '0');
            reg_8_d_itime_convertor_0_io_o <= (others => '0');
            reg_0_d_addition_43_io_r <= (others => '0');
            reg_0_d_multiplication_23_sint_mul_gen_addends_io_addend_17 <= (others => '0');
            reg_1_d_to8bit_cvt_55_io_o <= (others => '0');
            reg_20_d_to8bit_cvt_55_io_o <= (others => '0');
            reg_0_d_subtraction_6_io_r <= (others => '0');
            reg_0_d_multiplication_24_sint_mul_adder_25_io_r <= (others => '0');
            reg_0_d_multiplication_24_sint_mul_adder_18_io_r <= (others => '0');
            reg_0_d_consts_opt_io_c0_95 <= (others => '0');
            reg_4_l_addition_27_io_a <= (others => '0');
            reg_0_d_multiplication_23_sint_mul_adder_18_io_r <= (others => '0');
            reg_8_d_consts_opt_io_c0_1 <= (others => '0');
            reg_7_d_consts_opt_io_c0_95 <= (others => '0');
            reg_2_d_multiplication_38_sint_mul_gen_addends_io_subend <= (others => '0');
            reg_2_d_consts_opt_io_c0_1 <= (others => '0');
            reg_19_l_subtraction_52_io_a <= (others => '0');
            reg_0_d_multiplication_38_sint_mul_adder_18_io_r <= (others => '0');
            reg_6_l_subtraction_33_io_b <= (others => '0');
            reg_4_d_multiplication_45_tc_io_o <= (others => '0');
            reg_0_d_multiplication_37_sint_mul_adder_4_io_r <= (others => '0');
            reg_3_d_multiplication_23_sint_mul_gen_addends_io_subend <= (others => '0');
            reg_5_l_addition_27_io_a <= (others => '0');
            reg_7_d_itime_convertor_0_io_o <= (others => '0');
            reg_0_d_multiplication_38_sint_mul_adder_25_io_r <= (others => '0');
            reg_1_d_multiplication_23_sint_mul_adder_21_io_r <= (others => '0');
            reg_0_d_multiplication_38_sint_mul_adder_2_io_r <= (others => '0');
            reg_0_d_addition_42_io_r <= (others => '0');
            reg_0_d_multiplication_24_sint_mul_gen_addends_io_addend_16 <= (others => '0');
            reg_0_d_to8bit_cvt_55_io_o <= (others => '0');
            reg_0_d_multiplication_23_sint_mul_adder_7_io_r <= (others => '0');
            reg_0_l_addition_12_io_b <= (others => '0');
            reg_0_d_multiplication_37_sint_mul_adder_14_io_r <= (others => '0');
            reg_8_valid_chain <= (others => '0');
            reg_5_d_consts_opt_io_c0_95 <= (others => '0');
            reg_6_d_consts_opt_io_c0_1 <= (others => '0');
            reg_6_l_addition_27_io_a <= (others => '0');
            reg_12_d_to8bit_cvt_55_io_o <= (others => '0');
            reg_7_l_subtraction_48_io_a <= (others => '0');
            reg_0_d_multiplication_38_sint_mul_adder_15_io_r <= (others => '0');
            reg_0_d_multiplication_38_sint_mul_adder_7_io_r <= (others => '0');
            reg_1_d_multiplication_24_sint_mul_adder_20_io_r <= (others => '0');
            reg_0_d_multiplication_37_sint_mul_adder_17_io_r <= (others => '0');
            reg_0_d_multiplication_38_sint_mul_adder_26_io_r <= (others => '0');
            reg_2_d_multiplication_24_sint_mul_adder_21_io_r <= (others => '0');
            reg_3_d_consts_opt_io_c0_95 <= (others => '0');
            reg_0_d_arith_shifter_41_io_o <= (others => '0');
            reg_0_d_multiplication_37_sint_mul_gen_addends_io_subend <= (others => '0');
            reg_0_d_multiplication_45_tc_io_o <= (others => '0');
            reg_0_l_addition_27_io_a <= (others => '0');
            reg_2_d_consts_opt_io_c5_5 <= (others => '0');
            reg_0_d_multiplication_24_sint_mul_adder_6_io_r <= (others => '0');
            reg_2_d_to8bit_cvt_55_io_o <= (others => '0');
            reg_14_l_subtraction_48_io_a <= (others => '0');
            reg_0_d_multiplication_45_sint_mul_adder_20_io_r <= (others => '0');
            reg_9_l_subtraction_33_io_b <= (others => '0');
            reg_0_l_addition_43_io_b <= (others => '0');
            reg_19_d_to8bit_cvt_55_io_o <= (others => '0');
            reg_9_l_subtraction_52_io_a <= (others => '0');
            reg_0_d_multiplication_23_sint_mul_adder_9_io_r <= (others => '0');
            reg_4_l_subtraction_33_io_b <= (others => '0');
            reg_0_d_multiplication_24_sint_mul_gen_addends_io_addend_14 <= (others => '0');
            reg_1_d_multiplication_37_tc_io_o <= (others => '0');
            reg_0_l_subtraction_33_io_b <= (others => '0');
            reg_14_l_addition_43_io_b <= (others => '0');
            reg_11_l_subtraction_52_io_a <= (others => '0');
            reg_1_d_consts_opt_io_c5_5 <= (others => '0');
            reg_0_l_ceil_19_io_i <= (others => '0');
            reg_0_d_multiplication_38_tc_io_o <= (others => '0');
            reg_10_l_subtraction_52_io_a <= (others => '0');
            reg_0_d_multiplication_23_sint_mul_adder_6_io_r <= (others => '0');
            reg_3_l_subtraction_48_io_a <= (others => '0');
            reg_21_l_subtraction_48_io_a <= (others => '0');
            reg_0_d_multiplication_23_sint_mul_adder_20_io_r <= (others => '0');
            reg_11_l_subtraction_48_io_a <= (others => '0');
            reg_13_valid_chain <= (others => '0');
            reg_4_d_multiplication_45_sint_mul_gen_addends_io_subend <= (others => '0');
            reg_1_d_consts_opt_io_c0_1 <= (others => '0');
            reg_14_l_subtraction_52_io_a <= (others => '0');
            reg_1_d_multiplication_23_sint_mul_adder_20_io_r <= (others => '0');
            reg_0_d_multiplication_38_sint_mul_adder_19_io_r <= (others => '0');
            reg_2_l_subtraction_33_io_b <= (others => '0');
            reg_11_valid_chain <= (others => '0');
            reg_3_d_multiplication_38_sint_mul_gen_addends_io_subend <= (others => '0');
            reg_3_d_multiplication_37_tc_io_o <= (others => '0');
            reg_0_d_multiplication_24_sint_mul_adder_20_io_r <= (others => '0');
            reg_9_d_consts_opt_io_c0_95 <= (others => '0');
            reg_16_l_subtraction_52_io_a <= (others => '0');
            reg_4_d_consts_opt_io_c0_1 <= (others => '0');
            reg_0_d_multiplication_24_sint_mul_adder_7_io_r <= (others => '0');
            reg_0_d_multiplication_23_sint_mul_gen_addends_io_addend_20 <= (others => '0');
            reg_6_d_itime_convertor_0_io_o <= (others => '0');
            reg_21_d_to8bit_cvt_55_io_o <= (others => '0');
            reg_9_l_subtraction_48_io_a <= (others => '0');
            reg_4_l_addition_43_io_b <= (others => '0');
            reg_0_d_multiplication_45_sint_mul_adder_18_io_r <= (others => '0');
            reg_0_d_multiplication_24_sint_mul_adder_8_io_r <= (others => '0');
            reg_0_l_subtraction_48_io_a <= (others => '0');
            reg_0_d_multiplication_24_sint_mul_adder_24_io_r <= (others => '0');
            reg_5_l_subtraction_52_io_a <= (others => '0');
            reg_2_d_fract_36_io_o <= (others => '0');
            reg_0_d_multiplication_37_tc_io_o <= (others => '0');
            reg_17_l_addition_43_io_b <= (others => '0');
            reg_0_d_multiplication_24_sint_mul_adder_21_io_r <= (others => '0');
            reg_0_d_multiplication_24_sint_mul_gen_addends_io_addend_12 <= (others => '0');
            reg_0_d_ceil_21_io_o <= (others => '0');
            reg_0_d_multiplication_24_sint_mul_gen_addends_io_addend_13 <= (others => '0');
            reg_0_d_multiplication_24_sint_mul_gen_addends_io_addend_25 <= (others => '0');
            reg_3_valid_chain <= (others => '0');
            reg_0_d_subtraction_48_io_r <= (others => '0');
            reg_1_d_multiplication_23_sint_mul_adder_16_io_r <= (others => '0');
            reg_0_d_multiplication_24_sint_mul_adder_9_io_r <= (others => '0');
            reg_2_l_addition_43_io_b <= (others => '0');
            reg_16_d_to8bit_cvt_55_io_o <= (others => '0');
            reg_6_valid_chain <= (others => '0');
            reg_0_d_multiplication_45_sint_mul_adder_5_io_r <= (others => '0');
            reg_0_d_multiplication_24_sint_mul_gen_addends_io_addend_21 <= (others => '0');
            reg_11_l_addition_43_io_b <= (others => '0');
            reg_4_l_subtraction_48_io_a <= (others => '0');
            reg_13_l_addition_43_io_b <= (others => '0');
            reg_2_l_subtraction_52_io_a <= (others => '0');
            reg_0_d_multiplication_23_sint_mul_adder_19_io_r <= (others => '0');
            reg_0_d_fract_36_io_o <= (others => '0');
            reg_2_d_multiplication_45_tc_io_o <= (others => '0');
            reg_18_d_to8bit_cvt_55_io_o <= (others => '0');
            reg_0_d_multiplication_24_sint_mul_gen_addends_io_addend_22 <= (others => '0');
            reg_17_l_subtraction_48_io_a <= (others => '0');
            reg_15_l_subtraction_52_io_a <= (others => '0');
            reg_5_d_itime_convertor_0_io_o <= (others => '0');
            reg_0_d_itime_us <= (others => '0');
            reg_1_l_addition_43_io_b <= (others => '0');
            reg_0_d_multiplication_23_sint_mul_gen_addends_io_addend_27 <= (others => '0');
            reg_0_d_multiplication_24_sint_mul_adder_16_io_r <= (others => '0');
            reg_7_l_subtraction_52_io_a <= (others => '0');
            reg_0_d_multiplication_45_sint_mul_adder_25_io_r <= (others => '0');
            reg_18_l_subtraction_52_io_a <= (others => '0');
            reg_5_d_multiplication_45_tc_io_o <= (others => '0');
            reg_21_l_subtraction_52_io_a <= (others => '0');
            reg_0_d_multiplication_45_sint_mul_adder_23_io_r <= (others => '0');
            reg_16_valid_chain <= (others => '0');
            reg_3_d_multiplication_45_sint_mul_gen_addends_io_subend <= (others => '0');
            reg_12_l_subtraction_52_io_a <= (others => '0');
            reg_0_d_subtraction_33_io_r <= (others => '0');
            reg_3_l_addition_43_io_b <= (others => '0');
            reg_0_d_multiplication_45_sint_mul_adder_21_io_r <= (others => '0');
            reg_17_l_subtraction_52_io_a <= (others => '0');
            reg_5_l_subtraction_33_io_b <= (others => '0');
            reg_2_d_itime_convertor_0_io_o <= (others => '0');
            reg_0_d_multiplication_23_sint_mul_gen_addends_io_addend_19 <= (others => '0');
            reg_0_d_multiplication_23_sint_mul_gen_addends_io_addend_23 <= (others => '0');
            reg_0_d_multiplication_24_sint_mul_gen_addends_io_addend_27 <= (others => '0');
            reg_7_d_to8bit_cvt_55_io_o <= (others => '0');
            reg_19_l_subtraction_48_io_a <= (others => '0');
            reg_16_l_subtraction_48_io_a <= (others => '0');
            reg_0_d_consts_opt_io_c5_5 <= (others => '0');
            reg_0_d_multiplication_38_sint_mul_adder_1_io_r <= (others => '0');
            reg_9_d_to8bit_cvt_55_io_o <= (others => '0');
            reg_2_d_multiplication_23_sint_mul_gen_addends_io_subend <= (others => '0');
            reg_1_d_multiplication_45_sint_mul_gen_addends_io_subend <= (others => '0');
            reg_3_l_addition_27_io_a <= (others => '0');
            reg_0_d_mux_calc_io_o <= (others => '0');
            reg_3_l_subtraction_33_io_b <= (others => '0');
            reg_0_d_multiplication_23_tc_io_o <= (others => '0');
            reg_10_l_subtraction_48_io_a <= (others => '0');
            reg_8_l_addition_27_io_a <= (others => '0');
            reg_0_d_multiplication_38_sint_mul_adder_17_io_r <= (others => '0');
            reg_0_d_multiplication_24_sint_mul_gen_addends_io_addend_20 <= (others => '0');
            reg_10_l_addition_43_io_b <= (others => '0');
            reg_15_valid_chain <= (others => '0');
            reg_0_d_multiplication_45_sint_mul_adder_12_io_r <= (others => '0');
            reg_9_d_consts_opt_io_c0_1 <= (others => '0');
            reg_0_d_multiplication_45_sint_mul_adder_19_io_r <= (others => '0');
            reg_0_d_multiplication_23_sint_mul_gen_addends_io_addend_21 <= (others => '0');
            reg_3_d_consts_opt_io_c0_1 <= (others => '0');
            reg_0_d_multiplication_23_sint_mul_gen_addends_io_addend_18 <= (others => '0');
            reg_0_d_multiplication_45_sint_mul_adder_7_io_r <= (others => '0');
            reg_0_d_multiplication_45_sint_mul_adder_10_io_r <= (others => '0');
            reg_10_d_consts_opt_io_c0_95 <= (others => '0');
            reg_12_l_subtraction_48_io_a <= (others => '0');
            reg_0_d_consts_opt_io_c0_1 <= (others => '0');
            reg_3_l_subtraction_52_io_a <= (others => '0');
            reg_7_d_consts_opt_io_c0_1 <= (others => '0');
            reg_0_d_multiplication_23_sint_mul_gen_addends_io_addend_25 <= (others => '0');
            reg_16_l_addition_43_io_b <= (others => '0');
            reg_0_d_multiplication_37_sint_mul_adder_15_io_r <= (others => '0');
            reg_0_d_multiplication_24_sint_mul_gen_addends_io_addend_26 <= (others => '0');
            reg_8_l_subtraction_33_io_b <= (others => '0');
            reg_0_d_multiplication_38_sint_mul_adder_5_io_r <= (others => '0');
            reg_10_valid_chain <= (others => '0');
            reg_0_d_multiplication_38_sint_mul_adder_3_io_r <= (others => '0');
            reg_1_l_addition_14_io_b <= (others => '0');
            reg_4_d_itime_convertor_0_io_o <= (others => '0');
            reg_0_d_arith_shifter_26_io_o <= (others => '0');
            reg_22_d_to8bit_cvt_55_io_o <= (others => '0');
            reg_3_d_fract_36_io_o <= (others => '0');
            reg_0_d_arith_shifter_51_io_o <= (others => '0');
            reg_0_d_multiplication_38_sint_mul_adder_22_io_r <= (others => '0');
            reg_0_d_multiplication_24_sint_mul_gen_addends_io_addend_23 <= (others => '0');
            reg_2_l_addition_27_io_a <= (others => '0');
            reg_1_d_multiplication_24_sint_mul_adder_19_io_r <= (others => '0');
            reg_0_d_multiplication_23_sint_mul_gen_addends_io_addend_22 <= (others => '0');
            reg_4_d_to8bit_cvt_55_io_o <= (others => '0');
            reg_0_d_multiplication_23_sint_mul_gen_addends_io_addend_24 <= (others => '0');
            reg_0_d_multiplication_38_sint_mul_adder_12_io_r <= (others => '0');
            reg_3_d_multiplication_24_sint_mul_gen_addends_io_subend <= (others => '0');
            reg_11_d_consts_opt_io_c0_95 <= (others => '0');
            reg_1_l_addition_12_io_b <= (others => '0');
            reg_13_d_to8bit_cvt_55_io_o <= (others => '0');
            reg_0_d_minx1mx_18_io_o <= (others => '0');
            reg_0_d_multiplication_38_sint_mul_adder_20_io_r <= (others => '0');
            reg_5_d_to8bit_cvt_55_io_o <= (others => '0');
            reg_0_l_addition_14_io_b <= (others => '0');
            reg_2_d_consts_opt_io_c0_95 <= (others => '0');
            reg_0_d_multiplication_38_sint_mul_adder_21_io_r <= (others => '0');
            reg_23_valid_chain <= (others => '0');
            reg_0_d_multiplication_23_sint_mul_adder_21_io_r <= (others => '0');
            reg_1_d_multiplication_23_sint_mul_gen_addends_io_subend <= (others => '0');
            reg_7_l_addition_27_io_a <= (others => '0');
            reg_7_l_subtraction_33_io_b <= (others => '0');
            reg_0_valid_chain <= (others => '0');
            reg_4_d_consts_opt_io_c0_95 <= (others => '0');
            reg_0_d_frag_x <= (others => '0');
            reg_0_d_multiplication_38_sint_mul_adder_23_io_r <= (others => '0');
            reg_17_d_to8bit_cvt_55_io_o <= (others => '0');
            reg_8_d_to8bit_cvt_55_io_o <= (others => '0');
            reg_0_d_multiplication_23_sint_mul_adder_24_io_r <= (others => '0');
            reg_7_l_addition_43_io_b <= (others => '0');
            reg_5_d_fract_36_io_o <= (others => '0');
            reg_10_d_to8bit_cvt_55_io_o <= (others => '0');
            reg_20_l_subtraction_48_io_a <= (others => '0');
            reg_0_d_multiplication_23_sint_mul_gen_addends_io_subend <= (others => '0');
            reg_0_d_multiplication_23_sint_mul_adder_17_io_r <= (others => '0');
            reg_8_l_subtraction_48_io_a <= (others => '0');
            reg_1_l_subtraction_33_io_b <= (others => '0');
            reg_2_d_multiplication_24_sint_mul_gen_addends_io_subend <= (others => '0');
            reg_2_d_multiplication_23_sint_mul_adder_16_io_r <= (others => '0');
            reg_3_d_consts_opt_io_c5_5 <= (others => '0');
            reg_0_d_multiplication_23_sint_mul_adder_16_io_r <= (others => '0');
            reg_0_d_multiplication_23_sint_mul_gen_addends_io_addend_26 <= (others => '0');
            reg_0_d_multiplication_45_sint_mul_adder_11_io_r <= (others => '0');
            reg_0_d_multiplication_45_sint_mul_adder_22_io_r <= (others => '0');
            reg_0_d_subtraction_52_io_r <= (others => '0');
            reg_0_d_minx1mx_16_io_o <= (others => '0');
            reg_14_valid_chain <= (others => '0');
            reg_0_l_ceil_21_io_i <= (others => '0');
            reg_2_d_multiplication_24_sint_mul_adder_16_io_r <= (others => '0');
            reg_4_valid_chain <= (others => '0');
            reg_2_d_multiplication_37_tc_io_o <= (others => '0');
            reg_1_d_multiplication_38_sint_mul_adder_25_io_r <= (others => '0');
            reg_0_d_multiplication_23_sint_mul_adder_8_io_r <= (others => '0');
            reg_0_d_multiplication_38_sint_mul_adder_14_io_r <= (others => '0');
            reg_0_d_multiplication_38_sint_mul_adder_24_io_r <= (others => '0');
            reg_0_d_fract_17_io_o <= (others => '0');
            reg_4_d_multiplication_38_sint_mul_gen_addends_io_subend <= (others => '0');
            reg_0_d_multiplication_45_sint_mul_adder_8_io_r <= (others => '0');
            reg_0_d_multiplication_23_sint_mul_gen_addends_io_addend_16 <= (others => '0');
            reg_4_l_subtraction_52_io_a <= (others => '0');
            reg_0_d_multiplication_24_tc_io_o <= (others => '0');
            reg_1_d_multiplication_23_sint_mul_adder_19_io_r <= (others => '0');
            reg_0_d_multiplication_23_sint_mul_gen_addends_io_addend_15 <= (others => '0');
            reg_0_d_multiplication_24_sint_mul_gen_addends_io_addend_15 <= (others => '0');
            reg_0_d_multiplication_38_sint_mul_adder_0_io_r <= (others => '0');
            reg_1_d_multiplication_38_sint_mul_gen_addends_io_subend <= (others => '0');
            reg_14_d_to8bit_cvt_55_io_o <= (others => '0');
            reg_0_d_multiplication_24_sint_mul_gen_addends_io_subend <= (others => '0');
            reg_9_l_addition_43_io_b <= (others => '0');
            reg_13_l_subtraction_48_io_a <= (others => '0');
            reg_0_l_subtraction_52_io_a <= (others => '0');
            reg_0_d_multiplication_38_sint_mul_adder_6_io_r <= (others => '0');
            reg_0_d_multiplication_45_sint_mul_adder_4_io_r <= (others => '0');
            reg_1_d_multiplication_24_sint_mul_adder_16_io_r <= (others => '0');
            reg_0_d_clamp01_44_io_o <= (others => '0');
            reg_2_d_multiplication_45_sint_mul_adder_21_io_r <= (others => '0');
            reg_18_valid_chain <= (others => '0');
            reg_1_d_multiplication_45_sint_mul_adder_20_io_r <= (others => '0');
            reg_18_l_subtraction_48_io_a <= (others => '0');
            reg_3_d_multiplication_45_tc_io_o <= (others => '0');
            reg_0_d_multiplication_45_sint_mul_adder_16_io_r <= (others => '0');
            reg_15_d_to8bit_cvt_55_io_o <= (others => '0');
        elsif rising_edge(clock) and in_ready_and_in_valid = "1" then
            reg_0_d_multiplication_23_sint_mul_gen_addends_io_addend_12 <= reg_next_0_d_multiplication_23_sint_mul_gen_addends_io_addend_12;
            reg_0_d_addition_13_io_r <= reg_next_0_d_addition_13_io_r;
            reg_9_valid_chain <= reg_next_9_valid_chain;
            reg_0_d_multiplication_45_sint_mul_adder_13_io_r <= reg_next_0_d_multiplication_45_sint_mul_adder_13_io_r;
            reg_0_d_multiplication_24_sint_mul_adder_19_io_r <= reg_next_0_d_multiplication_24_sint_mul_adder_19_io_r;
            reg_4_d_fract_36_io_o <= reg_next_4_d_fract_36_io_o;
            reg_20_valid_chain <= reg_next_20_valid_chain;
            reg_0_d_multiplication_23_sint_mul_gen_addends_io_addend_13 <= reg_next_0_d_multiplication_23_sint_mul_gen_addends_io_addend_13;
            reg_15_l_addition_43_io_b <= reg_next_15_l_addition_43_io_b;
            reg_2_valid_chain <= reg_next_2_valid_chain;
            reg_0_d_frag_y <= reg_next_0_d_frag_y;
            reg_21_valid_chain <= reg_next_21_valid_chain;
            reg_1_valid_chain <= reg_next_1_valid_chain;
            reg_22_valid_chain <= reg_next_22_valid_chain;
            reg_5_d_consts_opt_io_c0_1 <= reg_next_5_d_consts_opt_io_c0_1;
            reg_7_valid_chain <= reg_next_7_valid_chain;
            reg_0_d_multiplication_37_sint_mul_adder_5_io_r <= reg_next_0_d_multiplication_37_sint_mul_adder_5_io_r;
            reg_2_d_multiplication_45_sint_mul_gen_addends_io_subend <= reg_next_2_d_multiplication_45_sint_mul_gen_addends_io_subend;
            reg_12_valid_chain <= reg_next_12_valid_chain;
            reg_0_d_multiplication_24_sint_mul_gen_addends_io_addend_18 <= reg_next_0_d_multiplication_24_sint_mul_gen_addends_io_addend_18;
            reg_0_d_multiplication_24_sint_mul_gen_addends_io_addend_17 <= reg_next_0_d_multiplication_24_sint_mul_gen_addends_io_addend_17;
            reg_6_l_subtraction_52_io_a <= reg_next_6_l_subtraction_52_io_a;
            reg_0_d_multiplication_23_sint_mul_adder_25_io_r <= reg_next_0_d_multiplication_23_sint_mul_adder_25_io_r;
            reg_0_d_subtraction_10_io_r <= reg_next_0_d_subtraction_10_io_r;
            reg_0_d_fract_15_io_o <= reg_next_0_d_fract_15_io_o;
            reg_0_d_multiplication_45_sint_mul_gen_addends_io_subend <= reg_next_0_d_multiplication_45_sint_mul_gen_addends_io_subend;
            reg_8_l_addition_43_io_b <= reg_next_8_l_addition_43_io_b;
            reg_0_d_arith_shifter_40_io_o <= reg_next_0_d_arith_shifter_40_io_o;
            reg_1_l_addition_27_io_a <= reg_next_1_l_addition_27_io_a;
            reg_15_l_subtraction_48_io_a <= reg_next_15_l_subtraction_48_io_a;
            reg_5_l_addition_43_io_b <= reg_next_5_l_addition_43_io_b;
            reg_1_d_multiplication_24_sint_mul_gen_addends_io_subend <= reg_next_1_d_multiplication_24_sint_mul_gen_addends_io_subend;
            reg_5_valid_chain <= reg_next_5_valid_chain;
            reg_17_valid_chain <= reg_next_17_valid_chain;
            reg_6_l_subtraction_48_io_a <= reg_next_6_l_subtraction_48_io_a;
            reg_8_d_consts_opt_io_c0_95 <= reg_next_8_d_consts_opt_io_c0_95;
            reg_0_d_multiplication_23_sint_mul_gen_addends_io_addend_14 <= reg_next_0_d_multiplication_23_sint_mul_gen_addends_io_addend_14;
            reg_6_d_fract_36_io_o <= reg_next_6_d_fract_36_io_o;
            reg_3_d_itime_convertor_0_io_o <= reg_next_3_d_itime_convertor_0_io_o;
            reg_12_l_addition_43_io_b <= reg_next_12_l_addition_43_io_b;
            reg_0_d_multiplication_24_sint_mul_adder_17_io_r <= reg_next_0_d_multiplication_24_sint_mul_adder_17_io_r;
            reg_1_d_consts_opt_io_c0_95 <= reg_next_1_d_consts_opt_io_c0_95;
            reg_1_d_fract_36_io_o <= reg_next_1_d_fract_36_io_o;
            reg_3_d_to8bit_cvt_55_io_o <= reg_next_3_d_to8bit_cvt_55_io_o;
            reg_0_d_multiplication_24_sint_mul_gen_addends_io_addend_19 <= reg_next_0_d_multiplication_24_sint_mul_gen_addends_io_addend_19;
            reg_0_d_multiplication_37_sint_mul_adder_25_io_r <= reg_next_0_d_multiplication_37_sint_mul_adder_25_io_r;
            reg_1_l_subtraction_52_io_a <= reg_next_1_l_subtraction_52_io_a;
            reg_13_l_subtraction_52_io_a <= reg_next_13_l_subtraction_52_io_a;
            reg_0_d_multiplication_38_sint_mul_adder_13_io_r <= reg_next_0_d_multiplication_38_sint_mul_adder_13_io_r;
            reg_0_d_multiplication_45_sint_mul_adder_24_io_r <= reg_next_0_d_multiplication_45_sint_mul_adder_24_io_r;
            reg_1_d_multiplication_45_sint_mul_adder_21_io_r <= reg_next_1_d_multiplication_45_sint_mul_adder_21_io_r;
            reg_2_l_subtraction_48_io_a <= reg_next_2_l_subtraction_48_io_a;
            reg_8_l_subtraction_52_io_a <= reg_next_8_l_subtraction_52_io_a;
            reg_0_d_multiplication_45_sint_mul_adder_6_io_r <= reg_next_0_d_multiplication_45_sint_mul_adder_6_io_r;
            reg_0_d_ceil_19_io_o <= reg_next_0_d_ceil_19_io_o;
            reg_0_d_arith_shifter_47_io_o <= reg_next_0_d_arith_shifter_47_io_o;
            reg_2_d_multiplication_23_sint_mul_adder_21_io_r <= reg_next_2_d_multiplication_23_sint_mul_adder_21_io_r;
            reg_0_d_multiplication_38_sint_mul_gen_addends_io_subend <= reg_next_0_d_multiplication_38_sint_mul_gen_addends_io_subend;
            reg_1_d_multiplication_45_tc_io_o <= reg_next_1_d_multiplication_45_tc_io_o;
            reg_1_l_subtraction_48_io_a <= reg_next_1_l_subtraction_48_io_a;
            reg_0_d_multiplication_45_sint_mul_adder_9_io_r <= reg_next_0_d_multiplication_45_sint_mul_adder_9_io_r;
            reg_20_l_subtraction_52_io_a <= reg_next_20_l_subtraction_52_io_a;
            reg_18_l_addition_43_io_b <= reg_next_18_l_addition_43_io_b;
            reg_5_l_subtraction_48_io_a <= reg_next_5_l_subtraction_48_io_a;
            reg_0_d_itime_convertor_0_io_o <= reg_next_0_d_itime_convertor_0_io_o;
            reg_1_d_multiplication_24_sint_mul_adder_21_io_r <= reg_next_1_d_multiplication_24_sint_mul_adder_21_io_r;
            reg_0_d_multiplication_38_sint_mul_adder_16_io_r <= reg_next_0_d_multiplication_38_sint_mul_adder_16_io_r;
            reg_0_d_multiplication_24_sint_mul_gen_addends_io_addend_24 <= reg_next_0_d_multiplication_24_sint_mul_gen_addends_io_addend_24;
            reg_6_l_addition_43_io_b <= reg_next_6_l_addition_43_io_b;
            reg_11_d_to8bit_cvt_55_io_o <= reg_next_11_d_to8bit_cvt_55_io_o;
            reg_9_l_addition_27_io_a <= reg_next_9_l_addition_27_io_a;
            reg_1_d_itime_convertor_0_io_o <= reg_next_1_d_itime_convertor_0_io_o;
            reg_0_d_subtraction_11_io_r <= reg_next_0_d_subtraction_11_io_r;
            reg_0_d_multiplication_45_sint_mul_adder_26_io_r <= reg_next_0_d_multiplication_45_sint_mul_adder_26_io_r;
            reg_6_d_to8bit_cvt_55_io_o <= reg_next_6_d_to8bit_cvt_55_io_o;
            reg_9_d_itime_convertor_0_io_o <= reg_next_9_d_itime_convertor_0_io_o;
            reg_0_d_multiplication_38_sint_mul_adder_4_io_r <= reg_next_0_d_multiplication_38_sint_mul_adder_4_io_r;
            reg_6_d_consts_opt_io_c0_95 <= reg_next_6_d_consts_opt_io_c0_95;
            reg_0_d_multiplication_45_sint_mul_adder_17_io_r <= reg_next_0_d_multiplication_45_sint_mul_adder_17_io_r;
            reg_19_valid_chain <= reg_next_19_valid_chain;
            reg_8_d_itime_convertor_0_io_o <= reg_next_8_d_itime_convertor_0_io_o;
            reg_0_d_addition_43_io_r <= reg_next_0_d_addition_43_io_r;
            reg_0_d_multiplication_23_sint_mul_gen_addends_io_addend_17 <= reg_next_0_d_multiplication_23_sint_mul_gen_addends_io_addend_17;
            reg_1_d_to8bit_cvt_55_io_o <= reg_next_1_d_to8bit_cvt_55_io_o;
            reg_20_d_to8bit_cvt_55_io_o <= reg_next_20_d_to8bit_cvt_55_io_o;
            reg_0_d_subtraction_6_io_r <= reg_next_0_d_subtraction_6_io_r;
            reg_0_d_multiplication_24_sint_mul_adder_25_io_r <= reg_next_0_d_multiplication_24_sint_mul_adder_25_io_r;
            reg_0_d_multiplication_24_sint_mul_adder_18_io_r <= reg_next_0_d_multiplication_24_sint_mul_adder_18_io_r;
            reg_0_d_consts_opt_io_c0_95 <= reg_next_0_d_consts_opt_io_c0_95;
            reg_4_l_addition_27_io_a <= reg_next_4_l_addition_27_io_a;
            reg_0_d_multiplication_23_sint_mul_adder_18_io_r <= reg_next_0_d_multiplication_23_sint_mul_adder_18_io_r;
            reg_8_d_consts_opt_io_c0_1 <= reg_next_8_d_consts_opt_io_c0_1;
            reg_7_d_consts_opt_io_c0_95 <= reg_next_7_d_consts_opt_io_c0_95;
            reg_2_d_multiplication_38_sint_mul_gen_addends_io_subend <= reg_next_2_d_multiplication_38_sint_mul_gen_addends_io_subend;
            reg_2_d_consts_opt_io_c0_1 <= reg_next_2_d_consts_opt_io_c0_1;
            reg_19_l_subtraction_52_io_a <= reg_next_19_l_subtraction_52_io_a;
            reg_0_d_multiplication_38_sint_mul_adder_18_io_r <= reg_next_0_d_multiplication_38_sint_mul_adder_18_io_r;
            reg_6_l_subtraction_33_io_b <= reg_next_6_l_subtraction_33_io_b;
            reg_4_d_multiplication_45_tc_io_o <= reg_next_4_d_multiplication_45_tc_io_o;
            reg_0_d_multiplication_37_sint_mul_adder_4_io_r <= reg_next_0_d_multiplication_37_sint_mul_adder_4_io_r;
            reg_3_d_multiplication_23_sint_mul_gen_addends_io_subend <= reg_next_3_d_multiplication_23_sint_mul_gen_addends_io_subend;
            reg_5_l_addition_27_io_a <= reg_next_5_l_addition_27_io_a;
            reg_7_d_itime_convertor_0_io_o <= reg_next_7_d_itime_convertor_0_io_o;
            reg_0_d_multiplication_38_sint_mul_adder_25_io_r <= reg_next_0_d_multiplication_38_sint_mul_adder_25_io_r;
            reg_1_d_multiplication_23_sint_mul_adder_21_io_r <= reg_next_1_d_multiplication_23_sint_mul_adder_21_io_r;
            reg_0_d_multiplication_38_sint_mul_adder_2_io_r <= reg_next_0_d_multiplication_38_sint_mul_adder_2_io_r;
            reg_0_d_addition_42_io_r <= reg_next_0_d_addition_42_io_r;
            reg_0_d_multiplication_24_sint_mul_gen_addends_io_addend_16 <= reg_next_0_d_multiplication_24_sint_mul_gen_addends_io_addend_16;
            reg_0_d_to8bit_cvt_55_io_o <= reg_next_0_d_to8bit_cvt_55_io_o;
            reg_0_d_multiplication_23_sint_mul_adder_7_io_r <= reg_next_0_d_multiplication_23_sint_mul_adder_7_io_r;
            reg_0_l_addition_12_io_b <= reg_next_0_l_addition_12_io_b;
            reg_0_d_multiplication_37_sint_mul_adder_14_io_r <= reg_next_0_d_multiplication_37_sint_mul_adder_14_io_r;
            reg_8_valid_chain <= reg_next_8_valid_chain;
            reg_5_d_consts_opt_io_c0_95 <= reg_next_5_d_consts_opt_io_c0_95;
            reg_6_d_consts_opt_io_c0_1 <= reg_next_6_d_consts_opt_io_c0_1;
            reg_6_l_addition_27_io_a <= reg_next_6_l_addition_27_io_a;
            reg_12_d_to8bit_cvt_55_io_o <= reg_next_12_d_to8bit_cvt_55_io_o;
            reg_7_l_subtraction_48_io_a <= reg_next_7_l_subtraction_48_io_a;
            reg_0_d_multiplication_38_sint_mul_adder_15_io_r <= reg_next_0_d_multiplication_38_sint_mul_adder_15_io_r;
            reg_0_d_multiplication_38_sint_mul_adder_7_io_r <= reg_next_0_d_multiplication_38_sint_mul_adder_7_io_r;
            reg_1_d_multiplication_24_sint_mul_adder_20_io_r <= reg_next_1_d_multiplication_24_sint_mul_adder_20_io_r;
            reg_0_d_multiplication_37_sint_mul_adder_17_io_r <= reg_next_0_d_multiplication_37_sint_mul_adder_17_io_r;
            reg_0_d_multiplication_38_sint_mul_adder_26_io_r <= reg_next_0_d_multiplication_38_sint_mul_adder_26_io_r;
            reg_2_d_multiplication_24_sint_mul_adder_21_io_r <= reg_next_2_d_multiplication_24_sint_mul_adder_21_io_r;
            reg_3_d_consts_opt_io_c0_95 <= reg_next_3_d_consts_opt_io_c0_95;
            reg_0_d_arith_shifter_41_io_o <= reg_next_0_d_arith_shifter_41_io_o;
            reg_0_d_multiplication_37_sint_mul_gen_addends_io_subend <= reg_next_0_d_multiplication_37_sint_mul_gen_addends_io_subend;
            reg_0_d_multiplication_45_tc_io_o <= reg_next_0_d_multiplication_45_tc_io_o;
            reg_0_l_addition_27_io_a <= reg_next_0_l_addition_27_io_a;
            reg_2_d_consts_opt_io_c5_5 <= reg_next_2_d_consts_opt_io_c5_5;
            reg_0_d_multiplication_24_sint_mul_adder_6_io_r <= reg_next_0_d_multiplication_24_sint_mul_adder_6_io_r;
            reg_2_d_to8bit_cvt_55_io_o <= reg_next_2_d_to8bit_cvt_55_io_o;
            reg_14_l_subtraction_48_io_a <= reg_next_14_l_subtraction_48_io_a;
            reg_0_d_multiplication_45_sint_mul_adder_20_io_r <= reg_next_0_d_multiplication_45_sint_mul_adder_20_io_r;
            reg_9_l_subtraction_33_io_b <= reg_next_9_l_subtraction_33_io_b;
            reg_0_l_addition_43_io_b <= reg_next_0_l_addition_43_io_b;
            reg_19_d_to8bit_cvt_55_io_o <= reg_next_19_d_to8bit_cvt_55_io_o;
            reg_9_l_subtraction_52_io_a <= reg_next_9_l_subtraction_52_io_a;
            reg_0_d_multiplication_23_sint_mul_adder_9_io_r <= reg_next_0_d_multiplication_23_sint_mul_adder_9_io_r;
            reg_4_l_subtraction_33_io_b <= reg_next_4_l_subtraction_33_io_b;
            reg_0_d_multiplication_24_sint_mul_gen_addends_io_addend_14 <= reg_next_0_d_multiplication_24_sint_mul_gen_addends_io_addend_14;
            reg_1_d_multiplication_37_tc_io_o <= reg_next_1_d_multiplication_37_tc_io_o;
            reg_0_l_subtraction_33_io_b <= reg_next_0_l_subtraction_33_io_b;
            reg_14_l_addition_43_io_b <= reg_next_14_l_addition_43_io_b;
            reg_11_l_subtraction_52_io_a <= reg_next_11_l_subtraction_52_io_a;
            reg_1_d_consts_opt_io_c5_5 <= reg_next_1_d_consts_opt_io_c5_5;
            reg_0_l_ceil_19_io_i <= reg_next_0_l_ceil_19_io_i;
            reg_0_d_multiplication_38_tc_io_o <= reg_next_0_d_multiplication_38_tc_io_o;
            reg_10_l_subtraction_52_io_a <= reg_next_10_l_subtraction_52_io_a;
            reg_0_d_multiplication_23_sint_mul_adder_6_io_r <= reg_next_0_d_multiplication_23_sint_mul_adder_6_io_r;
            reg_3_l_subtraction_48_io_a <= reg_next_3_l_subtraction_48_io_a;
            reg_21_l_subtraction_48_io_a <= reg_next_21_l_subtraction_48_io_a;
            reg_0_d_multiplication_23_sint_mul_adder_20_io_r <= reg_next_0_d_multiplication_23_sint_mul_adder_20_io_r;
            reg_11_l_subtraction_48_io_a <= reg_next_11_l_subtraction_48_io_a;
            reg_13_valid_chain <= reg_next_13_valid_chain;
            reg_4_d_multiplication_45_sint_mul_gen_addends_io_subend <= reg_next_4_d_multiplication_45_sint_mul_gen_addends_io_subend;
            reg_1_d_consts_opt_io_c0_1 <= reg_next_1_d_consts_opt_io_c0_1;
            reg_14_l_subtraction_52_io_a <= reg_next_14_l_subtraction_52_io_a;
            reg_1_d_multiplication_23_sint_mul_adder_20_io_r <= reg_next_1_d_multiplication_23_sint_mul_adder_20_io_r;
            reg_0_d_multiplication_38_sint_mul_adder_19_io_r <= reg_next_0_d_multiplication_38_sint_mul_adder_19_io_r;
            reg_2_l_subtraction_33_io_b <= reg_next_2_l_subtraction_33_io_b;
            reg_11_valid_chain <= reg_next_11_valid_chain;
            reg_3_d_multiplication_38_sint_mul_gen_addends_io_subend <= reg_next_3_d_multiplication_38_sint_mul_gen_addends_io_subend;
            reg_3_d_multiplication_37_tc_io_o <= reg_next_3_d_multiplication_37_tc_io_o;
            reg_0_d_multiplication_24_sint_mul_adder_20_io_r <= reg_next_0_d_multiplication_24_sint_mul_adder_20_io_r;
            reg_9_d_consts_opt_io_c0_95 <= reg_next_9_d_consts_opt_io_c0_95;
            reg_16_l_subtraction_52_io_a <= reg_next_16_l_subtraction_52_io_a;
            reg_4_d_consts_opt_io_c0_1 <= reg_next_4_d_consts_opt_io_c0_1;
            reg_0_d_multiplication_24_sint_mul_adder_7_io_r <= reg_next_0_d_multiplication_24_sint_mul_adder_7_io_r;
            reg_0_d_multiplication_23_sint_mul_gen_addends_io_addend_20 <= reg_next_0_d_multiplication_23_sint_mul_gen_addends_io_addend_20;
            reg_6_d_itime_convertor_0_io_o <= reg_next_6_d_itime_convertor_0_io_o;
            reg_21_d_to8bit_cvt_55_io_o <= reg_next_21_d_to8bit_cvt_55_io_o;
            reg_9_l_subtraction_48_io_a <= reg_next_9_l_subtraction_48_io_a;
            reg_4_l_addition_43_io_b <= reg_next_4_l_addition_43_io_b;
            reg_0_d_multiplication_45_sint_mul_adder_18_io_r <= reg_next_0_d_multiplication_45_sint_mul_adder_18_io_r;
            reg_0_d_multiplication_24_sint_mul_adder_8_io_r <= reg_next_0_d_multiplication_24_sint_mul_adder_8_io_r;
            reg_0_l_subtraction_48_io_a <= reg_next_0_l_subtraction_48_io_a;
            reg_0_d_multiplication_24_sint_mul_adder_24_io_r <= reg_next_0_d_multiplication_24_sint_mul_adder_24_io_r;
            reg_5_l_subtraction_52_io_a <= reg_next_5_l_subtraction_52_io_a;
            reg_2_d_fract_36_io_o <= reg_next_2_d_fract_36_io_o;
            reg_0_d_multiplication_37_tc_io_o <= reg_next_0_d_multiplication_37_tc_io_o;
            reg_17_l_addition_43_io_b <= reg_next_17_l_addition_43_io_b;
            reg_0_d_multiplication_24_sint_mul_adder_21_io_r <= reg_next_0_d_multiplication_24_sint_mul_adder_21_io_r;
            reg_0_d_multiplication_24_sint_mul_gen_addends_io_addend_12 <= reg_next_0_d_multiplication_24_sint_mul_gen_addends_io_addend_12;
            reg_0_d_ceil_21_io_o <= reg_next_0_d_ceil_21_io_o;
            reg_0_d_multiplication_24_sint_mul_gen_addends_io_addend_13 <= reg_next_0_d_multiplication_24_sint_mul_gen_addends_io_addend_13;
            reg_0_d_multiplication_24_sint_mul_gen_addends_io_addend_25 <= reg_next_0_d_multiplication_24_sint_mul_gen_addends_io_addend_25;
            reg_3_valid_chain <= reg_next_3_valid_chain;
            reg_0_d_subtraction_48_io_r <= reg_next_0_d_subtraction_48_io_r;
            reg_1_d_multiplication_23_sint_mul_adder_16_io_r <= reg_next_1_d_multiplication_23_sint_mul_adder_16_io_r;
            reg_0_d_multiplication_24_sint_mul_adder_9_io_r <= reg_next_0_d_multiplication_24_sint_mul_adder_9_io_r;
            reg_2_l_addition_43_io_b <= reg_next_2_l_addition_43_io_b;
            reg_16_d_to8bit_cvt_55_io_o <= reg_next_16_d_to8bit_cvt_55_io_o;
            reg_6_valid_chain <= reg_next_6_valid_chain;
            reg_0_d_multiplication_45_sint_mul_adder_5_io_r <= reg_next_0_d_multiplication_45_sint_mul_adder_5_io_r;
            reg_0_d_multiplication_24_sint_mul_gen_addends_io_addend_21 <= reg_next_0_d_multiplication_24_sint_mul_gen_addends_io_addend_21;
            reg_11_l_addition_43_io_b <= reg_next_11_l_addition_43_io_b;
            reg_4_l_subtraction_48_io_a <= reg_next_4_l_subtraction_48_io_a;
            reg_13_l_addition_43_io_b <= reg_next_13_l_addition_43_io_b;
            reg_2_l_subtraction_52_io_a <= reg_next_2_l_subtraction_52_io_a;
            reg_0_d_multiplication_23_sint_mul_adder_19_io_r <= reg_next_0_d_multiplication_23_sint_mul_adder_19_io_r;
            reg_0_d_fract_36_io_o <= reg_next_0_d_fract_36_io_o;
            reg_2_d_multiplication_45_tc_io_o <= reg_next_2_d_multiplication_45_tc_io_o;
            reg_18_d_to8bit_cvt_55_io_o <= reg_next_18_d_to8bit_cvt_55_io_o;
            reg_0_d_multiplication_24_sint_mul_gen_addends_io_addend_22 <= reg_next_0_d_multiplication_24_sint_mul_gen_addends_io_addend_22;
            reg_17_l_subtraction_48_io_a <= reg_next_17_l_subtraction_48_io_a;
            reg_15_l_subtraction_52_io_a <= reg_next_15_l_subtraction_52_io_a;
            reg_5_d_itime_convertor_0_io_o <= reg_next_5_d_itime_convertor_0_io_o;
            reg_0_d_itime_us <= reg_next_0_d_itime_us;
            reg_1_l_addition_43_io_b <= reg_next_1_l_addition_43_io_b;
            reg_0_d_multiplication_23_sint_mul_gen_addends_io_addend_27 <= reg_next_0_d_multiplication_23_sint_mul_gen_addends_io_addend_27;
            reg_0_d_multiplication_24_sint_mul_adder_16_io_r <= reg_next_0_d_multiplication_24_sint_mul_adder_16_io_r;
            reg_7_l_subtraction_52_io_a <= reg_next_7_l_subtraction_52_io_a;
            reg_0_d_multiplication_45_sint_mul_adder_25_io_r <= reg_next_0_d_multiplication_45_sint_mul_adder_25_io_r;
            reg_18_l_subtraction_52_io_a <= reg_next_18_l_subtraction_52_io_a;
            reg_5_d_multiplication_45_tc_io_o <= reg_next_5_d_multiplication_45_tc_io_o;
            reg_21_l_subtraction_52_io_a <= reg_next_21_l_subtraction_52_io_a;
            reg_0_d_multiplication_45_sint_mul_adder_23_io_r <= reg_next_0_d_multiplication_45_sint_mul_adder_23_io_r;
            reg_16_valid_chain <= reg_next_16_valid_chain;
            reg_3_d_multiplication_45_sint_mul_gen_addends_io_subend <= reg_next_3_d_multiplication_45_sint_mul_gen_addends_io_subend;
            reg_12_l_subtraction_52_io_a <= reg_next_12_l_subtraction_52_io_a;
            reg_0_d_subtraction_33_io_r <= reg_next_0_d_subtraction_33_io_r;
            reg_3_l_addition_43_io_b <= reg_next_3_l_addition_43_io_b;
            reg_0_d_multiplication_45_sint_mul_adder_21_io_r <= reg_next_0_d_multiplication_45_sint_mul_adder_21_io_r;
            reg_17_l_subtraction_52_io_a <= reg_next_17_l_subtraction_52_io_a;
            reg_5_l_subtraction_33_io_b <= reg_next_5_l_subtraction_33_io_b;
            reg_2_d_itime_convertor_0_io_o <= reg_next_2_d_itime_convertor_0_io_o;
            reg_0_d_multiplication_23_sint_mul_gen_addends_io_addend_19 <= reg_next_0_d_multiplication_23_sint_mul_gen_addends_io_addend_19;
            reg_0_d_multiplication_23_sint_mul_gen_addends_io_addend_23 <= reg_next_0_d_multiplication_23_sint_mul_gen_addends_io_addend_23;
            reg_0_d_multiplication_24_sint_mul_gen_addends_io_addend_27 <= reg_next_0_d_multiplication_24_sint_mul_gen_addends_io_addend_27;
            reg_7_d_to8bit_cvt_55_io_o <= reg_next_7_d_to8bit_cvt_55_io_o;
            reg_19_l_subtraction_48_io_a <= reg_next_19_l_subtraction_48_io_a;
            reg_16_l_subtraction_48_io_a <= reg_next_16_l_subtraction_48_io_a;
            reg_0_d_consts_opt_io_c5_5 <= reg_next_0_d_consts_opt_io_c5_5;
            reg_0_d_multiplication_38_sint_mul_adder_1_io_r <= reg_next_0_d_multiplication_38_sint_mul_adder_1_io_r;
            reg_9_d_to8bit_cvt_55_io_o <= reg_next_9_d_to8bit_cvt_55_io_o;
            reg_2_d_multiplication_23_sint_mul_gen_addends_io_subend <= reg_next_2_d_multiplication_23_sint_mul_gen_addends_io_subend;
            reg_1_d_multiplication_45_sint_mul_gen_addends_io_subend <= reg_next_1_d_multiplication_45_sint_mul_gen_addends_io_subend;
            reg_3_l_addition_27_io_a <= reg_next_3_l_addition_27_io_a;
            reg_0_d_mux_calc_io_o <= reg_next_0_d_mux_calc_io_o;
            reg_3_l_subtraction_33_io_b <= reg_next_3_l_subtraction_33_io_b;
            reg_0_d_multiplication_23_tc_io_o <= reg_next_0_d_multiplication_23_tc_io_o;
            reg_10_l_subtraction_48_io_a <= reg_next_10_l_subtraction_48_io_a;
            reg_8_l_addition_27_io_a <= reg_next_8_l_addition_27_io_a;
            reg_0_d_multiplication_38_sint_mul_adder_17_io_r <= reg_next_0_d_multiplication_38_sint_mul_adder_17_io_r;
            reg_0_d_multiplication_24_sint_mul_gen_addends_io_addend_20 <= reg_next_0_d_multiplication_24_sint_mul_gen_addends_io_addend_20;
            reg_10_l_addition_43_io_b <= reg_next_10_l_addition_43_io_b;
            reg_15_valid_chain <= reg_next_15_valid_chain;
            reg_0_d_multiplication_45_sint_mul_adder_12_io_r <= reg_next_0_d_multiplication_45_sint_mul_adder_12_io_r;
            reg_9_d_consts_opt_io_c0_1 <= reg_next_9_d_consts_opt_io_c0_1;
            reg_0_d_multiplication_45_sint_mul_adder_19_io_r <= reg_next_0_d_multiplication_45_sint_mul_adder_19_io_r;
            reg_0_d_multiplication_23_sint_mul_gen_addends_io_addend_21 <= reg_next_0_d_multiplication_23_sint_mul_gen_addends_io_addend_21;
            reg_3_d_consts_opt_io_c0_1 <= reg_next_3_d_consts_opt_io_c0_1;
            reg_0_d_multiplication_23_sint_mul_gen_addends_io_addend_18 <= reg_next_0_d_multiplication_23_sint_mul_gen_addends_io_addend_18;
            reg_0_d_multiplication_45_sint_mul_adder_7_io_r <= reg_next_0_d_multiplication_45_sint_mul_adder_7_io_r;
            reg_0_d_multiplication_45_sint_mul_adder_10_io_r <= reg_next_0_d_multiplication_45_sint_mul_adder_10_io_r;
            reg_10_d_consts_opt_io_c0_95 <= reg_next_10_d_consts_opt_io_c0_95;
            reg_12_l_subtraction_48_io_a <= reg_next_12_l_subtraction_48_io_a;
            reg_0_d_consts_opt_io_c0_1 <= reg_next_0_d_consts_opt_io_c0_1;
            reg_3_l_subtraction_52_io_a <= reg_next_3_l_subtraction_52_io_a;
            reg_7_d_consts_opt_io_c0_1 <= reg_next_7_d_consts_opt_io_c0_1;
            reg_0_d_multiplication_23_sint_mul_gen_addends_io_addend_25 <= reg_next_0_d_multiplication_23_sint_mul_gen_addends_io_addend_25;
            reg_16_l_addition_43_io_b <= reg_next_16_l_addition_43_io_b;
            reg_0_d_multiplication_37_sint_mul_adder_15_io_r <= reg_next_0_d_multiplication_37_sint_mul_adder_15_io_r;
            reg_0_d_multiplication_24_sint_mul_gen_addends_io_addend_26 <= reg_next_0_d_multiplication_24_sint_mul_gen_addends_io_addend_26;
            reg_8_l_subtraction_33_io_b <= reg_next_8_l_subtraction_33_io_b;
            reg_0_d_multiplication_38_sint_mul_adder_5_io_r <= reg_next_0_d_multiplication_38_sint_mul_adder_5_io_r;
            reg_10_valid_chain <= reg_next_10_valid_chain;
            reg_0_d_multiplication_38_sint_mul_adder_3_io_r <= reg_next_0_d_multiplication_38_sint_mul_adder_3_io_r;
            reg_1_l_addition_14_io_b <= reg_next_1_l_addition_14_io_b;
            reg_4_d_itime_convertor_0_io_o <= reg_next_4_d_itime_convertor_0_io_o;
            reg_0_d_arith_shifter_26_io_o <= reg_next_0_d_arith_shifter_26_io_o;
            reg_22_d_to8bit_cvt_55_io_o <= reg_next_22_d_to8bit_cvt_55_io_o;
            reg_3_d_fract_36_io_o <= reg_next_3_d_fract_36_io_o;
            reg_0_d_arith_shifter_51_io_o <= reg_next_0_d_arith_shifter_51_io_o;
            reg_0_d_multiplication_38_sint_mul_adder_22_io_r <= reg_next_0_d_multiplication_38_sint_mul_adder_22_io_r;
            reg_0_d_multiplication_24_sint_mul_gen_addends_io_addend_23 <= reg_next_0_d_multiplication_24_sint_mul_gen_addends_io_addend_23;
            reg_2_l_addition_27_io_a <= reg_next_2_l_addition_27_io_a;
            reg_1_d_multiplication_24_sint_mul_adder_19_io_r <= reg_next_1_d_multiplication_24_sint_mul_adder_19_io_r;
            reg_0_d_multiplication_23_sint_mul_gen_addends_io_addend_22 <= reg_next_0_d_multiplication_23_sint_mul_gen_addends_io_addend_22;
            reg_4_d_to8bit_cvt_55_io_o <= reg_next_4_d_to8bit_cvt_55_io_o;
            reg_0_d_multiplication_23_sint_mul_gen_addends_io_addend_24 <= reg_next_0_d_multiplication_23_sint_mul_gen_addends_io_addend_24;
            reg_0_d_multiplication_38_sint_mul_adder_12_io_r <= reg_next_0_d_multiplication_38_sint_mul_adder_12_io_r;
            reg_3_d_multiplication_24_sint_mul_gen_addends_io_subend <= reg_next_3_d_multiplication_24_sint_mul_gen_addends_io_subend;
            reg_11_d_consts_opt_io_c0_95 <= reg_next_11_d_consts_opt_io_c0_95;
            reg_1_l_addition_12_io_b <= reg_next_1_l_addition_12_io_b;
            reg_13_d_to8bit_cvt_55_io_o <= reg_next_13_d_to8bit_cvt_55_io_o;
            reg_0_d_minx1mx_18_io_o <= reg_next_0_d_minx1mx_18_io_o;
            reg_0_d_multiplication_38_sint_mul_adder_20_io_r <= reg_next_0_d_multiplication_38_sint_mul_adder_20_io_r;
            reg_5_d_to8bit_cvt_55_io_o <= reg_next_5_d_to8bit_cvt_55_io_o;
            reg_0_l_addition_14_io_b <= reg_next_0_l_addition_14_io_b;
            reg_2_d_consts_opt_io_c0_95 <= reg_next_2_d_consts_opt_io_c0_95;
            reg_0_d_multiplication_38_sint_mul_adder_21_io_r <= reg_next_0_d_multiplication_38_sint_mul_adder_21_io_r;
            reg_23_valid_chain <= reg_next_23_valid_chain;
            reg_0_d_multiplication_23_sint_mul_adder_21_io_r <= reg_next_0_d_multiplication_23_sint_mul_adder_21_io_r;
            reg_1_d_multiplication_23_sint_mul_gen_addends_io_subend <= reg_next_1_d_multiplication_23_sint_mul_gen_addends_io_subend;
            reg_7_l_addition_27_io_a <= reg_next_7_l_addition_27_io_a;
            reg_7_l_subtraction_33_io_b <= reg_next_7_l_subtraction_33_io_b;
            reg_0_valid_chain <= reg_next_0_valid_chain;
            reg_4_d_consts_opt_io_c0_95 <= reg_next_4_d_consts_opt_io_c0_95;
            reg_0_d_frag_x <= reg_next_0_d_frag_x;
            reg_0_d_multiplication_38_sint_mul_adder_23_io_r <= reg_next_0_d_multiplication_38_sint_mul_adder_23_io_r;
            reg_17_d_to8bit_cvt_55_io_o <= reg_next_17_d_to8bit_cvt_55_io_o;
            reg_8_d_to8bit_cvt_55_io_o <= reg_next_8_d_to8bit_cvt_55_io_o;
            reg_0_d_multiplication_23_sint_mul_adder_24_io_r <= reg_next_0_d_multiplication_23_sint_mul_adder_24_io_r;
            reg_7_l_addition_43_io_b <= reg_next_7_l_addition_43_io_b;
            reg_5_d_fract_36_io_o <= reg_next_5_d_fract_36_io_o;
            reg_10_d_to8bit_cvt_55_io_o <= reg_next_10_d_to8bit_cvt_55_io_o;
            reg_20_l_subtraction_48_io_a <= reg_next_20_l_subtraction_48_io_a;
            reg_0_d_multiplication_23_sint_mul_gen_addends_io_subend <= reg_next_0_d_multiplication_23_sint_mul_gen_addends_io_subend;
            reg_0_d_multiplication_23_sint_mul_adder_17_io_r <= reg_next_0_d_multiplication_23_sint_mul_adder_17_io_r;
            reg_8_l_subtraction_48_io_a <= reg_next_8_l_subtraction_48_io_a;
            reg_1_l_subtraction_33_io_b <= reg_next_1_l_subtraction_33_io_b;
            reg_2_d_multiplication_24_sint_mul_gen_addends_io_subend <= reg_next_2_d_multiplication_24_sint_mul_gen_addends_io_subend;
            reg_2_d_multiplication_23_sint_mul_adder_16_io_r <= reg_next_2_d_multiplication_23_sint_mul_adder_16_io_r;
            reg_3_d_consts_opt_io_c5_5 <= reg_next_3_d_consts_opt_io_c5_5;
            reg_0_d_multiplication_23_sint_mul_adder_16_io_r <= reg_next_0_d_multiplication_23_sint_mul_adder_16_io_r;
            reg_0_d_multiplication_23_sint_mul_gen_addends_io_addend_26 <= reg_next_0_d_multiplication_23_sint_mul_gen_addends_io_addend_26;
            reg_0_d_multiplication_45_sint_mul_adder_11_io_r <= reg_next_0_d_multiplication_45_sint_mul_adder_11_io_r;
            reg_0_d_multiplication_45_sint_mul_adder_22_io_r <= reg_next_0_d_multiplication_45_sint_mul_adder_22_io_r;
            reg_0_d_subtraction_52_io_r <= reg_next_0_d_subtraction_52_io_r;
            reg_0_d_minx1mx_16_io_o <= reg_next_0_d_minx1mx_16_io_o;
            reg_14_valid_chain <= reg_next_14_valid_chain;
            reg_0_l_ceil_21_io_i <= reg_next_0_l_ceil_21_io_i;
            reg_2_d_multiplication_24_sint_mul_adder_16_io_r <= reg_next_2_d_multiplication_24_sint_mul_adder_16_io_r;
            reg_4_valid_chain <= reg_next_4_valid_chain;
            reg_2_d_multiplication_37_tc_io_o <= reg_next_2_d_multiplication_37_tc_io_o;
            reg_1_d_multiplication_38_sint_mul_adder_25_io_r <= reg_next_1_d_multiplication_38_sint_mul_adder_25_io_r;
            reg_0_d_multiplication_23_sint_mul_adder_8_io_r <= reg_next_0_d_multiplication_23_sint_mul_adder_8_io_r;
            reg_0_d_multiplication_38_sint_mul_adder_14_io_r <= reg_next_0_d_multiplication_38_sint_mul_adder_14_io_r;
            reg_0_d_multiplication_38_sint_mul_adder_24_io_r <= reg_next_0_d_multiplication_38_sint_mul_adder_24_io_r;
            reg_0_d_fract_17_io_o <= reg_next_0_d_fract_17_io_o;
            reg_4_d_multiplication_38_sint_mul_gen_addends_io_subend <= reg_next_4_d_multiplication_38_sint_mul_gen_addends_io_subend;
            reg_0_d_multiplication_45_sint_mul_adder_8_io_r <= reg_next_0_d_multiplication_45_sint_mul_adder_8_io_r;
            reg_0_d_multiplication_23_sint_mul_gen_addends_io_addend_16 <= reg_next_0_d_multiplication_23_sint_mul_gen_addends_io_addend_16;
            reg_4_l_subtraction_52_io_a <= reg_next_4_l_subtraction_52_io_a;
            reg_0_d_multiplication_24_tc_io_o <= reg_next_0_d_multiplication_24_tc_io_o;
            reg_1_d_multiplication_23_sint_mul_adder_19_io_r <= reg_next_1_d_multiplication_23_sint_mul_adder_19_io_r;
            reg_0_d_multiplication_23_sint_mul_gen_addends_io_addend_15 <= reg_next_0_d_multiplication_23_sint_mul_gen_addends_io_addend_15;
            reg_0_d_multiplication_24_sint_mul_gen_addends_io_addend_15 <= reg_next_0_d_multiplication_24_sint_mul_gen_addends_io_addend_15;
            reg_0_d_multiplication_38_sint_mul_adder_0_io_r <= reg_next_0_d_multiplication_38_sint_mul_adder_0_io_r;
            reg_1_d_multiplication_38_sint_mul_gen_addends_io_subend <= reg_next_1_d_multiplication_38_sint_mul_gen_addends_io_subend;
            reg_14_d_to8bit_cvt_55_io_o <= reg_next_14_d_to8bit_cvt_55_io_o;
            reg_0_d_multiplication_24_sint_mul_gen_addends_io_subend <= reg_next_0_d_multiplication_24_sint_mul_gen_addends_io_subend;
            reg_9_l_addition_43_io_b <= reg_next_9_l_addition_43_io_b;
            reg_13_l_subtraction_48_io_a <= reg_next_13_l_subtraction_48_io_a;
            reg_0_l_subtraction_52_io_a <= reg_next_0_l_subtraction_52_io_a;
            reg_0_d_multiplication_38_sint_mul_adder_6_io_r <= reg_next_0_d_multiplication_38_sint_mul_adder_6_io_r;
            reg_0_d_multiplication_45_sint_mul_adder_4_io_r <= reg_next_0_d_multiplication_45_sint_mul_adder_4_io_r;
            reg_1_d_multiplication_24_sint_mul_adder_16_io_r <= reg_next_1_d_multiplication_24_sint_mul_adder_16_io_r;
            reg_0_d_clamp01_44_io_o <= reg_next_0_d_clamp01_44_io_o;
            reg_2_d_multiplication_45_sint_mul_adder_21_io_r <= reg_next_2_d_multiplication_45_sint_mul_adder_21_io_r;
            reg_18_valid_chain <= reg_next_18_valid_chain;
            reg_1_d_multiplication_45_sint_mul_adder_20_io_r <= reg_next_1_d_multiplication_45_sint_mul_adder_20_io_r;
            reg_18_l_subtraction_48_io_a <= reg_next_18_l_subtraction_48_io_a;
            reg_3_d_multiplication_45_tc_io_o <= reg_next_3_d_multiplication_45_tc_io_o;
            reg_0_d_multiplication_45_sint_mul_adder_16_io_r <= reg_next_0_d_multiplication_45_sint_mul_adder_16_io_r;
            reg_15_d_to8bit_cvt_55_io_o <= reg_next_15_d_to8bit_cvt_55_io_o;
        end if;
    end process;

    itime_convertor_0: ITimeConvertor_UInt_64_SFixedPoint_16_12
        port map(
            i => itime_convertor_0_io_i,
            o => itime_convertor_0_io_o
        );

    fragcoord_value_convertor_1: FragCoordValueConvertor_UInt_12_SFixedPoint_16_12
        port map(
            i => fragcoord_value_convertor_1_io_i,
            o => fragcoord_value_convertor_1_io_o
        );

    fragcoord_value_convertor_2: FragCoordValueConvertor_UInt_12_SFixedPoint_16_12
        port map(
            i => fragcoord_value_convertor_2_io_i,
            o => fragcoord_value_convertor_2_io_o
        );

    consts_opt: Constants_ba508eb47443af17_Core
        port map(
            c0_1 => consts_opt_io_c0_1,
            c0_95 => consts_opt_io_c0_95,
            c1 => consts_opt_io_c1,
            c3_75 => consts_opt_io_c3_75,
            c5 => consts_opt_io_c5,
            c5_5 => consts_opt_io_c5_5,
            c384 => consts_opt_io_c384
        );

    arith_shifter_3: ArithShifter_NEG9_SFixedPoint_16_12
        port map(
            i => arith_shifter_3_io_i,
            o => arith_shifter_3_io_o
        );

    arith_shifter_4: ArithShifter_NEG7_SFixedPoint_16_12
        port map(
            i => arith_shifter_4_io_i,
            o => arith_shifter_4_io_o
        );

    addition_5: BitsAdd_SFixedPoint_16_12_SFixedPoint_16_12
        port map(
            a => addition_5_io_a,
            b => addition_5_io_b,
            r => addition_5_io_r
        );

    subtraction_6: BitsSubtract_SFixedPoint_16_12_SFixedPoint_16_12
        port map(
            a => subtraction_6_io_a,
            b => subtraction_6_io_b,
            r => subtraction_6_io_r
        );

    arith_shifter_7: ArithShifter_NEG9_SFixedPoint_16_12
        port map(
            i => arith_shifter_7_io_i,
            o => arith_shifter_7_io_o
        );

    arith_shifter_8: ArithShifter_NEG7_SFixedPoint_16_12
        port map(
            i => arith_shifter_8_io_i,
            o => arith_shifter_8_io_o
        );

    addition_9: BitsAdd_SFixedPoint_16_12_SFixedPoint_16_12
        port map(
            a => addition_9_io_a,
            b => addition_9_io_b,
            r => addition_9_io_r
        );

    subtraction_10: BitsSubtract_SFixedPoint_16_12_SFixedPoint_16_12
        port map(
            a => subtraction_10_io_a,
            b => subtraction_10_io_b,
            r => subtraction_10_io_r
        );

    subtraction_11: BitsSubtract_SFixedPoint_16_12_SFixedPoint_16_12
        port map(
            a => subtraction_11_io_a,
            b => subtraction_11_io_b,
            r => subtraction_11_io_r
        );

    addition_12: BitsAdd_SFixedPoint_16_12_SFixedPoint_16_12
        port map(
            a => addition_12_io_a,
            b => addition_12_io_b,
            r => addition_12_io_r
        );

    addition_13: BitsAdd_SFixedPoint_16_12_SFixedPoint_16_12
        port map(
            a => addition_13_io_a,
            b => addition_13_io_b,
            r => addition_13_io_r
        );

    addition_14: BitsAdd_SFixedPoint_16_12_SFixedPoint_16_12
        port map(
            a => addition_14_io_a,
            b => addition_14_io_b,
            r => addition_14_io_r
        );

    fract_15: Fract_SFixedPoint_16_12
        port map(
            i => fract_15_io_i,
            o => fract_15_io_o
        );

    minx1mx_16: MinPositiveXandOneMinusX_SFixedPoint_16_12
        port map(
            i => minx1mx_16_io_i,
            o => minx1mx_16_io_o
        );

    fract_17: Fract_SFixedPoint_16_12
        port map(
            i => fract_17_io_i,
            o => fract_17_io_o
        );

    minx1mx_18: MinPositiveXandOneMinusX_SFixedPoint_16_12
        port map(
            i => minx1mx_18_io_i,
            o => minx1mx_18_io_o
        );

    ceil_19: Ceil_SFixedPoint_16_12
        port map(
            i => ceil_19_io_i,
            o => ceil_19_io_o
        );

    subtraction_20: BitsSubtract_SFixedPoint_16_12_SFixedPoint_16_12
        port map(
            a => subtraction_20_io_a,
            b => subtraction_20_io_b,
            r => subtraction_20_io_r
        );

    ceil_21: Ceil_SFixedPoint_16_12
        port map(
            i => ceil_21_io_i,
            o => ceil_21_io_o
        );

    subtraction_22: BitsSubtract_SFixedPoint_16_12_SFixedPoint_16_12
        port map(
            a => subtraction_22_io_a,
            b => subtraction_22_io_b,
            r => subtraction_22_io_r
        );

    multiplication_23_sint_mul_gen_addends: Multiply_SInt_29_SInt_29_AddendsGenerator
        port map(
            long => multiplication_23_sint_mul_gen_addends_io_long,
            short => multiplication_23_sint_mul_gen_addends_io_short,
            addend_0 => multiplication_23_sint_mul_gen_addends_io_addend_0,
            addend_1 => multiplication_23_sint_mul_gen_addends_io_addend_1,
            addend_2 => multiplication_23_sint_mul_gen_addends_io_addend_2,
            addend_3 => multiplication_23_sint_mul_gen_addends_io_addend_3,
            addend_4 => multiplication_23_sint_mul_gen_addends_io_addend_4,
            addend_5 => multiplication_23_sint_mul_gen_addends_io_addend_5,
            addend_6 => multiplication_23_sint_mul_gen_addends_io_addend_6,
            addend_7 => multiplication_23_sint_mul_gen_addends_io_addend_7,
            addend_8 => multiplication_23_sint_mul_gen_addends_io_addend_8,
            addend_9 => multiplication_23_sint_mul_gen_addends_io_addend_9,
            addend_10 => multiplication_23_sint_mul_gen_addends_io_addend_10,
            addend_11 => multiplication_23_sint_mul_gen_addends_io_addend_11,
            addend_12 => multiplication_23_sint_mul_gen_addends_io_addend_12,
            addend_13 => multiplication_23_sint_mul_gen_addends_io_addend_13,
            addend_14 => multiplication_23_sint_mul_gen_addends_io_addend_14,
            addend_15 => multiplication_23_sint_mul_gen_addends_io_addend_15,
            addend_16 => multiplication_23_sint_mul_gen_addends_io_addend_16,
            addend_17 => multiplication_23_sint_mul_gen_addends_io_addend_17,
            addend_18 => multiplication_23_sint_mul_gen_addends_io_addend_18,
            addend_19 => multiplication_23_sint_mul_gen_addends_io_addend_19,
            addend_20 => multiplication_23_sint_mul_gen_addends_io_addend_20,
            addend_21 => multiplication_23_sint_mul_gen_addends_io_addend_21,
            addend_22 => multiplication_23_sint_mul_gen_addends_io_addend_22,
            addend_23 => multiplication_23_sint_mul_gen_addends_io_addend_23,
            addend_24 => multiplication_23_sint_mul_gen_addends_io_addend_24,
            addend_25 => multiplication_23_sint_mul_gen_addends_io_addend_25,
            addend_26 => multiplication_23_sint_mul_gen_addends_io_addend_26,
            addend_27 => multiplication_23_sint_mul_gen_addends_io_addend_27,
            subend => multiplication_23_sint_mul_gen_addends_io_subend
        );

    multiplication_23_sint_mul_adder_0: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_23_sint_mul_adder_0_io_a,
            b => multiplication_23_sint_mul_adder_0_io_b,
            r => multiplication_23_sint_mul_adder_0_io_r
        );

    multiplication_23_sint_mul_adder_1: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_23_sint_mul_adder_1_io_a,
            b => multiplication_23_sint_mul_adder_1_io_b,
            r => multiplication_23_sint_mul_adder_1_io_r
        );

    multiplication_23_sint_mul_adder_2: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_23_sint_mul_adder_2_io_a,
            b => multiplication_23_sint_mul_adder_2_io_b,
            r => multiplication_23_sint_mul_adder_2_io_r
        );

    multiplication_23_sint_mul_adder_3: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_23_sint_mul_adder_3_io_a,
            b => multiplication_23_sint_mul_adder_3_io_b,
            r => multiplication_23_sint_mul_adder_3_io_r
        );

    multiplication_23_sint_mul_adder_4: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_23_sint_mul_adder_4_io_a,
            b => multiplication_23_sint_mul_adder_4_io_b,
            r => multiplication_23_sint_mul_adder_4_io_r
        );

    multiplication_23_sint_mul_adder_5: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_23_sint_mul_adder_5_io_a,
            b => multiplication_23_sint_mul_adder_5_io_b,
            r => multiplication_23_sint_mul_adder_5_io_r
        );

    multiplication_23_sint_mul_adder_6: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_23_sint_mul_adder_6_io_a,
            b => multiplication_23_sint_mul_adder_6_io_b,
            r => multiplication_23_sint_mul_adder_6_io_r
        );

    multiplication_23_sint_mul_adder_7: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_23_sint_mul_adder_7_io_a,
            b => multiplication_23_sint_mul_adder_7_io_b,
            r => multiplication_23_sint_mul_adder_7_io_r
        );

    multiplication_23_sint_mul_adder_8: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_23_sint_mul_adder_8_io_a,
            b => multiplication_23_sint_mul_adder_8_io_b,
            r => multiplication_23_sint_mul_adder_8_io_r
        );

    multiplication_23_sint_mul_adder_9: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_23_sint_mul_adder_9_io_a,
            b => multiplication_23_sint_mul_adder_9_io_b,
            r => multiplication_23_sint_mul_adder_9_io_r
        );

    multiplication_23_sint_mul_adder_10: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_23_sint_mul_adder_10_io_a,
            b => multiplication_23_sint_mul_adder_10_io_b,
            r => multiplication_23_sint_mul_adder_10_io_r
        );

    multiplication_23_sint_mul_adder_11: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_23_sint_mul_adder_11_io_a,
            b => multiplication_23_sint_mul_adder_11_io_b,
            r => multiplication_23_sint_mul_adder_11_io_r
        );

    multiplication_23_sint_mul_adder_12: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_23_sint_mul_adder_12_io_a,
            b => multiplication_23_sint_mul_adder_12_io_b,
            r => multiplication_23_sint_mul_adder_12_io_r
        );

    multiplication_23_sint_mul_adder_13: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_23_sint_mul_adder_13_io_a,
            b => multiplication_23_sint_mul_adder_13_io_b,
            r => multiplication_23_sint_mul_adder_13_io_r
        );

    multiplication_23_sint_mul_adder_14: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_23_sint_mul_adder_14_io_a,
            b => multiplication_23_sint_mul_adder_14_io_b,
            r => multiplication_23_sint_mul_adder_14_io_r
        );

    multiplication_23_sint_mul_adder_15: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_23_sint_mul_adder_15_io_a,
            b => multiplication_23_sint_mul_adder_15_io_b,
            r => multiplication_23_sint_mul_adder_15_io_r
        );

    multiplication_23_sint_mul_adder_16: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_23_sint_mul_adder_16_io_a,
            b => multiplication_23_sint_mul_adder_16_io_b,
            r => multiplication_23_sint_mul_adder_16_io_r
        );

    multiplication_23_sint_mul_adder_17: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_23_sint_mul_adder_17_io_a,
            b => multiplication_23_sint_mul_adder_17_io_b,
            r => multiplication_23_sint_mul_adder_17_io_r
        );

    multiplication_23_sint_mul_adder_18: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_23_sint_mul_adder_18_io_a,
            b => multiplication_23_sint_mul_adder_18_io_b,
            r => multiplication_23_sint_mul_adder_18_io_r
        );

    multiplication_23_sint_mul_adder_19: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_23_sint_mul_adder_19_io_a,
            b => multiplication_23_sint_mul_adder_19_io_b,
            r => multiplication_23_sint_mul_adder_19_io_r
        );

    multiplication_23_sint_mul_adder_20: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_23_sint_mul_adder_20_io_a,
            b => multiplication_23_sint_mul_adder_20_io_b,
            r => multiplication_23_sint_mul_adder_20_io_r
        );

    multiplication_23_sint_mul_adder_21: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_23_sint_mul_adder_21_io_a,
            b => multiplication_23_sint_mul_adder_21_io_b,
            r => multiplication_23_sint_mul_adder_21_io_r
        );

    multiplication_23_sint_mul_adder_22: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_23_sint_mul_adder_22_io_a,
            b => multiplication_23_sint_mul_adder_22_io_b,
            r => multiplication_23_sint_mul_adder_22_io_r
        );

    multiplication_23_sint_mul_adder_23: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_23_sint_mul_adder_23_io_a,
            b => multiplication_23_sint_mul_adder_23_io_b,
            r => multiplication_23_sint_mul_adder_23_io_r
        );

    multiplication_23_sint_mul_adder_24: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_23_sint_mul_adder_24_io_a,
            b => multiplication_23_sint_mul_adder_24_io_b,
            r => multiplication_23_sint_mul_adder_24_io_r
        );

    multiplication_23_sint_mul_adder_25: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_23_sint_mul_adder_25_io_a,
            b => multiplication_23_sint_mul_adder_25_io_b,
            r => multiplication_23_sint_mul_adder_25_io_r
        );

    multiplication_23_sint_mul_adder_26: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_23_sint_mul_adder_26_io_a,
            b => multiplication_23_sint_mul_adder_26_io_b,
            r => multiplication_23_sint_mul_adder_26_io_r
        );

    multiplication_23_sint_mul_subtractor: BitsSubtract_SInt_58_SInt_58
        port map(
            a => multiplication_23_sint_mul_subtractor_io_a,
            b => multiplication_23_sint_mul_subtractor_io_b,
            r => multiplication_23_sint_mul_subtractor_io_r
        );

    multiplication_23_tc: Multiply_SFixedPoint_16_12_SFixedPoint_16_12_Truncated_Truncator
        port map(
            i => multiplication_23_tc_io_i,
            o => multiplication_23_tc_io_o
        );

    multiplication_24_sint_mul_gen_addends: Multiply_SInt_29_SInt_29_AddendsGenerator
        port map(
            long => multiplication_24_sint_mul_gen_addends_io_long,
            short => multiplication_24_sint_mul_gen_addends_io_short,
            addend_0 => multiplication_24_sint_mul_gen_addends_io_addend_0,
            addend_1 => multiplication_24_sint_mul_gen_addends_io_addend_1,
            addend_2 => multiplication_24_sint_mul_gen_addends_io_addend_2,
            addend_3 => multiplication_24_sint_mul_gen_addends_io_addend_3,
            addend_4 => multiplication_24_sint_mul_gen_addends_io_addend_4,
            addend_5 => multiplication_24_sint_mul_gen_addends_io_addend_5,
            addend_6 => multiplication_24_sint_mul_gen_addends_io_addend_6,
            addend_7 => multiplication_24_sint_mul_gen_addends_io_addend_7,
            addend_8 => multiplication_24_sint_mul_gen_addends_io_addend_8,
            addend_9 => multiplication_24_sint_mul_gen_addends_io_addend_9,
            addend_10 => multiplication_24_sint_mul_gen_addends_io_addend_10,
            addend_11 => multiplication_24_sint_mul_gen_addends_io_addend_11,
            addend_12 => multiplication_24_sint_mul_gen_addends_io_addend_12,
            addend_13 => multiplication_24_sint_mul_gen_addends_io_addend_13,
            addend_14 => multiplication_24_sint_mul_gen_addends_io_addend_14,
            addend_15 => multiplication_24_sint_mul_gen_addends_io_addend_15,
            addend_16 => multiplication_24_sint_mul_gen_addends_io_addend_16,
            addend_17 => multiplication_24_sint_mul_gen_addends_io_addend_17,
            addend_18 => multiplication_24_sint_mul_gen_addends_io_addend_18,
            addend_19 => multiplication_24_sint_mul_gen_addends_io_addend_19,
            addend_20 => multiplication_24_sint_mul_gen_addends_io_addend_20,
            addend_21 => multiplication_24_sint_mul_gen_addends_io_addend_21,
            addend_22 => multiplication_24_sint_mul_gen_addends_io_addend_22,
            addend_23 => multiplication_24_sint_mul_gen_addends_io_addend_23,
            addend_24 => multiplication_24_sint_mul_gen_addends_io_addend_24,
            addend_25 => multiplication_24_sint_mul_gen_addends_io_addend_25,
            addend_26 => multiplication_24_sint_mul_gen_addends_io_addend_26,
            addend_27 => multiplication_24_sint_mul_gen_addends_io_addend_27,
            subend => multiplication_24_sint_mul_gen_addends_io_subend
        );

    multiplication_24_sint_mul_adder_0: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_24_sint_mul_adder_0_io_a,
            b => multiplication_24_sint_mul_adder_0_io_b,
            r => multiplication_24_sint_mul_adder_0_io_r
        );

    multiplication_24_sint_mul_adder_1: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_24_sint_mul_adder_1_io_a,
            b => multiplication_24_sint_mul_adder_1_io_b,
            r => multiplication_24_sint_mul_adder_1_io_r
        );

    multiplication_24_sint_mul_adder_2: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_24_sint_mul_adder_2_io_a,
            b => multiplication_24_sint_mul_adder_2_io_b,
            r => multiplication_24_sint_mul_adder_2_io_r
        );

    multiplication_24_sint_mul_adder_3: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_24_sint_mul_adder_3_io_a,
            b => multiplication_24_sint_mul_adder_3_io_b,
            r => multiplication_24_sint_mul_adder_3_io_r
        );

    multiplication_24_sint_mul_adder_4: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_24_sint_mul_adder_4_io_a,
            b => multiplication_24_sint_mul_adder_4_io_b,
            r => multiplication_24_sint_mul_adder_4_io_r
        );

    multiplication_24_sint_mul_adder_5: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_24_sint_mul_adder_5_io_a,
            b => multiplication_24_sint_mul_adder_5_io_b,
            r => multiplication_24_sint_mul_adder_5_io_r
        );

    multiplication_24_sint_mul_adder_6: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_24_sint_mul_adder_6_io_a,
            b => multiplication_24_sint_mul_adder_6_io_b,
            r => multiplication_24_sint_mul_adder_6_io_r
        );

    multiplication_24_sint_mul_adder_7: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_24_sint_mul_adder_7_io_a,
            b => multiplication_24_sint_mul_adder_7_io_b,
            r => multiplication_24_sint_mul_adder_7_io_r
        );

    multiplication_24_sint_mul_adder_8: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_24_sint_mul_adder_8_io_a,
            b => multiplication_24_sint_mul_adder_8_io_b,
            r => multiplication_24_sint_mul_adder_8_io_r
        );

    multiplication_24_sint_mul_adder_9: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_24_sint_mul_adder_9_io_a,
            b => multiplication_24_sint_mul_adder_9_io_b,
            r => multiplication_24_sint_mul_adder_9_io_r
        );

    multiplication_24_sint_mul_adder_10: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_24_sint_mul_adder_10_io_a,
            b => multiplication_24_sint_mul_adder_10_io_b,
            r => multiplication_24_sint_mul_adder_10_io_r
        );

    multiplication_24_sint_mul_adder_11: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_24_sint_mul_adder_11_io_a,
            b => multiplication_24_sint_mul_adder_11_io_b,
            r => multiplication_24_sint_mul_adder_11_io_r
        );

    multiplication_24_sint_mul_adder_12: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_24_sint_mul_adder_12_io_a,
            b => multiplication_24_sint_mul_adder_12_io_b,
            r => multiplication_24_sint_mul_adder_12_io_r
        );

    multiplication_24_sint_mul_adder_13: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_24_sint_mul_adder_13_io_a,
            b => multiplication_24_sint_mul_adder_13_io_b,
            r => multiplication_24_sint_mul_adder_13_io_r
        );

    multiplication_24_sint_mul_adder_14: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_24_sint_mul_adder_14_io_a,
            b => multiplication_24_sint_mul_adder_14_io_b,
            r => multiplication_24_sint_mul_adder_14_io_r
        );

    multiplication_24_sint_mul_adder_15: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_24_sint_mul_adder_15_io_a,
            b => multiplication_24_sint_mul_adder_15_io_b,
            r => multiplication_24_sint_mul_adder_15_io_r
        );

    multiplication_24_sint_mul_adder_16: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_24_sint_mul_adder_16_io_a,
            b => multiplication_24_sint_mul_adder_16_io_b,
            r => multiplication_24_sint_mul_adder_16_io_r
        );

    multiplication_24_sint_mul_adder_17: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_24_sint_mul_adder_17_io_a,
            b => multiplication_24_sint_mul_adder_17_io_b,
            r => multiplication_24_sint_mul_adder_17_io_r
        );

    multiplication_24_sint_mul_adder_18: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_24_sint_mul_adder_18_io_a,
            b => multiplication_24_sint_mul_adder_18_io_b,
            r => multiplication_24_sint_mul_adder_18_io_r
        );

    multiplication_24_sint_mul_adder_19: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_24_sint_mul_adder_19_io_a,
            b => multiplication_24_sint_mul_adder_19_io_b,
            r => multiplication_24_sint_mul_adder_19_io_r
        );

    multiplication_24_sint_mul_adder_20: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_24_sint_mul_adder_20_io_a,
            b => multiplication_24_sint_mul_adder_20_io_b,
            r => multiplication_24_sint_mul_adder_20_io_r
        );

    multiplication_24_sint_mul_adder_21: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_24_sint_mul_adder_21_io_a,
            b => multiplication_24_sint_mul_adder_21_io_b,
            r => multiplication_24_sint_mul_adder_21_io_r
        );

    multiplication_24_sint_mul_adder_22: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_24_sint_mul_adder_22_io_a,
            b => multiplication_24_sint_mul_adder_22_io_b,
            r => multiplication_24_sint_mul_adder_22_io_r
        );

    multiplication_24_sint_mul_adder_23: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_24_sint_mul_adder_23_io_a,
            b => multiplication_24_sint_mul_adder_23_io_b,
            r => multiplication_24_sint_mul_adder_23_io_r
        );

    multiplication_24_sint_mul_adder_24: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_24_sint_mul_adder_24_io_a,
            b => multiplication_24_sint_mul_adder_24_io_b,
            r => multiplication_24_sint_mul_adder_24_io_r
        );

    multiplication_24_sint_mul_adder_25: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_24_sint_mul_adder_25_io_a,
            b => multiplication_24_sint_mul_adder_25_io_b,
            r => multiplication_24_sint_mul_adder_25_io_r
        );

    multiplication_24_sint_mul_adder_26: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_24_sint_mul_adder_26_io_a,
            b => multiplication_24_sint_mul_adder_26_io_b,
            r => multiplication_24_sint_mul_adder_26_io_r
        );

    multiplication_24_sint_mul_subtractor: BitsSubtract_SInt_58_SInt_58
        port map(
            a => multiplication_24_sint_mul_subtractor_io_a,
            b => multiplication_24_sint_mul_subtractor_io_b,
            r => multiplication_24_sint_mul_subtractor_io_r
        );

    multiplication_24_tc: Multiply_SFixedPoint_16_12_SFixedPoint_16_12_Truncated_Truncator
        port map(
            i => multiplication_24_tc_io_i,
            o => multiplication_24_tc_io_o
        );

    addition_25: BitsAdd_SFixedPoint_16_12_SFixedPoint_16_12
        port map(
            a => addition_25_io_a,
            b => addition_25_io_b,
            r => addition_25_io_r
        );

    arith_shifter_26: ArithShifter_NEG3_SFixedPoint_16_12
        port map(
            i => arith_shifter_26_io_i,
            o => arith_shifter_26_io_o
        );

    addition_27: BitsAdd_SFixedPoint_16_12_SFixedPoint_16_12
        port map(
            a => addition_27_io_a,
            b => addition_27_io_b,
            r => addition_27_io_r
        );

    arith_shifter_28: ArithShifter_NEG1_SFixedPoint_16_12
        port map(
            i => arith_shifter_28_io_i,
            o => arith_shifter_28_io_o
        );

    subtraction_29: BitsSubtract_SFixedPoint_16_12_SFixedPoint_16_12
        port map(
            a => subtraction_29_io_a,
            b => subtraction_29_io_b,
            r => subtraction_29_io_r
        );

    arith_shifter_30: ArithShifter_NEG2_SFixedPoint_16_12
        port map(
            i => arith_shifter_30_io_i,
            o => arith_shifter_30_io_o
        );

    fract_31: Fract_SFixedPoint_16_12
        port map(
            i => fract_31_io_i,
            o => fract_31_io_o
        );

    arith_shifter_32: ArithShifter_1_SFixedPoint_16_12
        port map(
            i => arith_shifter_32_io_i,
            o => arith_shifter_32_io_o
        );

    subtraction_33: BitsSubtract_SFixedPoint_16_12_SFixedPoint_16_12
        port map(
            a => subtraction_33_io_a,
            b => subtraction_33_io_b,
            r => subtraction_33_io_r
        );

    min_34: Min_SFixedPoint_16_12_SFixedPoint_16_12
        port map(
            a => min_34_io_a,
            b => min_34_io_b,
            o => min_34_io_o
        );

    arith_shifter_35: ArithShifter_2_SFixedPoint_16_12
        port map(
            i => arith_shifter_35_io_i,
            o => arith_shifter_35_io_o
        );

    fract_36: Fract_SFixedPoint_16_12
        port map(
            i => fract_36_io_i,
            o => fract_36_io_o
        );

    mux_calc: CustomVHDLOperator_447d1b8997193967
        port map(
            ee => mux_calc_io_ee,
            vv => mux_calc_io_vv,
            o => mux_calc_io_o
        );

    multiplication_37_sint_mul_gen_addends: Multiply_SInt_29_SInt_29_AddendsGenerator
        port map(
            long => multiplication_37_sint_mul_gen_addends_io_long,
            short => multiplication_37_sint_mul_gen_addends_io_short,
            addend_0 => multiplication_37_sint_mul_gen_addends_io_addend_0,
            addend_1 => multiplication_37_sint_mul_gen_addends_io_addend_1,
            addend_2 => multiplication_37_sint_mul_gen_addends_io_addend_2,
            addend_3 => multiplication_37_sint_mul_gen_addends_io_addend_3,
            addend_4 => multiplication_37_sint_mul_gen_addends_io_addend_4,
            addend_5 => multiplication_37_sint_mul_gen_addends_io_addend_5,
            addend_6 => multiplication_37_sint_mul_gen_addends_io_addend_6,
            addend_7 => multiplication_37_sint_mul_gen_addends_io_addend_7,
            addend_8 => multiplication_37_sint_mul_gen_addends_io_addend_8,
            addend_9 => multiplication_37_sint_mul_gen_addends_io_addend_9,
            addend_10 => multiplication_37_sint_mul_gen_addends_io_addend_10,
            addend_11 => multiplication_37_sint_mul_gen_addends_io_addend_11,
            addend_12 => multiplication_37_sint_mul_gen_addends_io_addend_12,
            addend_13 => multiplication_37_sint_mul_gen_addends_io_addend_13,
            addend_14 => multiplication_37_sint_mul_gen_addends_io_addend_14,
            addend_15 => multiplication_37_sint_mul_gen_addends_io_addend_15,
            addend_16 => multiplication_37_sint_mul_gen_addends_io_addend_16,
            addend_17 => multiplication_37_sint_mul_gen_addends_io_addend_17,
            addend_18 => multiplication_37_sint_mul_gen_addends_io_addend_18,
            addend_19 => multiplication_37_sint_mul_gen_addends_io_addend_19,
            addend_20 => multiplication_37_sint_mul_gen_addends_io_addend_20,
            addend_21 => multiplication_37_sint_mul_gen_addends_io_addend_21,
            addend_22 => multiplication_37_sint_mul_gen_addends_io_addend_22,
            addend_23 => multiplication_37_sint_mul_gen_addends_io_addend_23,
            addend_24 => multiplication_37_sint_mul_gen_addends_io_addend_24,
            addend_25 => multiplication_37_sint_mul_gen_addends_io_addend_25,
            addend_26 => multiplication_37_sint_mul_gen_addends_io_addend_26,
            addend_27 => multiplication_37_sint_mul_gen_addends_io_addend_27,
            subend => multiplication_37_sint_mul_gen_addends_io_subend
        );

    multiplication_37_sint_mul_adder_0: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_37_sint_mul_adder_0_io_a,
            b => multiplication_37_sint_mul_adder_0_io_b,
            r => multiplication_37_sint_mul_adder_0_io_r
        );

    multiplication_37_sint_mul_adder_1: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_37_sint_mul_adder_1_io_a,
            b => multiplication_37_sint_mul_adder_1_io_b,
            r => multiplication_37_sint_mul_adder_1_io_r
        );

    multiplication_37_sint_mul_adder_2: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_37_sint_mul_adder_2_io_a,
            b => multiplication_37_sint_mul_adder_2_io_b,
            r => multiplication_37_sint_mul_adder_2_io_r
        );

    multiplication_37_sint_mul_adder_3: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_37_sint_mul_adder_3_io_a,
            b => multiplication_37_sint_mul_adder_3_io_b,
            r => multiplication_37_sint_mul_adder_3_io_r
        );

    multiplication_37_sint_mul_adder_4: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_37_sint_mul_adder_4_io_a,
            b => multiplication_37_sint_mul_adder_4_io_b,
            r => multiplication_37_sint_mul_adder_4_io_r
        );

    multiplication_37_sint_mul_adder_5: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_37_sint_mul_adder_5_io_a,
            b => multiplication_37_sint_mul_adder_5_io_b,
            r => multiplication_37_sint_mul_adder_5_io_r
        );

    multiplication_37_sint_mul_adder_6: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_37_sint_mul_adder_6_io_a,
            b => multiplication_37_sint_mul_adder_6_io_b,
            r => multiplication_37_sint_mul_adder_6_io_r
        );

    multiplication_37_sint_mul_adder_7: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_37_sint_mul_adder_7_io_a,
            b => multiplication_37_sint_mul_adder_7_io_b,
            r => multiplication_37_sint_mul_adder_7_io_r
        );

    multiplication_37_sint_mul_adder_8: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_37_sint_mul_adder_8_io_a,
            b => multiplication_37_sint_mul_adder_8_io_b,
            r => multiplication_37_sint_mul_adder_8_io_r
        );

    multiplication_37_sint_mul_adder_9: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_37_sint_mul_adder_9_io_a,
            b => multiplication_37_sint_mul_adder_9_io_b,
            r => multiplication_37_sint_mul_adder_9_io_r
        );

    multiplication_37_sint_mul_adder_10: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_37_sint_mul_adder_10_io_a,
            b => multiplication_37_sint_mul_adder_10_io_b,
            r => multiplication_37_sint_mul_adder_10_io_r
        );

    multiplication_37_sint_mul_adder_11: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_37_sint_mul_adder_11_io_a,
            b => multiplication_37_sint_mul_adder_11_io_b,
            r => multiplication_37_sint_mul_adder_11_io_r
        );

    multiplication_37_sint_mul_adder_12: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_37_sint_mul_adder_12_io_a,
            b => multiplication_37_sint_mul_adder_12_io_b,
            r => multiplication_37_sint_mul_adder_12_io_r
        );

    multiplication_37_sint_mul_adder_13: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_37_sint_mul_adder_13_io_a,
            b => multiplication_37_sint_mul_adder_13_io_b,
            r => multiplication_37_sint_mul_adder_13_io_r
        );

    multiplication_37_sint_mul_adder_14: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_37_sint_mul_adder_14_io_a,
            b => multiplication_37_sint_mul_adder_14_io_b,
            r => multiplication_37_sint_mul_adder_14_io_r
        );

    multiplication_37_sint_mul_adder_15: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_37_sint_mul_adder_15_io_a,
            b => multiplication_37_sint_mul_adder_15_io_b,
            r => multiplication_37_sint_mul_adder_15_io_r
        );

    multiplication_37_sint_mul_adder_16: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_37_sint_mul_adder_16_io_a,
            b => multiplication_37_sint_mul_adder_16_io_b,
            r => multiplication_37_sint_mul_adder_16_io_r
        );

    multiplication_37_sint_mul_adder_17: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_37_sint_mul_adder_17_io_a,
            b => multiplication_37_sint_mul_adder_17_io_b,
            r => multiplication_37_sint_mul_adder_17_io_r
        );

    multiplication_37_sint_mul_adder_18: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_37_sint_mul_adder_18_io_a,
            b => multiplication_37_sint_mul_adder_18_io_b,
            r => multiplication_37_sint_mul_adder_18_io_r
        );

    multiplication_37_sint_mul_adder_19: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_37_sint_mul_adder_19_io_a,
            b => multiplication_37_sint_mul_adder_19_io_b,
            r => multiplication_37_sint_mul_adder_19_io_r
        );

    multiplication_37_sint_mul_adder_20: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_37_sint_mul_adder_20_io_a,
            b => multiplication_37_sint_mul_adder_20_io_b,
            r => multiplication_37_sint_mul_adder_20_io_r
        );

    multiplication_37_sint_mul_adder_21: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_37_sint_mul_adder_21_io_a,
            b => multiplication_37_sint_mul_adder_21_io_b,
            r => multiplication_37_sint_mul_adder_21_io_r
        );

    multiplication_37_sint_mul_adder_22: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_37_sint_mul_adder_22_io_a,
            b => multiplication_37_sint_mul_adder_22_io_b,
            r => multiplication_37_sint_mul_adder_22_io_r
        );

    multiplication_37_sint_mul_adder_23: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_37_sint_mul_adder_23_io_a,
            b => multiplication_37_sint_mul_adder_23_io_b,
            r => multiplication_37_sint_mul_adder_23_io_r
        );

    multiplication_37_sint_mul_adder_24: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_37_sint_mul_adder_24_io_a,
            b => multiplication_37_sint_mul_adder_24_io_b,
            r => multiplication_37_sint_mul_adder_24_io_r
        );

    multiplication_37_sint_mul_adder_25: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_37_sint_mul_adder_25_io_a,
            b => multiplication_37_sint_mul_adder_25_io_b,
            r => multiplication_37_sint_mul_adder_25_io_r
        );

    multiplication_37_sint_mul_adder_26: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_37_sint_mul_adder_26_io_a,
            b => multiplication_37_sint_mul_adder_26_io_b,
            r => multiplication_37_sint_mul_adder_26_io_r
        );

    multiplication_37_sint_mul_subtractor: BitsSubtract_SInt_58_SInt_58
        port map(
            a => multiplication_37_sint_mul_subtractor_io_a,
            b => multiplication_37_sint_mul_subtractor_io_b,
            r => multiplication_37_sint_mul_subtractor_io_r
        );

    multiplication_37_tc: Multiply_SFixedPoint_16_12_SFixedPoint_16_12_Truncated_Truncator
        port map(
            i => multiplication_37_tc_io_i,
            o => multiplication_37_tc_io_o
        );

    multiplication_38_sint_mul_gen_addends: Multiply_SInt_29_SInt_29_AddendsGenerator
        port map(
            long => multiplication_38_sint_mul_gen_addends_io_long,
            short => multiplication_38_sint_mul_gen_addends_io_short,
            addend_0 => multiplication_38_sint_mul_gen_addends_io_addend_0,
            addend_1 => multiplication_38_sint_mul_gen_addends_io_addend_1,
            addend_2 => multiplication_38_sint_mul_gen_addends_io_addend_2,
            addend_3 => multiplication_38_sint_mul_gen_addends_io_addend_3,
            addend_4 => multiplication_38_sint_mul_gen_addends_io_addend_4,
            addend_5 => multiplication_38_sint_mul_gen_addends_io_addend_5,
            addend_6 => multiplication_38_sint_mul_gen_addends_io_addend_6,
            addend_7 => multiplication_38_sint_mul_gen_addends_io_addend_7,
            addend_8 => multiplication_38_sint_mul_gen_addends_io_addend_8,
            addend_9 => multiplication_38_sint_mul_gen_addends_io_addend_9,
            addend_10 => multiplication_38_sint_mul_gen_addends_io_addend_10,
            addend_11 => multiplication_38_sint_mul_gen_addends_io_addend_11,
            addend_12 => multiplication_38_sint_mul_gen_addends_io_addend_12,
            addend_13 => multiplication_38_sint_mul_gen_addends_io_addend_13,
            addend_14 => multiplication_38_sint_mul_gen_addends_io_addend_14,
            addend_15 => multiplication_38_sint_mul_gen_addends_io_addend_15,
            addend_16 => multiplication_38_sint_mul_gen_addends_io_addend_16,
            addend_17 => multiplication_38_sint_mul_gen_addends_io_addend_17,
            addend_18 => multiplication_38_sint_mul_gen_addends_io_addend_18,
            addend_19 => multiplication_38_sint_mul_gen_addends_io_addend_19,
            addend_20 => multiplication_38_sint_mul_gen_addends_io_addend_20,
            addend_21 => multiplication_38_sint_mul_gen_addends_io_addend_21,
            addend_22 => multiplication_38_sint_mul_gen_addends_io_addend_22,
            addend_23 => multiplication_38_sint_mul_gen_addends_io_addend_23,
            addend_24 => multiplication_38_sint_mul_gen_addends_io_addend_24,
            addend_25 => multiplication_38_sint_mul_gen_addends_io_addend_25,
            addend_26 => multiplication_38_sint_mul_gen_addends_io_addend_26,
            addend_27 => multiplication_38_sint_mul_gen_addends_io_addend_27,
            subend => multiplication_38_sint_mul_gen_addends_io_subend
        );

    multiplication_38_sint_mul_adder_0: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_38_sint_mul_adder_0_io_a,
            b => multiplication_38_sint_mul_adder_0_io_b,
            r => multiplication_38_sint_mul_adder_0_io_r
        );

    multiplication_38_sint_mul_adder_1: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_38_sint_mul_adder_1_io_a,
            b => multiplication_38_sint_mul_adder_1_io_b,
            r => multiplication_38_sint_mul_adder_1_io_r
        );

    multiplication_38_sint_mul_adder_2: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_38_sint_mul_adder_2_io_a,
            b => multiplication_38_sint_mul_adder_2_io_b,
            r => multiplication_38_sint_mul_adder_2_io_r
        );

    multiplication_38_sint_mul_adder_3: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_38_sint_mul_adder_3_io_a,
            b => multiplication_38_sint_mul_adder_3_io_b,
            r => multiplication_38_sint_mul_adder_3_io_r
        );

    multiplication_38_sint_mul_adder_4: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_38_sint_mul_adder_4_io_a,
            b => multiplication_38_sint_mul_adder_4_io_b,
            r => multiplication_38_sint_mul_adder_4_io_r
        );

    multiplication_38_sint_mul_adder_5: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_38_sint_mul_adder_5_io_a,
            b => multiplication_38_sint_mul_adder_5_io_b,
            r => multiplication_38_sint_mul_adder_5_io_r
        );

    multiplication_38_sint_mul_adder_6: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_38_sint_mul_adder_6_io_a,
            b => multiplication_38_sint_mul_adder_6_io_b,
            r => multiplication_38_sint_mul_adder_6_io_r
        );

    multiplication_38_sint_mul_adder_7: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_38_sint_mul_adder_7_io_a,
            b => multiplication_38_sint_mul_adder_7_io_b,
            r => multiplication_38_sint_mul_adder_7_io_r
        );

    multiplication_38_sint_mul_adder_8: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_38_sint_mul_adder_8_io_a,
            b => multiplication_38_sint_mul_adder_8_io_b,
            r => multiplication_38_sint_mul_adder_8_io_r
        );

    multiplication_38_sint_mul_adder_9: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_38_sint_mul_adder_9_io_a,
            b => multiplication_38_sint_mul_adder_9_io_b,
            r => multiplication_38_sint_mul_adder_9_io_r
        );

    multiplication_38_sint_mul_adder_10: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_38_sint_mul_adder_10_io_a,
            b => multiplication_38_sint_mul_adder_10_io_b,
            r => multiplication_38_sint_mul_adder_10_io_r
        );

    multiplication_38_sint_mul_adder_11: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_38_sint_mul_adder_11_io_a,
            b => multiplication_38_sint_mul_adder_11_io_b,
            r => multiplication_38_sint_mul_adder_11_io_r
        );

    multiplication_38_sint_mul_adder_12: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_38_sint_mul_adder_12_io_a,
            b => multiplication_38_sint_mul_adder_12_io_b,
            r => multiplication_38_sint_mul_adder_12_io_r
        );

    multiplication_38_sint_mul_adder_13: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_38_sint_mul_adder_13_io_a,
            b => multiplication_38_sint_mul_adder_13_io_b,
            r => multiplication_38_sint_mul_adder_13_io_r
        );

    multiplication_38_sint_mul_adder_14: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_38_sint_mul_adder_14_io_a,
            b => multiplication_38_sint_mul_adder_14_io_b,
            r => multiplication_38_sint_mul_adder_14_io_r
        );

    multiplication_38_sint_mul_adder_15: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_38_sint_mul_adder_15_io_a,
            b => multiplication_38_sint_mul_adder_15_io_b,
            r => multiplication_38_sint_mul_adder_15_io_r
        );

    multiplication_38_sint_mul_adder_16: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_38_sint_mul_adder_16_io_a,
            b => multiplication_38_sint_mul_adder_16_io_b,
            r => multiplication_38_sint_mul_adder_16_io_r
        );

    multiplication_38_sint_mul_adder_17: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_38_sint_mul_adder_17_io_a,
            b => multiplication_38_sint_mul_adder_17_io_b,
            r => multiplication_38_sint_mul_adder_17_io_r
        );

    multiplication_38_sint_mul_adder_18: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_38_sint_mul_adder_18_io_a,
            b => multiplication_38_sint_mul_adder_18_io_b,
            r => multiplication_38_sint_mul_adder_18_io_r
        );

    multiplication_38_sint_mul_adder_19: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_38_sint_mul_adder_19_io_a,
            b => multiplication_38_sint_mul_adder_19_io_b,
            r => multiplication_38_sint_mul_adder_19_io_r
        );

    multiplication_38_sint_mul_adder_20: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_38_sint_mul_adder_20_io_a,
            b => multiplication_38_sint_mul_adder_20_io_b,
            r => multiplication_38_sint_mul_adder_20_io_r
        );

    multiplication_38_sint_mul_adder_21: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_38_sint_mul_adder_21_io_a,
            b => multiplication_38_sint_mul_adder_21_io_b,
            r => multiplication_38_sint_mul_adder_21_io_r
        );

    multiplication_38_sint_mul_adder_22: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_38_sint_mul_adder_22_io_a,
            b => multiplication_38_sint_mul_adder_22_io_b,
            r => multiplication_38_sint_mul_adder_22_io_r
        );

    multiplication_38_sint_mul_adder_23: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_38_sint_mul_adder_23_io_a,
            b => multiplication_38_sint_mul_adder_23_io_b,
            r => multiplication_38_sint_mul_adder_23_io_r
        );

    multiplication_38_sint_mul_adder_24: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_38_sint_mul_adder_24_io_a,
            b => multiplication_38_sint_mul_adder_24_io_b,
            r => multiplication_38_sint_mul_adder_24_io_r
        );

    multiplication_38_sint_mul_adder_25: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_38_sint_mul_adder_25_io_a,
            b => multiplication_38_sint_mul_adder_25_io_b,
            r => multiplication_38_sint_mul_adder_25_io_r
        );

    multiplication_38_sint_mul_adder_26: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_38_sint_mul_adder_26_io_a,
            b => multiplication_38_sint_mul_adder_26_io_b,
            r => multiplication_38_sint_mul_adder_26_io_r
        );

    multiplication_38_sint_mul_subtractor: BitsSubtract_SInt_58_SInt_58
        port map(
            a => multiplication_38_sint_mul_subtractor_io_a,
            b => multiplication_38_sint_mul_subtractor_io_b,
            r => multiplication_38_sint_mul_subtractor_io_r
        );

    multiplication_38_tc: Multiply_SFixedPoint_16_12_SFixedPoint_16_12_Truncated_Truncator
        port map(
            i => multiplication_38_tc_io_i,
            o => multiplication_38_tc_io_o
        );

    subtraction_39: BitsSubtract_SFixedPoint_16_12_SFixedPoint_16_12
        port map(
            a => subtraction_39_io_a,
            b => subtraction_39_io_b,
            r => subtraction_39_io_r
        );

    arith_shifter_40: ArithShifter_4_SFixedPoint_16_12
        port map(
            i => arith_shifter_40_io_i,
            o => arith_shifter_40_io_o
        );

    arith_shifter_41: ArithShifter_2_SFixedPoint_16_12
        port map(
            i => arith_shifter_41_io_i,
            o => arith_shifter_41_io_o
        );

    addition_42: BitsAdd_SFixedPoint_16_12_SFixedPoint_16_12
        port map(
            a => addition_42_io_a,
            b => addition_42_io_b,
            r => addition_42_io_r
        );

    addition_43: BitsAdd_SFixedPoint_16_12_SFixedPoint_16_12
        port map(
            a => addition_43_io_a,
            b => addition_43_io_b,
            r => addition_43_io_r
        );

    clamp01_44: Clamp0To1_SFixedPoint_16_12
        port map(
            i => clamp01_44_io_i,
            o => clamp01_44_io_o
        );

    multiplication_45_sint_mul_gen_addends: Multiply_SInt_29_SInt_29_AddendsGenerator
        port map(
            long => multiplication_45_sint_mul_gen_addends_io_long,
            short => multiplication_45_sint_mul_gen_addends_io_short,
            addend_0 => multiplication_45_sint_mul_gen_addends_io_addend_0,
            addend_1 => multiplication_45_sint_mul_gen_addends_io_addend_1,
            addend_2 => multiplication_45_sint_mul_gen_addends_io_addend_2,
            addend_3 => multiplication_45_sint_mul_gen_addends_io_addend_3,
            addend_4 => multiplication_45_sint_mul_gen_addends_io_addend_4,
            addend_5 => multiplication_45_sint_mul_gen_addends_io_addend_5,
            addend_6 => multiplication_45_sint_mul_gen_addends_io_addend_6,
            addend_7 => multiplication_45_sint_mul_gen_addends_io_addend_7,
            addend_8 => multiplication_45_sint_mul_gen_addends_io_addend_8,
            addend_9 => multiplication_45_sint_mul_gen_addends_io_addend_9,
            addend_10 => multiplication_45_sint_mul_gen_addends_io_addend_10,
            addend_11 => multiplication_45_sint_mul_gen_addends_io_addend_11,
            addend_12 => multiplication_45_sint_mul_gen_addends_io_addend_12,
            addend_13 => multiplication_45_sint_mul_gen_addends_io_addend_13,
            addend_14 => multiplication_45_sint_mul_gen_addends_io_addend_14,
            addend_15 => multiplication_45_sint_mul_gen_addends_io_addend_15,
            addend_16 => multiplication_45_sint_mul_gen_addends_io_addend_16,
            addend_17 => multiplication_45_sint_mul_gen_addends_io_addend_17,
            addend_18 => multiplication_45_sint_mul_gen_addends_io_addend_18,
            addend_19 => multiplication_45_sint_mul_gen_addends_io_addend_19,
            addend_20 => multiplication_45_sint_mul_gen_addends_io_addend_20,
            addend_21 => multiplication_45_sint_mul_gen_addends_io_addend_21,
            addend_22 => multiplication_45_sint_mul_gen_addends_io_addend_22,
            addend_23 => multiplication_45_sint_mul_gen_addends_io_addend_23,
            addend_24 => multiplication_45_sint_mul_gen_addends_io_addend_24,
            addend_25 => multiplication_45_sint_mul_gen_addends_io_addend_25,
            addend_26 => multiplication_45_sint_mul_gen_addends_io_addend_26,
            addend_27 => multiplication_45_sint_mul_gen_addends_io_addend_27,
            subend => multiplication_45_sint_mul_gen_addends_io_subend
        );

    multiplication_45_sint_mul_adder_0: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_45_sint_mul_adder_0_io_a,
            b => multiplication_45_sint_mul_adder_0_io_b,
            r => multiplication_45_sint_mul_adder_0_io_r
        );

    multiplication_45_sint_mul_adder_1: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_45_sint_mul_adder_1_io_a,
            b => multiplication_45_sint_mul_adder_1_io_b,
            r => multiplication_45_sint_mul_adder_1_io_r
        );

    multiplication_45_sint_mul_adder_2: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_45_sint_mul_adder_2_io_a,
            b => multiplication_45_sint_mul_adder_2_io_b,
            r => multiplication_45_sint_mul_adder_2_io_r
        );

    multiplication_45_sint_mul_adder_3: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_45_sint_mul_adder_3_io_a,
            b => multiplication_45_sint_mul_adder_3_io_b,
            r => multiplication_45_sint_mul_adder_3_io_r
        );

    multiplication_45_sint_mul_adder_4: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_45_sint_mul_adder_4_io_a,
            b => multiplication_45_sint_mul_adder_4_io_b,
            r => multiplication_45_sint_mul_adder_4_io_r
        );

    multiplication_45_sint_mul_adder_5: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_45_sint_mul_adder_5_io_a,
            b => multiplication_45_sint_mul_adder_5_io_b,
            r => multiplication_45_sint_mul_adder_5_io_r
        );

    multiplication_45_sint_mul_adder_6: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_45_sint_mul_adder_6_io_a,
            b => multiplication_45_sint_mul_adder_6_io_b,
            r => multiplication_45_sint_mul_adder_6_io_r
        );

    multiplication_45_sint_mul_adder_7: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_45_sint_mul_adder_7_io_a,
            b => multiplication_45_sint_mul_adder_7_io_b,
            r => multiplication_45_sint_mul_adder_7_io_r
        );

    multiplication_45_sint_mul_adder_8: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_45_sint_mul_adder_8_io_a,
            b => multiplication_45_sint_mul_adder_8_io_b,
            r => multiplication_45_sint_mul_adder_8_io_r
        );

    multiplication_45_sint_mul_adder_9: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_45_sint_mul_adder_9_io_a,
            b => multiplication_45_sint_mul_adder_9_io_b,
            r => multiplication_45_sint_mul_adder_9_io_r
        );

    multiplication_45_sint_mul_adder_10: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_45_sint_mul_adder_10_io_a,
            b => multiplication_45_sint_mul_adder_10_io_b,
            r => multiplication_45_sint_mul_adder_10_io_r
        );

    multiplication_45_sint_mul_adder_11: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_45_sint_mul_adder_11_io_a,
            b => multiplication_45_sint_mul_adder_11_io_b,
            r => multiplication_45_sint_mul_adder_11_io_r
        );

    multiplication_45_sint_mul_adder_12: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_45_sint_mul_adder_12_io_a,
            b => multiplication_45_sint_mul_adder_12_io_b,
            r => multiplication_45_sint_mul_adder_12_io_r
        );

    multiplication_45_sint_mul_adder_13: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_45_sint_mul_adder_13_io_a,
            b => multiplication_45_sint_mul_adder_13_io_b,
            r => multiplication_45_sint_mul_adder_13_io_r
        );

    multiplication_45_sint_mul_adder_14: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_45_sint_mul_adder_14_io_a,
            b => multiplication_45_sint_mul_adder_14_io_b,
            r => multiplication_45_sint_mul_adder_14_io_r
        );

    multiplication_45_sint_mul_adder_15: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_45_sint_mul_adder_15_io_a,
            b => multiplication_45_sint_mul_adder_15_io_b,
            r => multiplication_45_sint_mul_adder_15_io_r
        );

    multiplication_45_sint_mul_adder_16: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_45_sint_mul_adder_16_io_a,
            b => multiplication_45_sint_mul_adder_16_io_b,
            r => multiplication_45_sint_mul_adder_16_io_r
        );

    multiplication_45_sint_mul_adder_17: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_45_sint_mul_adder_17_io_a,
            b => multiplication_45_sint_mul_adder_17_io_b,
            r => multiplication_45_sint_mul_adder_17_io_r
        );

    multiplication_45_sint_mul_adder_18: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_45_sint_mul_adder_18_io_a,
            b => multiplication_45_sint_mul_adder_18_io_b,
            r => multiplication_45_sint_mul_adder_18_io_r
        );

    multiplication_45_sint_mul_adder_19: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_45_sint_mul_adder_19_io_a,
            b => multiplication_45_sint_mul_adder_19_io_b,
            r => multiplication_45_sint_mul_adder_19_io_r
        );

    multiplication_45_sint_mul_adder_20: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_45_sint_mul_adder_20_io_a,
            b => multiplication_45_sint_mul_adder_20_io_b,
            r => multiplication_45_sint_mul_adder_20_io_r
        );

    multiplication_45_sint_mul_adder_21: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_45_sint_mul_adder_21_io_a,
            b => multiplication_45_sint_mul_adder_21_io_b,
            r => multiplication_45_sint_mul_adder_21_io_r
        );

    multiplication_45_sint_mul_adder_22: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_45_sint_mul_adder_22_io_a,
            b => multiplication_45_sint_mul_adder_22_io_b,
            r => multiplication_45_sint_mul_adder_22_io_r
        );

    multiplication_45_sint_mul_adder_23: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_45_sint_mul_adder_23_io_a,
            b => multiplication_45_sint_mul_adder_23_io_b,
            r => multiplication_45_sint_mul_adder_23_io_r
        );

    multiplication_45_sint_mul_adder_24: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_45_sint_mul_adder_24_io_a,
            b => multiplication_45_sint_mul_adder_24_io_b,
            r => multiplication_45_sint_mul_adder_24_io_r
        );

    multiplication_45_sint_mul_adder_25: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_45_sint_mul_adder_25_io_a,
            b => multiplication_45_sint_mul_adder_25_io_b,
            r => multiplication_45_sint_mul_adder_25_io_r
        );

    multiplication_45_sint_mul_adder_26: BitsAdd_SInt_58_SInt_58
        port map(
            a => multiplication_45_sint_mul_adder_26_io_a,
            b => multiplication_45_sint_mul_adder_26_io_b,
            r => multiplication_45_sint_mul_adder_26_io_r
        );

    multiplication_45_sint_mul_subtractor: BitsSubtract_SInt_58_SInt_58
        port map(
            a => multiplication_45_sint_mul_subtractor_io_a,
            b => multiplication_45_sint_mul_subtractor_io_b,
            r => multiplication_45_sint_mul_subtractor_io_r
        );

    multiplication_45_tc: Multiply_SFixedPoint_16_12_SFixedPoint_16_12_Truncated_Truncator
        port map(
            i => multiplication_45_tc_io_i,
            o => multiplication_45_tc_io_o
        );

    addition_46: BitsAdd_SFixedPoint_16_12_SFixedPoint_16_12
        port map(
            a => addition_46_io_a,
            b => addition_46_io_b,
            r => addition_46_io_r
        );

    arith_shifter_47: ArithShifter_NEG1_SFixedPoint_16_12
        port map(
            i => arith_shifter_47_io_i,
            o => arith_shifter_47_io_o
        );

    subtraction_48: BitsSubtract_SFixedPoint_16_12_SFixedPoint_16_12
        port map(
            a => subtraction_48_io_a,
            b => subtraction_48_io_b,
            r => subtraction_48_io_r
        );

    to8bit_cvt_49: To8bitConvertor_SFixedPoint_16_12
        port map(
            i_clamped => to8bit_cvt_49_io_i_clamped,
            o => to8bit_cvt_49_io_o
        );

    clamp01_49: Clamp0To1_SFixedPoint_16_12
        port map(
            i => clamp01_49_io_i,
            o => clamp01_49_io_o
        );

    arith_shifter_51: ArithShifter_NEG2_SFixedPoint_16_12
        port map(
            i => arith_shifter_51_io_i,
            o => arith_shifter_51_io_o
        );

    subtraction_52: BitsSubtract_SFixedPoint_16_12_SFixedPoint_16_12
        port map(
            a => subtraction_52_io_a,
            b => subtraction_52_io_b,
            r => subtraction_52_io_r
        );

    to8bit_cvt_53: To8bitConvertor_SFixedPoint_16_12
        port map(
            i_clamped => to8bit_cvt_53_io_i_clamped,
            o => to8bit_cvt_53_io_o
        );

    clamp01_53: Clamp0To1_SFixedPoint_16_12
        port map(
            i => clamp01_53_io_i,
            o => clamp01_53_io_o
        );

    to8bit_cvt_55: To8bitConvertor_SFixedPoint_16_12
        port map(
            i_clamped => to8bit_cvt_55_io_i_clamped,
            o => to8bit_cvt_55_io_o
        );

    clamp01_55: Clamp0To1_SFixedPoint_16_12
        port map(
            i => clamp01_55_io_i,
            o => clamp01_55_io_o
        );

    color_24bit_cvt: Concatenate_Bits_8_Bits_8_Bits_8
        port map(
            r => color_24bit_cvt_io_r,
            g => color_24bit_cvt_io_g,
            b => color_24bit_cvt_io_b,
            o => color_24bit_cvt_io_o
        );

    reg_next_0_d_itime_us <= itime_us;
    itime_convertor_0_io_i <= reg_0_d_itime_us;
    reg_next_0_d_frag_x <= frag_x;
    fragcoord_value_convertor_1_io_i <= reg_0_d_frag_x;
    reg_next_0_d_frag_y <= frag_y;
    fragcoord_value_convertor_2_io_i <= reg_0_d_frag_y;
    frag_color <= color_24bit_cvt_io_o;
    reg_next_1_d_itime_convertor_0_io_o <= reg_0_d_itime_convertor_0_io_o;
    reg_next_2_d_itime_convertor_0_io_o <= reg_1_d_itime_convertor_0_io_o;
    reg_next_3_d_itime_convertor_0_io_o <= reg_2_d_itime_convertor_0_io_o;
    reg_next_4_d_itime_convertor_0_io_o <= reg_3_d_itime_convertor_0_io_o;
    reg_next_5_d_itime_convertor_0_io_o <= reg_4_d_itime_convertor_0_io_o;
    reg_next_6_d_itime_convertor_0_io_o <= reg_5_d_itime_convertor_0_io_o;
    reg_next_7_d_itime_convertor_0_io_o <= reg_6_d_itime_convertor_0_io_o;
    reg_next_8_d_itime_convertor_0_io_o <= reg_7_d_itime_convertor_0_io_o;
    reg_next_9_d_itime_convertor_0_io_o <= reg_8_d_itime_convertor_0_io_o;
    reg_next_0_d_itime_convertor_0_io_o <= itime_convertor_0_io_o;
    subtraction_29_io_a <= reg_9_d_itime_convertor_0_io_o;
    arith_shifter_3_io_i <= fragcoord_value_convertor_1_io_o;
    arith_shifter_4_io_i <= fragcoord_value_convertor_1_io_o;
    arith_shifter_7_io_i <= fragcoord_value_convertor_2_io_o;
    arith_shifter_8_io_i <= fragcoord_value_convertor_2_io_o;
    reg_next_1_d_consts_opt_io_c0_1 <= reg_0_d_consts_opt_io_c0_1;
    reg_next_2_d_consts_opt_io_c0_1 <= reg_1_d_consts_opt_io_c0_1;
    reg_next_3_d_consts_opt_io_c0_1 <= reg_2_d_consts_opt_io_c0_1;
    reg_next_4_d_consts_opt_io_c0_1 <= reg_3_d_consts_opt_io_c0_1;
    reg_next_5_d_consts_opt_io_c0_1 <= reg_4_d_consts_opt_io_c0_1;
    reg_next_6_d_consts_opt_io_c0_1 <= reg_5_d_consts_opt_io_c0_1;
    reg_next_7_d_consts_opt_io_c0_1 <= reg_6_d_consts_opt_io_c0_1;
    reg_next_8_d_consts_opt_io_c0_1 <= reg_7_d_consts_opt_io_c0_1;
    reg_next_9_d_consts_opt_io_c0_1 <= reg_8_d_consts_opt_io_c0_1;
    reg_next_0_d_consts_opt_io_c0_1 <= consts_opt_io_c0_1;
    multiplication_45_sint_mul_gen_addends_io_long <= reg_9_d_consts_opt_io_c0_1;
    reg_next_1_d_consts_opt_io_c0_95 <= reg_0_d_consts_opt_io_c0_95;
    reg_next_2_d_consts_opt_io_c0_95 <= reg_1_d_consts_opt_io_c0_95;
    reg_next_3_d_consts_opt_io_c0_95 <= reg_2_d_consts_opt_io_c0_95;
    reg_next_4_d_consts_opt_io_c0_95 <= reg_3_d_consts_opt_io_c0_95;
    reg_next_5_d_consts_opt_io_c0_95 <= reg_4_d_consts_opt_io_c0_95;
    reg_next_6_d_consts_opt_io_c0_95 <= reg_5_d_consts_opt_io_c0_95;
    reg_next_7_d_consts_opt_io_c0_95 <= reg_6_d_consts_opt_io_c0_95;
    reg_next_8_d_consts_opt_io_c0_95 <= reg_7_d_consts_opt_io_c0_95;
    reg_next_9_d_consts_opt_io_c0_95 <= reg_8_d_consts_opt_io_c0_95;
    reg_next_10_d_consts_opt_io_c0_95 <= reg_9_d_consts_opt_io_c0_95;
    reg_next_11_d_consts_opt_io_c0_95 <= reg_10_d_consts_opt_io_c0_95;
    reg_next_0_d_consts_opt_io_c0_95 <= consts_opt_io_c0_95;
    multiplication_37_sint_mul_gen_addends_io_short <= reg_11_d_consts_opt_io_c0_95;
    reg_next_1_l_addition_27_io_a <= reg_0_l_addition_27_io_a;
    reg_next_2_l_addition_27_io_a <= reg_1_l_addition_27_io_a;
    reg_next_3_l_addition_27_io_a <= reg_2_l_addition_27_io_a;
    reg_next_4_l_addition_27_io_a <= reg_3_l_addition_27_io_a;
    reg_next_5_l_addition_27_io_a <= reg_4_l_addition_27_io_a;
    reg_next_6_l_addition_27_io_a <= reg_5_l_addition_27_io_a;
    reg_next_7_l_addition_27_io_a <= reg_6_l_addition_27_io_a;
    reg_next_8_l_addition_27_io_a <= reg_7_l_addition_27_io_a;
    reg_next_9_l_addition_27_io_a <= reg_8_l_addition_27_io_a;
    reg_next_0_l_addition_27_io_a <= consts_opt_io_c1;
    addition_27_io_a <= reg_9_l_addition_27_io_a;
    reg_next_1_l_subtraction_33_io_b <= reg_0_l_subtraction_33_io_b;
    reg_next_2_l_subtraction_33_io_b <= reg_1_l_subtraction_33_io_b;
    reg_next_3_l_subtraction_33_io_b <= reg_2_l_subtraction_33_io_b;
    reg_next_4_l_subtraction_33_io_b <= reg_3_l_subtraction_33_io_b;
    reg_next_5_l_subtraction_33_io_b <= reg_4_l_subtraction_33_io_b;
    reg_next_6_l_subtraction_33_io_b <= reg_5_l_subtraction_33_io_b;
    reg_next_7_l_subtraction_33_io_b <= reg_6_l_subtraction_33_io_b;
    reg_next_8_l_subtraction_33_io_b <= reg_7_l_subtraction_33_io_b;
    reg_next_9_l_subtraction_33_io_b <= reg_8_l_subtraction_33_io_b;
    reg_next_0_l_subtraction_33_io_b <= consts_opt_io_c1;
    subtraction_33_io_b <= reg_9_l_subtraction_33_io_b;
    reg_next_1_l_addition_43_io_b <= reg_0_l_addition_43_io_b;
    reg_next_2_l_addition_43_io_b <= reg_1_l_addition_43_io_b;
    reg_next_3_l_addition_43_io_b <= reg_2_l_addition_43_io_b;
    reg_next_4_l_addition_43_io_b <= reg_3_l_addition_43_io_b;
    reg_next_5_l_addition_43_io_b <= reg_4_l_addition_43_io_b;
    reg_next_6_l_addition_43_io_b <= reg_5_l_addition_43_io_b;
    reg_next_7_l_addition_43_io_b <= reg_6_l_addition_43_io_b;
    reg_next_8_l_addition_43_io_b <= reg_7_l_addition_43_io_b;
    reg_next_9_l_addition_43_io_b <= reg_8_l_addition_43_io_b;
    reg_next_10_l_addition_43_io_b <= reg_9_l_addition_43_io_b;
    reg_next_11_l_addition_43_io_b <= reg_10_l_addition_43_io_b;
    reg_next_12_l_addition_43_io_b <= reg_11_l_addition_43_io_b;
    reg_next_13_l_addition_43_io_b <= reg_12_l_addition_43_io_b;
    reg_next_14_l_addition_43_io_b <= reg_13_l_addition_43_io_b;
    reg_next_15_l_addition_43_io_b <= reg_14_l_addition_43_io_b;
    reg_next_16_l_addition_43_io_b <= reg_15_l_addition_43_io_b;
    reg_next_17_l_addition_43_io_b <= reg_16_l_addition_43_io_b;
    reg_next_18_l_addition_43_io_b <= reg_17_l_addition_43_io_b;
    reg_next_0_l_addition_43_io_b <= consts_opt_io_c1;
    addition_43_io_b <= reg_18_l_addition_43_io_b;
    reg_next_1_l_subtraction_48_io_a <= reg_0_l_subtraction_48_io_a;
    reg_next_2_l_subtraction_48_io_a <= reg_1_l_subtraction_48_io_a;
    reg_next_3_l_subtraction_48_io_a <= reg_2_l_subtraction_48_io_a;
    reg_next_4_l_subtraction_48_io_a <= reg_3_l_subtraction_48_io_a;
    reg_next_5_l_subtraction_48_io_a <= reg_4_l_subtraction_48_io_a;
    reg_next_6_l_subtraction_48_io_a <= reg_5_l_subtraction_48_io_a;
    reg_next_7_l_subtraction_48_io_a <= reg_6_l_subtraction_48_io_a;
    reg_next_8_l_subtraction_48_io_a <= reg_7_l_subtraction_48_io_a;
    reg_next_9_l_subtraction_48_io_a <= reg_8_l_subtraction_48_io_a;
    reg_next_10_l_subtraction_48_io_a <= reg_9_l_subtraction_48_io_a;
    reg_next_11_l_subtraction_48_io_a <= reg_10_l_subtraction_48_io_a;
    reg_next_12_l_subtraction_48_io_a <= reg_11_l_subtraction_48_io_a;
    reg_next_13_l_subtraction_48_io_a <= reg_12_l_subtraction_48_io_a;
    reg_next_14_l_subtraction_48_io_a <= reg_13_l_subtraction_48_io_a;
    reg_next_15_l_subtraction_48_io_a <= reg_14_l_subtraction_48_io_a;
    reg_next_16_l_subtraction_48_io_a <= reg_15_l_subtraction_48_io_a;
    reg_next_17_l_subtraction_48_io_a <= reg_16_l_subtraction_48_io_a;
    reg_next_18_l_subtraction_48_io_a <= reg_17_l_subtraction_48_io_a;
    reg_next_19_l_subtraction_48_io_a <= reg_18_l_subtraction_48_io_a;
    reg_next_20_l_subtraction_48_io_a <= reg_19_l_subtraction_48_io_a;
    reg_next_21_l_subtraction_48_io_a <= reg_20_l_subtraction_48_io_a;
    reg_next_0_l_subtraction_48_io_a <= consts_opt_io_c1;
    subtraction_48_io_a <= reg_21_l_subtraction_48_io_a;
    reg_next_1_l_subtraction_52_io_a <= reg_0_l_subtraction_52_io_a;
    reg_next_2_l_subtraction_52_io_a <= reg_1_l_subtraction_52_io_a;
    reg_next_3_l_subtraction_52_io_a <= reg_2_l_subtraction_52_io_a;
    reg_next_4_l_subtraction_52_io_a <= reg_3_l_subtraction_52_io_a;
    reg_next_5_l_subtraction_52_io_a <= reg_4_l_subtraction_52_io_a;
    reg_next_6_l_subtraction_52_io_a <= reg_5_l_subtraction_52_io_a;
    reg_next_7_l_subtraction_52_io_a <= reg_6_l_subtraction_52_io_a;
    reg_next_8_l_subtraction_52_io_a <= reg_7_l_subtraction_52_io_a;
    reg_next_9_l_subtraction_52_io_a <= reg_8_l_subtraction_52_io_a;
    reg_next_10_l_subtraction_52_io_a <= reg_9_l_subtraction_52_io_a;
    reg_next_11_l_subtraction_52_io_a <= reg_10_l_subtraction_52_io_a;
    reg_next_12_l_subtraction_52_io_a <= reg_11_l_subtraction_52_io_a;
    reg_next_13_l_subtraction_52_io_a <= reg_12_l_subtraction_52_io_a;
    reg_next_14_l_subtraction_52_io_a <= reg_13_l_subtraction_52_io_a;
    reg_next_15_l_subtraction_52_io_a <= reg_14_l_subtraction_52_io_a;
    reg_next_16_l_subtraction_52_io_a <= reg_15_l_subtraction_52_io_a;
    reg_next_17_l_subtraction_52_io_a <= reg_16_l_subtraction_52_io_a;
    reg_next_18_l_subtraction_52_io_a <= reg_17_l_subtraction_52_io_a;
    reg_next_19_l_subtraction_52_io_a <= reg_18_l_subtraction_52_io_a;
    reg_next_20_l_subtraction_52_io_a <= reg_19_l_subtraction_52_io_a;
    reg_next_21_l_subtraction_52_io_a <= reg_20_l_subtraction_52_io_a;
    reg_next_0_l_subtraction_52_io_a <= consts_opt_io_c1;
    subtraction_52_io_a <= reg_21_l_subtraction_52_io_a;
    clamp01_55_io_i <= consts_opt_io_c1;
    subtraction_10_io_b <= consts_opt_io_c3_75;
    subtraction_6_io_b <= consts_opt_io_c5;
    reg_next_1_l_addition_12_io_b <= reg_0_l_addition_12_io_b;
    reg_next_0_l_addition_12_io_b <= consts_opt_io_c5;
    addition_12_io_b <= reg_1_l_addition_12_io_b;
    reg_next_1_l_addition_14_io_b <= reg_0_l_addition_14_io_b;
    reg_next_0_l_addition_14_io_b <= consts_opt_io_c5;
    addition_14_io_b <= reg_1_l_addition_14_io_b;
    reg_next_1_d_consts_opt_io_c5_5 <= reg_0_d_consts_opt_io_c5_5;
    reg_next_2_d_consts_opt_io_c5_5 <= reg_1_d_consts_opt_io_c5_5;
    reg_next_3_d_consts_opt_io_c5_5 <= reg_2_d_consts_opt_io_c5_5;
    reg_next_0_d_consts_opt_io_c5_5 <= consts_opt_io_c5_5;
    subtraction_20_io_b <= reg_3_d_consts_opt_io_c5_5;
    subtraction_22_io_b <= reg_3_d_consts_opt_io_c5_5;
    addition_5_io_a <= arith_shifter_3_io_o;
    addition_5_io_b <= arith_shifter_4_io_o;
    subtraction_6_io_a <= addition_5_io_r;
    reg_next_0_d_subtraction_6_io_r <= subtraction_6_io_r;
    subtraction_11_io_a <= reg_0_d_subtraction_6_io_r;
    addition_13_io_a <= reg_0_d_subtraction_6_io_r;
    addition_9_io_a <= arith_shifter_7_io_o;
    addition_9_io_b <= arith_shifter_8_io_o;
    subtraction_10_io_a <= addition_9_io_r;
    reg_next_0_d_subtraction_10_io_r <= subtraction_10_io_r;
    subtraction_11_io_b <= reg_0_d_subtraction_10_io_r;
    addition_13_io_b <= reg_0_d_subtraction_10_io_r;
    reg_next_0_d_subtraction_11_io_r <= subtraction_11_io_r;
    addition_12_io_a <= reg_0_d_subtraction_11_io_r;
    fract_15_io_i <= addition_12_io_r;
    reg_next_0_l_ceil_19_io_i <= addition_12_io_r;
    ceil_19_io_i <= reg_0_l_ceil_19_io_i;
    reg_next_0_d_addition_13_io_r <= addition_13_io_r;
    addition_14_io_a <= reg_0_d_addition_13_io_r;
    fract_17_io_i <= addition_14_io_r;
    reg_next_0_l_ceil_21_io_i <= addition_14_io_r;
    ceil_21_io_i <= reg_0_l_ceil_21_io_i;
    reg_next_0_d_fract_15_io_o <= fract_15_io_o;
    minx1mx_16_io_i <= reg_0_d_fract_15_io_o;
    reg_next_0_d_minx1mx_16_io_o <= minx1mx_16_io_o;
    min_34_io_a <= reg_0_d_minx1mx_16_io_o;
    reg_next_0_d_fract_17_io_o <= fract_17_io_o;
    minx1mx_18_io_i <= reg_0_d_fract_17_io_o;
    reg_next_0_d_minx1mx_18_io_o <= minx1mx_18_io_o;
    min_34_io_b <= reg_0_d_minx1mx_18_io_o;
    reg_next_0_d_ceil_19_io_o <= ceil_19_io_o;
    subtraction_20_io_a <= reg_0_d_ceil_19_io_o;
    multiplication_23_sint_mul_gen_addends_io_long <= subtraction_20_io_r;
    multiplication_23_sint_mul_gen_addends_io_short <= subtraction_20_io_r;
    reg_next_0_d_ceil_21_io_o <= ceil_21_io_o;
    subtraction_22_io_a <= reg_0_d_ceil_21_io_o;
    multiplication_24_sint_mul_gen_addends_io_long <= subtraction_22_io_r;
    multiplication_24_sint_mul_gen_addends_io_short <= subtraction_22_io_r;
    multiplication_23_sint_mul_adder_0_io_a <= multiplication_23_sint_mul_gen_addends_io_addend_0;
    multiplication_23_sint_mul_adder_0_io_b <= multiplication_23_sint_mul_gen_addends_io_addend_1;
    multiplication_23_sint_mul_adder_1_io_a <= multiplication_23_sint_mul_gen_addends_io_addend_2;
    multiplication_23_sint_mul_adder_1_io_b <= multiplication_23_sint_mul_gen_addends_io_addend_3;
    multiplication_23_sint_mul_adder_2_io_a <= multiplication_23_sint_mul_gen_addends_io_addend_4;
    multiplication_23_sint_mul_adder_2_io_b <= multiplication_23_sint_mul_gen_addends_io_addend_5;
    multiplication_23_sint_mul_adder_3_io_a <= multiplication_23_sint_mul_gen_addends_io_addend_6;
    multiplication_23_sint_mul_adder_3_io_b <= multiplication_23_sint_mul_gen_addends_io_addend_7;
    multiplication_23_sint_mul_adder_4_io_a <= multiplication_23_sint_mul_gen_addends_io_addend_8;
    multiplication_23_sint_mul_adder_4_io_b <= multiplication_23_sint_mul_gen_addends_io_addend_9;
    multiplication_23_sint_mul_adder_5_io_a <= multiplication_23_sint_mul_gen_addends_io_addend_10;
    multiplication_23_sint_mul_adder_5_io_b <= multiplication_23_sint_mul_gen_addends_io_addend_11;
    reg_next_0_d_multiplication_23_sint_mul_gen_addends_io_addend_12 <= multiplication_23_sint_mul_gen_addends_io_addend_12;
    multiplication_23_sint_mul_adder_6_io_a <= reg_0_d_multiplication_23_sint_mul_gen_addends_io_addend_12;
    reg_next_0_d_multiplication_23_sint_mul_gen_addends_io_addend_13 <= multiplication_23_sint_mul_gen_addends_io_addend_13;
    multiplication_23_sint_mul_adder_6_io_b <= reg_0_d_multiplication_23_sint_mul_gen_addends_io_addend_13;
    reg_next_0_d_multiplication_23_sint_mul_gen_addends_io_addend_14 <= multiplication_23_sint_mul_gen_addends_io_addend_14;
    multiplication_23_sint_mul_adder_7_io_a <= reg_0_d_multiplication_23_sint_mul_gen_addends_io_addend_14;
    reg_next_0_d_multiplication_23_sint_mul_gen_addends_io_addend_15 <= multiplication_23_sint_mul_gen_addends_io_addend_15;
    multiplication_23_sint_mul_adder_7_io_b <= reg_0_d_multiplication_23_sint_mul_gen_addends_io_addend_15;
    reg_next_0_d_multiplication_23_sint_mul_gen_addends_io_addend_16 <= multiplication_23_sint_mul_gen_addends_io_addend_16;
    multiplication_23_sint_mul_adder_8_io_a <= reg_0_d_multiplication_23_sint_mul_gen_addends_io_addend_16;
    reg_next_0_d_multiplication_23_sint_mul_gen_addends_io_addend_17 <= multiplication_23_sint_mul_gen_addends_io_addend_17;
    multiplication_23_sint_mul_adder_8_io_b <= reg_0_d_multiplication_23_sint_mul_gen_addends_io_addend_17;
    reg_next_0_d_multiplication_23_sint_mul_gen_addends_io_addend_18 <= multiplication_23_sint_mul_gen_addends_io_addend_18;
    multiplication_23_sint_mul_adder_9_io_a <= reg_0_d_multiplication_23_sint_mul_gen_addends_io_addend_18;
    reg_next_0_d_multiplication_23_sint_mul_gen_addends_io_addend_19 <= multiplication_23_sint_mul_gen_addends_io_addend_19;
    multiplication_23_sint_mul_adder_9_io_b <= reg_0_d_multiplication_23_sint_mul_gen_addends_io_addend_19;
    reg_next_0_d_multiplication_23_sint_mul_gen_addends_io_addend_20 <= multiplication_23_sint_mul_gen_addends_io_addend_20;
    multiplication_23_sint_mul_adder_10_io_a <= reg_0_d_multiplication_23_sint_mul_gen_addends_io_addend_20;
    reg_next_0_d_multiplication_23_sint_mul_gen_addends_io_addend_21 <= multiplication_23_sint_mul_gen_addends_io_addend_21;
    multiplication_23_sint_mul_adder_10_io_b <= reg_0_d_multiplication_23_sint_mul_gen_addends_io_addend_21;
    reg_next_0_d_multiplication_23_sint_mul_gen_addends_io_addend_22 <= multiplication_23_sint_mul_gen_addends_io_addend_22;
    multiplication_23_sint_mul_adder_11_io_a <= reg_0_d_multiplication_23_sint_mul_gen_addends_io_addend_22;
    reg_next_0_d_multiplication_23_sint_mul_gen_addends_io_addend_23 <= multiplication_23_sint_mul_gen_addends_io_addend_23;
    multiplication_23_sint_mul_adder_11_io_b <= reg_0_d_multiplication_23_sint_mul_gen_addends_io_addend_23;
    reg_next_0_d_multiplication_23_sint_mul_gen_addends_io_addend_24 <= multiplication_23_sint_mul_gen_addends_io_addend_24;
    multiplication_23_sint_mul_adder_12_io_a <= reg_0_d_multiplication_23_sint_mul_gen_addends_io_addend_24;
    reg_next_0_d_multiplication_23_sint_mul_gen_addends_io_addend_25 <= multiplication_23_sint_mul_gen_addends_io_addend_25;
    multiplication_23_sint_mul_adder_12_io_b <= reg_0_d_multiplication_23_sint_mul_gen_addends_io_addend_25;
    reg_next_0_d_multiplication_23_sint_mul_gen_addends_io_addend_26 <= multiplication_23_sint_mul_gen_addends_io_addend_26;
    multiplication_23_sint_mul_adder_13_io_a <= reg_0_d_multiplication_23_sint_mul_gen_addends_io_addend_26;
    reg_next_0_d_multiplication_23_sint_mul_gen_addends_io_addend_27 <= multiplication_23_sint_mul_gen_addends_io_addend_27;
    multiplication_23_sint_mul_adder_13_io_b <= reg_0_d_multiplication_23_sint_mul_gen_addends_io_addend_27;
    reg_next_1_d_multiplication_23_sint_mul_gen_addends_io_subend <= reg_0_d_multiplication_23_sint_mul_gen_addends_io_subend;
    reg_next_2_d_multiplication_23_sint_mul_gen_addends_io_subend <= reg_1_d_multiplication_23_sint_mul_gen_addends_io_subend;
    reg_next_3_d_multiplication_23_sint_mul_gen_addends_io_subend <= reg_2_d_multiplication_23_sint_mul_gen_addends_io_subend;
    reg_next_0_d_multiplication_23_sint_mul_gen_addends_io_subend <= multiplication_23_sint_mul_gen_addends_io_subend;
    multiplication_23_sint_mul_subtractor_io_b <= reg_3_d_multiplication_23_sint_mul_gen_addends_io_subend;
    multiplication_23_sint_mul_adder_14_io_a <= multiplication_23_sint_mul_adder_0_io_r;
    multiplication_23_sint_mul_adder_14_io_b <= multiplication_23_sint_mul_adder_1_io_r;
    multiplication_23_sint_mul_adder_15_io_a <= multiplication_23_sint_mul_adder_2_io_r;
    multiplication_23_sint_mul_adder_15_io_b <= multiplication_23_sint_mul_adder_3_io_r;
    multiplication_23_sint_mul_adder_16_io_a <= multiplication_23_sint_mul_adder_4_io_r;
    multiplication_23_sint_mul_adder_16_io_b <= multiplication_23_sint_mul_adder_5_io_r;
    reg_next_0_d_multiplication_23_sint_mul_adder_6_io_r <= multiplication_23_sint_mul_adder_6_io_r;
    multiplication_23_sint_mul_adder_17_io_a <= reg_0_d_multiplication_23_sint_mul_adder_6_io_r;
    reg_next_0_d_multiplication_23_sint_mul_adder_7_io_r <= multiplication_23_sint_mul_adder_7_io_r;
    multiplication_23_sint_mul_adder_17_io_b <= reg_0_d_multiplication_23_sint_mul_adder_7_io_r;
    reg_next_0_d_multiplication_23_sint_mul_adder_8_io_r <= multiplication_23_sint_mul_adder_8_io_r;
    multiplication_23_sint_mul_adder_18_io_a <= reg_0_d_multiplication_23_sint_mul_adder_8_io_r;
    reg_next_0_d_multiplication_23_sint_mul_adder_9_io_r <= multiplication_23_sint_mul_adder_9_io_r;
    multiplication_23_sint_mul_adder_18_io_b <= reg_0_d_multiplication_23_sint_mul_adder_9_io_r;
    multiplication_23_sint_mul_adder_19_io_a <= multiplication_23_sint_mul_adder_10_io_r;
    multiplication_23_sint_mul_adder_19_io_b <= multiplication_23_sint_mul_adder_11_io_r;
    multiplication_23_sint_mul_adder_20_io_a <= multiplication_23_sint_mul_adder_12_io_r;
    multiplication_23_sint_mul_adder_20_io_b <= multiplication_23_sint_mul_adder_13_io_r;
    multiplication_23_sint_mul_adder_21_io_a <= multiplication_23_sint_mul_adder_14_io_r;
    multiplication_23_sint_mul_adder_21_io_b <= multiplication_23_sint_mul_adder_15_io_r;
    reg_next_1_d_multiplication_23_sint_mul_adder_16_io_r <= reg_0_d_multiplication_23_sint_mul_adder_16_io_r;
    reg_next_2_d_multiplication_23_sint_mul_adder_16_io_r <= reg_1_d_multiplication_23_sint_mul_adder_16_io_r;
    reg_next_0_d_multiplication_23_sint_mul_adder_16_io_r <= multiplication_23_sint_mul_adder_16_io_r;
    multiplication_23_sint_mul_adder_22_io_a <= reg_2_d_multiplication_23_sint_mul_adder_16_io_r;
    reg_next_0_d_multiplication_23_sint_mul_adder_17_io_r <= multiplication_23_sint_mul_adder_17_io_r;
    multiplication_23_sint_mul_adder_22_io_b <= reg_0_d_multiplication_23_sint_mul_adder_17_io_r;
    reg_next_0_d_multiplication_23_sint_mul_adder_18_io_r <= multiplication_23_sint_mul_adder_18_io_r;
    multiplication_23_sint_mul_adder_23_io_a <= reg_0_d_multiplication_23_sint_mul_adder_18_io_r;
    reg_next_1_d_multiplication_23_sint_mul_adder_19_io_r <= reg_0_d_multiplication_23_sint_mul_adder_19_io_r;
    reg_next_0_d_multiplication_23_sint_mul_adder_19_io_r <= multiplication_23_sint_mul_adder_19_io_r;
    multiplication_23_sint_mul_adder_23_io_b <= reg_1_d_multiplication_23_sint_mul_adder_19_io_r;
    reg_next_1_d_multiplication_23_sint_mul_adder_20_io_r <= reg_0_d_multiplication_23_sint_mul_adder_20_io_r;
    reg_next_0_d_multiplication_23_sint_mul_adder_20_io_r <= multiplication_23_sint_mul_adder_20_io_r;
    multiplication_23_sint_mul_adder_25_io_b <= reg_1_d_multiplication_23_sint_mul_adder_20_io_r;
    reg_next_1_d_multiplication_23_sint_mul_adder_21_io_r <= reg_0_d_multiplication_23_sint_mul_adder_21_io_r;
    reg_next_2_d_multiplication_23_sint_mul_adder_21_io_r <= reg_1_d_multiplication_23_sint_mul_adder_21_io_r;
    reg_next_0_d_multiplication_23_sint_mul_adder_21_io_r <= multiplication_23_sint_mul_adder_21_io_r;
    multiplication_23_sint_mul_adder_24_io_a <= reg_2_d_multiplication_23_sint_mul_adder_21_io_r;
    multiplication_23_sint_mul_adder_24_io_b <= multiplication_23_sint_mul_adder_22_io_r;
    multiplication_23_sint_mul_adder_25_io_a <= multiplication_23_sint_mul_adder_23_io_r;
    reg_next_0_d_multiplication_23_sint_mul_adder_24_io_r <= multiplication_23_sint_mul_adder_24_io_r;
    multiplication_23_sint_mul_adder_26_io_a <= reg_0_d_multiplication_23_sint_mul_adder_24_io_r;
    reg_next_0_d_multiplication_23_sint_mul_adder_25_io_r <= multiplication_23_sint_mul_adder_25_io_r;
    multiplication_23_sint_mul_adder_26_io_b <= reg_0_d_multiplication_23_sint_mul_adder_25_io_r;
    multiplication_23_sint_mul_subtractor_io_a <= multiplication_23_sint_mul_adder_26_io_r;
    multiplication_23_tc_io_i <= multiplication_23_sint_mul_subtractor_io_r;
    reg_next_0_d_multiplication_23_tc_io_o <= multiplication_23_tc_io_o;
    addition_25_io_a <= reg_0_d_multiplication_23_tc_io_o;
    multiplication_24_sint_mul_adder_0_io_a <= multiplication_24_sint_mul_gen_addends_io_addend_0;
    multiplication_24_sint_mul_adder_0_io_b <= multiplication_24_sint_mul_gen_addends_io_addend_1;
    multiplication_24_sint_mul_adder_1_io_a <= multiplication_24_sint_mul_gen_addends_io_addend_2;
    multiplication_24_sint_mul_adder_1_io_b <= multiplication_24_sint_mul_gen_addends_io_addend_3;
    multiplication_24_sint_mul_adder_2_io_a <= multiplication_24_sint_mul_gen_addends_io_addend_4;
    multiplication_24_sint_mul_adder_2_io_b <= multiplication_24_sint_mul_gen_addends_io_addend_5;
    multiplication_24_sint_mul_adder_3_io_a <= multiplication_24_sint_mul_gen_addends_io_addend_6;
    multiplication_24_sint_mul_adder_3_io_b <= multiplication_24_sint_mul_gen_addends_io_addend_7;
    multiplication_24_sint_mul_adder_4_io_a <= multiplication_24_sint_mul_gen_addends_io_addend_8;
    multiplication_24_sint_mul_adder_4_io_b <= multiplication_24_sint_mul_gen_addends_io_addend_9;
    multiplication_24_sint_mul_adder_5_io_a <= multiplication_24_sint_mul_gen_addends_io_addend_10;
    multiplication_24_sint_mul_adder_5_io_b <= multiplication_24_sint_mul_gen_addends_io_addend_11;
    reg_next_0_d_multiplication_24_sint_mul_gen_addends_io_addend_12 <= multiplication_24_sint_mul_gen_addends_io_addend_12;
    multiplication_24_sint_mul_adder_6_io_a <= reg_0_d_multiplication_24_sint_mul_gen_addends_io_addend_12;
    reg_next_0_d_multiplication_24_sint_mul_gen_addends_io_addend_13 <= multiplication_24_sint_mul_gen_addends_io_addend_13;
    multiplication_24_sint_mul_adder_6_io_b <= reg_0_d_multiplication_24_sint_mul_gen_addends_io_addend_13;
    reg_next_0_d_multiplication_24_sint_mul_gen_addends_io_addend_14 <= multiplication_24_sint_mul_gen_addends_io_addend_14;
    multiplication_24_sint_mul_adder_7_io_a <= reg_0_d_multiplication_24_sint_mul_gen_addends_io_addend_14;
    reg_next_0_d_multiplication_24_sint_mul_gen_addends_io_addend_15 <= multiplication_24_sint_mul_gen_addends_io_addend_15;
    multiplication_24_sint_mul_adder_7_io_b <= reg_0_d_multiplication_24_sint_mul_gen_addends_io_addend_15;
    reg_next_0_d_multiplication_24_sint_mul_gen_addends_io_addend_16 <= multiplication_24_sint_mul_gen_addends_io_addend_16;
    multiplication_24_sint_mul_adder_8_io_a <= reg_0_d_multiplication_24_sint_mul_gen_addends_io_addend_16;
    reg_next_0_d_multiplication_24_sint_mul_gen_addends_io_addend_17 <= multiplication_24_sint_mul_gen_addends_io_addend_17;
    multiplication_24_sint_mul_adder_8_io_b <= reg_0_d_multiplication_24_sint_mul_gen_addends_io_addend_17;
    reg_next_0_d_multiplication_24_sint_mul_gen_addends_io_addend_18 <= multiplication_24_sint_mul_gen_addends_io_addend_18;
    multiplication_24_sint_mul_adder_9_io_a <= reg_0_d_multiplication_24_sint_mul_gen_addends_io_addend_18;
    reg_next_0_d_multiplication_24_sint_mul_gen_addends_io_addend_19 <= multiplication_24_sint_mul_gen_addends_io_addend_19;
    multiplication_24_sint_mul_adder_9_io_b <= reg_0_d_multiplication_24_sint_mul_gen_addends_io_addend_19;
    reg_next_0_d_multiplication_24_sint_mul_gen_addends_io_addend_20 <= multiplication_24_sint_mul_gen_addends_io_addend_20;
    multiplication_24_sint_mul_adder_10_io_a <= reg_0_d_multiplication_24_sint_mul_gen_addends_io_addend_20;
    reg_next_0_d_multiplication_24_sint_mul_gen_addends_io_addend_21 <= multiplication_24_sint_mul_gen_addends_io_addend_21;
    multiplication_24_sint_mul_adder_10_io_b <= reg_0_d_multiplication_24_sint_mul_gen_addends_io_addend_21;
    reg_next_0_d_multiplication_24_sint_mul_gen_addends_io_addend_22 <= multiplication_24_sint_mul_gen_addends_io_addend_22;
    multiplication_24_sint_mul_adder_11_io_a <= reg_0_d_multiplication_24_sint_mul_gen_addends_io_addend_22;
    reg_next_0_d_multiplication_24_sint_mul_gen_addends_io_addend_23 <= multiplication_24_sint_mul_gen_addends_io_addend_23;
    multiplication_24_sint_mul_adder_11_io_b <= reg_0_d_multiplication_24_sint_mul_gen_addends_io_addend_23;
    reg_next_0_d_multiplication_24_sint_mul_gen_addends_io_addend_24 <= multiplication_24_sint_mul_gen_addends_io_addend_24;
    multiplication_24_sint_mul_adder_12_io_a <= reg_0_d_multiplication_24_sint_mul_gen_addends_io_addend_24;
    reg_next_0_d_multiplication_24_sint_mul_gen_addends_io_addend_25 <= multiplication_24_sint_mul_gen_addends_io_addend_25;
    multiplication_24_sint_mul_adder_12_io_b <= reg_0_d_multiplication_24_sint_mul_gen_addends_io_addend_25;
    reg_next_0_d_multiplication_24_sint_mul_gen_addends_io_addend_26 <= multiplication_24_sint_mul_gen_addends_io_addend_26;
    multiplication_24_sint_mul_adder_13_io_a <= reg_0_d_multiplication_24_sint_mul_gen_addends_io_addend_26;
    reg_next_0_d_multiplication_24_sint_mul_gen_addends_io_addend_27 <= multiplication_24_sint_mul_gen_addends_io_addend_27;
    multiplication_24_sint_mul_adder_13_io_b <= reg_0_d_multiplication_24_sint_mul_gen_addends_io_addend_27;
    reg_next_1_d_multiplication_24_sint_mul_gen_addends_io_subend <= reg_0_d_multiplication_24_sint_mul_gen_addends_io_subend;
    reg_next_2_d_multiplication_24_sint_mul_gen_addends_io_subend <= reg_1_d_multiplication_24_sint_mul_gen_addends_io_subend;
    reg_next_3_d_multiplication_24_sint_mul_gen_addends_io_subend <= reg_2_d_multiplication_24_sint_mul_gen_addends_io_subend;
    reg_next_0_d_multiplication_24_sint_mul_gen_addends_io_subend <= multiplication_24_sint_mul_gen_addends_io_subend;
    multiplication_24_sint_mul_subtractor_io_b <= reg_3_d_multiplication_24_sint_mul_gen_addends_io_subend;
    multiplication_24_sint_mul_adder_14_io_a <= multiplication_24_sint_mul_adder_0_io_r;
    multiplication_24_sint_mul_adder_14_io_b <= multiplication_24_sint_mul_adder_1_io_r;
    multiplication_24_sint_mul_adder_15_io_a <= multiplication_24_sint_mul_adder_2_io_r;
    multiplication_24_sint_mul_adder_15_io_b <= multiplication_24_sint_mul_adder_3_io_r;
    multiplication_24_sint_mul_adder_16_io_a <= multiplication_24_sint_mul_adder_4_io_r;
    multiplication_24_sint_mul_adder_16_io_b <= multiplication_24_sint_mul_adder_5_io_r;
    reg_next_0_d_multiplication_24_sint_mul_adder_6_io_r <= multiplication_24_sint_mul_adder_6_io_r;
    multiplication_24_sint_mul_adder_17_io_a <= reg_0_d_multiplication_24_sint_mul_adder_6_io_r;
    reg_next_0_d_multiplication_24_sint_mul_adder_7_io_r <= multiplication_24_sint_mul_adder_7_io_r;
    multiplication_24_sint_mul_adder_17_io_b <= reg_0_d_multiplication_24_sint_mul_adder_7_io_r;
    reg_next_0_d_multiplication_24_sint_mul_adder_8_io_r <= multiplication_24_sint_mul_adder_8_io_r;
    multiplication_24_sint_mul_adder_18_io_a <= reg_0_d_multiplication_24_sint_mul_adder_8_io_r;
    reg_next_0_d_multiplication_24_sint_mul_adder_9_io_r <= multiplication_24_sint_mul_adder_9_io_r;
    multiplication_24_sint_mul_adder_18_io_b <= reg_0_d_multiplication_24_sint_mul_adder_9_io_r;
    multiplication_24_sint_mul_adder_19_io_a <= multiplication_24_sint_mul_adder_10_io_r;
    multiplication_24_sint_mul_adder_19_io_b <= multiplication_24_sint_mul_adder_11_io_r;
    multiplication_24_sint_mul_adder_20_io_a <= multiplication_24_sint_mul_adder_12_io_r;
    multiplication_24_sint_mul_adder_20_io_b <= multiplication_24_sint_mul_adder_13_io_r;
    multiplication_24_sint_mul_adder_21_io_a <= multiplication_24_sint_mul_adder_14_io_r;
    multiplication_24_sint_mul_adder_21_io_b <= multiplication_24_sint_mul_adder_15_io_r;
    reg_next_1_d_multiplication_24_sint_mul_adder_16_io_r <= reg_0_d_multiplication_24_sint_mul_adder_16_io_r;
    reg_next_2_d_multiplication_24_sint_mul_adder_16_io_r <= reg_1_d_multiplication_24_sint_mul_adder_16_io_r;
    reg_next_0_d_multiplication_24_sint_mul_adder_16_io_r <= multiplication_24_sint_mul_adder_16_io_r;
    multiplication_24_sint_mul_adder_22_io_a <= reg_2_d_multiplication_24_sint_mul_adder_16_io_r;
    reg_next_0_d_multiplication_24_sint_mul_adder_17_io_r <= multiplication_24_sint_mul_adder_17_io_r;
    multiplication_24_sint_mul_adder_22_io_b <= reg_0_d_multiplication_24_sint_mul_adder_17_io_r;
    reg_next_0_d_multiplication_24_sint_mul_adder_18_io_r <= multiplication_24_sint_mul_adder_18_io_r;
    multiplication_24_sint_mul_adder_23_io_a <= reg_0_d_multiplication_24_sint_mul_adder_18_io_r;
    reg_next_1_d_multiplication_24_sint_mul_adder_19_io_r <= reg_0_d_multiplication_24_sint_mul_adder_19_io_r;
    reg_next_0_d_multiplication_24_sint_mul_adder_19_io_r <= multiplication_24_sint_mul_adder_19_io_r;
    multiplication_24_sint_mul_adder_23_io_b <= reg_1_d_multiplication_24_sint_mul_adder_19_io_r;
    reg_next_1_d_multiplication_24_sint_mul_adder_20_io_r <= reg_0_d_multiplication_24_sint_mul_adder_20_io_r;
    reg_next_0_d_multiplication_24_sint_mul_adder_20_io_r <= multiplication_24_sint_mul_adder_20_io_r;
    multiplication_24_sint_mul_adder_25_io_b <= reg_1_d_multiplication_24_sint_mul_adder_20_io_r;
    reg_next_1_d_multiplication_24_sint_mul_adder_21_io_r <= reg_0_d_multiplication_24_sint_mul_adder_21_io_r;
    reg_next_2_d_multiplication_24_sint_mul_adder_21_io_r <= reg_1_d_multiplication_24_sint_mul_adder_21_io_r;
    reg_next_0_d_multiplication_24_sint_mul_adder_21_io_r <= multiplication_24_sint_mul_adder_21_io_r;
    multiplication_24_sint_mul_adder_24_io_a <= reg_2_d_multiplication_24_sint_mul_adder_21_io_r;
    multiplication_24_sint_mul_adder_24_io_b <= multiplication_24_sint_mul_adder_22_io_r;
    multiplication_24_sint_mul_adder_25_io_a <= multiplication_24_sint_mul_adder_23_io_r;
    reg_next_0_d_multiplication_24_sint_mul_adder_24_io_r <= multiplication_24_sint_mul_adder_24_io_r;
    multiplication_24_sint_mul_adder_26_io_a <= reg_0_d_multiplication_24_sint_mul_adder_24_io_r;
    reg_next_0_d_multiplication_24_sint_mul_adder_25_io_r <= multiplication_24_sint_mul_adder_25_io_r;
    multiplication_24_sint_mul_adder_26_io_b <= reg_0_d_multiplication_24_sint_mul_adder_25_io_r;
    multiplication_24_sint_mul_subtractor_io_a <= multiplication_24_sint_mul_adder_26_io_r;
    multiplication_24_tc_io_i <= multiplication_24_sint_mul_subtractor_io_r;
    reg_next_0_d_multiplication_24_tc_io_o <= multiplication_24_tc_io_o;
    addition_25_io_b <= reg_0_d_multiplication_24_tc_io_o;
    arith_shifter_26_io_i <= addition_25_io_r;
    reg_next_0_d_arith_shifter_26_io_o <= arith_shifter_26_io_o;
    addition_27_io_b <= reg_0_d_arith_shifter_26_io_o;
    arith_shifter_28_io_i <= addition_27_io_r;
    multiplication_45_sint_mul_gen_addends_io_short <= addition_27_io_r;
    subtraction_29_io_b <= arith_shifter_28_io_o;
    arith_shifter_30_io_i <= subtraction_29_io_r;
    fract_31_io_i <= arith_shifter_30_io_o;
    arith_shifter_32_io_i <= fract_31_io_o;
    subtraction_33_io_a <= arith_shifter_32_io_o;
    reg_next_0_d_subtraction_33_io_r <= subtraction_33_io_r;
    mux_calc_io_ee <= reg_0_d_subtraction_33_io_r;
    multiplication_38_sint_mul_gen_addends_io_long <= reg_0_d_subtraction_33_io_r;
    multiplication_38_sint_mul_gen_addends_io_short <= reg_0_d_subtraction_33_io_r;
    arith_shifter_35_io_i <= min_34_io_o;
    fract_36_io_i <= arith_shifter_35_io_o;
    reg_next_1_d_fract_36_io_o <= reg_0_d_fract_36_io_o;
    reg_next_2_d_fract_36_io_o <= reg_1_d_fract_36_io_o;
    reg_next_3_d_fract_36_io_o <= reg_2_d_fract_36_io_o;
    reg_next_4_d_fract_36_io_o <= reg_3_d_fract_36_io_o;
    reg_next_5_d_fract_36_io_o <= reg_4_d_fract_36_io_o;
    reg_next_6_d_fract_36_io_o <= reg_5_d_fract_36_io_o;
    reg_next_0_d_fract_36_io_o <= fract_36_io_o;
    mux_calc_io_vv <= reg_6_d_fract_36_io_o;
    reg_next_0_d_mux_calc_io_o <= mux_calc_io_o;
    multiplication_37_sint_mul_gen_addends_io_long <= reg_0_d_mux_calc_io_o;
    multiplication_37_sint_mul_adder_0_io_a <= multiplication_37_sint_mul_gen_addends_io_addend_0;
    multiplication_37_sint_mul_adder_0_io_b <= multiplication_37_sint_mul_gen_addends_io_addend_1;
    multiplication_37_sint_mul_adder_1_io_a <= multiplication_37_sint_mul_gen_addends_io_addend_2;
    multiplication_37_sint_mul_adder_1_io_b <= multiplication_37_sint_mul_gen_addends_io_addend_3;
    multiplication_37_sint_mul_adder_2_io_a <= multiplication_37_sint_mul_gen_addends_io_addend_4;
    multiplication_37_sint_mul_adder_2_io_b <= multiplication_37_sint_mul_gen_addends_io_addend_5;
    multiplication_37_sint_mul_adder_3_io_a <= multiplication_37_sint_mul_gen_addends_io_addend_6;
    multiplication_37_sint_mul_adder_3_io_b <= multiplication_37_sint_mul_gen_addends_io_addend_7;
    multiplication_37_sint_mul_adder_4_io_a <= multiplication_37_sint_mul_gen_addends_io_addend_8;
    multiplication_37_sint_mul_adder_4_io_b <= multiplication_37_sint_mul_gen_addends_io_addend_9;
    multiplication_37_sint_mul_adder_5_io_a <= multiplication_37_sint_mul_gen_addends_io_addend_10;
    multiplication_37_sint_mul_adder_5_io_b <= multiplication_37_sint_mul_gen_addends_io_addend_11;
    multiplication_37_sint_mul_adder_6_io_a <= multiplication_37_sint_mul_gen_addends_io_addend_12;
    multiplication_37_sint_mul_adder_6_io_b <= multiplication_37_sint_mul_gen_addends_io_addend_13;
    multiplication_37_sint_mul_adder_7_io_a <= multiplication_37_sint_mul_gen_addends_io_addend_14;
    multiplication_37_sint_mul_adder_7_io_b <= multiplication_37_sint_mul_gen_addends_io_addend_15;
    multiplication_37_sint_mul_adder_8_io_a <= multiplication_37_sint_mul_gen_addends_io_addend_16;
    multiplication_37_sint_mul_adder_8_io_b <= multiplication_37_sint_mul_gen_addends_io_addend_17;
    multiplication_37_sint_mul_adder_9_io_a <= multiplication_37_sint_mul_gen_addends_io_addend_18;
    multiplication_37_sint_mul_adder_9_io_b <= multiplication_37_sint_mul_gen_addends_io_addend_19;
    multiplication_37_sint_mul_adder_10_io_a <= multiplication_37_sint_mul_gen_addends_io_addend_20;
    multiplication_37_sint_mul_adder_10_io_b <= multiplication_37_sint_mul_gen_addends_io_addend_21;
    multiplication_37_sint_mul_adder_11_io_a <= multiplication_37_sint_mul_gen_addends_io_addend_22;
    multiplication_37_sint_mul_adder_11_io_b <= multiplication_37_sint_mul_gen_addends_io_addend_23;
    multiplication_37_sint_mul_adder_12_io_a <= multiplication_37_sint_mul_gen_addends_io_addend_24;
    multiplication_37_sint_mul_adder_12_io_b <= multiplication_37_sint_mul_gen_addends_io_addend_25;
    multiplication_37_sint_mul_adder_13_io_a <= multiplication_37_sint_mul_gen_addends_io_addend_26;
    multiplication_37_sint_mul_adder_13_io_b <= multiplication_37_sint_mul_gen_addends_io_addend_27;
    reg_next_0_d_multiplication_37_sint_mul_gen_addends_io_subend <= multiplication_37_sint_mul_gen_addends_io_subend;
    multiplication_37_sint_mul_subtractor_io_b <= reg_0_d_multiplication_37_sint_mul_gen_addends_io_subend;
    multiplication_37_sint_mul_adder_14_io_a <= multiplication_37_sint_mul_adder_0_io_r;
    multiplication_37_sint_mul_adder_14_io_b <= multiplication_37_sint_mul_adder_1_io_r;
    multiplication_37_sint_mul_adder_15_io_a <= multiplication_37_sint_mul_adder_2_io_r;
    multiplication_37_sint_mul_adder_15_io_b <= multiplication_37_sint_mul_adder_3_io_r;
    reg_next_0_d_multiplication_37_sint_mul_adder_4_io_r <= multiplication_37_sint_mul_adder_4_io_r;
    multiplication_37_sint_mul_adder_16_io_a <= reg_0_d_multiplication_37_sint_mul_adder_4_io_r;
    reg_next_0_d_multiplication_37_sint_mul_adder_5_io_r <= multiplication_37_sint_mul_adder_5_io_r;
    multiplication_37_sint_mul_adder_16_io_b <= reg_0_d_multiplication_37_sint_mul_adder_5_io_r;
    multiplication_37_sint_mul_adder_17_io_a <= multiplication_37_sint_mul_adder_6_io_r;
    multiplication_37_sint_mul_adder_17_io_b <= multiplication_37_sint_mul_adder_7_io_r;
    multiplication_37_sint_mul_adder_18_io_a <= multiplication_37_sint_mul_adder_8_io_r;
    multiplication_37_sint_mul_adder_18_io_b <= multiplication_37_sint_mul_adder_9_io_r;
    multiplication_37_sint_mul_adder_19_io_a <= multiplication_37_sint_mul_adder_10_io_r;
    multiplication_37_sint_mul_adder_19_io_b <= multiplication_37_sint_mul_adder_11_io_r;
    multiplication_37_sint_mul_adder_20_io_a <= multiplication_37_sint_mul_adder_12_io_r;
    multiplication_37_sint_mul_adder_20_io_b <= multiplication_37_sint_mul_adder_13_io_r;
    reg_next_0_d_multiplication_37_sint_mul_adder_14_io_r <= multiplication_37_sint_mul_adder_14_io_r;
    multiplication_37_sint_mul_adder_21_io_a <= reg_0_d_multiplication_37_sint_mul_adder_14_io_r;
    reg_next_0_d_multiplication_37_sint_mul_adder_15_io_r <= multiplication_37_sint_mul_adder_15_io_r;
    multiplication_37_sint_mul_adder_21_io_b <= reg_0_d_multiplication_37_sint_mul_adder_15_io_r;
    multiplication_37_sint_mul_adder_22_io_a <= multiplication_37_sint_mul_adder_16_io_r;
    reg_next_0_d_multiplication_37_sint_mul_adder_17_io_r <= multiplication_37_sint_mul_adder_17_io_r;
    multiplication_37_sint_mul_adder_22_io_b <= reg_0_d_multiplication_37_sint_mul_adder_17_io_r;
    multiplication_37_sint_mul_adder_23_io_a <= multiplication_37_sint_mul_adder_18_io_r;
    multiplication_37_sint_mul_adder_23_io_b <= multiplication_37_sint_mul_adder_19_io_r;
    multiplication_37_sint_mul_adder_25_io_b <= multiplication_37_sint_mul_adder_20_io_r;
    multiplication_37_sint_mul_adder_24_io_a <= multiplication_37_sint_mul_adder_21_io_r;
    multiplication_37_sint_mul_adder_24_io_b <= multiplication_37_sint_mul_adder_22_io_r;
    multiplication_37_sint_mul_adder_25_io_a <= multiplication_37_sint_mul_adder_23_io_r;
    multiplication_37_sint_mul_adder_26_io_a <= multiplication_37_sint_mul_adder_24_io_r;
    reg_next_0_d_multiplication_37_sint_mul_adder_25_io_r <= multiplication_37_sint_mul_adder_25_io_r;
    multiplication_37_sint_mul_adder_26_io_b <= reg_0_d_multiplication_37_sint_mul_adder_25_io_r;
    multiplication_37_sint_mul_subtractor_io_a <= multiplication_37_sint_mul_adder_26_io_r;
    multiplication_37_tc_io_i <= multiplication_37_sint_mul_subtractor_io_r;
    reg_next_1_d_multiplication_37_tc_io_o <= reg_0_d_multiplication_37_tc_io_o;
    reg_next_2_d_multiplication_37_tc_io_o <= reg_1_d_multiplication_37_tc_io_o;
    reg_next_3_d_multiplication_37_tc_io_o <= reg_2_d_multiplication_37_tc_io_o;
    reg_next_0_d_multiplication_37_tc_io_o <= multiplication_37_tc_io_o;
    subtraction_39_io_a <= reg_3_d_multiplication_37_tc_io_o;
    multiplication_38_sint_mul_adder_0_io_a <= multiplication_38_sint_mul_gen_addends_io_addend_0;
    multiplication_38_sint_mul_adder_0_io_b <= multiplication_38_sint_mul_gen_addends_io_addend_1;
    multiplication_38_sint_mul_adder_1_io_a <= multiplication_38_sint_mul_gen_addends_io_addend_2;
    multiplication_38_sint_mul_adder_1_io_b <= multiplication_38_sint_mul_gen_addends_io_addend_3;
    multiplication_38_sint_mul_adder_2_io_a <= multiplication_38_sint_mul_gen_addends_io_addend_4;
    multiplication_38_sint_mul_adder_2_io_b <= multiplication_38_sint_mul_gen_addends_io_addend_5;
    multiplication_38_sint_mul_adder_3_io_a <= multiplication_38_sint_mul_gen_addends_io_addend_6;
    multiplication_38_sint_mul_adder_3_io_b <= multiplication_38_sint_mul_gen_addends_io_addend_7;
    multiplication_38_sint_mul_adder_4_io_a <= multiplication_38_sint_mul_gen_addends_io_addend_8;
    multiplication_38_sint_mul_adder_4_io_b <= multiplication_38_sint_mul_gen_addends_io_addend_9;
    multiplication_38_sint_mul_adder_5_io_a <= multiplication_38_sint_mul_gen_addends_io_addend_10;
    multiplication_38_sint_mul_adder_5_io_b <= multiplication_38_sint_mul_gen_addends_io_addend_11;
    multiplication_38_sint_mul_adder_6_io_a <= multiplication_38_sint_mul_gen_addends_io_addend_12;
    multiplication_38_sint_mul_adder_6_io_b <= multiplication_38_sint_mul_gen_addends_io_addend_13;
    multiplication_38_sint_mul_adder_7_io_a <= multiplication_38_sint_mul_gen_addends_io_addend_14;
    multiplication_38_sint_mul_adder_7_io_b <= multiplication_38_sint_mul_gen_addends_io_addend_15;
    multiplication_38_sint_mul_adder_8_io_a <= multiplication_38_sint_mul_gen_addends_io_addend_16;
    multiplication_38_sint_mul_adder_8_io_b <= multiplication_38_sint_mul_gen_addends_io_addend_17;
    multiplication_38_sint_mul_adder_9_io_a <= multiplication_38_sint_mul_gen_addends_io_addend_18;
    multiplication_38_sint_mul_adder_9_io_b <= multiplication_38_sint_mul_gen_addends_io_addend_19;
    multiplication_38_sint_mul_adder_10_io_a <= multiplication_38_sint_mul_gen_addends_io_addend_20;
    multiplication_38_sint_mul_adder_10_io_b <= multiplication_38_sint_mul_gen_addends_io_addend_21;
    multiplication_38_sint_mul_adder_11_io_a <= multiplication_38_sint_mul_gen_addends_io_addend_22;
    multiplication_38_sint_mul_adder_11_io_b <= multiplication_38_sint_mul_gen_addends_io_addend_23;
    multiplication_38_sint_mul_adder_12_io_a <= multiplication_38_sint_mul_gen_addends_io_addend_24;
    multiplication_38_sint_mul_adder_12_io_b <= multiplication_38_sint_mul_gen_addends_io_addend_25;
    multiplication_38_sint_mul_adder_13_io_a <= multiplication_38_sint_mul_gen_addends_io_addend_26;
    multiplication_38_sint_mul_adder_13_io_b <= multiplication_38_sint_mul_gen_addends_io_addend_27;
    reg_next_1_d_multiplication_38_sint_mul_gen_addends_io_subend <= reg_0_d_multiplication_38_sint_mul_gen_addends_io_subend;
    reg_next_2_d_multiplication_38_sint_mul_gen_addends_io_subend <= reg_1_d_multiplication_38_sint_mul_gen_addends_io_subend;
    reg_next_3_d_multiplication_38_sint_mul_gen_addends_io_subend <= reg_2_d_multiplication_38_sint_mul_gen_addends_io_subend;
    reg_next_4_d_multiplication_38_sint_mul_gen_addends_io_subend <= reg_3_d_multiplication_38_sint_mul_gen_addends_io_subend;
    reg_next_0_d_multiplication_38_sint_mul_gen_addends_io_subend <= multiplication_38_sint_mul_gen_addends_io_subend;
    multiplication_38_sint_mul_subtractor_io_b <= reg_4_d_multiplication_38_sint_mul_gen_addends_io_subend;
    reg_next_0_d_multiplication_38_sint_mul_adder_0_io_r <= multiplication_38_sint_mul_adder_0_io_r;
    multiplication_38_sint_mul_adder_14_io_a <= reg_0_d_multiplication_38_sint_mul_adder_0_io_r;
    reg_next_0_d_multiplication_38_sint_mul_adder_1_io_r <= multiplication_38_sint_mul_adder_1_io_r;
    multiplication_38_sint_mul_adder_14_io_b <= reg_0_d_multiplication_38_sint_mul_adder_1_io_r;
    reg_next_0_d_multiplication_38_sint_mul_adder_2_io_r <= multiplication_38_sint_mul_adder_2_io_r;
    multiplication_38_sint_mul_adder_15_io_a <= reg_0_d_multiplication_38_sint_mul_adder_2_io_r;
    reg_next_0_d_multiplication_38_sint_mul_adder_3_io_r <= multiplication_38_sint_mul_adder_3_io_r;
    multiplication_38_sint_mul_adder_15_io_b <= reg_0_d_multiplication_38_sint_mul_adder_3_io_r;
    reg_next_0_d_multiplication_38_sint_mul_adder_4_io_r <= multiplication_38_sint_mul_adder_4_io_r;
    multiplication_38_sint_mul_adder_16_io_a <= reg_0_d_multiplication_38_sint_mul_adder_4_io_r;
    reg_next_0_d_multiplication_38_sint_mul_adder_5_io_r <= multiplication_38_sint_mul_adder_5_io_r;
    multiplication_38_sint_mul_adder_16_io_b <= reg_0_d_multiplication_38_sint_mul_adder_5_io_r;
    reg_next_0_d_multiplication_38_sint_mul_adder_6_io_r <= multiplication_38_sint_mul_adder_6_io_r;
    multiplication_38_sint_mul_adder_17_io_a <= reg_0_d_multiplication_38_sint_mul_adder_6_io_r;
    reg_next_0_d_multiplication_38_sint_mul_adder_7_io_r <= multiplication_38_sint_mul_adder_7_io_r;
    multiplication_38_sint_mul_adder_17_io_b <= reg_0_d_multiplication_38_sint_mul_adder_7_io_r;
    multiplication_38_sint_mul_adder_18_io_a <= multiplication_38_sint_mul_adder_8_io_r;
    multiplication_38_sint_mul_adder_18_io_b <= multiplication_38_sint_mul_adder_9_io_r;
    multiplication_38_sint_mul_adder_19_io_a <= multiplication_38_sint_mul_adder_10_io_r;
    multiplication_38_sint_mul_adder_19_io_b <= multiplication_38_sint_mul_adder_11_io_r;
    reg_next_0_d_multiplication_38_sint_mul_adder_12_io_r <= multiplication_38_sint_mul_adder_12_io_r;
    multiplication_38_sint_mul_adder_20_io_a <= reg_0_d_multiplication_38_sint_mul_adder_12_io_r;
    reg_next_0_d_multiplication_38_sint_mul_adder_13_io_r <= multiplication_38_sint_mul_adder_13_io_r;
    multiplication_38_sint_mul_adder_20_io_b <= reg_0_d_multiplication_38_sint_mul_adder_13_io_r;
    reg_next_0_d_multiplication_38_sint_mul_adder_14_io_r <= multiplication_38_sint_mul_adder_14_io_r;
    multiplication_38_sint_mul_adder_21_io_a <= reg_0_d_multiplication_38_sint_mul_adder_14_io_r;
    reg_next_0_d_multiplication_38_sint_mul_adder_15_io_r <= multiplication_38_sint_mul_adder_15_io_r;
    multiplication_38_sint_mul_adder_21_io_b <= reg_0_d_multiplication_38_sint_mul_adder_15_io_r;
    reg_next_0_d_multiplication_38_sint_mul_adder_16_io_r <= multiplication_38_sint_mul_adder_16_io_r;
    multiplication_38_sint_mul_adder_22_io_a <= reg_0_d_multiplication_38_sint_mul_adder_16_io_r;
    reg_next_0_d_multiplication_38_sint_mul_adder_17_io_r <= multiplication_38_sint_mul_adder_17_io_r;
    multiplication_38_sint_mul_adder_22_io_b <= reg_0_d_multiplication_38_sint_mul_adder_17_io_r;
    reg_next_0_d_multiplication_38_sint_mul_adder_18_io_r <= multiplication_38_sint_mul_adder_18_io_r;
    multiplication_38_sint_mul_adder_23_io_a <= reg_0_d_multiplication_38_sint_mul_adder_18_io_r;
    reg_next_0_d_multiplication_38_sint_mul_adder_19_io_r <= multiplication_38_sint_mul_adder_19_io_r;
    multiplication_38_sint_mul_adder_23_io_b <= reg_0_d_multiplication_38_sint_mul_adder_19_io_r;
    reg_next_0_d_multiplication_38_sint_mul_adder_20_io_r <= multiplication_38_sint_mul_adder_20_io_r;
    multiplication_38_sint_mul_adder_25_io_b <= reg_0_d_multiplication_38_sint_mul_adder_20_io_r;
    reg_next_0_d_multiplication_38_sint_mul_adder_21_io_r <= multiplication_38_sint_mul_adder_21_io_r;
    multiplication_38_sint_mul_adder_24_io_a <= reg_0_d_multiplication_38_sint_mul_adder_21_io_r;
    reg_next_0_d_multiplication_38_sint_mul_adder_22_io_r <= multiplication_38_sint_mul_adder_22_io_r;
    multiplication_38_sint_mul_adder_24_io_b <= reg_0_d_multiplication_38_sint_mul_adder_22_io_r;
    reg_next_0_d_multiplication_38_sint_mul_adder_23_io_r <= multiplication_38_sint_mul_adder_23_io_r;
    multiplication_38_sint_mul_adder_25_io_a <= reg_0_d_multiplication_38_sint_mul_adder_23_io_r;
    reg_next_0_d_multiplication_38_sint_mul_adder_24_io_r <= multiplication_38_sint_mul_adder_24_io_r;
    multiplication_38_sint_mul_adder_26_io_a <= reg_0_d_multiplication_38_sint_mul_adder_24_io_r;
    reg_next_1_d_multiplication_38_sint_mul_adder_25_io_r <= reg_0_d_multiplication_38_sint_mul_adder_25_io_r;
    reg_next_0_d_multiplication_38_sint_mul_adder_25_io_r <= multiplication_38_sint_mul_adder_25_io_r;
    multiplication_38_sint_mul_adder_26_io_b <= reg_1_d_multiplication_38_sint_mul_adder_25_io_r;
    reg_next_0_d_multiplication_38_sint_mul_adder_26_io_r <= multiplication_38_sint_mul_adder_26_io_r;
    multiplication_38_sint_mul_subtractor_io_a <= reg_0_d_multiplication_38_sint_mul_adder_26_io_r;
    multiplication_38_tc_io_i <= multiplication_38_sint_mul_subtractor_io_r;
    reg_next_0_d_multiplication_38_tc_io_o <= multiplication_38_tc_io_o;
    subtraction_39_io_b <= reg_0_d_multiplication_38_tc_io_o;
    arith_shifter_40_io_i <= subtraction_39_io_r;
    arith_shifter_41_io_i <= subtraction_39_io_r;
    reg_next_0_d_arith_shifter_40_io_o <= arith_shifter_40_io_o;
    addition_42_io_a <= reg_0_d_arith_shifter_40_io_o;
    reg_next_0_d_arith_shifter_41_io_o <= arith_shifter_41_io_o;
    addition_42_io_b <= reg_0_d_arith_shifter_41_io_o;
    reg_next_0_d_addition_42_io_r <= addition_42_io_r;
    addition_43_io_a <= reg_0_d_addition_42_io_r;
    reg_next_0_d_addition_43_io_r <= addition_43_io_r;
    clamp01_44_io_i <= reg_0_d_addition_43_io_r;
    reg_next_0_d_clamp01_44_io_o <= clamp01_44_io_o;
    addition_46_io_a <= reg_0_d_clamp01_44_io_o;
    multiplication_45_sint_mul_adder_0_io_a <= multiplication_45_sint_mul_gen_addends_io_addend_0;
    multiplication_45_sint_mul_adder_0_io_b <= multiplication_45_sint_mul_gen_addends_io_addend_1;
    multiplication_45_sint_mul_adder_1_io_a <= multiplication_45_sint_mul_gen_addends_io_addend_2;
    multiplication_45_sint_mul_adder_1_io_b <= multiplication_45_sint_mul_gen_addends_io_addend_3;
    multiplication_45_sint_mul_adder_2_io_a <= multiplication_45_sint_mul_gen_addends_io_addend_4;
    multiplication_45_sint_mul_adder_2_io_b <= multiplication_45_sint_mul_gen_addends_io_addend_5;
    multiplication_45_sint_mul_adder_3_io_a <= multiplication_45_sint_mul_gen_addends_io_addend_6;
    multiplication_45_sint_mul_adder_3_io_b <= multiplication_45_sint_mul_gen_addends_io_addend_7;
    multiplication_45_sint_mul_adder_4_io_a <= multiplication_45_sint_mul_gen_addends_io_addend_8;
    multiplication_45_sint_mul_adder_4_io_b <= multiplication_45_sint_mul_gen_addends_io_addend_9;
    multiplication_45_sint_mul_adder_5_io_a <= multiplication_45_sint_mul_gen_addends_io_addend_10;
    multiplication_45_sint_mul_adder_5_io_b <= multiplication_45_sint_mul_gen_addends_io_addend_11;
    multiplication_45_sint_mul_adder_6_io_a <= multiplication_45_sint_mul_gen_addends_io_addend_12;
    multiplication_45_sint_mul_adder_6_io_b <= multiplication_45_sint_mul_gen_addends_io_addend_13;
    multiplication_45_sint_mul_adder_7_io_a <= multiplication_45_sint_mul_gen_addends_io_addend_14;
    multiplication_45_sint_mul_adder_7_io_b <= multiplication_45_sint_mul_gen_addends_io_addend_15;
    multiplication_45_sint_mul_adder_8_io_a <= multiplication_45_sint_mul_gen_addends_io_addend_16;
    multiplication_45_sint_mul_adder_8_io_b <= multiplication_45_sint_mul_gen_addends_io_addend_17;
    multiplication_45_sint_mul_adder_9_io_a <= multiplication_45_sint_mul_gen_addends_io_addend_18;
    multiplication_45_sint_mul_adder_9_io_b <= multiplication_45_sint_mul_gen_addends_io_addend_19;
    multiplication_45_sint_mul_adder_10_io_a <= multiplication_45_sint_mul_gen_addends_io_addend_20;
    multiplication_45_sint_mul_adder_10_io_b <= multiplication_45_sint_mul_gen_addends_io_addend_21;
    multiplication_45_sint_mul_adder_11_io_a <= multiplication_45_sint_mul_gen_addends_io_addend_22;
    multiplication_45_sint_mul_adder_11_io_b <= multiplication_45_sint_mul_gen_addends_io_addend_23;
    multiplication_45_sint_mul_adder_12_io_a <= multiplication_45_sint_mul_gen_addends_io_addend_24;
    multiplication_45_sint_mul_adder_12_io_b <= multiplication_45_sint_mul_gen_addends_io_addend_25;
    multiplication_45_sint_mul_adder_13_io_a <= multiplication_45_sint_mul_gen_addends_io_addend_26;
    multiplication_45_sint_mul_adder_13_io_b <= multiplication_45_sint_mul_gen_addends_io_addend_27;
    reg_next_1_d_multiplication_45_sint_mul_gen_addends_io_subend <= reg_0_d_multiplication_45_sint_mul_gen_addends_io_subend;
    reg_next_2_d_multiplication_45_sint_mul_gen_addends_io_subend <= reg_1_d_multiplication_45_sint_mul_gen_addends_io_subend;
    reg_next_3_d_multiplication_45_sint_mul_gen_addends_io_subend <= reg_2_d_multiplication_45_sint_mul_gen_addends_io_subend;
    reg_next_4_d_multiplication_45_sint_mul_gen_addends_io_subend <= reg_3_d_multiplication_45_sint_mul_gen_addends_io_subend;
    reg_next_0_d_multiplication_45_sint_mul_gen_addends_io_subend <= multiplication_45_sint_mul_gen_addends_io_subend;
    multiplication_45_sint_mul_subtractor_io_b <= reg_4_d_multiplication_45_sint_mul_gen_addends_io_subend;
    multiplication_45_sint_mul_adder_14_io_a <= multiplication_45_sint_mul_adder_0_io_r;
    multiplication_45_sint_mul_adder_14_io_b <= multiplication_45_sint_mul_adder_1_io_r;
    multiplication_45_sint_mul_adder_15_io_a <= multiplication_45_sint_mul_adder_2_io_r;
    multiplication_45_sint_mul_adder_15_io_b <= multiplication_45_sint_mul_adder_3_io_r;
    reg_next_0_d_multiplication_45_sint_mul_adder_4_io_r <= multiplication_45_sint_mul_adder_4_io_r;
    multiplication_45_sint_mul_adder_16_io_a <= reg_0_d_multiplication_45_sint_mul_adder_4_io_r;
    reg_next_0_d_multiplication_45_sint_mul_adder_5_io_r <= multiplication_45_sint_mul_adder_5_io_r;
    multiplication_45_sint_mul_adder_16_io_b <= reg_0_d_multiplication_45_sint_mul_adder_5_io_r;
    reg_next_0_d_multiplication_45_sint_mul_adder_6_io_r <= multiplication_45_sint_mul_adder_6_io_r;
    multiplication_45_sint_mul_adder_17_io_a <= reg_0_d_multiplication_45_sint_mul_adder_6_io_r;
    reg_next_0_d_multiplication_45_sint_mul_adder_7_io_r <= multiplication_45_sint_mul_adder_7_io_r;
    multiplication_45_sint_mul_adder_17_io_b <= reg_0_d_multiplication_45_sint_mul_adder_7_io_r;
    reg_next_0_d_multiplication_45_sint_mul_adder_8_io_r <= multiplication_45_sint_mul_adder_8_io_r;
    multiplication_45_sint_mul_adder_18_io_a <= reg_0_d_multiplication_45_sint_mul_adder_8_io_r;
    reg_next_0_d_multiplication_45_sint_mul_adder_9_io_r <= multiplication_45_sint_mul_adder_9_io_r;
    multiplication_45_sint_mul_adder_18_io_b <= reg_0_d_multiplication_45_sint_mul_adder_9_io_r;
    reg_next_0_d_multiplication_45_sint_mul_adder_10_io_r <= multiplication_45_sint_mul_adder_10_io_r;
    multiplication_45_sint_mul_adder_19_io_a <= reg_0_d_multiplication_45_sint_mul_adder_10_io_r;
    reg_next_0_d_multiplication_45_sint_mul_adder_11_io_r <= multiplication_45_sint_mul_adder_11_io_r;
    multiplication_45_sint_mul_adder_19_io_b <= reg_0_d_multiplication_45_sint_mul_adder_11_io_r;
    reg_next_0_d_multiplication_45_sint_mul_adder_12_io_r <= multiplication_45_sint_mul_adder_12_io_r;
    multiplication_45_sint_mul_adder_20_io_a <= reg_0_d_multiplication_45_sint_mul_adder_12_io_r;
    reg_next_0_d_multiplication_45_sint_mul_adder_13_io_r <= multiplication_45_sint_mul_adder_13_io_r;
    multiplication_45_sint_mul_adder_20_io_b <= reg_0_d_multiplication_45_sint_mul_adder_13_io_r;
    multiplication_45_sint_mul_adder_21_io_a <= multiplication_45_sint_mul_adder_14_io_r;
    multiplication_45_sint_mul_adder_21_io_b <= multiplication_45_sint_mul_adder_15_io_r;
    reg_next_0_d_multiplication_45_sint_mul_adder_16_io_r <= multiplication_45_sint_mul_adder_16_io_r;
    multiplication_45_sint_mul_adder_22_io_a <= reg_0_d_multiplication_45_sint_mul_adder_16_io_r;
    reg_next_0_d_multiplication_45_sint_mul_adder_17_io_r <= multiplication_45_sint_mul_adder_17_io_r;
    multiplication_45_sint_mul_adder_22_io_b <= reg_0_d_multiplication_45_sint_mul_adder_17_io_r;
    reg_next_0_d_multiplication_45_sint_mul_adder_18_io_r <= multiplication_45_sint_mul_adder_18_io_r;
    multiplication_45_sint_mul_adder_23_io_a <= reg_0_d_multiplication_45_sint_mul_adder_18_io_r;
    reg_next_0_d_multiplication_45_sint_mul_adder_19_io_r <= multiplication_45_sint_mul_adder_19_io_r;
    multiplication_45_sint_mul_adder_23_io_b <= reg_0_d_multiplication_45_sint_mul_adder_19_io_r;
    reg_next_1_d_multiplication_45_sint_mul_adder_20_io_r <= reg_0_d_multiplication_45_sint_mul_adder_20_io_r;
    reg_next_0_d_multiplication_45_sint_mul_adder_20_io_r <= multiplication_45_sint_mul_adder_20_io_r;
    multiplication_45_sint_mul_adder_25_io_b <= reg_1_d_multiplication_45_sint_mul_adder_20_io_r;
    reg_next_1_d_multiplication_45_sint_mul_adder_21_io_r <= reg_0_d_multiplication_45_sint_mul_adder_21_io_r;
    reg_next_2_d_multiplication_45_sint_mul_adder_21_io_r <= reg_1_d_multiplication_45_sint_mul_adder_21_io_r;
    reg_next_0_d_multiplication_45_sint_mul_adder_21_io_r <= multiplication_45_sint_mul_adder_21_io_r;
    multiplication_45_sint_mul_adder_24_io_a <= reg_2_d_multiplication_45_sint_mul_adder_21_io_r;
    reg_next_0_d_multiplication_45_sint_mul_adder_22_io_r <= multiplication_45_sint_mul_adder_22_io_r;
    multiplication_45_sint_mul_adder_24_io_b <= reg_0_d_multiplication_45_sint_mul_adder_22_io_r;
    reg_next_0_d_multiplication_45_sint_mul_adder_23_io_r <= multiplication_45_sint_mul_adder_23_io_r;
    multiplication_45_sint_mul_adder_25_io_a <= reg_0_d_multiplication_45_sint_mul_adder_23_io_r;
    reg_next_0_d_multiplication_45_sint_mul_adder_24_io_r <= multiplication_45_sint_mul_adder_24_io_r;
    multiplication_45_sint_mul_adder_26_io_a <= reg_0_d_multiplication_45_sint_mul_adder_24_io_r;
    reg_next_0_d_multiplication_45_sint_mul_adder_25_io_r <= multiplication_45_sint_mul_adder_25_io_r;
    multiplication_45_sint_mul_adder_26_io_b <= reg_0_d_multiplication_45_sint_mul_adder_25_io_r;
    reg_next_0_d_multiplication_45_sint_mul_adder_26_io_r <= multiplication_45_sint_mul_adder_26_io_r;
    multiplication_45_sint_mul_subtractor_io_a <= reg_0_d_multiplication_45_sint_mul_adder_26_io_r;
    multiplication_45_tc_io_i <= multiplication_45_sint_mul_subtractor_io_r;
    reg_next_1_d_multiplication_45_tc_io_o <= reg_0_d_multiplication_45_tc_io_o;
    reg_next_2_d_multiplication_45_tc_io_o <= reg_1_d_multiplication_45_tc_io_o;
    reg_next_3_d_multiplication_45_tc_io_o <= reg_2_d_multiplication_45_tc_io_o;
    reg_next_4_d_multiplication_45_tc_io_o <= reg_3_d_multiplication_45_tc_io_o;
    reg_next_5_d_multiplication_45_tc_io_o <= reg_4_d_multiplication_45_tc_io_o;
    reg_next_0_d_multiplication_45_tc_io_o <= multiplication_45_tc_io_o;
    addition_46_io_b <= reg_5_d_multiplication_45_tc_io_o;
    arith_shifter_47_io_i <= addition_46_io_r;
    arith_shifter_51_io_i <= addition_46_io_r;
    reg_next_0_d_arith_shifter_47_io_o <= arith_shifter_47_io_o;
    subtraction_48_io_b <= reg_0_d_arith_shifter_47_io_o;
    reg_next_0_d_subtraction_48_io_r <= subtraction_48_io_r;
    clamp01_49_io_i <= reg_0_d_subtraction_48_io_r;
    to8bit_cvt_49_io_i_clamped <= clamp01_49_io_o;
    color_24bit_cvt_io_r <= to8bit_cvt_49_io_o;
    reg_next_0_d_arith_shifter_51_io_o <= arith_shifter_51_io_o;
    subtraction_52_io_b <= reg_0_d_arith_shifter_51_io_o;
    reg_next_0_d_subtraction_52_io_r <= subtraction_52_io_r;
    clamp01_53_io_i <= reg_0_d_subtraction_52_io_r;
    to8bit_cvt_53_io_i_clamped <= clamp01_53_io_o;
    color_24bit_cvt_io_g <= to8bit_cvt_53_io_o;
    to8bit_cvt_55_io_i_clamped <= clamp01_55_io_o;
    reg_next_1_d_to8bit_cvt_55_io_o <= reg_0_d_to8bit_cvt_55_io_o;
    reg_next_2_d_to8bit_cvt_55_io_o <= reg_1_d_to8bit_cvt_55_io_o;
    reg_next_3_d_to8bit_cvt_55_io_o <= reg_2_d_to8bit_cvt_55_io_o;
    reg_next_4_d_to8bit_cvt_55_io_o <= reg_3_d_to8bit_cvt_55_io_o;
    reg_next_5_d_to8bit_cvt_55_io_o <= reg_4_d_to8bit_cvt_55_io_o;
    reg_next_6_d_to8bit_cvt_55_io_o <= reg_5_d_to8bit_cvt_55_io_o;
    reg_next_7_d_to8bit_cvt_55_io_o <= reg_6_d_to8bit_cvt_55_io_o;
    reg_next_8_d_to8bit_cvt_55_io_o <= reg_7_d_to8bit_cvt_55_io_o;
    reg_next_9_d_to8bit_cvt_55_io_o <= reg_8_d_to8bit_cvt_55_io_o;
    reg_next_10_d_to8bit_cvt_55_io_o <= reg_9_d_to8bit_cvt_55_io_o;
    reg_next_11_d_to8bit_cvt_55_io_o <= reg_10_d_to8bit_cvt_55_io_o;
    reg_next_12_d_to8bit_cvt_55_io_o <= reg_11_d_to8bit_cvt_55_io_o;
    reg_next_13_d_to8bit_cvt_55_io_o <= reg_12_d_to8bit_cvt_55_io_o;
    reg_next_14_d_to8bit_cvt_55_io_o <= reg_13_d_to8bit_cvt_55_io_o;
    reg_next_15_d_to8bit_cvt_55_io_o <= reg_14_d_to8bit_cvt_55_io_o;
    reg_next_16_d_to8bit_cvt_55_io_o <= reg_15_d_to8bit_cvt_55_io_o;
    reg_next_17_d_to8bit_cvt_55_io_o <= reg_16_d_to8bit_cvt_55_io_o;
    reg_next_18_d_to8bit_cvt_55_io_o <= reg_17_d_to8bit_cvt_55_io_o;
    reg_next_19_d_to8bit_cvt_55_io_o <= reg_18_d_to8bit_cvt_55_io_o;
    reg_next_20_d_to8bit_cvt_55_io_o <= reg_19_d_to8bit_cvt_55_io_o;
    reg_next_21_d_to8bit_cvt_55_io_o <= reg_20_d_to8bit_cvt_55_io_o;
    reg_next_22_d_to8bit_cvt_55_io_o <= reg_21_d_to8bit_cvt_55_io_o;
    reg_next_0_d_to8bit_cvt_55_io_o <= to8bit_cvt_55_io_o;
    color_24bit_cvt_io_b <= reg_22_d_to8bit_cvt_55_io_o;
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
    reg_next_0_valid_chain <= in_valid;
    out_valid <= reg_23_valid_chain;
    in_ready_buffer <= (not reg_23_valid_chain) or out_ready;
    in_ready <= in_ready_buffer;
    in_ready_and_in_valid <= in_ready_buffer and in_valid;
end architecture;