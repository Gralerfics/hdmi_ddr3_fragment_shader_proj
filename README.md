# hdmi_ddr3_fragment_shader_proj

A Vivado project for hardware shader tests with DDR3 double buffering (RGB565) and HDMI output. It is modified from MicroPhase A7Lite examples.

The HDL code in `<src>/new/shader` should be a pipelined shader circuit. Currently in it is an example automatically generated and pipelined by [NodalHDL](https://github.com/Gralerfics/nodalhdl). An GIF for the result:

![Pretty Hip](doc/pretty_hip_example.gif)

This pattern is from [Shadertoy](https://www.shadertoy.com/) named [Pretty Hip](https://www.shadertoy.com/view/XsBfRW), with some modifications.

> Since the NodalHDL project is still being refined and operations such as square roots, floating point numbers, division, etc. are not yet implemented, the code in this example has been simplified a lot so fixed point numbers will be used, and there has been no divisions (or can be done by shifting) (see Code 1).

You can now ask NodalHDL to generate the HDL files with Python scripts as following (full in Code 2):

```python
def shader(iTime_us_u64: ComputeElement, fragCoord_u12: vec2) -> ComputeElement:
    iTime_us = sfixed(iTime_us_u64, T.W_int + 20, T.W_frac)
    iTime_s = sfixed(iTime_us >> 20, T.W_int, T.W_frac)
    
    fragCoord = vec2(sfixed(fragCoord_u12.x, T.W_int, T.W_frac), sfixed(fragCoord_u12.y, T.W_int, T.W_frac))
    
    a = vec2((fragCoord.x >> 9) + (fragCoord.x >> 7) - 5, (fragCoord.y >> 9) + (fragCoord.y >> 7) - 3.75)
    u = vec2(a.x - a.y + 5, a.x + a.y + 5)
    f = fract(u)
    f = min(f, 1 - f)
    v = ceil(u) - 5.5
    
    s = 1 + ((v.x * v.x + v.y * v.y) >> 3)
    e = (fract((iTime_s - (s >> 1)) >> 2) << 1) - 1
    t = fract(min(f.x, f.y) << 2)
    
    rampFactor = 0.95 * mux(e[e.type.W - 1], 1 - t, t) - e * e
    mixFactor = clamp((rampFactor << 4) + (rampFactor << 2) + 1, 0, 0.9999) + s * 0.1
    
    fragColor = clamp(vec4(1 - (mixFactor >> 1), 1 - (mixFactor >> 2), 0.9999, 0.9999), 0, 0.9999)
    return uint(fragColor.r << 8, 8) @ uint(fragColor.g << 8, 8) @ "11111111"
```

and the generated structure can be automatically **pipelined** into `26` levels with estimated minimim clock period `2.465ns`.

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
from nodalhdl.core.signal import *
from nodalhdl.core.structure import *
from nodalhdl.core.hdl import *
from nodalhdl.py.core import *
from nodalhdl.timing.sta import *
from nodalhdl.timing.pipelining import *


from nodalhdl.py.std import mux, sfixed, uint
from nodalhdl.py.glsl import vec2, vec4, fract, ceil, min, clamp


T = SFixedPoint[16, 12]

def shader(iTime_us_u64: ComputeElement, fragCoord_u12: vec2) -> ComputeElement:
    iTime_us = sfixed(iTime_us_u64, T.W_int + 20, T.W_frac)
    iTime_s = sfixed(iTime_us >> 20, T.W_int, T.W_frac)
    
    fragCoord = vec2(sfixed(fragCoord_u12.x, T.W_int, T.W_frac), sfixed(fragCoord_u12.y, T.W_int, T.W_frac))
    
    a = vec2((fragCoord.x >> 9) + (fragCoord.x >> 7) - 5, (fragCoord.y >> 9) + (fragCoord.y >> 7) - 3.75)
    u = vec2(a.x - a.y + 5, a.x + a.y + 5)
    f = fract(u)
    f = min(f, 1 - f)
    v = ceil(u) - 5.5
    
    s = 1 + ((v.x * v.x + v.y * v.y) >> 3)
    e = (fract((iTime_s - (s >> 1)) >> 2) << 1) - 1
    t = fract(min(f.x, f.y) << 2)
    
    rampFactor = 0.95 * mux(e[e.type.W - 1], 1 - t, t) - e * e
    mixFactor = clamp((rampFactor << 4) + (rampFactor << 2) + 1, 0, 0.9999) + s * 0.1
    
    fragColor = clamp(vec4(1 - (mixFactor >> 1), 1 - (mixFactor >> 2), 0.9999, 0.9999), 0, 0.9999)
    return uint(fragColor.r << 8, 8) @ uint(fragColor.g << 8, 8) @ "11111111"


s = Structure()
iTime_us = ComputeElement(s, "itime_us", UInt[64])
fragCoord = vec2(
    x = ComputeElement(s, "frag_x", UInt[12]),
    y = ComputeElement(s, "frag_y", UInt[12]),
)
shader(iTime_us, fragCoord).output("frag_color")


# expand
s.singletonize()
s.expand()
rid = RuntimeId.create()
s.deduction(rid)
print(s.runtime_info(rid))

# static timing analysis
sta = VivadoSTA(part_name = "xc7a200tfbg484-1", temporary_workspace_path = ".vivado_sta_shader", vivado_executable_path = "vivado.bat")
sta.analyse(s, rid, skip_emitting_and_script_running = False) # True to skip

# pipelining
levels, Phi_Gr = pipelining(s, rid, 26, model = "simple")
print("Phi_Gr ~", Phi_Gr)

# HDL generation
model = s.generation(rid, top_module_name = "shader")
insert_ready_valid_chain(model, levels)
emit_to_files(model.emit_vhdl(), "C:/Workspace/hdmi_ddr3_fragment_shader_proj/hdmi_ddr3_fragment_shader_proj.srcs/sources_1/new/shader")
```

