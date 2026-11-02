v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 120 -0 140 -0 {lab=OUT}
N -100 -40 -70 -40 {lab=#net1}
N 40 -110 40 -50 {lab=#net2}
N 40 -110 300 -110 {lab=#net2}
N 300 -110 300 20 {lab=#net2}
N 300 80 300 100 {lab=0}
N 40 90 140 90 {lab=0}
N 40 90 40 110 {lab=0}
N 40 50 40 90 {lab=0}
N -170 110 -170 130 {lab=0}
N -170 40 -170 50 {lab=#net3}
N -170 40 -70 40 {lab=#net3}
N 140 -0 210 0 {lab=OUT}
N 140 80 140 90 {lab=0}
N 140 -0 140 20 {lab=OUT}
N 210 -10 210 -0 {lab=OUT}
N 210 -140 210 -70 {lab=#net1}
N -100 -140 210 -140 {lab=#net1}
N -100 -140 -100 -40 {lab=#net1}
N -260 100 -260 110 {lab=0}
N -260 20 -260 40 {lab=#net1}
N -260 120 -170 120 {lab=0}
N -260 110 -260 120 {lab=0}
N -260 -40 -260 20 {lab=#net1}
N -260 -40 -100 -40 {lab=#net1}
C {xschem/amp.sym} -30 0 0 0 {name=x1}
C {vsource.sym} 300 50 0 0 {name=V1 value=3.3 savecurrent=false}
C {vsource.sym} -170 80 0 0 {name=V2 value="dc 1.65 ac 1" savecurrent=false}
C {gnd.sym} 300 100 0 0 {name=l1 lab=0}
C {gnd.sym} 40 110 0 0 {name=l2 lab=0}
C {gnd.sym} -170 130 0 0 {name=l3 lab=0}
C {capa.sym} 140 50 0 0 {name=C1
m=1
value=10pF
footprint=1206
device="ceramic capacitor"}
C {code_shown.sym} 360 -130 0 0 {name=models only_toplevel=true value="
.param fnoicor=0
.param sw_stat_global=0
.param sw_stat_mismatch=0
.param mc_skew=0
.param res_mc_skew=0
.param cap_mc_skew=0

.control
  ac dec 100 1 100MEG
  plot vdb(vout) xlimit 1 100MEG ylabel 'Gain (dB)'
  plot cph(vout)*180/pi xlimit 1 100MEG ylabel 'Phase (Degrees)'
.endc

.save all

.lib /foss/pdks/ciel/gf180mcu/versions/026824c7969ce6f4fc9678e6ca04b0a06a596c4b/gf180mcuD/libs.tech/ngspice/sm141064.ngspice typical
.lib /foss/pdks/ciel/gf180mcu/versions/026824c7969ce6f4fc9678e6ca04b0a06a596c4b/gf180mcuD/libs.tech/ngspice/sm141064.ngspice res_typical
"

}
C {ind.sym} 210 -40 0 0 {name=L4
m=1
value=1T
footprint=1206
device=inductor}
C {lab_pin.sym} 210 0 3 0 {name=p1 sig_type=std_logic lab=OUT}
C {capa.sym} -260 70 0 0 {name=C2
m=1
value=10pF
footprint=1206
device="ceramic capacitor"}
