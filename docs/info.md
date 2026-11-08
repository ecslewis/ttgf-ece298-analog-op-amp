<!---
Tiny Tapeout Project Datasheet Documentation
Project: Telescopic Cascode Operational Amplifier
Target: GlobalFoundries 180nm CMOS (GF180MCU 3.3V)
Course: ECE298A
Authors: Ella Lewis, Qasim Ebsim
-->

## How it works

This project implements a high-gain, single-stage telescopic cascode operational amplifier with an integrated self-biased current generator, fabricated in the GlobalFoundries GF180MCU 3.3V CMOS process (`gf180mcuD`).

### Circuit Architecture

The amplifier consists of two coordinated sub-blocks:

1. **Amplifier Core (`amp_stg_1`)**:
   - **Input Differential Pair**: NMOS input transistors (`XM1`, `XM7`, $W/L = 32\mu\text{m} / 1.4\mu\text{m}$) operating with an input common-mode voltage centered around $1.2\text{ V}$.
   - **Telescopic Cascode Stage**: Both the NMOS signal path (`XM4`, `XM5`) and PMOS current-mirror active load (`XM2`, `XM8`) utilize cascode transistors ($L = 2.0\mu\text{m}$) to dramatically boost output resistance without requiring multiple gain stages:
     $$R_{out} \approx (g_{m,n\_casc} \cdot r_{o,n}^2) \parallel (g_{m,p\_casc} \cdot r_{o,p}^2)$$
   - **High DC Gain**: The cascode configuration yields an open-loop DC gain exceeding **$100\text{ dB}$** with a single dominant pole at the output node, ensuring inherent stability and large phase margin without complex Miller compensation capacitors.

2. **Bias Generation Network (`amp_bias`)**:
   - Accepts a single external $30\,\mu\text{A}$ reference current ($I_{ref}$) through `vbias_in` (`ua[3]`).
   - Generates the critical bias voltages required to keep all cascode transistors in the active saturation region:
     - `vbias_tail`: Sets the tail current source to mirror the $30\,\mu\text{A}$ bias.
     - `vbias_1` ($\approx 1.62\text{ V}$): Sets the gate bias for the PMOS cascode current mirrors.
     - `vbias_2` ($\approx 1.89\text{ V}$): Sets the gate bias for the NMOS cascode transistors.
   - Post-layout parasitic extraction (PEX) confirms robust startup dynamics with settling times under $20\text{ ns}$ and enhanced high-frequency power supply ripple suppression.

---

### Key Specifications (Simulated with Parasitic Extraction)

| Parameter | Value | Condition / Notes |
| :--- | :---: | :--- |
| **Technology** | GF180MCU 3.3V CMOS | 7-metal stack (`gf180mcuD`) |
| **Supply Voltage ($V_{DD}$)** | $3.3\text{ V}$ | Nominal operating supply |
| **Open-Loop DC Gain ($A_0$)** | **$101.9\text{ dB}$** | $V_{cm} = 1.2\text{ V}$, $C_L = 1\text{ pF}$ |
| **Unity-Gain Bandwidth ($f_u$)** | **$32.5\text{ MHz}$** | Load capacitance $C_L = 1\text{ pF}$ |
| **Phase Margin ($\text{PM}$)** | **$> 80^\circ$** | Inherent dominant pole stability |
| **Input Common-Mode Range** | $1.0\text{ V}$ to $1.5\text{ V}$ | Optimal nominal bias at $1.2\text{ V}$ |
| **Output Voltage Swing** | $0.8\text{ V}$ to $2.5\text{ V}$ | Telescopic cascode headroom |
| **Tail Current ($I_{tail}$)** | $30\,\mu\text{A}$ | Set by $30\,\mu\text{A}$ reference input |
| **Total Power Dissipation** | $\approx 250\,\mu\text{W}$ | Core amp + bias network |
| **Layout Footprint** | $1 \times 2\text{ Tile}$ | Standard Tiny Tapeout analog slot |

