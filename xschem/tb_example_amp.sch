v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 100 -180 230 -180 {lab=vin_p}
N 40 -180 100 -180 {lab=vin_p}
N 40 -100 40 -80 {lab=vin_p}
N 530 -180 550 -180 {lab=#net1}
N 550 -330 550 -190 {lab=#net1}
N 490 -430 550 -430 {lab=#net1}
N 530 -160 870 -160 {lab=vout}
N 530 -140 540 -140 {lab=0}
N 540 -140 540 -120 {lab=0}
N 490 -430 490 -410 {lab=#net1}
N 550 -430 550 -330 {lab=#net1}
N 870 -160 880 -160 {lab=vout}
N 890 -160 890 -140 {lab=vout}
N 880 -160 890 -160 {lab=vout}
N 40 -20 40 -10 {lab=0}
N 550 -190 550 -180 {lab=#net1}
N 370 -90 610 -90 {lab=vout}
N 610 -160 610 -90 {lab=vout}
N 230 -90 310 -90 {lab=vin_n}
N 40 -160 40 -100 {lab=vin_p}
N 200 -160 230 -160 {lab=vin_n}
N 200 -160 220 -160 {lab=vin_n}
N 220 -160 220 -90 {lab=vin_n}
N 220 -90 230 -90 {lab=vin_n}
N 40 -180 40 -160 {lab=vin_p}
N 150 -160 200 -160 {lab=vin_n}
N 150 -160 150 -140 {lab=vin_n}
C {vsource.sym} 490 -380 0 0 {name=V3 value=3.3 savecurrent=false}
C {gnd.sym} 490 -350 0 0 {name=l1 lab=0}
C {gnd.sym} 540 -120 0 0 {name=l3 lab=0}
C {lab_pin.sym} 40 -180 0 0 {name=p1 sig_type=std_logic lab=vin_p}
C {lab_pin.sym} 200 -160 3 0 {name=p2 sig_type=std_logic lab=vin_n}
C {lab_pin.sym} 610 -160 3 1 {name=p4 sig_type=std_logic lab=vout}
C {capa.sym} 890 -110 0 0 {name=C2
m=1
value=1p
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 890 -80 0 0 {name=l5 lab=0}
C {code_shown.sym} 720 -230 2 1 {name=s1 only_toplevel=false value="
* GF180MCU Global Process & Noise Parameters (Must be before .lib)
.param fnoicor = 0
.param sw_stat_global = 0
.param sw_stat_mismatch = 1

* PDK Model Include (MOSFETs)
.include /foss/pdks/ciel/gf180mcu/versions/026824c7969ce6f4fc9678e6ca04b0a06a596c4b/gf180mcuD/libs.tech/ngspice/design.ngspice
.lib /foss/pdks/ciel/gf180mcu/versions/026824c7969ce6f4fc9678e6ca04b0a06a596c4b/gf180mcuD/libs.tech/ngspice/sm141064.ngspice typical
.lib /foss/pdks/ciel/gf180mcu/versions/026824c7969ce6f4fc9678e6ca04b0a06a596c4b/gf180mcuD/libs.tech/ngspice/sm141064.ngspice res_typical

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

echo =========================================================
echo             2. TRANSISTOR SATURATION CHECK
echo =========================================================
echo   If Margin is POSITIVE (+) -> SATURATION (GOOD)
echo   If Margin is NEGATIVE (-) -> TRIODE/LINEAR (BAD - KILLS GAIN)
echo =========================================================

* NMOS Tail (XM3 in stg1)
let vds_tail   = abs(@m.x1.xm3.m0[vds])
let vdsat_tail = abs(@m.x1.xm3.m0[vdsat])
let marg_tail  = vds_tail - vdsat_tail

* NMOS Input (XM1 in stg1)
let vds_in     = abs(@m.x1.xm1.m0[vds])
let vdsat_in   = abs(@m.x1.xm1.m0[vdsat])
let marg_in    = vds_in - vdsat_in

* NMOS Cascode (XM4 in stg1)
let vds_casc   = abs(@m.x1.xm4.m0[vds])
let vdsat_casc = abs(@m.x1.xm4.m0[vdsat])
let marg_casc  = vds_casc - vdsat_casc

* PMOS Cascode (XM8 in stg1)
let vds_pcasc   = abs(@m.x1.xm8.m0[vds])
let vdsat_pcasc = abs(@m.x1.xm8.m0[vdsat])
let marg_pcasc  = vds_pcasc - vdsat_pcasc

* PMOS Mirror (XM10 in stg1)
let vds_pmir   = abs(@m.x1.xm10.m0[vds])
let vdsat_pmir = abs(@m.x1.xm10.m0[vdsat])
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
C {vsource.sym} 40 -50 0 0 {name=V1 value="dc 1.2 ac 1 PULSE(1.20 1.25 10n 1n 1n 90n 200n)" savecurrent=false}
C {gnd.sym} 40 -10 0 0 {name=l2 lab=0}
C {ind.sym} 340 -90 1 0 {name=L4
m=1
value=1T
footprint=1206
device=inductor}
C {capa.sym} 150 -110 0 0 {name=C1
m=1
value=1e12
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 150 -80 0 0 {name=l6 lab=0}
C {xschem/gfmcu_example_amp.sym} 380 -160 0 0 {name=x1}
