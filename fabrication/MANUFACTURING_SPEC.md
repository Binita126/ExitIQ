# ExitIQ — PCB Manufacturing & Fabrication Specification

**Document Version:** 1.0  
**Project:** ExitIQ — Edge AI Fire-Hazard-Aware Emergency Evacuation Guidance Terminal  
**ECAD Tool:** KiCad 10.0.6  
**Generated Date:** 2026-10-24  
**Design Directory:** `ExitIQ_GitHub_Release`  
**Target Substrate:** 2-Layer Rigid FR4 PCB  

---

## 1. Board Physical Specifications

| Parameter | Specification | Notes |
| :--- | :--- | :--- |
| **Board Dimensions** | $100.00\text{ mm} \times 80.00\text{ mm}$ ($3.937" \times 3.150"$) | Rectangular outline defined on `Edge.Cuts` |
| **Board Thickness** | $1.60\text{ mm} \pm 10\%$ | Standard FR4 core |
| **Layer Count** | 2 Copper Layers | Layer 1 (Top / F.Cu), Layer 2 (Bottom / B.Cu) |
| **Copper Weight** | $1.0\text{ oz}$ outer ($35\text{ µm}$ base foil) | Suitable for $2.5\text{ A}$ boost & $2.0\text{ A}$ LED rail |
| **Internal Cutouts / Slots** | 1× Slot: $1.00\text{ mm} \times 14.00\text{ mm}$ | Thermal isolation slot for SHT40 / SGP40 sensors |
| **Mounting Holes** | 4× $\varnothing 3.20\text{ mm}$ Non-Plated Through Holes (NPTH) | M3 screw clearance at $(5, 5)$, $(95, 5)$, $(95, 75)$, $(5, 75)\text{ mm}$ |
| **Solder Mask** | Liquid Photo-Imageable (LPI), Green | Both Front and Back |
| **Silkscreen** | High-Resolution White | Both Front and Back |
| **Surface Finish** | Lead-Free HASL or ENIG (Electroless Nickel Immersion Gold) | ENIG strongly recommended due to fine-pitch DFN/QFN pads |
| **Min Track Width / Space** | $0.20\text{ mm}$ ($7.87\text{ mil}$) / $0.20\text{ mm}$ ($7.87\text{ mil}$) | Power rails up to $1.20\text{ mm}$; localized $0.15\text{ mm}$ space on U3 |
| **Minimum Drill Size** | $0.30\text{ mm}$ ($11.8\text{ mil}$) | Via stitching and signal layer transitions |
| **Component Placement** | Single-Sided (Top Layer Only) | Bottom layer is dedicated solid GND ground plane |

---

## 2. Complete Fabrication Package Deliverables

### A. Gerber Files (`fabrication/gerbers/`)
All Gerber files are generated in Gerber RS-274X / X2 format with $2:6$ metric millimeter coordinate resolution:

| File Name | RS-274X Layer Name | Description | Size (Bytes) |
| :--- | :--- | :--- | :--- |
| [`ExitIQ-F_Cu.gtl`](gerbers/ExitIQ-F_Cu.gtl) | Front Copper (L1) | Top signal tracks, high-current power polygons, local GND pours | 47,631 |
| [`ExitIQ-B_Cu.gbl`](gerbers/ExitIQ-B_Cu.gbl) | Back Copper (L2) | Bottom solid continuous ground return plane & thermal polygon | 165,906 |
| [`ExitIQ-F_Mask.gts`](gerbers/ExitIQ-F_Mask.gts) | Front Solder Mask | Solder mask openings for SMD pads and THT component pins | 12,216 |
| [`ExitIQ-B_Mask.gbs`](gerbers/ExitIQ-B_Mask.gbs) | Back Solder Mask | Solder mask openings for THT solder joints and test pads | 3,578 |
| [`ExitIQ-F_Paste.gtp`](gerbers/ExitIQ-F_Paste.gtp) | Front Solder Paste | Solder paste stencil apertures for automated SMD paste printing | 10,029 |
| [`ExitIQ-B_Paste.gbp`](gerbers/ExitIQ-B_Paste.gbp) | Back Solder Paste | Bottom solder paste stencil (blank; no bottom SMD components) | 466 |
| [`ExitIQ-F_Silkscreen.gto`](gerbers/ExitIQ-F_Silkscreen.gto) | Front Silkscreen | Component designators, polarities, connector pinouts, safety text | 203,870 |
| [`ExitIQ-B_Silkscreen.gbo`](gerbers/ExitIQ-B_Silkscreen.gbo) | Back Silkscreen | Bottom markings, board identification, version and test markings | 3,590 |
| [`ExitIQ-Edge_Cuts.gm1`](gerbers/ExitIQ-Edge_Cuts.gm1) | Board Outline / Mechanical | $100\text{ mm} \times 80\text{ mm}$ board edge profile and internal thermal slot | 843 |
| [`ExitIQ-job.gbrjob`](gerbers/ExitIQ-job.gbrjob) | Gerber Job Spec | KiCad JSON metadata specifying layer stackup, thickness, dielectric | 2,797 |

