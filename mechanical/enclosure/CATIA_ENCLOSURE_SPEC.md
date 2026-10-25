# ExitIQ Emergency Evacuation Guidance Terminal
## Mechanical Enclosure Design Specification & CATIA V5 Interface Guide

**Document Revision:** 1.0  
**Date:** October 2026  
**Status:** Approved for Mechanical CAD Modeling  
**Associated Files:**
- **3D Solid PCB Model:** `mechanical/step/ExitIQ.step` (AP214/AP242 STEP Solid Model)
- **2D Dimensioned CAD Vector:** `mechanical/cad/ExitIQ_BoardOutline_Mounting.dxf` (DXF R14 mm units)
- **ECAD Board File:** `hardware/pcb/ExitIQ.kicad_pcb`

---

## 1. PCB Geometry & Mechanical Datums

```
(0, 80) +---------------------------------------------------------------+ (100, 80)
        |  O [H4: 5, 75]            (Top View)             [H3: 95, 75] O |
        |                                                                 |
        |  [USB-C]                                            [J_EXP]     |
        |                                       [THERMAL      [OLED]      |
        |  [BATT]                                 SLOT]       [TEST_BTN]  |
        |                                                     [EXT_LED]   |
        |  [BQ24074]            [ESP32-S3 DEVKIT]                         |
        |                                                                 |
        |  [TPS61023]        LED1 LED2 LED3 LED4 LED5 LED6 LED7 LED8      |
        |  O [H1: 5, 5]                                      [H2: 95, 5] O|
  (0, 0)+---------------------------------------------------------------+ (100, 0)
```

| Parameter | Nominal 2D ECAD | 3D MCAD Datum (ISO 10303 / CATIA) | Notes |
| :--- | :--- | :--- | :--- |
| **Board Width ($X$)** | $100.00\text{ mm}$ | $X \in [0.00, 100.00]\text{ mm}$ | Primary datum along left edge ($X = 0$) |
| **Board Height ($Y$)** | $80.00\text{ mm}$ | $Y \in [-80.00, 0.00]\text{ mm}$ | Standard 3D right-handed Cartesian export ($Y_{3D} = -Y_{2D}$) |
| **PCB Thickness ($Z$)** | $1.60\text{ mm}$ | $Z \in [0.00, 1.60]\text{ mm}$ | Base seat at $Z = 0.00\text{ mm}$, top at $Z = +1.60\text{ mm}$ |
| **Mounting Hole H1** | $(5.00, 5.00)\text{ mm}$ | $(X = 5.00, Y = -5.00, Z = 0.00)\text{ mm}$ | $\varnothing 3.20\text{ mm}$ thru (M3 clearance, near USB-C) |
| **Mounting Hole H2** | $(95.00, 5.00)\text{ mm}$ | $(X = 95.00, Y = -5.00, Z = 0.00)\text{ mm}$ | $\varnothing 3.20\text{ mm}$ thru (M3 clearance, near Sensor Bay) |
| **Mounting Hole H3** | $(95.00, 75.00)\text{ mm}$ | $(X = 95.00, Y = -75.00, Z = 0.00)\text{ mm}$ | $\varnothing 3.20\text{ mm}$ thru (M3 clearance, near LED8) |
| **Mounting Hole H4** | $(5.00, 75.00)\text{ mm}$ | $(X = 5.00, Y = -75.00, Z = 0.00)\text{ mm}$ | $\varnothing 3.20\text{ mm}$ thru (M3 clearance, near LED1) |
| **Mounting Hole Keepout** | $\varnothing 6.00\text{ mm}$ | $\varnothing 6.00\text{ mm}$ concentric | Screw head & standoff boss diameter |
| **Thermal Isolation Slot** | $X = 72 - 73, Y = 14 - 28\text{ mm}$ | $X = 72 - 73, Y = -28 - -14\text{ mm}$ | $1.0\text{ mm}$ milled slot through FR4 |

---

## 2. Component Vertical Clearances & Enclosure Envelope

| Region / Component | PCB Side | Max Height ($Z$) | Recommended Clearance | Enclosure Allowance |
| :--- | :--- | :--- | :--- | :--- |
| **ESP32-S3-DevKitC-1 Socket Assembly** | Top | $12.50\text{ mm}$ | $+2.50\text{ mm}$ | Enclosure internal depth $\ge 15.00\text{ mm}$ above PCB |
| **C_LED_BULK (Radial Electrolytic Cap)** | Top | $11.50\text{ mm}$ | $+1.50\text{ mm}$ | Fits within standard $15.00\text{ mm}$ ceiling |
| **SW1 (Tactile Push Button)** | Top | $5.00\text{ mm}$ | Extends to bezel | Button actuator pin $\varnothing 3.5\text{ mm}$, hole $\varnothing 4.2\text{ mm}$ |
| **J_OLED (Mounted SSD1306 Panel)** | Top | $10.50\text{ mm}$ | Flush with bezel | Graphic window $26.0\text{ mm} \times 15.0\text{ mm}$ |
| **BZ1 (CMT-8540S Magnetic Buzzer)** | Top | $4.00\text{ mm}$ | $+1.0\text{ mm}$ to acoustic vent | Acoustic port $\varnothing 2.5 - 3.0\text{ mm}$ |
| **WS2812B LED Array** | Top | $1.65\text{ mm}$ | $+1.0\text{ mm}$ to lightguide | Spans $X = 39.0 - 92.0\text{ mm}, Y = 74.0\text{ mm}$ |
| **Bottom Side Solder Leads & Vias** | Bottom | $2.54\text{ mm}$ | $+1.50\text{ mm}$ to base | Enclosure standoff height $\ge 4.00\text{ mm}$ |

