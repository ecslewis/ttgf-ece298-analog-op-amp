v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -120 100 220 100 {lab=vout}
N 220 100 230 100 {lab=vout}
N 240 100 240 120 {lab=vout}
N 230 100 240 100 {lab=vout}
N -550 100 -420 100 {lab=vin_p}
N -610 100 -550 100 {lab=vin_p}
N -610 180 -610 200 {lab=vin_p}
N -120 80 -100 80 {lab=#net1}
N -100 -70 -100 70 {lab=#net1}
N -160 -170 -100 -170 {lab=#net1}
N -120 120 -110 120 {lab=0}
N -110 120 -110 140 {lab=0}
N -160 -170 -160 -150 {lab=#net1}
N -100 -170 -100 -70 {lab=#net1}
N -610 260 -610 270 {lab=0}
N -100 70 -100 80 {lab=#net1}
N -280 170 -40 170 {lab=vout}
N -40 100 -40 170 {lab=vout}
N -420 170 -340 170 {lab=vin_n}
N -610 120 -610 180 {lab=vin_p}
N -450 120 -420 120 {lab=vin_n}
N -430 170 -420 170 {lab=vin_n}
N -610 100 -610 120 {lab=vin_p}
N -500 120 -450 120 {lab=vin_n}
N -500 120 -500 140 {lab=vin_n}
N -430 120 -430 170 {lab=vin_n}
N -450 -170 -160 -170 {lab=#net1}
N -450 -170 -450 -40 {lab=#net1}
N -450 20 -450 80 {lab=#net2}
N -450 80 -420 80 {lab=#net2}
C {capa.sym} 240 150 0 0 {name=C2
m=1
value=1p
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 240 180 0 0 {name=l5 lab=0}
C {code_shown.sym} 70 30 2 1 {name=s1 only_toplevel=false value="
* GF180MCU Global Process & Noise Parameters (Must be before .lib)
.param fnoicor = 0
.param sw_stat_global = 0
.param sw_stat_mismatch = 1

* PDK Model Include (MOSFETs)
.lib /foss/pdks/ciel/gf180mcu/versions/026824c7969ce6f4fc9678e6ca04b0a06a596c4b/gf180mcuD/libs.tech/ngspice/sm141064.ngspice typical

* MIM Capacitor Model (bypasses missing OSDI library)
.subckt cap_mim_2f0ff c0 c1 c_width=1e-6 c_length=1e-6
C_mim c0 c1 2.5p
.ends cap_mim_2f0ff

* Remove any .ac or .tran lines outside .control so they don't run prematurely
.save all

.control
destroy all

* ======================================================================
* 1. DC OPERATING POINT & TRANSISTOR SATURATION CHECK
* ======================================================================
op

let v_inp_dc   = v(vin_p)
let v_inn_dc   = v(vin_n)
let v_out_dc   = v(vout)
let v_diode_dc = v(x1.x2.net3)
let i_vdd_ua   = abs(v3#branch) * 1e6
let p_total_mw = i_vdd_ua * 3.3 / 1e3

echo ======================================================================
echo                    1. DC OPERATING VOLTAGES & POWER
echo ======================================================================
print v_inp_dc v_inn_dc v_out_dc v_diode_dc
print i_vdd_ua p_total_mw

* ======================================================================
* 2. AUTOMATED TRANSISTOR SATURATION CHECKER
* ======================================================================
* Calculates margin = abs(VDS) - abs(VDSAT). 
* Margin negative -> TRIODE / LINEAR (Failing)
* 0 to 50mV -> EDGE OF SATURATION (Warning)

let thr = 0.05

* --- Calculate Margins for Stage 1 (x1.x2) ---
let m_s1_xm1  = abs(@m.x1.x2.xm1.m0[vds])  - abs(@m.x1.x2.xm1.m0[vdsat])
let m_s1_xm2  = abs(@m.x1.x2.xm2.m0[vds])  - abs(@m.x1.x2.xm2.m0[vdsat])
let m_s1_xm3  = abs(@m.x1.x2.xm3.m0[vds])  - abs(@m.x1.x2.xm3.m0[vdsat])
let m_s1_xm4  = abs(@m.x1.x2.xm4.m0[vds])  - abs(@m.x1.x2.xm4.m0[vdsat])
let m_s1_xm5  = abs(@m.x1.x2.xm5.m0[vds])  - abs(@m.x1.x2.xm5.m0[vdsat])
let m_s1_xm7  = abs(@m.x1.x2.xm7.m0[vds])  - abs(@m.x1.x2.xm7.m0[vdsat])
let m_s1_xm8  = abs(@m.x1.x2.xm8.m0[vds])  - abs(@m.x1.x2.xm8.m0[vdsat])
let m_s1_xm9  = abs(@m.x1.x2.xm9.m0[vds])  - abs(@m.x1.x2.xm9.m0[vdsat])
let m_s1_xm10 = abs(@m.x1.x2.xm10.m0[vds]) - abs(@m.x1.x2.xm10.m0[vdsat])

* --- Calculate Margins for Bias Generator (x1.x1) ---
let m_bg_xm1  = abs(@m.x1.x1.xm1.m0[vds])  - abs(@m.x1.x1.xm1.m0[vdsat])
let m_bg_xm3  = abs(@m.x1.x1.xm3.m0[vds])  - abs(@m.x1.x1.xm3.m0[vdsat])
let m_bg_xm4  = abs(@m.x1.x1.xm4.m0[vds])  - abs(@m.x1.x1.xm4.m0[vdsat])
let m_bg_xm5  = abs(@m.x1.x1.xm5.m0[vds])  - abs(@m.x1.x1.xm5.m0[vdsat])
let m_bg_xm6  = abs(@m.x1.x1.xm6.m0[vds])  - abs(@m.x1.x1.xm6.m0[vdsat])
let m_bg_xm7  = abs(@m.x1.x1.xm7.m0[vds])  - abs(@m.x1.x1.xm7.m0[vdsat])
let m_bg_xm8  = abs(@m.x1.x1.xm8.m0[vds])  - abs(@m.x1.x1.xm8.m0[vdsat])
let m_bg_xm9  = abs(@m.x1.x1.xm9.m0[vds])  - abs(@m.x1.x1.xm9.m0[vdsat])

echo ======================================================================
echo                  *** TRIODE WARNINGS - MARGIN NEGATIVE ***
echo ======================================================================
if m_s1_xm1 < 0
  echo Stage 1 XM1 NMOS Input Right     : $&m_s1_xm1 V
end
if m_s1_xm2 < 0
  echo Stage 1 XM2 PMOS Cascode Left    : $&m_s1_xm2 V
end
if m_s1_xm3 < 0
  echo Stage 1 XM3 NMOS Tail            : $&m_s1_xm3 V
end
if m_s1_xm4 < 0
  echo Stage 1 XM4 NMOS Cascode Right   : $&m_s1_xm4 V
end
if m_s1_xm5 < 0
  echo Stage 1 XM5 NMOS Cascode Left    : $&m_s1_xm5 V
end
if m_s1_xm7 < 0
  echo Stage 1 XM7 NMOS Input Left      : $&m_s1_xm7 V
end
if m_s1_xm8 < 0
  echo Stage 1 XM8 PMOS Cascode Right   : $&m_s1_xm8 V
end
if m_s1_xm9 < 0
  echo Stage 1 XM9 PMOS Mirror Left     : $&m_s1_xm9 V
end
if m_s1_xm10 < 0
  echo Stage 1 XM10 PMOS Mirror Right   : $&m_s1_xm10 V
end
if m_bg_xm1 < 0
  echo Bias XM1 NMOS Ref Diode          : $&m_bg_xm1 V
end
if m_bg_xm3 < 0
  echo Bias XM3 NMOS Mirror             : $&m_bg_xm3 V
end
if m_bg_xm4 < 0
  echo Bias XM4 PMOS Mirror             : $&m_bg_xm4 V
end
if m_bg_xm5 < 0
  echo Bias XM5 PMOS Mirror             : $&m_bg_xm5 V
end
if m_bg_xm6 < 0
  echo Bias XM6 NMOS Mirror             : $&m_bg_xm6 V
end
if m_bg_xm7 < 0
  echo Bias XM7 NMOS Mirror             : $&m_bg_xm7 V
end
if m_bg_xm8 < 0
  echo Bias XM8 NMOS Cascode Bias Gen   : $&m_bg_xm8 V
end
if m_bg_xm9 < 0
  echo Bias XM9 PMOS Cascode Bias Gen   : $&m_bg_xm9 V
end

echo .
echo ======================================================================
echo             *** EDGE OF SATURATION - MARGIN 0 TO 50mV ***
echo ======================================================================
if m_s1_xm1 > 0
  if m_s1_xm1 < thr
    echo Stage 1 XM1 NMOS Input Right     : $&m_s1_xm1 V
  end
end
if m_s1_xm2 > 0
  if m_s1_xm2 < thr
    echo Stage 1 XM2 PMOS Cascode Left    : $&m_s1_xm2 V
  end
end
if m_s1_xm3 > 0
  if m_s1_xm3 < thr
    echo Stage 1 XM3 NMOS Tail            : $&m_s1_xm3 V
  end
end
if m_s1_xm4 > 0
  if m_s1_xm4 < thr
    echo Stage 1 XM4 NMOS Cascode Right   : $&m_s1_xm4 V
  end
end
if m_s1_xm5 > 0
  if m_s1_xm5 < thr
    echo Stage 1 XM5 NMOS Cascode Left    : $&m_s1_xm5 V
  end
end
if m_s1_xm7 > 0
  if m_s1_xm7 < thr
    echo Stage 1 XM7 NMOS Input Left      : $&m_s1_xm7 V
  end
end
if m_s1_xm8 > 0
  if m_s1_xm8 < thr
    echo Stage 1 XM8 PMOS Cascode Right   : $&m_s1_xm8 V
  end
end
if m_s1_xm9 > 0
  if m_s1_xm9 < thr
    echo Stage 1 XM9 PMOS Mirror Left     : $&m_s1_xm9 V
  end
end
if m_s1_xm10 > 0
  if m_s1_xm10 < thr
    echo Stage 1 XM10 PMOS Mirror Right   : $&m_s1_xm10 V
  end
end
if m_bg_xm1 > 0
  if m_bg_xm1 < thr
    echo Bias XM1 NMOS Ref Diode          : $&m_bg_xm1 V
  end
end
if m_bg_xm3 > 0
  if m_bg_xm3 < thr
    echo Bias XM3 NMOS Mirror             : $&m_bg_xm3 V
  end
end
if m_bg_xm4 > 0
  if m_bg_xm4 < thr
    echo Bias XM4 PMOS Mirror             : $&m_bg_xm4 V
  end
end
if m_bg_xm5 > 0
  if m_bg_xm5 < thr
    echo Bias XM5 PMOS Mirror             : $&m_bg_xm5 V
  end
end
if m_bg_xm6 > 0
  if m_bg_xm6 < thr
    echo Bias XM6 NMOS Mirror             : $&m_bg_xm6 V
  end
end
if m_bg_xm7 > 0
  if m_bg_xm7 < thr
    echo Bias XM7 NMOS Mirror             : $&m_bg_xm7 V
  end
end
if m_bg_xm8 > 0
  if m_bg_xm8 < thr
    echo Bias XM8 NMOS Cascode Bias Gen   : $&m_bg_xm8 V
  end
end
if m_bg_xm9 > 0
  if m_bg_xm9 < thr
    echo Bias XM9 PMOS Cascode Bias Gen   : $&m_bg_xm9 V
  end
end

* ======================================================================
* 3. AC FREQUENCY RESPONSE (OPEN-LOOP: L4=1e12, C1=1e12)
* ======================================================================
alter l4 = 1e12
alter c1 = 1e12
ac dec 35 1 5G

let v_out_ac  = v(vout)
let gain_db   = db(v_out_ac)
let phase_deg = cph(v_out_ac) * 180 / 3.1415926535

meas ac dc_gain find gain_db at=1
let g_3db = dc_gain - 3
meas ac f_3db when gain_db = g_3db
meas ac f_ugbw when gain_db = 0
meas ac ph_ugbw find phase_deg when gain_db = 0
let pm = 180 + ph_ugbw

echo ======================================================================
echo                    3. AC FREQUENCY RESPONSE RESULTS
echo ======================================================================
print dc_gain
print f_3db
print f_ugbw
print pm

* ======================================================================
* 4. TRANSIENT & SLEW RATE (CLOSED-LOOP UNITY-GAIN: L4=1p, C1=1f)
* ======================================================================
alter l4 = 1e-12
alter c1 = 1e-18
tran 0.1n 1000n

meas tran v_init find v(vout) at=9n
meas tran v_max MAX v(vout) from=10n to=100n
meas tran v_min MIN v(vout) from=100n to=200n

* 20% to 80% levels (1.21V to 1.24V) with from=10n to ignore startup settling
meas tran t_rise TRIG v(vout) VAL=1.21 RISE=1 TARG v(vout) VAL=1.24 RISE=1 from=10n
meas tran t_fall TRIG v(vout) VAL=1.24 FALL=1 TARG v(vout) VAL=1.21 FALL=1 from=50n

* Calculate Slew Rates
let sr_rise_v_us = (0.03 / t_rise) / 1e6
let sr_fall_v_us = (0.03 / t_fall) / 1e6

echo ======================================================================
echo                    4. TRANSIENT & SLEW RATE RESULTS
echo ======================================================================
print v_init v_max v_min
print t_rise sr_rise_v_us
print t_fall sr_fall_v_us
* ======================================================================
* 5. DC SWEEP (OUTPUT SWING & ICMR)
* ======================================================================
alter l4 = 1e-12
alter c1 = 1e-18
dc v1 0 3.3 1m

* Calculate Output Swing
let vout_deriv = deriv(v(vout))
meas dc swing_min find v(vout) when vout_deriv=0.9 cross=1
meas dc swing_max find v(vout) when vout_deriv=0.9 cross=last
let total_swing = swing_max - swing_min

* Calculate ICMR Margins using node voltages to bypass ngspice vector bugs
* VTH is approx 0.45V for the GF180 3.3V NMOS devices
let vds_tail_sweep = v(x1.x2.net6)
let vdsat_tail_sweep = v(x1.net1) - 0.45
let marg_tail_sweep = vds_tail_sweep - vdsat_tail_sweep

let vds_in_sweep = v(x1.x2.net4) - v(x1.x2.net6)
let vgs_in_sweep = v(vin_n) - v(x1.x2.net6)
let vdsat_in_sweep = vgs_in_sweep - 0.45
let marg_in_sweep = vds_in_sweep - vdsat_in_sweep

echo ======================================================================
echo                    5. OUTPUT SWING RESULTS
echo ======================================================================
print swing_min swing_max total_swing

* ======================================================================
* 6. NOISE ANALYSIS
* ======================================================================
noise v(vout) v1 dec 35 1 5G

echo ======================================================================
echo                    6. NOISE ANALYSIS RESULTS
echo ======================================================================
print inoise_total onoise_total

* ======================================================================
* 7. PLOTS
* ======================================================================
setplot ac1
plot db(v(vout)) title 'Open-Loop Gain (dB)'
plot (cph(v(vout))*180/3.14159265) title 'Open-Loop Phase (Deg)'

setplot tran1
plot v(vout) v(vin_p) title 'Closed-Loop Transient Step Response'

setplot dc1
plot v(vout) v(vin_p) title 'DC Transfer Characteristic (Output Swing)'
*plot marg_tail_sweep marg_in_sweep title 'ICMR: Saturation Margins (>0 is good)'

*setplot noise1
*plot inoise_spectrum title 'Input-Referred Noise Spectrum (V/rtHz)'

.endc
"}
C {vsource.sym} -160 -120 0 0 {name=V3 value=3.3 savecurrent=false}
C {gnd.sym} -160 -90 0 0 {name=l1 lab=0}
C {gnd.sym} -110 140 0 0 {name=l3 lab=0}
C {lab_pin.sym} -610 100 0 0 {name=p1 sig_type=std_logic lab=vin_p}
C {lab_pin.sym} -450 120 3 0 {name=p2 sig_type=std_logic lab=vin_n}
C {lab_pin.sym} -40 100 3 1 {name=p4 sig_type=std_logic lab=vout}
C {vsource.sym} -610 230 0 0 {name=V1 value="dc 1.2 ac 1 PULSE(1.20 1.25 10n 1n 1n 90n 200n)" savecurrent=false}
C {gnd.sym} -610 270 0 0 {name=l2 lab=0}
C {ind.sym} -310 170 1 0 {name=L4
m=1
value=1T
footprint=1206
device=inductor}
C {capa.sym} -500 170 0 0 {name=C1
m=1
value=1e12
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} -500 200 0 0 {name=l6 lab=0}
C {ttgf-ece298-analog-op-amp/xschem/amp_single_stage.sym} -270 100 0 0 {name=x1}
C {isource.sym} -450 -10 0 0 {name=I0 value=30u}