---

### Pinout Mapping

| Pin Name | Direction | Signal | Function |
| :--- | :---: | :---: | :--- |
| `ua[0]` | Input | `vin_p` | Non-inverting analog input ($V_{cm} \approx 1.2\text{ V}$) |
| `ua[1]` | Input | `vin_n` | Inverting analog input |
| `ua[2]` | Output | `vout` | Single-ended analog output |
| `ua[3]` | Input | `vbias_in` | Reference current input (sink/source $30\,\mu\text{A}$ nominal) |
| `VDPWR` | Power | `VDD` | $3.3\text{ V}$ Analog core power supply |
| `VGND` | Ground | `VSS` | $0\text{ V}$ Ground return |

*Note: Digital dedicated I/O pins (`ui_in`, `uo_out`, `uio`) are tied off internally to ground and can remain unconnected during analog operation.*

---

## How to test

### 1. Power Supply and Biasing Setup
1. Connect `VGND` (Pin ground) to clean bench ground ($0\text{ V}$).
2. Connect `VDPWR` to a low-noise $3.3\text{ V}$ regulated power supply.
3. Connect a precision current source providing $30\,\mu\text{A}$ into `ua[3]` (`vbias_in`), or connect a precision resistor ($R_{bias} \approx (3.3\text{V} - 0.78\text{V}) / 30\,\mu\text{A} \approx 84.5\text{ k}\Omega$) from `VDPWR` to `ua[3]`.

### 2. Unity-Gain Buffer Test (Functional Verification)
1. Configure the op-amp in unity-gain feedback by externally tying `ua[2]` (`vout`) directly to `ua[1]` (`vin_n`).
2. Apply a DC voltage to `ua[0]` (`vin_p`) using a precision voltage source.
3. Sweep `vin_p` from $1.0\text{ V}$ to $1.5\text{ V}$ in $50\text{ mV}$ steps:
   - Verify that $V_{out}$ linearly tracks $V_{in}$ with less than $5\text{ mV}$ offset error.
4. Apply a $100\text{ kHz}$ sinusoidal signal ($50\text{ mV}_{p-p}$ centered at $1.2\text{ V}$ DC) to `vin_p`:
   - Observe `vout` on an oscilloscope; verify clean, distortion-free unity-gain following.
5. Apply a $100\text{ kHz}$ square wave ($100\text{ mV}_{p-p}$, $10\text{ ns}$ edge rate) to test step response and verify that no ringing or overshoot occurs.

### 3. Open-Loop AC & Small-Signal Characterization
1. Build a closed-loop inverting or non-inverting amplifier configuration with external precision resistors (e.g. $R_1 = 10\text{ k}\Omega$, $R_2 = 100\text{ k}\Omega$ for closed-loop gain $A_v = 10$).
2. Connect a function generator to the input and a spectrum analyzer / high-impedance oscilloscope probe to `vout`.
3. Measure closed-loop frequency response to verify the $-3\text{ dB}$ cutoff frequency and compute the effective gain-bandwidth product ($f_u \approx 30\text{ MHz}$).

---

## External hardware

1. **Power Supply**: Low-noise $3.3\text{ V}$ DC bench power supply.
2. **Current Reference**: A Keithley / SMU precision DC current source set to $30\,\mu\text{A}$, or an external $84.5\text{ k}\Omega$ ($0.1\%$) metal film resistor tied to $V_{DD}$.
3. **Signal Generator**: Arbitrary waveform generator capable of producing signals with DC common-mode offsets ($1.2\text{ V}_{DC}$).
4. **Oscilloscope**: Two-channel oscilloscope ($> 100\text{ MHz}$ bandwidth) with $10\times$ high-impedance probes ($C_{probe} \le 10\text{ pF}$) to prevent excessive capacitive loading on `vout`.
5. **Breadboard / Custom PCB**: Standard Tiny Tapeout carrier breakout board with SMA or 0.1-inch header connections to `ua[0..3]`.
