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
.param sw_stat_mismatch = 10

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
destroy all

* ======================================================================
* 1. DC OPERATING POINT & POWER
* ======================================================================
op

let v_inp_dc   = v(vin_p)
let v_inn_dc   = v(vin_n)
let v_out_dc   = v(vout)
let i_vdd_ua   = abs(v3#branch) * 1e6
let p_total_mw = i_vdd_ua * 3.3 / 1e3

echo ======================================================================
echo                    1. DC OPERATING VOLTAGES & POWER
echo ======================================================================
print v_inp_dc v_inn_dc v_out_dc
print i_vdd_ua p_total_mw

* ======================================================================
* 2. AUTOMATED TRANSISTOR SATURATION CHECKER
* ======================================================================
let thr = 0.05

* --- Calculate Margins (abs(VDS) - abs(VDSAT)) ---
let m_xm1  = abs(@m.x1.xm1.m0[vds])  - abs(@m.x1.xm1.m0[vdsat])
let m_xm2  = abs(@m.x1.xm2.m0[vds])  - abs(@m.x1.xm2.m0[vdsat])
let m_xm3  = abs(@m.x1.xm3.m0[vds])  - abs(@m.x1.xm3.m0[vdsat])
let m_xm4  = abs(@m.x1.xm4.m0[vds])  - abs(@m.x1.xm4.m0[vdsat])
let m_xm5  = abs(@m.x1.xm5.m0[vds])  - abs(@m.x1.xm5.m0[vdsat])
let m_xm6  = abs(@m.x1.xm6.m0[vds])  - abs(@m.x1.xm6.m0[vdsat])
let m_xm7  = abs(@m.x1.xm7.m0[vds])  - abs(@m.x1.xm7.m0[vdsat])

let m_xm10 = abs(@m.x1.xm10.m0[vds]) - abs(@m.x1.xm10.m0[vdsat])
let m_xm12 = abs(@m.x1.xm12.m0[vds]) - abs(@m.x1.xm12.m0[vdsat])
let m_xm13 = abs(@m.x1.xm13.m0[vds]) - abs(@m.x1.xm13.m0[vdsat])
let m_xm14 = abs(@m.x1.xm14.m0[vds]) - abs(@m.x1.xm14.m0[vdsat])
let m_xm15 = abs(@m.x1.xm15.m0[vds]) - abs(@m.x1.xm15.m0[vdsat])
let m_xm16 = abs(@m.x1.xm16.m0[vds]) - abs(@m.x1.xm16.m0[vdsat])
let m_xm18 = abs(@m.x1.xm18.m0[vds]) - abs(@m.x1.xm18.m0[vdsat])
let m_xm19 = abs(@m.x1.xm19.m0[vds]) - abs(@m.x1.xm19.m0[vdsat])
let m_xm20 = abs(@m.x1.xm20.m0[vds]) - abs(@m.x1.xm20.m0[vdsat])
let m_xm21 = abs(@m.x1.xm21.m0[vds]) - abs(@m.x1.xm21.m0[vdsat])
let m_xm22 = abs(@m.x1.xm22.m0[vds]) - abs(@m.x1.xm22.m0[vdsat])

echo ======================================================================
echo                  *** TRIODE WARNINGS - MARGIN NEGATIVE ***
echo ======================================================================
if m_xm1 < 0
  echo Bias XM1 PMOS          : $&m_xm1 V
end
if m_xm2 < 0
  echo Bias XM2 PMOS          : $&m_xm2 V
end
if m_xm3 < 0
  echo Bias XM3 PMOS          : $&m_xm3 V
end
if m_xm4 < 0
  echo Bias XM4 NMOS          : $&m_xm4 V
end
if m_xm5 < 0
  echo Bias XM5 NMOS          : $&m_xm5 V
end
if m_xm6 < 0
  echo Bias XM6 NMOS          : $&m_xm6 V
end
if m_xm7 < 0
  echo Bias XM7 NMOS          : $&m_xm7 V
end
if m_xm10 < 0
  echo Amp XM10 PMOS Tail     : $&m_xm10 V
end
if m_xm12 < 0
  echo Amp XM12 PMOS Input L  : $&m_xm12 V
end
if m_xm13 < 0
  echo Amp XM13 PMOS Input R  : $&m_xm13 V
end
if m_xm14 < 0
  echo Amp XM14 PMOS Source L : $&m_xm14 V
end
if m_xm15 < 0
  echo Amp XM15 PMOS Cascode L: $&m_xm15 V
end
if m_xm16 < 0
  echo Amp XM16 PMOS Source R : $&m_xm16 V
end
if m_xm18 < 0
  echo Amp XM18 PMOS Cascode R: $&m_xm18 V
end
if m_xm19 < 0
  echo Amp XM19 NMOS Cascode L: $&m_xm19 V
end
if m_xm20 < 0
  echo Amp XM20 NMOS Load L   : $&m_xm20 V
end
if m_xm21 < 0
  echo Amp XM21 NMOS Cascode R: $&m_xm21 V
end
if m_xm22 < 0
  echo Amp XM22 NMOS Load R   : $&m_xm22 V
end

echo .
echo ======================================================================
echo             *** EDGE OF SATURATION - MARGIN 0 TO 50mV ***
echo ======================================================================
if m_xm1 > 0
  if m_xm1 < thr
    echo Bias XM1 PMOS          : $&m_xm1 V
  end
end
if m_xm2 > 0
  if m_xm2 < thr
    echo Bias XM2 PMOS          : $&m_xm2 V
  end
end
if m_xm3 > 0
  if m_xm3 < thr
    echo Bias XM3 PMOS          : $&m_xm3 V
  end
end
if m_xm4 > 0
  if m_xm4 < thr
    echo Bias XM4 NMOS          : $&m_xm4 V
  end
end
if m_xm5 > 0
  if m_xm5 < thr
    echo Bias XM5 NMOS          : $&m_xm5 V
  end
end
if m_xm6 > 0
  if m_xm6 < thr
    echo Bias XM6 NMOS          : $&m_xm6 V
  end
end
if m_xm7 > 0
  if m_xm7 < thr
    echo Bias XM7 NMOS          : $&m_xm7 V
  end
end
if m_xm10 > 0
  if m_xm10 < thr
    echo Amp XM10 PMOS Tail     : $&m_xm10 V
  end
end
if m_xm12 > 0
  if m_xm12 < thr
    echo Amp XM12 PMOS Input L  : $&m_xm12 V
  end
end
if m_xm13 > 0
  if m_xm13 < thr
    echo Amp XM13 PMOS Input R  : $&m_xm13 V
  end
end
if m_xm14 > 0
  if m_xm14 < thr
    echo Amp XM14 PMOS Source L : $&m_xm14 V
  end
end
if m_xm15 > 0
  if m_xm15 < thr
    echo Amp XM15 PMOS Cascode L: $&m_xm15 V
  end
end
if m_xm16 > 0
  if m_xm16 < thr
    echo Amp XM16 PMOS Source R : $&m_xm16 V
  end
end
if m_xm18 > 0
  if m_xm18 < thr
    echo Amp XM18 PMOS Cascode R: $&m_xm18 V
  end
end
if m_xm19 > 0
  if m_xm19 < thr
    echo Amp XM19 NMOS Cascode L: $&m_xm19 V
  end
end
if m_xm20 > 0
  if m_xm20 < thr
    echo Amp XM20 NMOS Load L   : $&m_xm20 V
  end
end
if m_xm21 > 0
  if m_xm21 < thr
    echo Amp XM21 NMOS Cascode R: $&m_xm21 V
  end
end
if m_xm22 > 0
  if m_xm22 < thr
    echo Amp XM22 NMOS Load R   : $&m_xm22 V
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

meas tran t_rise TRIG v(vout) VAL=1.21 RISE=1 TARG v(vout) VAL=1.24 RISE=1 from=10n
meas tran t_fall TRIG v(vout) VAL=1.24 FALL=1 TARG v(vout) VAL=1.21 FALL=1 from=50n

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

* Explicitly save variables so the ICMR curves plot correctly during DC sweep
save all @m.x1.xm10.m0[vds] @m.x1.xm10.m0[vdsat] @m.x1.xm12.m0[vds] @m.x1.xm12.m0[vdsat]
dc v1 0 3.3 1m

let vout_deriv = deriv(v(vout))
meas dc swing_min find v(vout) when vout_deriv=0.9 cross=1
meas dc swing_max find v(vout) when vout_deriv=0.9 cross=last
let total_swing = swing_max - swing_min

* Calculate ICMR Margins for the PMOS Tail and PMOS Input Pair
let m_tail_sweep = abs(@m.x1.xm10.m0[vds]) - abs(@m.x1.xm10.m0[vdsat])
let m_in_sweep   = abs(@m.x1.xm12.m0[vds]) - abs(@m.x1.xm12.m0[vdsat])

echo ======================================================================
echo                    5. OUTPUT SWING RESULTS
echo ======================================================================
print swing_min swing_max total_swing

* ======================================================================
* 6. NOISE ANALYSIS
* ======================================================================
* Reset save behavior so noise spectrum saves correctly
save all
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
*plot m_tail_sweep m_in_sweep title 'ICMR: Saturation Margins (>0 is good)'

*setplot noise1
*plot inoise_spectrum title 'Input-Referred Noise Spectrum (V/rtHz)'

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
C {ttgf-ece298-analog-op-amp/xschem/gfmcu_example_amp.sym} 380 -160 0 0 {name=x1}
