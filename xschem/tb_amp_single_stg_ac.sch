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
value=2p
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 240 180 0 0 {name=l5 lab=0}
C {code_shown.sym} 70 30 2 1 {name=s1 only_toplevel=false value="
* ======================================================================
* ADVANCED ANALOG OP-AMP TESTBENCH (GF180MCU)
* ======================================================================
* Process Corner Selection: typical, ff, ss, fs, sf
.param fnoicor = 0
.param sw_stat_global = 0
.param sw_stat_mismatch = 0

* PDK Model Include (MOSFETs)
.lib /foss/pdks/ciel/gf180mcu/versions/026824c7969ce6f4fc9678e6ca04b0a06a596c4b/gf180mcuD/libs.tech/ngspice/sm141064.ngspice typical

* MIM Capacitor Model (bypasses missing OSDI library)
.subckt cap_mim_2f0ff c0 c1 c_width=1e-6 c_length=1e-6
C_mim c0 c1 2.5p
.ends cap_mim_2f0ff

* Common-Mode AC Coupling Capacitor (1aF in diff mode, 1TF in CM mode)
C_cm vin_n vin_p 1e-18

* ======================================================================
* OPTIONAL: PEX EXTRACTION DUAL-DUT INSTANTIATION
* ======================================================================
* To compare ideal schematic vs layout extracted with Magic PEX:
* 1. Extract layout in Magic:
*    load tt_um_ece298_analog_op_amp; flatten tt_um_flat; load tt_um_flat
*    extract do local; extract all; ext2spice lvs; ext2spice cthresh 0.01; ext2spice -o /foss/designs/ttgf-ece298-analog-op-amp/mag/tt_um_flat_pex.spice
* 2. Uncomment the .include line below:
* .include /foss/designs/ttgf-ece298-analog-op-amp/mag/tt_um_flat_pex.spice
* 3. Uncomment the PEX instance and load cap below:
* XPEX 0 0 0 vin_p vin_n vout_pex net2 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 net1 tt_um_flat
* C2_pex vout_pex 0 2p

.save all

.control
destroy all
set color0=white
set color1=black
let pi = 3.141592653589793

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
echo                    1. DC OPERATING POINT & POWER
echo ======================================================================
print v_inp_dc v_inn_dc v_out_dc
print i_vdd_ua p_total_mw

* ======================================================================
* 2. DIFFERENTIAL AC (GAIN, GBW, PM)
* ======================================================================
alter l4 = 1e12
alter c1 = 1e12
alter c_cm = 1e-18
alter v1 acmag = 1.0
alter v3 acmag = 0.0

ac dec 35 1 5G

let v_out_dm  = v(vout)
let gain_adm  = db(v_out_dm)
let phase_adm = cph(v_out_dm) * 180 / pi

meas ac a0_dm find gain_adm at=1
let g3db = a0_dm - 3
meas ac f3db when gain_adm = g3db
meas ac gbw when gain_adm = 0
meas ac ph_gbw find phase_adm when gain_adm = 0
let pm = 180 + ph_gbw

echo ======================================================================
echo                    2. DIFFERENTIAL AC RESULTS
echo ======================================================================
print a0_dm f3db gbw pm

plot gain_adm title 'Open-Loop Gain (dB)'
plot phase_adm title 'Open-Loop Phase (Deg)'

* ======================================================================
* 3. CMRR (COMMON-MODE REJECTION RATIO)
* ======================================================================
* For Common-Mode AC: open C1 and short vin_n to vin_p via C_cm
alter c1 = 1e-18
alter c_cm = 1e12
alter v1 acmag = 1.0

ac dec 35 1 5G

let v_out_cm = v(vout)
let gain_acm = db(v_out_cm)
let cmrr_vec = ac1.gain_adm - gain_acm

meas ac a0_cm find gain_acm at=1
meas ac cmrr_dc find cmrr_vec at=1
meas ac cmrr_10k find cmrr_vec at=10k
meas ac cmrr_1m find cmrr_vec at=1meg

echo ======================================================================
echo                    3. CMRR RESULTS
echo ======================================================================
print a0_cm cmrr_dc cmrr_10k cmrr_1m

* ======================================================================
* 4. PSRR+ (POWER SUPPLY REJECTION RATIO)
* ======================================================================
* Restore differential configuration, inject 1V AC onto VDD (v3)
alter c1 = 1e12
alter c_cm = 1e-18
alter v1 acmag = 0.0
alter v3 acmag = 1.0

ac dec 35 1 5G

let gain_supply = db(v(vout))
let psrr_vec = ac1.gain_adm - gain_supply

meas ac psrr_dc find psrr_vec at=1
meas ac psrr_10k find psrr_vec at=10k
meas ac psrr_1m find psrr_vec at=1meg

echo ======================================================================
echo                    4. PSRR+ RESULTS
echo ======================================================================
print psrr_dc psrr_10k psrr_1m

alter v3 acmag = 0.0

plot ac2.cmrr_vec ac3.psrr_vec title 'CMRR and PSRR+ vs Frequency (dB)'

* ======================================================================
* 5. MULTI-LINE LOAD CAPACITANCE SWEEP (CL = 0.5p, 1p, 2p, 5p)
* ======================================================================
alter v1 acmag = 1.0

alter c2 = 0.5p
ac dec 35 1 5G
alter c2 = 1.0p
ac dec 35 1 5G
alter c2 = 2.0p
ac dec 35 1 5G
alter c2 = 5.0p
ac dec 35 1 5G
alter c2 = 2p

plot db(ac4.v(vout)) db(ac5.v(vout)) db(ac6.v(vout)) db(ac7.v(vout)) title 'Gain vs CL: 0.5p (ac4), 1p (ac5), 2p (ac6), 5p (ac7)'
plot (cph(ac4.v(vout))*180/pi) (cph(ac5.v(vout))*180/pi) (cph(ac6.v(vout))*180/pi) (cph(ac7.v(vout))*180/pi) title 'Phase vs CL: 0.5p, 1p, 2p, 5p'

* ======================================================================
* 6. MULTI-LINE BIAS CURRENT SWEEP (Iref = 20u, 25u, 30u, 35u)
* ======================================================================
alter i0 = 20u
ac dec 35 1 5G
alter i0 = 25u
ac dec 35 1 5G
alter i0 = 30u
ac dec 35 1 5G
alter i0 = 35u
ac dec 35 1 5G
alter i0 = 30u

plot db(ac8.v(vout)) db(ac9.v(vout)) db(ac10.v(vout)) db(ac11.v(vout)) title 'Gain vs Iref: 20u (ac8), 25u (ac9), 30u (ac10), 35u (ac11)'

* ======================================================================
* 7. TRANSIENT & SLEW RATE (CLOSED-LOOP UNITY-GAIN)
* ======================================================================
alter l4 = 1e-12
alter c1 = 1e-18
alter c_cm = 1e-18
alter v1 acmag = 0.0

tran 0.1n 1000n

meas tran t_rise TRIG v(vout) VAL=1.21 RISE=1 TARG v(vout) VAL=1.24 RISE=1 from=10n
meas tran t_fall TRIG v(vout) VAL=1.24 FALL=1 TARG v(vout) VAL=1.21 FALL=1 from=50n

let sr_rise_v_us = (0.03 / t_rise) / 1e6
let sr_fall_v_us = (0.03 / t_fall) / 1e6

echo ======================================================================
echo                    7. TRANSIENT & SLEW RATE RESULTS
echo ======================================================================
print sr_rise_v_us sr_fall_v_us

plot v(vout) v(vin_p) title 'Closed-Loop Transient Step Response'

* Ideal vs PEX Overlay (uncomment when PEX is enabled):
* plot db(ac1.v(vout)) db(ac1.v(vout_pex)) title 'Gain: Ideal vs PEX Extracted'

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
