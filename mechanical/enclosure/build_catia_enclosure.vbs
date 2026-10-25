' ==============================================================================
' ExitIQ Emergency Evacuation Guidance Terminal
' CATIA V5 Native Enclosure Modeling Automation Script
' Revision: 2.0.0 (Production Release)
' ==============================================================================

Option Explicit

Dim CATIA, docs
Dim fso, projectDir, enclosureDir, pcbStepPath
Dim basePartPath, baseStepPath, lidPartPath, lidStepPath
Dim assyProdPath, assyStepPath

Set fso = CreateObject("Scripting.FileSystemObject")
projectDir = "C:\Users\RHESSA\Downloads\ExitIQ_CAD_Project"
enclosureDir = projectDir & "\mechanical\enclosure"
pcbStepPath = projectDir & "\mechanical\step\ExitIQ.step"

basePartPath = enclosureDir & "\ExitIQ_Enclosure_Base.CATPart"
baseStepPath = enclosureDir & "\ExitIQ_Enclosure_Base.step"
lidPartPath  = enclosureDir & "\ExitIQ_Enclosure_Lid.CATPart"
lidStepPath  = enclosureDir & "\ExitIQ_Enclosure_Lid.step"
assyProdPath = enclosureDir & "\ExitIQ_Enclosure_Assembly.CATProduct"
assyStepPath = enclosureDir & "\ExitIQ_Enclosure_Assembly.step"

If Not fso.FolderExists(enclosureDir) Then
    fso.CreateFolder(enclosureDir)
End If

WScript.Echo "Connecting to CATIA V5 Application..."
On Error Resume Next
Set CATIA = GetObject(, "CATIA.Application")
If Err.Number <> 0 Then
    Err.Clear
    Set CATIA = CreateObject("CATIA.Application")
End If
If Err.Number <> 0 Then
    WScript.Echo "CRITICAL: Could not connect to or start CATIA.Application!"
    WScript.Quit 1
End If
On Error GoTo 0

CATIA.Visible = True
CATIA.DisplayFileAlerts = False
Set docs = CATIA.Documents

WScript.Echo "CATIA V5 Connected: " & CATIA.Name
WScript.Echo "Starting native CAD generation..."

