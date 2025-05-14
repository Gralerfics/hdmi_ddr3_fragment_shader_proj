# hdmi_ddr3_fragment_shader_proj

A Vivado project for hardware shader tests with DDR3 double buffering (RGB565) and HDMI output. It is modified from MicroPhase A7Lite examples.

The HDL code in `<src>/new/shader` should be a pipelined shader circuit. Currently in it is an example automatically generated and pipelined by [NodalHDL](https://github.com/Gralerfics/nodalhdl). An GIF for the result:

![Pretty Hip](doc/pretty_hip_example.gif)

This pattern is from [Shadertoy](https://www.shadertoy.com/) named [Pretty Hip](https://www.shadertoy.com/view/XsBfRW), with some modifications.

Since the NodalHDL project is still being refined and operations such as square roots, floating point numbers, division, etc. are not yet implemented, the code in this example has been simplified a lot so fixed point numbers will be used, and there has been no divisions (or can be done by shifting). See Code 1.

NodalHDL **will** implement conversions directly from the Python syntax. **But** now it is necessary to use a middle layer representation to implement the above shader (Code 2).

After that, it can be automatically **pipelined** into `24` levels with estimated minimim clock period `2.488ns`.

**Code 1**

```glsl
void mainImage(out vec4 O, vec2 u) {
    // float rx = 1024.0; // iResolution.x;
    // float ry = 768.0; // iResolution.y;
    
    float ax = (1.0 / 512.0 + 1.0 / 128.0) * u.x - 5.0;
    float ay = (1.0 / 512.0 + 1.0 / 128.0) * u.y - 3.75;
    
    float ux = ax - ay + 5.0;
    float uy = ax + ay + 5.0;
    
    float fx = fract(ux);
    float fy = fract(uy);
    fx = min(fx, 1.0 - fx);
    fy = min(fy, 1.0 - fy);

    float vx = ceil(ux) - 5.5;
    float vy = ceil(uy) - 5.5;

    float vsqr = vx * vx + vy * vy;
    float vs = 1.0 + vsqr / 8.0;
    float ee = 2.0 * fract((iTime - vs * 0.5) / 4.0) - 1.0;
    float vv = fract(4.0 * min(fx, fy));

    float mux = ee < 0.0 ? vv : 1.0 - vv;
    float rampFactor = 0.95 * mux - ee * ee;
    float clampValue = (16.0 + 4.0) * rampFactor + 1.0;
    float mixFactor = clamp(clampValue, 0.0, 1.0) + vs * 0.1;
    
    O.r = 1.0 - mixFactor / 2.0;
    O.g = 1.0 - mixFactor / 4.0;
    O.b = 1.0;
    O.a = 1.0;
}
```

**Code 2**

```python
def Shader() -> Structure:
    s = Structure()

    UID = 0
    def builder(f):
        def _builder(*args, **kwargs):
            res = f(*args, **kwargs)
            nonlocal UID
            UID += 1
            return res
        return _builder

    @builder
    def TArithmeticShifter(i: Node, n: int): # n > 0: move left, else right
        # u = s.add_substructure(f"arith_shifter_{i.full_name}_{str(n).replace("-", "neg")}_{UID}", CustomVHDLOperator(
        u = s.add_substructure(f"arith_shifter_{UID}", CustomVHDLOperator(
            {"i": T},
            {"o": T},
            f"o <= std_logic_vector({"shift_left" if n >= 0 else "shift_right"}(signed(i), {abs(n)}));"
        ))
        s.connect(i, u.IO.i)
        return u.IO.o
    
    @builder
    def TFract(i: Node):
        # u = s.add_substructure(f"fract_{i.full_name}_{UID}", CustomVHDLOperator(
        u = s.add_substructure(f"fract_{UID}", CustomVHDLOperator(
            {"i": T},
            {"o": T},
            f"o <= (o'high downto {T.W_frac} => '0') & i({T.W_frac - 1} downto 0);"
        ))
        s.connect(i, u.IO.i)
        return u.IO.o
    
    @builder
    def TAddition(a: Node, b: Node):
        # u = s.add_substructure(f"addition_{a.full_name}_{b.full_name}_{UID}", Add(T, T))
        u = s.add_substructure(f"addition_{UID}", Add(T, T))
        s.connect(a, u.IO.a)
        s.connect(b, u.IO.b)
        return u.IO.r
    
    @builder
    def TSubtraction(a: Node, b: Node):
        # u = s.add_substructure(f"subtraction_{a.full_name}_{b.full_name}_{UID}", Subtract(T, T))
        u = s.add_substructure(f"subtraction_{UID}", Subtract(T, T))
        s.connect(a, u.IO.a)
        s.connect(b, u.IO.b)
        return u.IO.r
    
    @builder
    def TMultiplication(a: Node, b: Node):
        # u = s.add_substructure(f"multiplication_{a.full_name}_{b.full_name}_{UID}", Multiply(T, T))
        u = s.add_substructure(f"multiplication_{UID}", Multiply(T, T))
        s.connect(a, u.IO.a)
        s.connect(b, u.IO.b)
        return u.IO.r
    
    @builder
    def TMin(a: Node, b: Node):
        # u = s.add_substructure(f"min_{a.full_name}_{b.full_name}_{UID}", CustomVHDLOperator(
        u = s.add_substructure(f"min_{UID}", CustomVHDLOperator(
            {"a": T, "b": T},
            {"o": T},
            f"o <= a when signed(a) < signed(b) else b;"
        ))
        s.connect(a, u.IO.a)
        s.connect(b, u.IO.b)
        return u.IO.o
    
    @builder
    def TMinPositiveXAndOneMinusX(i: Node):
        # u = s.add_substructure(f"minx1mx_{i.full_name}_{UID}", CustomVHDLOperator(
        u = s.add_substructure(f"minx1mx_{UID}", CustomVHDLOperator(
            {"i": T},
            {"o": T},
            f"o <= i when unsigned(i) < to_unsigned({1 << (T.W_frac - 1)}, {T.W}) else std_logic_vector(to_unsigned({1 << T.W_frac}, {T.W}) - unsigned(i));"
        ))
        s.connect(i, u.IO.i)
        return u.IO.o
    
    @builder
    def TCeil(i: Node):
        # u = s.add_substructure(f"ceil_{i.full_name}_{UID}", CustomVHDLOperator(
        u = s.add_substructure(f"ceil_{UID}", CustomVHDLOperator(
            {"i": T},
            {"o": T},
            f"o({T.W_frac - 1} downto 0) <= (others => '0');\n" +
                f"plus_one <= std_logic_vector(unsigned(i) + to_unsigned({1 << T.W_frac}, {T.W}));" +
                f"o(o'high downto {T.W_frac}) <= i(i'high downto {T.W_frac}) when i({T.W_frac - 1} downto 0) = ({T.W_frac - 1} downto 0 => '0') else plus_one(o'high downto {T.W_frac});",
            f"signal plus_one: std_logic_vector({T.W} - 1 downto 0);"
        ))
        s.connect(i, u.IO.i)
        return u.IO.o
    
    @builder
    def TClampZeroToOne(i: Node): # notice that it should be [0.0, 1.0)
        # u = s.add_substructure(f"clamp01_{i.full_name}_{UID}", CustomVHDLOperator(
        u = s.add_substructure(f"clamp01_{UID}", CustomVHDLOperator(
            {"i": T},
            {"o": T},
            f"o <= (others => '0') when i(i'high) = '1' else\n" +
            f"     (i'high downto {T.W_frac} => '0', others => '1') when i(i'high downto {T.W_frac}) /= (i'high downto {T.W_frac} => '0') else\n" +
            f"     (i'high downto {T.W_frac} => '0') & i({T.W_frac - 1} downto 0);"
        ))
        s.connect(i, u.IO.i)
        return u.IO.o
    
    @builder
    def fragCoordValueConvertor(i: Node):
        u = s.add_substructure(f"fragcoord_value_convertor_{UID}", CustomVHDLOperator(
            {"i": UInt[12]},
            {"o": T},
            f"o({T.W_frac + 11} downto {T.W_frac}) <= i;\n" +
                f"o({T.W - 1} downto {T.W_frac + 12}) <= (others => '0');\n" +
                f"o({T.W_frac - 1} downto 0) <= (others => '0');"
        ))
        s.connect(i, u.IO.i)
        return u.IO.o
    
    @builder
    def iTimeConvertor(i: Node):
        u = s.add_substructure(f"itime_convertor_{UID}", CustomVHDLOperator(
            {"i": UInt[64]},
            {"o": T},
            f"o <= '0' & i({20 + T.W_int - 1} downto {20 - T.W_frac});" # TODO f"o <= '0' & i({min(20 + T.W_int - 2, 63)} downto {max(20 - T.W_frac, 0)});"
        ))
        s.connect(i, u.IO.i)
        return u.IO.o
    
    @builder
    def Tto8bitConvertor(i: Node):
        u = s.add_substructure(f"to8bit_cvt_{UID}", CustomVHDLOperator(
            {"i_clamped": T},
            {"o": Bits[8]},
            f"o <= i_clamped({T.W_frac - 1} downto {T.W_frac - 8});"
        ))
        s.connect(TClampZeroToOne(i), u.IO.i_clamped)
        return u.IO.o
    
    @builder
    def Concatenate888(r: Node, g: Node, b: Node):
        u = s.add_substructure("color_24bit_cvt", CustomVHDLOperator(
            {"r": Bits[8], "g": Bits[8], "b": Bits[8]},
            {"o": Bits[24]},
            "o <= r & g & b;"
        ))
        s.connect(r, u.IO.r)
        s.connect(g, u.IO.g)
        s.connect(b, u.IO.b)
        return u.IO.o
    
    # ports
    iTime_us = s.add_port("itime_us", Input[UInt[64]])
    fragCoord_12bit = s.add_port("frag", Bundle[{"x": Input[UInt[12]], "y": Input[UInt[12]]}])
    fragColor_24bit = s.add_port("frag_color", Output[Bits[24]])
    
    # iTime
    iTime_s = iTimeConvertor(iTime_us) # 2^{-20} = 1 / 1048576 (s) ~ 1 (us)
    
    # fragCoord
    fragCoord = StructuralNodes({
        "x": fragCoordValueConvertor(fragCoord_12bit.x),
        "y": fragCoordValueConvertor(fragCoord_12bit.y)
    })
    
    # constants
    constants = (0.1, 0.95, 1, 3.75, 5, 5.5, 384)
    consts = s.add_substructure("consts", Constants(**{f"c{str(c).replace(".", "_")}": T(c) for c in constants}))
    C = lambda c: consts.IO.access(f"c{str(c).replace(".", "_")}")
    
    # ax, ay
    ax = TSubtraction(
        TAddition(
            TArithmeticShifter(fragCoord.x, -9),
            TArithmeticShifter(fragCoord.x, -7)
        ),
        C(5)
    )
    ay = TSubtraction(
        TAddition(
            TArithmeticShifter(fragCoord.y, -9),
            TArithmeticShifter(fragCoord.y, -7)
        ),
        C(3.75)
    )
    
    # ux, uy
    ux = TAddition(TSubtraction(ax, ay), C(5))
    uy = TAddition(TAddition(ax, ay), C(5))
    
    # fx, fy
    fx = TMinPositiveXAndOneMinusX(TFract(ux))
    fy = TMinPositiveXAndOneMinusX(TFract(uy))
    
    # vx, vy
    vx = TSubtraction(TCeil(ux), C(5.5))
    vy = TSubtraction(TCeil(uy), C(5.5))
    
    # vsqr, s, e, v
    vsqr = TAddition(TMultiplication(vx, vx), TMultiplication(vy, vy))
    vs = TAddition(C(1), TArithmeticShifter(vsqr, -3))
    ee = TSubtraction(TArithmeticShifter(TFract(TArithmeticShifter(TSubtraction(iTime_s, TArithmeticShifter(vs, -1)), -2)), 1), C(1))
    vv = TFract(TArithmeticShifter(TMin(fx, fy), 2))
    
    # mux, rampFactor, clampValue, mixFactor
    mux_calc = s.add_substructure("mux_calc", CustomVHDLOperator(
        {"ee": T, "vv": T},
        {"o": T},
        f"o <= vv when ee(ee'high) = '1' else std_logic_vector(to_unsigned({1 << T.W_frac}, {T.W}) - unsigned(vv));"
    ))
    s.connect(ee, mux_calc.IO.ee)
    s.connect(vv, mux_calc.IO.vv)
    mux = mux_calc.IO.o
    rampFactor = TSubtraction(TMultiplication(C(0.95), mux), TMultiplication(ee, ee))
    clampValue = TAddition(
        TAddition(
            TArithmeticShifter(rampFactor, 4),
            TArithmeticShifter(rampFactor, 2)
        ),
        C(1)
    )
    mixFactor = TAddition(TClampZeroToOne(clampValue), TMultiplication(vs, C(0.1)))
    
    # r, g, b, a
    r = Tto8bitConvertor(TSubtraction(C(1), TArithmeticShifter(mixFactor, -1)))
    g = Tto8bitConvertor(TSubtraction(C(1), TArithmeticShifter(mixFactor, -2)))
    b = Tto8bitConvertor(consts.IO.c1)
    a = b
    
    # 24bit frag_color output
    s.connect(Concatenate888(r, g, b), fragColor_24bit)
    
    return s
```

