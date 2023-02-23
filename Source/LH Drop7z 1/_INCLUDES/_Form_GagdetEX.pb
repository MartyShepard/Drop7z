
;//////////////////////////////////////////////////////////////////////////////// Structure
Structure gadgetex
    Pressed.i
    Disabled.i
    
    toggle.i
    toggled.i
    
    ImageNormal.i
    ImageOver.i
    ImagePressed.i
    ImageDisabled.i
    
    FACE.l
    
    TextNormal.s
    TextOver.s
    TextPressed.s   
EndStructure

;////////////////////////////////////////////////////////////////////////////////  Enumeration
Enumeration
    #ButtonGadgetEx_Entered
    #ButtonGadgetEx_Released
    #ButtonGadgetEx_Pressed
    
EndEnumeration

Enumeration FormFont
    #ButtonGadgetEx_FontID
  EndEnumeration

LoadFont(#ButtonGadgetEx_FontID,"Segoe UI", 9)   


;//////////////////////////////////////////////////////////////////////////////// Texter
Procedure SetGadgetTextEx(_DRAWING,GadgetEx_X.i = 0,GadgetEx_Y.i = 0, TxtGaEx$ = "Not Clicked", RGBGaEx.i = $00FFFFFF,GadgetEx_Font.i = #ButtonGadgetEx_FontID)
    
    DrawingMode(#PB_2DDrawing_Transparent)
    DrawingFont(FontID(GadgetEx_Font))
    
    GetTextMetrics_(_DRAWING, TM.NEWTEXTMETRIC)  ;to change text bottom position
    
   ; DrawText(GadgetEx_X.i/9,GadgetEx_Y.i-TM\tmAscent-8, TxtGaEx$, RGBGaEx.i)
   
   TxtGaEx_Lenght = Len(TxtGaEx$)
   If (TxtGaEx_Lenght <> 0)
       
       If TxtGaEx_Lenght = 16
           If GadgetEx_Y.i = 27
              DrawText(GadgetEx_X.i/TxtGaEx_Lenght,GadgetEx_Y.i-TM\tmAscent-8, TxtGaEx$, RGBGaEx.i)
           EndIf
           If GadgetEx_Y.i = 20
              DrawText(GadgetEx_X.i/TxtGaEx_Lenght-3,GadgetEx_Y.i-TM\tmAscent-5, TxtGaEx$, RGBGaEx.i)
           EndIf
           ProcedureReturn
       EndIf
            
       
       If TxtGaEx_Lenght = 15 
           
           If GadgetEx_Y.i = 27
              DrawText(GadgetEx_X.i/TxtGaEx_Lenght,GadgetEx_Y.i-TM\tmAscent-8, TxtGaEx$, RGBGaEx.i)
           EndIf
           If GadgetEx_Y.i = 20
              DrawText(GadgetEx_X.i/TxtGaEx_Lenght-3,GadgetEx_Y.i-TM\tmAscent-5, TxtGaEx$, RGBGaEx.i)
           EndIf:ProcedureReturn
       EndIf
       
       If TxtGaEx_Lenght = 14
           
           
           If GadgetEx_Y.i = 27
              DrawText(GadgetEx_X.i/TxtGaEx_Lenght+2,GadgetEx_Y.i-TM\tmAscent-8, TxtGaEx$, RGBGaEx.i)
           EndIf
           If GadgetEx_Y.i = 20
              DrawText(GadgetEx_X.i/TxtGaEx_Lenght-3,GadgetEx_Y.i-TM\tmAscent-5, TxtGaEx$, RGBGaEx.i)
           EndIf:ProcedureReturn
       EndIf


       If TxtGaEx_Lenght = 13 
           
           If GadgetEx_Y.i = 27
              DrawText(GadgetEx_X.i/TxtGaEx_Lenght,GadgetEx_Y.i-TM\tmAscent-8, TxtGaEx$, RGBGaEx.i)
           EndIf
           If GadgetEx_Y.i = 20
              DrawText(GadgetEx_X.i/TxtGaEx_Lenght-3,GadgetEx_Y.i-TM\tmAscent-5, TxtGaEx$, RGBGaEx.i)
           EndIf:ProcedureReturn
       EndIf
                   
       If TxtGaEx_Lenght = 12 
           
           If GadgetEx_Y.i = 27
              DrawText(GadgetEx_X.i/TxtGaEx_Lenght+3,GadgetEx_Y.i-TM\tmAscent-8, TxtGaEx$, RGBGaEx.i)
           EndIf
           If GadgetEx_Y.i = 20
              DrawText(GadgetEx_X.i/TxtGaEx_Lenght-4,GadgetEx_Y.i-TM\tmAscent-5, TxtGaEx$, RGBGaEx.i)
           EndIf:ProcedureReturn
       EndIf
       
       If TxtGaEx_Lenght = 11 
           
           If GadgetEx_Y.i = 27
              DrawText(GadgetEx_X.i/TxtGaEx_Lenght+3,GadgetEx_Y.i-TM\tmAscent-8, TxtGaEx$, RGBGaEx.i)
           EndIf
           If GadgetEx_Y.i = 20
              DrawText(GadgetEx_X.i/TxtGaEx_Lenght+2,GadgetEx_Y.i-TM\tmAscent-5, TxtGaEx$, RGBGaEx.i)
           EndIf:ProcedureReturn
       EndIf        
       
       If TxtGaEx_Lenght = 10 
           
           If GadgetEx_Y.i = 27
              DrawText(GadgetEx_X.i/TxtGaEx_Lenght+9,GadgetEx_Y.i-TM\tmAscent-8, TxtGaEx$, RGBGaEx.i)
           EndIf
           If GadgetEx_Y.i = 20
              DrawText(GadgetEx_X.i/TxtGaEx_Lenght+8,GadgetEx_Y.i-TM\tmAscent-5, TxtGaEx$, RGBGaEx.i)
           EndIf:ProcedureReturn
       EndIf
       
       If TxtGaEx_Lenght = 8 
           If GadgetEx_Y.i = 27
              DrawText(GadgetEx_X.i/TxtGaEx_Lenght+6,GadgetEx_Y.i-TM\tmAscent-8, TxtGaEx$, RGBGaEx.i)
           EndIf
           If GadgetEx_Y.i = 20
              DrawText(GadgetEx_X.i/TxtGaEx_Lenght+1,GadgetEx_Y.i-TM\tmAscent-5, TxtGaEx$, RGBGaEx.i)
           EndIf:ProcedureReturn
       EndIf

       If TxtGaEx_Lenght = 7 
           If GadgetEx_Y.i = 27
              DrawText(GadgetEx_X.i/TxtGaEx_Lenght+12,GadgetEx_Y.i-TM\tmAscent-8, TxtGaEx$, RGBGaEx.i)
           EndIf
           If GadgetEx_Y.i = 20
              DrawText(GadgetEx_X.i/TxtGaEx_Lenght+11,GadgetEx_Y.i-TM\tmAscent-5, TxtGaEx$, RGBGaEx.i)
           EndIf:ProcedureReturn
       EndIf 
          
       If TxtGaEx_Lenght = 6 
           
           If GadgetEx_Y.i = 27
              DrawText(GadgetEx_X.i/TxtGaEx_Lenght+10,GadgetEx_Y.i-TM\tmAscent-8, TxtGaEx$, RGBGaEx.i)
           EndIf
           If GadgetEx_Y.i = 20
              DrawText(GadgetEx_X.i/TxtGaEx_Lenght+9,GadgetEx_Y.i-TM\tmAscent-5, TxtGaEx$, RGBGaEx.i)
           EndIf:ProcedureReturn
       EndIf
       If TxtGaEx_Lenght = 5 
           
           If GadgetEx_Y.i = 27
              DrawText(GadgetEx_X.i/TxtGaEx_Lenght+11,GadgetEx_Y.i-TM\tmAscent-8, TxtGaEx$, RGBGaEx.i)
           EndIf
           If GadgetEx_Y.i = 20
              DrawText(GadgetEx_X.i/TxtGaEx_Lenght+10,GadgetEx_Y.i-TM\tmAscent-5, TxtGaEx$, RGBGaEx.i)
           EndIf:ProcedureReturn
       EndIf
       
       If TxtGaEx_Lenght = 4 
           
           If GadgetEx_Y.i = 27
              DrawText(GadgetEx_X.i/TxtGaEx_Lenght+10,GadgetEx_Y.i-TM\tmAscent-8, TxtGaEx$, RGBGaEx.i)
           EndIf
           If GadgetEx_Y.i = 20
              DrawText(GadgetEx_X.i/TxtGaEx_Lenght+9,GadgetEx_Y.i-TM\tmAscent-5, TxtGaEx$, RGBGaEx.i)
           EndIf:ProcedureReturn
       EndIf
       
       If TxtGaEx_Lenght = 2 
           
           If GadgetEx_Y.i = 27
              DrawText(GadgetEx_X.i/TxtGaEx_Lenght-6,GadgetEx_Y.i-TM\tmAscent-8, TxtGaEx$, RGBGaEx.i)
           EndIf
           If GadgetEx_Y.i = 20
              DrawText(GadgetEx_X.i/TxtGaEx_Lenght-5,GadgetEx_Y.i-TM\tmAscent-5, TxtGaEx$, RGBGaEx.i)
           EndIf:ProcedureReturn
       EndIf 
                       
       
           If GadgetEx_Y.i = 27
              DrawText(GadgetEx_X.i/TxtGaEx_Lenght+8,GadgetEx_Y.i-TM\tmAscent-8, TxtGaEx$, RGBGaEx.i)
           EndIf
           If GadgetEx_Y.i = 20
              DrawText(GadgetEx_X.i/TxtGaEx_Lenght+7,GadgetEx_Y.i-TM\tmAscent-5, TxtGaEx$, RGBGaEx.i)
           EndIf:ProcedureReturn       
   EndIf
EndProcedure     


;//////////////////////////////////////////////////////////////////////////////// Disabled
Procedure GrayscaleCallback(x, y, TopColor, BottomColor)
    Define Gray.i
    Gray = Red(TopColor)*0.56+Green(TopColor)*0.33+Blue(TopColor)*0.11+Alpha(BottomColor)
    ProcedureReturn Gray<<16+Gray<<8+Gray<<24+Gray
EndProcedure

;//////////////////////////////////////////////////////////////////////////////// Neuer EvenType
Procedure EventGadgetEx(GadgetID)
    Protected *GadgetEx.gadgetex = GetGadgetData(GadgetID)
    
    If *GadgetEx\Disabled=#False
        If EventType() = #PB_EventType_MouseEnter
            
            If *GadgetEx\toggle=#True And *GadgetEx\toggled=#False
                _DRAWING = StartDrawing(CanvasOutput(GadgetID))
                Box(0, 0, GadgetWidth(GadgetID), GadgetHeight(GadgetID), *GadgetEx\FACE)
                DrawingMode(#PB_2DDrawing_AlphaBlend)
                DrawImage(ImageID(*GadgetEx\ImageOver), 0, 0)
                DrawImage(ImageID(*GadgetEx\ImageOver), 0, 0)
                SetGadgetTextEx(_DRAWING,GadgetWidth(GadgetID), GadgetHeight(GadgetID),"100000")
                Delay(1000)
                StopDrawing()
                
            ElseIf *GadgetEx\toggle=#False
                _DRAWING = StartDrawing(CanvasOutput(GadgetID))
                Box(0, 0, GadgetWidth(GadgetID), GadgetHeight(GadgetID), *GadgetEx\FACE)
                DrawingMode(#PB_2DDrawing_AlphaBlend)
                DrawImage(ImageID(*GadgetEx\ImageOver), 0, 0)
                DrawImage(ImageID(*GadgetEx\ImageOver), 0, 0)
                
                SetGadgetTextEx(_DRAWING,GadgetWidth(GadgetID), GadgetHeight(GadgetID),*GadgetEx\TextOver.s) ;// Mit der Mouse darüber
                StopDrawing()
                
            EndIf
            
            ProcedureReturn #ButtonGadgetEx_Entered
            
        ElseIf EventType() = #PB_EventType_MouseLeave
            If *GadgetEx\toggle=#True And *GadgetEx\toggled=#False
                _DRAWING = StartDrawing(CanvasOutput(GadgetID))
                Box(0, 0, GadgetWidth(GadgetID), GadgetHeight(GadgetID), *GadgetEx\FACE)
                DrawingMode(#PB_2DDrawing_AlphaBlend)
                DrawImage(ImageID(*GadgetEx\ImageNormal), 0, 0)
                DrawImage(ImageID(*GadgetEx\ImageNormal), 0, 0)
                
                SetGadgetTextEx(_DRAWING,GadgetWidth(GadgetID), GadgetHeight(GadgetID),"200000")
                Delay(1000)          
                StopDrawing()
                
                
            ElseIf *GadgetEx\toggle=#False
                _DRAWING = StartDrawing(CanvasOutput(GadgetID))
                Box(0, 0, GadgetWidth(GadgetID), GadgetHeight(GadgetID), *GadgetEx\FACE)
                DrawingMode(#PB_2DDrawing_AlphaBlend)
                DrawImage(ImageID(*GadgetEx\ImageNormal), 0, 0)
                DrawImage(ImageID(*GadgetEx\ImageNormal), 0, 0)
                
                SetGadgetTextEx(_DRAWING,GadgetWidth(GadgetID), GadgetHeight(GadgetID),*GadgetEx\TextNormal.s) ;// nach dem Clicken 
                StopDrawing()
            EndIf
            ProcedureReturn #ButtonGadgetEx_Released
            
        ElseIf EventType() = #PB_EventType_LeftButtonDown
            *GadgetEx\Pressed=#True
            
            _DRAWING = StartDrawing(CanvasOutput(GadgetID))
            Box(0, 0, GadgetWidth(GadgetID), GadgetHeight(GadgetID), *GadgetEx\FACE)
            DrawingMode(#PB_2DDrawing_AlphaBlend)
            DrawImage(ImageID(*GadgetEx\ImagePressed), 0, 0)
            
            SetGadgetTextEx(_DRAWING,GadgetWidth(GadgetID), GadgetHeight(GadgetID),*GadgetEx\TextNormal.s) ;// nach dem Clicken LeftButtonDown
            StopDrawing()
            ProcedureReturn -1
            
        ElseIf EventType() = #PB_EventType_LeftButtonUp
            *GadgetEx\Pressed=#False
            
            ; If *GadgetEx\toggle=#False
            _DRAWING = StartDrawing(CanvasOutput(GadgetID))
            Box(0, 0, GadgetWidth(GadgetID), GadgetHeight(GadgetID), *GadgetEx\FACE)
            DrawingMode(#PB_2DDrawing_AlphaBlend)
            DrawImage(ImageID(*GadgetEx\ImageNormal), 0, 0)
            
            SetGadgetTextEx(_DRAWING,GadgetWidth(GadgetID), GadgetHeight(GadgetID),*GadgetEx\TextNormal.s) ;// nach dem Clicken LeftButtonUp
            
            StopDrawing()
            
            ;EndIf
            
            If  GetGadgetAttribute(GadgetID, #PB_Canvas_MouseX)>0 And GetGadgetAttribute(GadgetID, #PB_Canvas_MouseY)>0 And GetGadgetAttribute(GadgetID, #PB_Canvas_MouseX)<GadgetWidth(GadgetID) And GetGadgetAttribute(GadgetID, #PB_Canvas_MouseY)< GadgetHeight(GadgetID)
                
                If *GadgetEx\toggle=#True
                    *GadgetEx\toggled!1
                EndIf
                
                If *GadgetEx\toggle=#True And *GadgetEx\toggled=#True
                    _DRAWING= StartDrawing(CanvasOutput(GadgetID))
                    Box(0, 0, GadgetWidth(GadgetID), GadgetHeight(GadgetID), *GadgetEx\FACE)
                    DrawingMode(#PB_2DDrawing_AlphaBlend)
                    DrawImage(ImageID(*GadgetEx\ImagePressed), 0, 0)
                    SetGadgetTextEx(_DRAWING,GadgetWidth(GadgetID), GadgetHeight(GadgetID),"500000")
                    Delay(1000)            
                    StopDrawing()
                Else
                    _DRAWING = StartDrawing(CanvasOutput(GadgetID))
                    Box(0, 0, GadgetWidth(GadgetID), GadgetHeight(GadgetID), *GadgetEx\FACE)
                    DrawingMode(#PB_2DDrawing_AlphaBlend)
                    DrawImage(ImageID(*GadgetEx\ImageOver), 0, 0)
                    SetGadgetTextEx(_DRAWING,GadgetWidth(GadgetID), GadgetHeight(GadgetID),*GadgetEx\TextNormal.s) ;// nach dem Clicken 
                    StopDrawing()
                EndIf
                
                ProcedureReturn #ButtonGadgetEx_Pressed
            EndIf
            
        ElseIf EventType() = #PB_EventType_MouseMove
            If GetGadgetAttribute(GadgetID, #PB_Canvas_MouseX)<0 Or GetGadgetAttribute(GadgetID, #PB_Canvas_MouseY)<0 Or GetGadgetAttribute(GadgetID, #PB_Canvas_MouseX)>GadgetWidth(GadgetID) Or GetGadgetAttribute(GadgetID, #PB_Canvas_MouseY)> GadgetHeight(GadgetID) Or *GadgetEx\Pressed=#False
                
                If *GadgetEx\Pressed=#True
                    If *GadgetEx\toggle=#True And *GadgetEx\toggled=#True
                        _DRAWING = StartDrawing(CanvasOutput(GadgetID))
                        Box(0, 0, GadgetWidth(GadgetID), GadgetHeight(GadgetID), *GadgetEx\FACE)
                        DrawingMode(#PB_2DDrawing_AlphaBlend)
                        DrawImage(ImageID(*GadgetEx\ImagePressed), 0, 0)
                        SetGadgetTextEx(_DRAWING,GadgetWidth(GadgetID), GadgetHeight(GadgetID),"600000")
                        Delay(1000)              
                        StopDrawing()
                    Else
                        _DRAWING = StartDrawing(CanvasOutput(GadgetID))
                        Box(0, 0, GadgetWidth(GadgetID), GadgetHeight(GadgetID), *GadgetEx\FACE)
                        DrawingMode(#PB_2DDrawing_AlphaBlend)
                        DrawImage(ImageID(*GadgetEx\ImageNormal), 0, 0)
                        SetGadgetTextEx(_DRAWING,GadgetWidth(GadgetID), GadgetHeight(GadgetID),*GadgetEx\TextNormal.s) ; Wenn die mouse lnage gedrückt wird und dann wegezogen
                        Delay(10)              
                        StopDrawing()
                    EndIf
                    ProcedureReturn #ButtonGadgetEx_Released
                EndIf
            Else
                _DRAWING = StartDrawing(CanvasOutput(GadgetID))
                Box(0, 0, GadgetWidth(GadgetID), GadgetHeight(GadgetID), *GadgetEx\FACE)
                DrawingMode(#PB_2DDrawing_AlphaBlend)
                DrawImage(ImageID(*GadgetEx\ImagePressed), 0, 0)
                SetGadgetTextEx(_DRAWING,GadgetWidth(GadgetID), GadgetHeight(GadgetID),*GadgetEx\TextNormal.s) ;// nach dem Clicken   
                StopDrawing()
            EndIf
        EndIf
    EndIf
    
    ;//////////////////////////////////////////////////////////////////////////////// Toogle  
EndProcedure
Procedure GadgetToggleEx(GadgetID, state)
    Protected *GadgetEx.gadgetex = GetGadgetData(GadgetID)
    *GadgetEx\toggle = state
EndProcedure

;//////////////////////////////////////////////////////////////////////////////// 
Procedure GetGadgetStateEx(GadgetID)
    Protected *GadgetEx.gadgetex = GetGadgetData(GadgetID)
    ProcedureReturn *GadgetEx\toggled
EndProcedure

;//////////////////////////////////////////////////////////////////////////////// 
Procedure SetGadgetStateEx(GadgetID, state)
    Protected *GadgetEx.gadgetex = GetGadgetData(GadgetID)
    *GadgetEx\toggled = state
    
    If state=#True
        _DRAWING = StartDrawing(CanvasOutput(GadgetID))
        Box(0, 0, GadgetWidth(GadgetID), GadgetHeight(GadgetID), *GadgetEx\FACE)
        DrawingMode(#PB_2DDrawing_AlphaBlend)
        DrawImage(ImageID(*GadgetEx\ImagePressed), 0, 0)
        SetGadgetTextEx(_DRAWING,GadgetWidth(GadgetID), GadgetHeight(GadgetID),"900000")
        Delay(1000)      
        StopDrawing()
    Else
        _DRAWING = StartDrawing(CanvasOutput(GadgetID))
        Box(0, 0, GadgetWidth(GadgetID), GadgetHeight(GadgetID), *GadgetEx\FACE)
        DrawingMode(#PB_2DDrawing_AlphaBlend)
        DrawImage(ImageID(*GadgetEx\ImageNormal), 0, 0)
        SetGadgetTextEx(_DRAWING,GadgetWidth(GadgetID), GadgetHeight(GadgetID),*GadgetEx\TextNormal.s) ;Folg nach eineme state = 0
        Delay(10)      
        StopDrawing()
    EndIf
EndProcedure

;//////////////////////////////////////////////////////////////////////////////// 
Procedure DisableGadgetEx(GadgetID, state)
    
    Protected *GadgetEx.gadgetex = GetGadgetData(GadgetID)
    
    DisableGadget(GadgetID, state)
    If state=#True
        _DRAWING = StartDrawing(CanvasOutput(GadgetID))
        Box(0, 0, GadgetWidth(GadgetID), GadgetHeight(GadgetID), *GadgetEx\FACE)
        DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_AlphaClip    )
        CustomFilterCallback(@GrayscaleCallback())
        If *GadgetEx\toggled=#True
            DrawImage(ImageID(*GadgetEx\ImageDisabled), 0, 0)
        Else
            DrawImage(ImageID(*GadgetEx\ImageDisabled), 0, 0)
        EndIf
        SetGadgetTextEx(_DRAWING,GadgetWidth(GadgetID), GadgetHeight(GadgetID),*GadgetEx\TextNormal.s) ;// Disabled 1     
        StopDrawing()
    Else
        _DRAWING = StartDrawing(CanvasOutput(GadgetID))
        Box(0, 0, GadgetWidth(GadgetID), GadgetHeight(GadgetID), *GadgetEx\FACE)
        DrawingMode(#PB_2DDrawing_AlphaBlend)
        If *GadgetEx\toggled=#True
            DrawImage(ImageID(*GadgetEx\ImagePressed), 0, 0)
        Else
            DrawImage(ImageID(*GadgetEx\ImageNormal), 0, 0)
        EndIf
        SetGadgetTextEx(_DRAWING,GadgetWidth(GadgetID), GadgetHeight(GadgetID),*GadgetEx\TextNormal.s) ;// Disabled     
        StopDrawing()
    EndIf
EndProcedure

;//////////////////////////////////////////////////////////////////////////////// 
Procedure ButtonGadgetEx(GadgetID, x, y, Width, Height,
                         ImageNormal,   ImageOver,  ImagePressed, ImageDisabled,
                         TextNormal$,   TextOver$,  TextPressed$,
                         color)
    
    CanvasGadget(GadgetID, x, y, Width, Height)
    Protected *GadgetEx.gadgetex = AllocateMemory(SizeOf(gadgetex))
    SetGadgetData(GadgetID,*GadgetEx)
    
    *GadgetEx\ImageNormal = ImageNormal
    *GadgetEx\ImageOver = ImageOver
    *GadgetEx\ImagePressed = ImagePressed
    *GadgetEx\ImageDisabled = ImageDisabled
    
    *GadgetEx\FACE = color
    
    *GadgetEx\TextNormal.s = TextNormal$
    *GadgetEx\TextOver.s = TextOver$   
    *GadgetEx\TextPressed.s = TextPressed$   
    
    _DRAWING = StartDrawing(CanvasOutput(GadgetID))
    ;DrawingMode(#PB_2DDrawing_AlphaBlend)    
    Box(0, 0, GadgetWidth(GadgetID), GadgetHeight(GadgetID), *GadgetEx\FACE)
    DrawingMode(#PB_2DDrawing_AlphaBlend)
    DrawImage(ImageID(ImageNormal), 0, 0)
    
    SetGadgetTextEx(_DRAWING,Width,Height,*GadgetEx\TextNormal.s)  
    StopDrawing()
EndProcedure
; IDE Options = PureBasic 5.21 LTS (Windows - x64)
; CursorPosition = 124
; FirstLine = 84
; Folding = --
; EnableAsm
; EnableUnicode
; EnableXP
; UseMainFile = 7z_Main_Source.pb
; CurrentDirectory = Release\