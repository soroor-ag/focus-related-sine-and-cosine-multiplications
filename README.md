# focus-related-sine-and-cosine-multiplications
VHDL code for a digital block that computes focus-related sine and cosine multiplications, for beamforming or phased-array signal processing (used in ultrasound imaging, radar, or similar systems).
# x_focusal - Focus Angle Computation in VHDL

This project implements a **sine/cosine-based focusing module** in VHDL, 
designed for **beamforming applications** (e.g., ultrasound, radar, or phased arrays).  
It computes **radial focus coordinates** by multiplying sine/cosine values 
with a given focus coefficient.

## 📌 Features
- Uses ROM-based lookup tables for sine and cosine waveforms.
- Fixed-point arithmetic (17-bit LUT values, 20-bit radial focus).
- Computes:
  - `X_focus = sin(angle) × Radial_focus`
  - `Z_focus = cos(angle) × Radial_focus`
- Clock-synchronous design.

## 📂 File Structure
- `x_focusal.vhd` → Top-level module.
- `rom_1014.vhd` → Sine lookup table (ROM).
- `rom_1018.vhd` → Cosine lookup table (ROM).

## 🛠️ Inputs & Outputs

### Inputs
- `i_clk` : System clock.
- `i_Radial_focus (20-bit)` : Radial focus coefficient.
- `i_Res_coeff (3-bit)` : Resolution coefficient (step size).
- `i_k (7-bit)` : Index (beam/element).

### Outputs
- `o_X_focus1 (37-bit)` : Sine × Radial focus.
- `o_Z_focus1 (37-bit)` : Cosine × Radial focus.

## ⚙️ How It Works
1. The index `i_k` is scaled by `i_Res_coeff` to generate an address.
2. This address selects precomputed sine and cosine values from ROMs.
3. The selected sine/cosine values are multiplied by `i_Radial_focus`.
4. Results are output as `o_X_focus1` and `o_Z_focus1`.

## 🚀 Applications
- Ultrasound imaging (dynamic focusing).
- Radar beamforming.
- Antenna array signal processing.
- Any system requiring real-time sine/cosine weighted computations.


- Date: **2021-02-06**
