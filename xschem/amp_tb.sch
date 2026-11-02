v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 120 -0 140 -0 {lab=#net1}
N 140 -90 140 -0 {lab=#net1}
N -100 -90 140 -90 {lab=#net1}
N -100 -90 -100 -40 {lab=#net1}
N -100 -40 -70 -40 {lab=#net1}
N 40 -110 40 -50 {lab=#net2}
N 40 -110 300 -110 {lab=#net2}
N 300 -110 300 20 {lab=#net2}
N 300 80 300 100 {lab=0}
N 40 90 140 90 {lab=0}
N 40 90 40 110 {lab=0}
N 40 50 40 90 {lab=0}
N 140 60 140 90 {lab=0}
N -170 110 -170 120 {lab=0}
N -170 40 -170 50 {lab=#net3}
N -170 40 -70 40 {lab=#net3}
C {xschem/amp.sym} -30 0 0 0 {name=x1}
C {vsource.sym} 300 50 0 0 {name=V1 value=3.3 savecurrent=false}
C {vsource.sym} -170 80 0 0 {name=V2 value=1.65 savecurrent=false}
C {gnd.sym} 300 100 0 0 {name=l1 lab=0}
C {gnd.sym} 40 110 0 0 {name=l2 lab=0}
C {gnd.sym} -170 120 0 0 {name=l3 lab=0}
C {capa.sym} 140 30 0 0 {name=C1
m=1
value=10p
footprint=1206
device="ceramic capacitor"}
C {code_shown.sym} 390 -130 0 0 {name=s1 only_toplevel=false value="
.control
  op
  show all
  print all
.endc

.save all
"
}
C {code_shown.sym} 530 -130 0 0 {name=models only_toplevel=true value="
.param fnoicor=0
.param sw_stat_global=0
.param sw_stat_mismatch=0
.param mc_skew=0
.param res_mc_skew=0
.param cap_mc_skew=0

.lib /foss/pdks/ciel/gf180mcu/versions/026824c7969ce6f4fc9678e6ca04b0a06a596c4b/gf180mcuD/libs.tech/ngspice/sm141064.ngspice typical
.lib /foss/pdks/ciel/gf180mcu/versions/026824c7969ce6f4fc9678e6ca04b0a06a596c4b/gf180mcuD/libs.tech/ngspice/sm141064.ngspice res_typical
"
}
