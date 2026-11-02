v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 200 -60 220 -60 {lab=VDD}
N 220 -160 220 -60 {lab=VDD}
N 220 -160 600 -160 {lab=VDD}
N 600 -160 600 -50 {lab=VDD}
N 590 -50 600 -50 {lab=VDD}
N 600 -160 990 -160 {lab=VDD}
N 200 0 240 0 {lab=#net1}
N 240 20 240 50 {lab=#net1}
N 260 -50 290 -50 {lab=#net2}
N 270 -30 290 -30 {lab=#net3}
N 200 -40 240 -40 {lab=#net2}
N 240 -50 260 -50 {lab=#net2}
N 250 -30 270 -30 {lab=#net3}
N 200 -20 250 -20 {lab=#net3}
N 260 -10 290 -10 {lab=vin_p}
N 260 -10 260 140 {lab=vin_p}
N 270 10 290 10 {lab=vin_n}
N 200 40 200 70 {lab=VSS}
N 200 70 600 70 {lab=VSS}
N 600 10 600 70 {lab=VSS}
N 980 10 990 10 {lab=VSS}
N 600 70 990 70 {lab=VSS}
N 990 10 990 70 {lab=VSS}
N 990 -160 990 -50 {lab=VDD}
N 270 10 270 140 {lab=vin_n}
N 980 -10 1010 -10 {lab=vout}
N 600 70 600 90 {lab=VSS}
N 600 -200 600 -160 {lab=VDD}
N 590 -10 600 -10 {lab=VSS}
N 600 -10 600 10 {lab=VSS}
N 240 50 290 50 {lab=#net1}
N 980 -30 990 -30 {lab=VDD}
N 990 -50 990 -30 {lab=VDD}
N 290 50 650 50 {lab=#net1}
N 650 -10 650 50 {lab=#net1}
N 650 -10 680 -10 {lab=#net1}
N 590 -30 660 -30 {lab=#net4}
N 660 -30 680 -30 {lab=#net4}
N 240 -50 240 -40 {lab=#net2}
N 250 -30 250 -20 {lab=#net3}
N 240 0 240 20 {lab=#net1}
N 200 20 200 40 {lab=VSS}
N 280 30 290 30 {lab=#net1}
N 280 30 280 50 {lab=#net1}
C {xschem/amp_stg_1.sym} 440 -10 0 0 {name=x2}
C {xschem/amp_stg_2.sym} 830 -10 0 0 {name=x3}
C {xschem/amp_bias.sym} 50 -20 0 0 {name=x1}
C {opin.sym} 1010 -10 0 0 {name=p1 lab=vout}
C {ipin.sym} 270 140 0 1 {name=p3 lab=vin_n}
C {ipin.sym} 260 140 0 0 {name=p4 lab=vin_p}
C {iopin.sym} 600 90 0 0 {name=p2 lab=VSS}
C {iopin.sym} 600 -200 0 0 {name=p6 lab=VDD}
