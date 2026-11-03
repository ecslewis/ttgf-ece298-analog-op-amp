v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -210 -50 -190 -50 {lab=VDD}
N -190 -150 -190 -50 {lab=VDD}
N -190 -150 190 -150 {lab=VDD}
N 190 -150 190 -40 {lab=VDD}
N 180 -40 190 -40 {lab=VDD}
N -210 10 -170 10 {lab=#net1}
N -150 -40 -120 -40 {lab=#net2}
N -140 -20 -120 -20 {lab=#net3}
N -210 -30 -170 -30 {lab=#net2}
N -170 -40 -150 -40 {lab=#net2}
N -160 -20 -140 -20 {lab=#net3}
N -210 -10 -160 -10 {lab=#net3}
N -150 0 -120 0 {lab=vin_n}
N -150 0 -150 150 {lab=vin_n}
N -140 20 -120 20 {lab=vin_p}
N -210 50 -210 80 {lab=VSS}
N -210 80 190 80 {lab=VSS}
N 190 20 190 80 {lab=VSS}
N -140 20 -140 150 {lab=vin_p}
N 190 80 190 100 {lab=VSS}
N 190 -190 190 -150 {lab=VDD}
N 180 0 190 0 {lab=VSS}
N 190 0 190 20 {lab=VSS}
N 180 -20 250 -20 {lab=vout}
N 250 -20 270 -20 {lab=vout}
N -170 -40 -170 -30 {lab=#net2}
N -160 -20 -160 -10 {lab=#net3}
N -170 10 -170 30 {lab=#net1}
N -210 30 -210 50 {lab=VSS}
N -130 40 -120 40 {lab=#net1}
N -170 40 -130 40 {lab=#net1}
N -170 30 -170 40 {lab=#net1}
N 270 -20 330 -20 {lab=vout}
C {opin.sym} 330 -20 0 0 {name=p1 lab=vout}
C {ipin.sym} -150 150 0 0 {name=p3 lab=vin_n}
C {ipin.sym} -140 150 0 1 {name=p4 lab=vin_p}
C {iopin.sym} 190 100 0 0 {name=p2 lab=VSS}
C {iopin.sym} 190 -190 0 0 {name=p6 lab=VDD}
C {ttgf-ece298-analog-op-amp/xschem/amp_bias.sym} -360 -10 0 0 {name=x1}
C {ttgf-ece298-analog-op-amp/xschem/amp_stg_1.sym} 30 0 0 0 {name=x2}