### B. NC Drill Files (`fabrication/drill/`)
Exported in standard Excellon format with metric millimeter units and decimal coordinate formatting:

| File Name | Format | Plating Type | Hole Count | Description | Size (Bytes) |
| :--- | :--- | :--- | :--- | :--- | :--- |
| [`ExitIQ-PTH.drl`](drill/ExitIQ-PTH.drl) | Excellon | Plated (PTH) | 118 | Signal/GND vias, component leads, USB tabs | 2,435 |
| [`ExitIQ-NPTH.drl`](drill/ExitIQ-NPTH.drl) | Excellon | Non-Plated (NPTH) | 6 | 4× M3 mounting holes + 2× USB-C alignment pegs | 489 |
| [`ExitIQ-PTH-drl_map.pdf`](drill/ExitIQ-PTH-drl_map.pdf) | Vector PDF | Plated (PTH) | 118 | Plated through-hole drill location and tool symbol map | 19,133 |
| [`ExitIQ-NPTH-drl_map.pdf`](drill/ExitIQ-NPTH-drl_map.pdf) | Vector PDF | Non-Plated (NPTH) | 6 | Non-plated hole drill location and tool symbol map | 12,921 |
| [`ExitIQ_drill_report.rpt`](drill/ExitIQ_drill_report.rpt) | Text Report | Both | 124 | Tool summary and hit count breakdown | 846 |

### C. Assembly & Position Files (`fabrication/assembly/`)

| File Name | Format | Target | Description | Size (Bytes) |
| :--- | :--- | :--- | :--- | :--- |
| [`ExitIQ_all_pos.csv`](assembly/ExitIQ_all_pos.csv) | CSV (mm) | All Components (70) | Complete pick-and-place positions (Ref, Val, Package, X, Y, Rot, Side) | 5,528 |
| [`ExitIQ_smd_pos.csv`](assembly/ExitIQ_smd_pos.csv) | CSV (mm) | SMD Only (63) | Machine placement position list excluding THT through-hole headers | 4,770 |
| [`ExitIQ_top_pos.csv`](assembly/ExitIQ_top_pos.csv) | CSV (mm) | Top Layer (70) | Top side placement list (100% of components are top-mounted) | 5,528 |
| [`ExitIQ_all_pos.pos`](assembly/ExitIQ_all_pos.pos) | ASCII (mm) | All Components (70) | Standard IPC/KiCad ASCII format position file | 9,026 |
| [`ExitIQ_Assembly_BOM.csv`](assembly/ExitIQ_Assembly_BOM.csv) | CSV | All Components (70) | Cleaned, grouped assembly bill of materials (41 unique line items) | 2,252 |

### D. Production Archive
- [`fabrication/ExitIQ_Gerber_Drill_Package.zip`](ExitIQ_Gerber_Drill_Package.zip) ($114,932\text{ bytes}$)  
  Consolidated ZIP package containing all 9 Gerber files, 2 NC drill files, 2 drill map PDFs, and the drill hit report. Ready for direct upload to PCB fabrication portals (e.g. JLCPCB, PCBWay, OSH Park).

---

## 3. Drill Tool Breakdown & Statistics

