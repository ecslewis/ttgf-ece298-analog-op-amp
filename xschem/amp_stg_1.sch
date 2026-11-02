v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 520 -570 520 -530 {lab=#net1}
N 690 -570 690 -530 {lab=#net2}
N 520 -470 520 -410 {lab=#net3}
N 690 -470 690 -410 {lab=vout}
N 690 -350 690 -310 {lab=#net4}
N 520 -350 520 -310 {lab=#net5}
N 520 -250 520 -220 {lab=#net6}
N 520 -220 600 -220 {lab=#net6}
N 600 -220 690 -220 {lab=#net6}
N 690 -250 690 -220 {lab=#net6}
N 600 -220 600 -210 {lab=#net6}
N 600 -150 600 -120 {lab=VSS}
N 520 -640 520 -630 {lab=VDD}
N 520 -640 690 -640 {lab=VDD}
N 690 -640 690 -630 {lab=VDD}
N 610 -710 610 -640 {lab=VDD}
N 730 -280 750 -280 {lab=vn}
N 450 -280 480 -280 {lab=vp}
N 560 -380 650 -380 {lab=vbias_2}
N 560 -500 650 -500 {lab=vbias_1}
N 600 -500 600 -430 {lab=vbias_1}
N 360 -430 600 -430 {lab=vbias_1}
N 610 -380 610 -330 {lab=vbias_2}
N 370 -330 610 -330 {lab=vbias_2}
N 370 -180 560 -180 {lab=vbias_tail}
N 690 -430 870 -430 {lab=vout}
N 690 -500 800 -500 {lab=VDD}
N 800 -600 800 -500 {lab=VDD}
N 690 -600 800 -600 {lab=VDD}
N 800 -640 800 -600 {lab=VDD}
N 690 -640 800 -640 {lab=VDD}
N 420 -640 520 -640 {lab=VDD}
N 420 -640 420 -500 {lab=VDD}
N 420 -500 520 -500 {lab=VDD}
N 420 -600 520 -600 {lab=VDD}
N 600 -180 690 -180 {lab=VSS}
N 690 -180 690 -140 {lab=VSS}
N 600 -140 690 -140 {lab=VSS}
N 670 -240 670 -180 {lab=VSS}
N 600 -240 670 -240 {lab=VSS}
N 600 -280 600 -240 {lab=VSS}
N 600 -280 690 -280 {lab=VSS}
N 520 -280 600 -280 {lab=VSS}
N 690 -380 800 -380 {lab=VSS}
N 800 -380 800 -180 {lab=VSS}
N 690 -180 800 -180 {lab=VSS}
N 390 -140 600 -140 {lab=VSS}
N 390 -380 390 -140 {lab=VSS}
N 390 -380 520 -380 {lab=VSS}
N 560 -600 580 -600 {lab=#net3}
N 630 -600 650 -600 {lab=#net3}
N 580 -600 630 -600 {lab=#net3}
N 580 -600 580 -550 {lab=#net3}
N 520 -450 580 -450 {lab=#net3}
N 580 -550 580 -450 {lab=#net3}
C {title.sym} 160 -30 0 0 {name=l1 author="Qasim Ebsim"}
C {gf180mcu_fd_pr/pfet_03v3.sym} 540 -500 0 1 {name=M2
L=1.4u
W=12u
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
C {iopin.sym} 610 -710 0 0 {name=p1 lab=VDD}
C {iopin.sym} 600 -120 0 0 {name=p2 lab=VSS}
C {ipin.sym} 750 -280 0 1 {name=p3 lab=vn}
C {ipin.sym} 450 -280 0 0 {name=p4 lab=vp}
C {opin.sym} 870 -430 0 0 {name=p6 lab=vout

}
C {gf180mcu_fd_pr/nfet_03v3.sym} 710 -280 0 1 {name=M1
L=0.5u
W=8u
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
C {gf180mcu_fd_pr/nfet_03v3.sym} 580 -180 0 0 {name=M3
L=1.4u
W=12u
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
C {gf180mcu_fd_pr/nfet_03v3.sym} 670 -380 0 0 {name=M4
L=1.4u
W=8u
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
C {gf180mcu_fd_pr/nfet_03v3.sym} 540 -380 0 1 {name=M5
L=1.4u
W=8u
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
C {gf180mcu_fd_pr/nfet_03v3.sym} 500 -280 0 0 {name=M7
L=0.5u
W=8u
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
C {gf180mcu_fd_pr/pfet_03v3.sym} 670 -500 0 0 {name=M8
L=1.4u
W=12u
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
C {gf180mcu_fd_pr/pfet_03v3.sym} 540 -600 0 1 {name=M9
L=1.4u
W=4u
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
C {gf180mcu_fd_pr/pfet_03v3.sym} 670 -600 0 0 {name=M10
L=1.4u
W=4u
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
C {ipin.sym} 370 -180 0 0 {name=p7 lab=vbias_tail}
C {ipin.sym} 370 -330 0 0 {name=p8 lab=vbias_2}
C {ipin.sym} 360 -430 0 0 {name=p9 lab=vbias_1
}
