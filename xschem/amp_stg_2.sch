v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 620 -140 620 -100 {lab=VSS}
N 620 -590 620 -520 {lab=VDD}
N 620 -490 700 -490 {lab=VDD}
N 700 -530 700 -490 {lab=VDD}
N 620 -530 700 -530 {lab=VDD}
N 620 -130 710 -130 {lab=VSS}
N 710 -170 710 -130 {lab=VSS}
N 620 -170 710 -170 {lab=VSS}
N 540 -490 580 -490 {lab=vin}
N 560 -170 580 -170 {lab=vbias}
N 620 -410 740 -410 {lab=vout}
N 620 -620 620 -590 {lab=VDD}
N 620 -330 620 -200 {lab=vout}
N 620 -460 620 -330 {lab=vout}
N 560 -360 620 -360 {lab=vout}
N 490 -490 540 -490 {lab=vin}
N 500 -490 500 -480 {lab=vin}
N 500 -360 560 -360 {lab=vout}
C {title.sym} 160 -30 0 0 {name=l1 author="Qasim Ebsim"}
C {ipin.sym} 490 -490 0 0 {name=p3 lab=vin}
C {ipin.sym} 560 -170 0 0 {name=p8 lab=vbias}
C {gf180mcu_fd_pr/pfet_03v3.sym} 600 -490 0 0 {name=M1
L=0.5u
W=16u
nf=1
m=1
ad="'int((nf+1)/2) * W/nf * 0.18u'"
pd="'2*int((nf+1)/2) * (W/nf + 0.18u)'"
as="'int((nf+2)/2) * W/nf * 0.18u'"
ps="'2*int((nf+2)/2) * (W/nf + 0.18u)'"
nrd="'0.18u / W'" nrs="'0.18u / W'"
sa=0 sb=0 sd=0
model=pfet_03v3
spiceprefix=X
}
C {gf180mcu_fd_pr/nfet_03v3.sym} 600 -170 0 0 {name=M5
L=0.5u
W=8.0u
nf=1
m=1
ad="'int((nf+1)/2) * W/nf * 0.18u'"
pd="'2*int((nf+1)/2) * (W/nf + 0.18u)'"
as="'int((nf+2)/2) * W/nf * 0.18u'"
ps="'2*int((nf+2)/2) * (W/nf + 0.18u)'"
nrd="'0.18u / W'" nrs="'0.18u / W'"
sa=0 sb=0 sd=0
model=nfet_03v3
spiceprefix=X
}
C {iopin.sym} 620 -100 0 0 {name=p7 lab=VSS}
C {iopin.sym} 620 -620 0 0 {name=p10 lab=VDD}
C {opin.sym} 740 -410 0 0 {name=p11 lab=vout

}
C {capa.sym} 500 -450 0 0 {name=C2
m=1
value=3p
footprint=1206
device="ceramic capacitor"}
C {res.sym} 500 -390 0 0 {name=R2
value=4.7k
footprint=1206
device=resistor
m=1}