### Recommended External Enclosure Dimensions
- **Outer Dimensions:** $114.00\text{ mm} \times 94.00\text{ mm} \times 24.00\text{ mm}$ (assuming $2.0\text{ mm}$ nominal wall thickness).
- **Internal Cavity:** $104.00\text{ mm} \times 84.00\text{ mm} \times 20.00\text{ mm}$ ($2.0\text{ mm}$ perimeter expansion around $100 \times 80\text{ mm}$ PCB).
- **Mounting Bosses:** 4× cylindrical bosses with brass heat-set threaded inserts (M3 $\times 4.0\text{ mm}$) at $(5, 5)$, $(95, 5)$, $(95, 75)$, $(5, 75)\text{ mm}$, height $4.00\text{ mm}$.

---

## 3. Enclosure Wall Cutouts & Aperture Coordinates

All coordinates referenced from the PCB bottom-left corner $(0, 0)$:

### 1. Left Wall: USB Type-C Main Power Input
- **Center Location:** $X = 0.00\text{ mm}$ (outer edge), $Y = 15.00\text{ mm}$, $Z = +1.60\text{ mm}$ above PCB surface.
- **Aperture Size:** $9.60\text{ mm}$ wide $\times 3.60\text{ mm}$ high with $1.80\text{ mm}$ corner radii (standard USB-C receptacle clearance).

### 2. Left Wall: Battery Connector Service Hatch (Optional)
- **Center Location:** $X = 0.00\text{ mm}$, $Y = 32.00\text{ mm}$, $Z = +3.00\text{ mm}$ above PCB surface.
- **Aperture Size:** $8.50\text{ mm}$ wide $\times 7.00\text{ mm}$ high for JST-PH polarized 2-pin harness entry.

### 3. Front Face: SSD1306 0.96" OLED Display Bezel
- **Center Location:** $X = 94.00\text{ mm}$, $Y = 36.00\text{ mm}$.
- **Aperture Size:** $26.00\text{ mm} \times 15.00\text{ mm}$ rectangular window with internal retaining clips or double-sided adhesive rebate for acrylic protective lens.

### 4. Front Face: System Test / Evacuation Drill Push Button
- **Center Location:** $X = 86.00\text{ mm}$, $Y = 50.00\text{ mm}$.
- **Aperture Size:** $\varnothing 4.50\text{ mm}$ round hole with chamfer for an integrated silicone membrane or snap-in plastic plunger.

### 5. Front / Top Face: Acoustic Buzzer Sound Port
- **Center Location:** $X = 55.70\text{ mm}$, $Y = 14.00\text{ mm}$.
- **Aperture Size:** 3× $\varnothing 1.50\text{ mm}$ holes or a single $\varnothing 3.00\text{ mm}$ acoustic grille located directly over the CMT-8540S diaphragm.

### 6. Right Wall: Sensor Environmental Intake Louvers
- **Location:** Right side wall spanning $Y = 10.00\text{ mm}$ to $Y = 26.00\text{ mm}$.
- **Design:** Angled downward-slanted ventilation louvers to allow ambient airflow across the SHT40 temperature/humidity sensor and SGP40 VOC sensor while blocking dust and direct water drip.

### 7. Bottom Wall / Bezel: Directional Guidance Light Window
- **Location:** Front bottom edge spanning $X = 39.00\text{ mm}$ to $X = 92.00\text{ mm}$ at $Y = 74.00\text{ mm}$.
- **Design:** Optically diffused polycarbonate light pipe or frosted acrylic window with 8 individual internal baffling chambers ($6.70\text{ mm}$ pitch) to prevent optical crosstalk between adjacent WS2812B pixels during dynamic wave / directional animation.

---

## 4. CATIA V5 Workflow & Modeling Instructions

1. **Importing the PCB Solid into CATIA V5:**
   - Launch CATIA V5 $\rightarrow$ **File** $\rightarrow$ **Open...**
   - Select `mechanical/step/ExitIQ.step`.
   - The PCB board substrate, mounting holes, thermal slot, and 65 SMD/THT components will load as an exact 3D solid assembly.
2. **Importing 2D Outline into Sketcher:**
   - In CATIA V5 Part Design, create a new Part.
   - Insert $\rightarrow$ Import $\rightarrow$ select `mechanical/cad/ExitIQ_BoardOutline_Mounting.dxf`.
   - Use the DXF contours to parametrically drive the enclosure floor sketch and mounting boss positions.
3. **Drafting Wall Enclosure Parts:**
   - **Base Enclosure (Bottom Tub):** Contains the 4× M3 standoff bosses, internal battery compartment (for single 18650 cell or 3.7V Li-Po pack), and wall mounting keyholes.
   - **Top Enclosure (Bezel Cover):** Contains the display aperture, button plunger guide, acoustic sound grille, sensor louvers, and directional LED light diffuser.