' ==============================================================================
' SUBROUTINE 1: BUILD ENCLOSURE BASE (CATPart)
' ==============================================================================
Sub BuildBase()
    WScript.Echo "--- Modeling ExitIQ_Enclosure_Base.CATPart ---"
    Dim partDoc, part, body, sf, sketches, originElements, planeXY
    Dim sk, f2d, pad, pkt

    Set partDoc = docs.Add("Part")
    Set part = partDoc.Part
    partDoc.Product.PartNumber = "ExitIQ_Enclosure_Base"
    Set body = part.MainBody
    Set sf = part.ShapeFactory
    Set sketches = body.Sketches
    Set originElements = part.OriginElements
    Set planeXY = originElements.PlaneXY

    ' 1. Outer Solid Shell: 114 x 94 mm, Height from Z=-7.0 to Z=+5.0 (12.0 mm total)
    Set sk = sketches.Add(planeXY)
    Set f2d = sk.OpenEdition()
    f2d.CreateLine -7.0, -7.0, 107.0, -7.0
    f2d.CreateLine 107.0, -7.0, 107.0, 87.0
    f2d.CreateLine 107.0, 87.0, -7.0, 87.0
    f2d.CreateLine -7.0, 87.0, -7.0, -7.0
    sk.CloseEdition()

    Set pad = sf.AddNewPad(sk, 5.0)
    pad.SecondLimit.Dimension.Value = 7.0
    part.Update

    ' 2. Internal PCB Cavity Pocket: 104 x 84 mm (from Z=+5.0 down to Z=-4.5, depth 9.5 mm)
    Set sk = sketches.Add(planeXY)
    Set f2d = sk.OpenEdition()
    f2d.CreateLine -2.0, -2.0, 102.0, -2.0
    f2d.CreateLine 102.0, -2.0, 102.0, 82.0
    f2d.CreateLine 102.0, 82.0, -2.0, 82.0
    f2d.CreateLine -2.0, 82.0, -2.0, -2.0
    sk.CloseEdition()

    Set pkt = sf.AddNewPocket(sk, 9.5)
    part.Update

    ' 3. 4x Internal PCB Standoff Bosses: Dia 6.0mm (R=3.0) at (5,5), (95,5), (95,75), (5,75)
    ' Height: from floor Z=-4.5 to PCB seat Z=0.0 (height 4.5 mm)
    Set sk = sketches.Add(planeXY)
    Set f2d = sk.OpenEdition()
    f2d.CreateClosedCircle 5.0, 5.0, 3.0
    f2d.CreateClosedCircle 95.0, 5.0, 3.0
    f2d.CreateClosedCircle 95.0, 75.0, 3.0
    f2d.CreateClosedCircle 5.0, 75.0, 3.0
    sk.CloseEdition()

    Set pad = sf.AddNewPad(sk, 0.0)
    pad.SecondLimit.Dimension.Value = 4.5
    part.Update

    ' 4. 4x PCB Standoff Pilot Holes: Dia 2.8mm (R=1.4), Depth 4.0 mm
    Set sk = sketches.Add(planeXY)
    Set f2d = sk.OpenEdition()
    f2d.CreateClosedCircle 5.0, 5.0, 1.4
    f2d.CreateClosedCircle 95.0, 5.0, 1.4
    f2d.CreateClosedCircle 95.0, 75.0, 1.4
    f2d.CreateClosedCircle 5.0, 75.0, 1.4
    sk.CloseEdition()

    Set pkt = sf.AddNewPocket(sk, 4.0)
    part.Update

    ' 5. 4x Corner Lid Screw Bosses: Dia 7.0mm (R=3.5) at (-3.5,-3.5), (103.5,-3.5), etc.
    ' Height: from floor Z=-4.5 to parting plane Z=+5.0 (height 9.5 mm)
    Set sk = sketches.Add(planeXY)
    Set f2d = sk.OpenEdition()
    f2d.CreateClosedCircle -3.5, -3.5, 3.5
    f2d.CreateClosedCircle 103.5, -3.5, 3.5
    f2d.CreateClosedCircle 103.5, 83.5, 3.5
    f2d.CreateClosedCircle -3.5, 83.5, 3.5
    sk.CloseEdition()

    Set pad = sf.AddNewPad(sk, 5.0)
    pad.SecondLimit.Dimension.Value = 4.5
    part.Update

    ' 6. 4x Corner Lid Screw Pilot Holes: Dia 2.8mm (R=1.4), Depth 10.0 mm from Z=+5.0
    Set sk = sketches.Add(planeXY)
    Set f2d = sk.OpenEdition()
    f2d.CreateClosedCircle -3.5, -3.5, 1.4
    f2d.CreateClosedCircle 103.5, -3.5, 1.4
    f2d.CreateClosedCircle 103.5, 83.5, 1.4
    f2d.CreateClosedCircle -3.5, 83.5, 1.4
    sk.CloseEdition()

    Set pkt = sf.AddNewPocket(sk, 10.0)
    part.Update

    ' 7. Left Wall Cutout: USB-C Opening at Y=15.0 mm (width 11.0 mm, Y=9.5 to 20.5 mm)
    Set sk = sketches.Add(planeXY)
    Set f2d = sk.OpenEdition()
    f2d.CreateLine -8.0, 9.5, -1.0, 9.5
    f2d.CreateLine -1.0, 9.5, -1.0, 20.5
    f2d.CreateLine -1.0, 20.5, -8.0, 20.5
    f2d.CreateLine -8.0, 20.5, -8.0, 9.5
    sk.CloseEdition()

    Set pkt = sf.AddNewPocket(sk, 5.0)
    part.Update

    ' 8. Left Wall Cutout: Battery Cable Hatch at Y=32.0 mm (width 9.0 mm, Y=27.5 to 36.5 mm)
    Set sk = sketches.Add(planeXY)
    Set f2d = sk.OpenEdition()
    f2d.CreateLine -8.0, 27.5, -1.0, 27.5
    f2d.CreateLine -1.0, 27.5, -1.0, 36.5
    f2d.CreateLine -1.0, 36.5, -8.0, 36.5
    f2d.CreateLine -8.0, 36.5, -8.0, 27.5
    sk.CloseEdition()

    Set pkt = sf.AddNewPocket(sk, 7.0)
    part.Update

    ' 9. Right Wall Cutout: Sensor Intake Louvers (Y=12.0 to 24.0 mm)
    Set sk = sketches.Add(planeXY)
    Set f2d = sk.OpenEdition()
    f2d.CreateLine 101.0, 12.0, 108.0, 12.0
    f2d.CreateLine 108.0, 12.0, 108.0, 16.0
    f2d.CreateLine 108.0, 16.0, 101.0, 16.0
    f2d.CreateLine 101.0, 16.0, 101.0, 12.0

    f2d.CreateLine 101.0, 18.0, 108.0, 18.0
    f2d.CreateLine 108.0, 18.0, 108.0, 22.0
    f2d.CreateLine 108.0, 22.0, 101.0, 22.0
    f2d.CreateLine 101.0, 22.0, 101.0, 18.0
    sk.CloseEdition()

    Set pkt = sf.AddNewPocket(sk, 4.0)
    part.Update

    ' 10. Right Wall Cutout: External LED Strip Cable Exit (Y=54.0 to 62.0 mm)
    Set sk = sketches.Add(planeXY)
    Set f2d = sk.OpenEdition()
    f2d.CreateLine 101.0, 54.0, 108.0, 54.0
    f2d.CreateLine 108.0, 54.0, 108.0, 62.0
    f2d.CreateLine 108.0, 62.0, 101.0, 62.0
    f2d.CreateLine 101.0, 62.0, 101.0, 54.0
    sk.CloseEdition()

    Set pkt = sf.AddNewPocket(sk, 4.0)
    part.Update

    ' 11. 2x Wall Mounting Keyholes on Base Floor at (20, 40) and (80, 40)
    Set sk = sketches.Add(planeXY)
    Set f2d = sk.OpenEdition()
    f2d.CreateClosedCircle 20.0, 40.0, 3.5
    f2d.CreateClosedCircle 80.0, 40.0, 3.5
    sk.CloseEdition()

    Set pkt = sf.AddNewPocket(sk, 2.5)
    pkt.SecondLimit.Dimension.Value = 7.0
    part.Update

    WScript.Echo "Saving: " & basePartPath
    partDoc.SaveAs basePartPath
    WScript.Echo "Exporting: " & baseStepPath
    partDoc.ExportData baseStepPath, "stp"
    partDoc.Close
    WScript.Echo "Base successfully built and exported!"
