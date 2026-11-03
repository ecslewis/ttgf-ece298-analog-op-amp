v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 650 -640 650 -610 {lab=VDD}
N 490 -600 490 -580 {lab=VDD}
N 490 -600 650 -600 {lab=VDD}
N 650 -610 650 -600 {lab=VDD}
N 490 -520 490 -250 {lab=vbias_mirror}
N 490 -190 490 -160 {lab=VSS}
N 490 -160 680 -160 {lab=VSS}
N 820 -130 820 -110 {lab=VSS}
N 530 -280 530 -220 {lab=vbias_mirror}
N 490 -280 530 -280 {lab=vbias_mirror}
N 630 -190 630 -160 {lab=VSS}
N 530 -220 580 -220 {lab=vbias_mirror}
N 580 -220 590 -220 {lab=vbias_mirror}
N 630 -600 630 -500 {lab=VDD}
N 590 -470 590 -420 {lab=#net1}
N 590 -420 630 -420 {lab=#net1}
N 630 -440 630 -420 {lab=#net1}
N 630 -420 630 -260 {lab=#net1}
N 630 -260 630 -250 {lab=#net1}
N 570 -280 570 -220 {lab=vbias_mirror}
N 570 -280 720 -280 {lab=vbias_mirror}
N 750 -280 750 -220 {lab=vbias_mirror}
N 680 -160 980 -160 {lab=VSS}
N 980 -190 980 -160 {lab=VSS}
N 820 -160 820 -130 {lab=VSS}
N 810 -190 810 -160 {lab=VSS}
N 650 -600 980 -600 {lab=VDD}
N 980 -600 980 -500 {lab=VDD}
N 810 -600 810 -500 {lab=VDD}
N 630 -420 750 -420 {lab=#net1}
N 750 -420 930 -420 {lab=#net1}
N 930 -470 930 -420 {lab=#net1}
N 930 -470 940 -470 {lab=#net1}
N 980 -440 980 -340 {lab=vbias_2}
N 980 -280 980 -250 {lab=#net2}
N 940 -260 940 -220 {lab=#net2}
N 940 -260 980 -260 {lab=#net2}
N 940 -360 940 -310 {lab=vbias_2}
N 940 -360 980 -360 {lab=vbias_2}
N 410 -220 490 -220 {lab=VSS}
N 410 -220 410 -160 {lab=VSS}
N 410 -160 490 -160 {lab=VSS}
N 630 -220 710 -220 {lab=VSS}
N 710 -220 710 -160 {lab=VSS}
N 720 -280 750 -280 {lab=vbias_mirror}
N 750 -220 770 -220 {lab=vbias_mirror}
N 810 -220 890 -220 {lab=VSS}
N 890 -220 890 -160 {lab=VSS}
N 980 -220 1070 -220 {lab=VSS}
N 1070 -220 1070 -160 {lab=VSS}
N 980 -160 1070 -160 {lab=VSS}
N 980 -310 1070 -310 {lab=VSS}
N 1070 -310 1070 -220 {lab=VSS}
N 980 -470 1050 -470 {lab=VDD}
N 1050 -510 1050 -470 {lab=VDD}
N 980 -510 1050 -510 {lab=VDD}
N 630 -470 700 -470 {lab=VDD}
N 700 -510 700 -470 {lab=VDD}
N 630 -510 700 -510 {lab=VDD}
N 1060 -410 1080 -410 {lab=vbias_1}
N 1080 -410 1080 -400 {lab=vbias_1}
N 1080 -400 1120 -400 {lab=vbias_1}
N 980 -400 1060 -400 {lab=vbias_2}
N 1060 -400 1060 -380 {lab=vbias_2}
N 1060 -380 1120 -380 {lab=vbias_2}
N 750 -380 750 -280 {lab=vbias_mirror}
N 750 -380 1030 -380 {lab=vbias_mirror}
N 1030 -380 1030 -360 {lab=vbias_mirror}
N 1030 -360 1120 -360 {lab=vbias_mirror}
N 810 -440 810 -350 {lab=VDD}
N 810 -290 810 -250 {lab=vbias_1}
N 770 -320 770 -270 {lab=vbias_1}
N 770 -270 810 -270 {lab=vbias_1}
N 770 -410 770 -320 {lab=vbias_1}
N 770 -410 1060 -410 {lab=vbias_1}
N 810 -500 810 -440 {lab=VDD}
N 810 -370 880 -370 {lab=VDD}
N 880 -370 880 -320 {lab=VDD}
N 810 -320 880 -320 {lab=VDD}
C {title.sym} 190 -50 0 0 {name=l1 author="Qasim Ebsim"}
C {iopin.sym} 650 -640 0 0 {name=p1 lab=VDD}
C {iopin.sym} 820 -110 0 0 {name=p2 lab=VSS}
C {gf180mcu_fd_pr/nfet_03v3.sym} 510 -220 0 1 {name=M1
L=1.4u
W=32u
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
C {gf180mcu_fd_pr/nfet_03v3.sym} 610 -220 0 0 {name=M3
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
C {symbols/pfet_03v3.sym} 610 -470 0 0 {name=M4
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
model=pfet_03v3
spiceprefix=X
}
C {symbols/pfet_03v3.sym} 960 -470 0 0 {name=M5
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
model=pfet_03v3
spiceprefix=X
}
C {gf180mcu_fd_pr/nfet_03v3.sym} 790 -220 0 0 {name=M6
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
C {gf180mcu_fd_pr/nfet_03v3.sym} 960 -220 0 0 {name=M7
L=1.4u
W=6u
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
C {gf180mcu_fd_pr/nfet_03v3.sym} 960 -310 0 0 {name=M8
L=1.4u
W=6u
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
C {opin.sym} 1120 -400 0 0 {name=p3 lab=vbias_1
}
C {opin.sym} 1120 -380 0 0 {name=p4 lab=vbias_2
}
C {opin.sym} 1120 -360 0 0 {name=p6 lab=vbias_mirror}
C {symbols/pfet_03v3.sym} 790 -320 0 0 {name=M9
L=1.4u
W=1u
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
C {isource.sym} 490 -550 0 0 {name=I0 value=30u}