| Tool ID | Diameter (mm) | Diameter (inch) | Type | Plating | Quantity | Functional Usage |
| :---: | :---: | :---: | :---: | :---: | :---: | :--- |
| **T1** | $0.300\text{ mm}$ | $0.0118"$ | Circular | PTH | 54 | Signal vias & GND stitched plane transitions |
| **T2** | $0.600\text{ mm}$ | $0.0236"$ | Slotted | PTH | 4 | USB Type-C receptacle (J1) structural shield anchor tabs |
| **T3** | $0.750\text{ mm}$ | $0.0295"$ | Circular | PTH | 2 | JST-PH 2-pin battery connector (J2 / P1) pins |
| **T4** | $0.800\text{ mm}$ | $0.0315"$ | Circular | PTH | 2 | Piezo buzzer (BZ1) through-hole pins |
| **T5** | $1.000\text{ mm}$ | $0.0394"$ | Circular | PTH | 56 | ESP32-S3 DevKit sockets (44), OLED (4), LED Ext (3), EXP (5) |
| **T1** | $0.650\text{ mm}$ | $0.0256"$ | Circular | NPTH | 2 | USB-C receptacle (J1) plastic locating/polarizing alignment pegs |
| **T2** | $3.200\text{ mm}$ | $0.1260"$ | Circular | NPTH | 4 | Corner M3 mounting screw clearance holes |

* **Total Plated Holes (PTH):** 118  
* **Total Non-Plated Holes (NPTH):** 6  
* **Grand Total Drill Hits:** 124  

---

## 4. DFM Review & Manufacturing Clearance Notes

> [!CAUTION]
> **Do not assume the board is fabrication-ready solely because file export succeeded.**  
> The PCB manufacturer and assembly house must review the following documented items during Design For Manufacturing (DFM) check before production release:

### 1. Texas Instruments TPS61023 (U3) Pad Clearance
* **Component:** U3 (TPS61023DRLR, $5\text{V}$ Synchronous Boost Converter)
* **Package:** SOT-563 (DRL-6), $0.50\text{ mm}$ lead pitch
* **Physical Pad Spacing:** $0.150\text{ mm}$ ($5.91\text{ mil}$) between adjacent pad edges (Pads 1-2, 2-3, 4-5, 5-6).
* **Fabrication Status:**
  - Standard capability for prototype PCB manufacturers (e.g. JLCPCB, PCBWay) supports down to $0.127\text{ mm}$ ($5.0\text{ mil}$) copper spacing.
  - Solder mask web / dam between SOT-563 pads requires high-resolution LPI solder mask ($0.10\text{ mm}$ dam capability) or gang-mask aperture relief.
  - Solder paste stencil aperture reduction of $10\text{–}15\%$ should be applied by the SMT stencil supplier to avoid solder bridging during reflow.

### 2. USB Type-C Connector (J1) Locating Peg Hole Clearance
* **Component:** J1 (GCT USB4105-xx-A 16-pin Top-Mount Receptacle)
* **Feature:** Two $\varnothing 0.65\text{ mm}$ non-plated locating peg holes.
* **Hole-to-Copper Clearance:** $0.1944\text{ mm}$ to adjacent outer ground corner pads (A1, A12, B1, B12).
* **Fabrication Status:**
  - Standard manufacturer design rules default to $0.200\text{ mm}$ clearance between unplated holes and adjacent copper.
  - The actual clearance of $0.1944\text{ mm}$ is within $5.6\text{ µm}$ ($0.22\text{ mil}$) of the $0.200\text{ mm}$ rule.
  - **Zero Shorting Risk:** Because these two holes are strictly non-plated (NPTH) and accommodate non-conductive plastic alignment pegs, there is zero risk of electrical shorting. Vendor DFM waiver is standard for this connector footprint.

### 3. Non-Fatal DRC Warnings (Cosmetic / Placement)
* **Total DRC Warnings Recorded:** 105 (0 electrical errors, 0 shorts, 0 unrouted nets).
* **Silkscreen / Solder Mask / Courtyard Warnings:** 89 items.
  - Includes silkscreen text clipped by solder mask apertures and overlapping component courtyards (e.g. ESP32 socket boundary proximity to adjacent bypass caps).
  - Normal for compact high-density prototype designs; does not affect electrical operation or assembly integrity.

---

## 5. Verification Sign-off

- [x] **Schematic ERC:** Verified via KiCad 10 (`kicad-cli sch erc`), **0 errors, 0 warnings**.
- [x] **PCB Net Routing:** Verified via KiCad 10 (`kicad-cli pcb drc`), **0 unconnected items across all 69 nets**.
- [x] **Short Circuit Check:** **0 shorting items** (`[shorting_items] = 0`).
- [x] **Track Crossing Check:** **0 track crossings** (`[tracks_crossing] = 0`).
- [x] **Mechanical Enclosure Compatibility:** Verified via CATIA V5-6R2022 COM automated clash check, **0 hard collisions**.
- [x] **Fabrication Package Completeness:** All 9 Gerbers, 2 drill files, 2 drill maps, and 5 assembly files verified non-empty.