End Sub

' ==============================================================================
' SUBROUTINE 2: BUILD ENCLOSURE LID (CATPart)
' ==============================================================================
Sub BuildLid()
    WScript.Echo "--- Modeling ExitIQ_Enclosure_Lid.CATPart ---"
    Dim partDoc, part, body, sf, sketches, originElements, planeXY
    Dim sk, f2d, pad, pkt

    Set partDoc = docs.Add("Part")
    Set part = partDoc.Part
    partDoc.Product.PartNumber = "ExitIQ_Enclosure_Lid"
    Set body = part.MainBody
    Set sf = part.ShapeFactory
    Set sketches = body.Sketches
    Set originElements = part.OriginElements
    Set planeXY = originElements.PlaneXY

    ' 1. Outer Shell: 114 x 94 mm from Parting Plane Z=+5.0 to Top Face Z=+19.0 (14.0 mm)
    Set sk = sketches.Add(planeXY)
    Set f2d = sk.OpenEdition()
    f2d.CreateLine -7.0, -7.0, 107.0, -7.0
    f2d.CreateLine 107.0, -7.0, 107.0, 87.0
    f2d.CreateLine 107.0, 87.0, -7.0, 87.0
    f2d.CreateLine -7.0, 87.0, -7.0, -7.0
    sk.CloseEdition()

    Set pad = sf.AddNewPad(sk, 14.0)
    part.Update

    ' 2. Internal Clearance Cavity: 104 x 84 mm (depth 11.5 mm, leaving 2.5 mm ceiling)
    ' This establishes an internal clearance ceiling at Z=+16.5 mm (14.90 mm above PCB top!)
    Set sk = sketches.Add(planeXY)
    Set f2d = sk.OpenEdition()
    f2d.CreateLine -2.0, -2.0, 102.0, -2.0
    f2d.CreateLine 102.0, -2.0, 102.0, 82.0
    f2d.CreateLine 102.0, 82.0, -2.0, 82.0
    f2d.CreateLine -2.0, 82.0, -2.0, -2.0
    sk.CloseEdition()

    Set pkt = sf.AddNewPocket(sk, 11.5)
    part.Update

    ' 3. Stepped Interlocking Alignment Lip: Extends 1.5 mm downward into base
    Set sk = sketches.Add(planeXY)
    Set f2d = sk.OpenEdition()
    f2d.CreateLine -1.8, -1.8, 101.8, -1.8
    f2d.CreateLine 101.8, -1.8, 101.8, 81.8
    f2d.CreateLine 101.8, 81.8, -1.8, 81.8
    f2d.CreateLine -1.8, 81.8, -1.8, -1.8

    f2d.CreateLine -0.8, -0.8, -0.8, 80.8
    f2d.CreateLine -0.8, 80.8, 100.8, 80.8
    f2d.CreateLine 100.8, 80.8, 100.8, -0.8
    f2d.CreateLine 100.8, -0.8, -0.8, -0.8
    sk.CloseEdition()

    Set pad = sf.AddNewPad(sk, 0.0)
    pad.SecondLimit.Dimension.Value = 1.5
    part.Update

    ' 4. OLED Display Viewing Window: 28.0 x 16.0 mm centered at (94.0, 36.0)
    Set sk = sketches.Add(planeXY)
    Set f2d = sk.OpenEdition()
    f2d.CreateLine 80.0, 28.0, 108.0, 28.0
    f2d.CreateLine 108.0, 28.0, 108.0, 44.0
    f2d.CreateLine 108.0, 44.0, 80.0, 44.0
    f2d.CreateLine 80.0, 44.0, 80.0, 28.0
    sk.CloseEdition()

    Set pkt = sf.AddNewPocket(sk, 14.0)
    part.Update

    ' 5. Directional WS2812B LED Window: 55.0 x 8.0 mm at Y=73.5 mm (X=36.0 to 91.0 mm)
    Set sk = sketches.Add(planeXY)
    Set f2d = sk.OpenEdition()
    f2d.CreateLine 36.0, 69.5, 91.0, 69.5
    f2d.CreateLine 91.0, 69.5, 91.0, 77.5
    f2d.CreateLine 91.0, 77.5, 36.0, 77.5
    f2d.CreateLine 36.0, 77.5, 36.0, 69.5
    sk.CloseEdition()

    Set pkt = sf.AddNewPocket(sk, 14.0)
    part.Update

    ' 6. Buzzer Acoustic Sound Grille: Dia 4.0mm (R=2.0) at (55.7, 14.0)
    Set sk = sketches.Add(planeXY)
    Set f2d = sk.OpenEdition()
    f2d.CreateClosedCircle 55.7, 14.0, 2.0
    sk.CloseEdition()

    Set pkt = sf.AddNewPocket(sk, 14.0)
    part.Update

    ' 7. User Test Button Access Aperture: Dia 5.0mm (R=2.5) at (86.0, 50.0)
    Set sk = sketches.Add(planeXY)
    Set f2d = sk.OpenEdition()
    f2d.CreateClosedCircle 86.0, 50.0, 2.5
    sk.CloseEdition()

    Set pkt = sf.AddNewPocket(sk, 14.0)
    part.Update

    ' 8. Sensor Exhaust Ventilation Grille: 3 slots over sensor bay (X=76..90, Y=12..24)
    Set sk = sketches.Add(planeXY)
    Set f2d = sk.OpenEdition()
    f2d.CreateLine 76.0, 13.0, 90.0, 13.0
    f2d.CreateLine 90.0, 13.0, 90.0, 15.0
    f2d.CreateLine 90.0, 15.0, 76.0, 15.0
    f2d.CreateLine 76.0, 15.0, 76.0, 13.0

    f2d.CreateLine 76.0, 17.0, 90.0, 17.0
    f2d.CreateLine 90.0, 17.0, 90.0, 19.0
    f2d.CreateLine 90.0, 19.0, 76.0, 19.0
    f2d.CreateLine 76.0, 19.0, 76.0, 17.0

    f2d.CreateLine 76.0, 21.0, 90.0, 21.0
    f2d.CreateLine 90.0, 21.0, 90.0, 23.0
    f2d.CreateLine 90.0, 23.0, 76.0, 23.0
    f2d.CreateLine 76.0, 23.0, 76.0, 21.0
    sk.CloseEdition()

    Set pkt = sf.AddNewPocket(sk, 14.0)
    part.Update

    ' 9. 4x Corner Screw Through-Holes: Dia 3.4mm (R=1.7) at (-3.5,-3.5), (103.5,-3.5), etc.
    Set sk = sketches.Add(planeXY)
    Set f2d = sk.OpenEdition()
    f2d.CreateClosedCircle -3.5, -3.5, 1.7
    f2d.CreateClosedCircle 103.5, -3.5, 1.7
    f2d.CreateClosedCircle 103.5, 83.5, 1.7
    f2d.CreateClosedCircle -3.5, 83.5, 1.7
    sk.CloseEdition()

    Set pkt = sf.AddNewPocket(sk, 14.0)
    part.Update

    ' 10. 4x Corner Screw Counterbores: Dia 6.5mm (R=3.25), Depth 2.5 mm from top face
    Set sk = sketches.Add(planeXY)
    Set f2d = sk.OpenEdition()
    f2d.CreateClosedCircle -3.5, -3.5, 3.25
    f2d.CreateClosedCircle 103.5, -3.5, 3.25
    f2d.CreateClosedCircle 103.5, 83.5, 3.25
    f2d.CreateClosedCircle -3.5, 83.5, 3.25
    sk.CloseEdition()

    Set pkt = sf.AddNewPocket(sk, 2.5)
    part.Update

    WScript.Echo "Saving: " & lidPartPath
    partDoc.SaveAs lidPartPath
    WScript.Echo "Exporting: " & lidStepPath
    partDoc.ExportData lidStepPath, "stp"
    partDoc.Close
    WScript.Echo "Lid successfully built and exported!"
