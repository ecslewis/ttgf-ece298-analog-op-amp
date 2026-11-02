v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 510 -210 640 -210 {lab=vin_p}
N 450 -210 510 -210 {lab=vin_p}
N 450 -130 450 -110 {lab=vin_p}
N 940 -210 960 -210 {lab=#net1}
N 960 -360 960 -220 {lab=#net1}
N 900 -460 960 -460 {lab=#net1}
N 940 -190 1280 -190 {lab=vout}
N 940 -170 950 -170 {lab=0}
N 950 -170 950 -150 {lab=0}
N 900 -460 900 -440 {lab=#net1}
N 960 -460 960 -360 {lab=#net1}
N 1280 -190 1290 -190 {lab=vout}
N 1300 -190 1300 -170 {lab=vout}
N 1290 -190 1300 -190 {lab=vout}
N 450 -50 450 -40 {lab=0}
N 960 -220 960 -210 {lab=#net1}
N 780 -120 1020 -120 {lab=vout}
N 1020 -190 1020 -120 {lab=vout}
N 640 -120 720 -120 {lab=vin_n}
N 450 -190 450 -130 {lab=vin_p}
N 610 -190 640 -190 {lab=vin_n}
N 610 -190 630 -190 {lab=vin_n}
N 630 -190 630 -120 {lab=vin_n}
N 630 -120 640 -120 {lab=vin_n}
N 450 -210 450 -190 {lab=vin_p}
N 560 -190 610 -190 {lab=vin_n}
N 560 -190 560 -170 {lab=vin_n}
C {xschem/amp_multi_stg.sym} 790 -190 0 0 {name=x1 type=subcircuit}
C {vsource.sym} 900 -410 0 0 {name=V3 value=3.3 savecurrent=false}
C {gnd.sym} 900 -380 0 0 {name=l1 lab=0}
C {gnd.sym} 950 -150 0 0 {name=l3 lab=0}
C {lab_pin.sym} 450 -210 0 0 {name=p1 sig_type=std_logic lab=vin_p}
C {lab_pin.sym} 610 -190 3 0 {name=p2 sig_type=std_logic lab=vin_n}
C {lab_pin.sym} 1020 -190 3 1 {name=p4 sig_type=std_logic lab=vout}
C {capa.sym} 1300 -140 0 0 {name=C2
m=1
value=5p
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 1300 -110 0 0 {name=l5 lab=0}
C {code_shown.sym} 1130 -260 2 1 {name=s1 only_toplevel=false value="
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
* ======================================================================
* 1. DC OPERATING POINT & TRANSISTOR SATURATION CHECK
* ======================================================================
op

let v_inp_dc   = v(vin_p)
let v_inn_dc   = v(vin_n)
let v_out_dc   = v(vout)
let i_vdd_ua   = abs(v3#branch) * 1e6
let p_total_mw = i_vdd_ua * 3.3 / 1e3

echo ======================================================================
echo                   1. DC OPERATING VOLTAGES & POWER
echo ======================================================================
print v_inp_dc v_inn_dc v_out_dc
print i_vdd_ua p_total_mw

echo ======================================================================
echo                   2. TRANSISTOR SATURATION CHECK
echo ======================================================================
echo   If Margin is POSITIVE (+) -> SATURATION (GOOD)
echo   If Margin is NEGATIVE (-) -> TRIODE/LINEAR (BAD - KILLS GAIN)
echo ======================================================================

* NMOS Tail (XM3 in stg1)
let vds_tail   = abs(@m.x1.x2.xm3.m0[vds])
let vdsat_tail = abs(@m.x1.x2.xm3.m0[vdsat])
let marg_tail  = vds_tail - vdsat_tail

* NMOS Input (XM1 in stg1)
let vds_in     = abs(@m.x1.x2.xm1.m0[vds])
let vdsat_in   = abs(@m.x1.x2.xm1.m0[vdsat])
let marg_in    = vds_in - vdsat_in

* NMOS Cascode (XM4 in stg1)
let vds_casc   = abs(@m.x1.x2.xm4.m0[vds])
let vdsat_casc = abs(@m.x1.x2.xm4.m0[vdsat])
let marg_casc  = vds_casc - vdsat_casc

* PMOS Cascode (XM8 in stg1)
let vds_pcasc  = abs(@m.x1.x2.xm8.m0[vds])
let vdsat_pcasc= abs(@m.x1.x2.xm8.m0[vdsat])
let marg_pcasc = vds_pcasc - vdsat_pcasc

* PMOS Mirror (XM10 in stg1)
let vds_pmir   = abs(@m.x1.x2.xm10.m0[vds])
let vdsat_pmir = abs(@m.x1.x2.xm10.m0[vdsat])
let marg_pmir  = vds_pmir - vdsat_pmir

echo --- NMOS Tail (XM3) ---
print vds_tail vdsat_tail marg_tail
echo --- NMOS Input (XM1) ---
print vds_in vdsat_in marg_in
echo --- NMOS Cascode (XM4) ---
print vds_casc vdsat_casc marg_casc
echo --- PMOS Cascode (XM8) ---
print vds_pcasc vdsat_pcasc marg_pcasc
echo --- PMOS Mirror (XM10) ---
print vds_pmir vdsat_pmir marg_pmir
echo ======================================================================

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
echo                   3. AC FREQUENCY RESPONSE RESULTS
echo ======================================================================
print dc_gain
print f_3db
print f_ugbw
print pm
echo ======================================================================

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
echo                   4. TRANSIENT & SLEW RATE RESULTS
echo ======================================================================
print v_init v_max v_min
print t_rise sr_rise_v_us
print t_fall sr_fall_v_us
echo ======================================================================

* ======================================================================
* 5. PLOTS
* ======================================================================
setplot ac1
plot db(v(vout)) title 'Open-Loop Gain (dB)'
plot (cph(v(vout))*180/3.14159265) title 'Open-Loop Phase (Deg)'

setplot tran1
plot v(vout) v(vin_p) title 'Closed-Loop Transient Step Response'
.endc
"}
C {vsource.sym} 450 -80 0 0 {name=V1 value="dc 1.2 ac 1 PULSE(1.20 1.25 10n 1n 1n 90n 200n)" savecurrent=false}
C {gnd.sym} 450 -40 0 0 {name=l2 lab=0}
C {ind.sym} 750 -120 1 0 {name=L4
m=1
value=1T
footprint=1206
device=inductor}
C {capa.sym} 560 -140 0 0 {name=C1
m=1
value=1e12
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 560 -110 0 0 {name=l6 lab=0}