End Sub

' ==============================================================================
' SUBROUTINE 3: BUILD COMPLETE ENCLOSURE ASSEMBLY (CATProduct)
' ==============================================================================
Sub BuildAssembly()
    WScript.Echo "--- Assembling ExitIQ_Enclosure_Assembly.CATProduct ---"
    Dim prodDoc, rootProd, prods
    Dim compFiles(2)

    Set prodDoc = docs.Add("Product")
    Set rootProd = prodDoc.Product
    rootProd.PartNumber = "ExitIQ_Enclosure_Assembly"
    Set prods = rootProd.Products

    ' 1. Add Base CATPart
    compFiles(0) = basePartPath
    WScript.Echo "Inserting Component: " & basePartPath
    prods.AddComponentsFromFiles compFiles, "All"

    ' 2. Add PCB Reference STEP Solid
    compFiles(0) = pcbStepPath
    WScript.Echo "Inserting Component: " & pcbStepPath
    prods.AddComponentsFromFiles compFiles, "All"

    ' 3. Add Lid CATPart
    compFiles(0) = lidPartPath
    WScript.Echo "Inserting Component: " & lidPartPath
    prods.AddComponentsFromFiles compFiles, "All"

    rootProd.Update

    WScript.Echo "Saving Assembly: " & assyProdPath
    prodDoc.SaveAs assyProdPath

    WScript.Echo "Exporting Assembly Solid STEP: " & assyStepPath
    prodDoc.ExportData assyStepPath, "stp"

    prodDoc.Close
    WScript.Echo "Assembly successfully built and exported!"
End Sub

' ==============================================================================
' MAIN EXECUTION
' ==============================================================================
BuildBase
BuildLid
BuildAssembly

WScript.Echo "=================================================================="
WScript.Echo "CATIA V5 Enclosure CAD Generation Complete!"
WScript.Echo "Deliverables:"
WScript.Echo "  - " & basePartPath
WScript.Echo "  - " & baseStepPath
WScript.Echo "  - " & lidPartPath
WScript.Echo "  - " & lidStepPath
WScript.Echo "  - " & assyProdPath
WScript.Echo "  - " & assyStepPath
WScript.Echo "=================================================================="
