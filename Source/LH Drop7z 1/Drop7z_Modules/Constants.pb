DeclareModule DC

    Debug ""        
    Debug "Enumeration Drop 7z"  
    ;////////////////////////////////////////////////////////////////////////////////////////////////////////// Reserved Classes
    ;
    ;   Constants: Windows 1-10
    
        Enumeration 01 Step 1
            #_Window_001: #_Window_002: #_Window_003: #_Window_004: #_Window_005
        
        EndEnumeration
    
        Enums =  20 - #PB_Compiler_EnumerationValue
        
      
        Debug "Enumeration = 001 -> 0" + #PB_Compiler_EnumerationValue +" /Max: 020 /Free: "+Str(Enums)+" (Windows)"
        
    ;////////////////////////////////////////////////////////////////////////////////////////////////////////// Reserved Classes
    ;
    ;   Constants: Dateien
        
         Enumeration 21 Step 1
            #_FileConfig: #_FileHistory: #_FileProfiles: #_TempFile: #_DefaultFile: #_LinkLibrary: #CUEFILE: #MisMatch
        
        EndEnumeration
    
        Enums =  40 - #PB_Compiler_EnumerationValue
        Debug "Enumeration = 021 -> " + #PB_Compiler_EnumerationValue +" /Max: 040 /Free: "+Str(Enums)+" (Dateien)"
        
        
    ;////////////////////////////////////////////////////////////////////////////////////////////////////////// Reserved Classes
    ;
    ;   Constants: ListIcon
        
         Enumeration 41 Step 1
            #ListIcon_001: #ListIcon_002
        
        EndEnumeration
    
        Enums =  70 - #PB_Compiler_EnumerationValue
        Debug "Enumeration = 041 -> " + #PB_Compiler_EnumerationValue +" /Max: 070 /Free: "+Str(Enums)+" (ListIcon Gadget)"  
        
    ;////////////////////////////////////////////////////////////////////////////////////////////////////////// Reserved Classes
    ;
    ;   Constants: ProgressBar
        
         Enumeration 71 Step 1
            #Progress_001
        
        EndEnumeration
    
        Enums =  90 - #PB_Compiler_EnumerationValue
        Debug "Enumeration = 090 -> " + #PB_Compiler_EnumerationValue +" /Max: 090 /Free: "+Str(Enums)+" (ProgressBar Gadget)"          
        
    ;////////////////////////////////////////////////////////////////////////////////////////////////////////// Reserved Classes
    ;
    ;   Constants: ImageGadget
        
         Enumeration 91 Step 1
            #ImageGadget_001: #ImageGadget_002: #ImageGadget_003
        
        EndEnumeration
    
        Enums =  120 - #PB_Compiler_EnumerationValue
        Debug "Enumeration = 091 -> " + #PB_Compiler_EnumerationValue +" /Max: 120 /Free: "+Str(Enums)+" (ImageGadget Gadgets)" 
        
     ;////////////////////////////////////////////////////////////////////////////////////////////////////////// Reserved Classes
     ;
     ;   Constants: Scrollarea
        
         Enumeration 121 Step 1
            #ScrollArea_001: #ScrollArea_002
        
        EndEnumeration
    
        Enums =  140 - #PB_Compiler_EnumerationValue
        Debug "Enumeration = 121 -> " + #PB_Compiler_EnumerationValue +" /Max: 140 /Free: "+Str(Enums)+" (ScrollArea Gadgets)" 
        
     ;////////////////////////////////////////////////////////////////////////////////////////////////////////// Reserved Classes
     ;
     ;   Constants: Strings
        
         Enumeration 141 Step 1
            #String_001: #String_002: #String_003: #String_004: #String_005: #String_006
        
        EndEnumeration
    
        Enums =  599 - #PB_Compiler_EnumerationValue
        Debug "Enumeration = 141 -> " + #PB_Compiler_EnumerationValue +" /Max: 599 /Free: "+Str(Enums)+" (String Gadgets) > Modul: Mouse Curosr Enmumeration"          
        
     ;////////////////////////////////////////////////////////////////////////////////////////////////////////// Reserved Classes
    ;
    ;   Constants: Buttons
        
         Enumeration 611 Step 1
             #Button_001: #Button_002: #Button_003: #Button_004: #Button_005: #Button_006: #Button_007: #Button_008: #Button_009
             #Button_010: #Button_011: #Button_012: #Button_013: #Button_014: #Button_015: #Button_016: #Button_017
        
        EndEnumeration
    
        Enums =  959 - #PB_Compiler_EnumerationValue
        Debug "Enumeration = 611 -> " + #PB_Compiler_EnumerationValue +" /Max: 959 /Free: "+Str(Enums)+" (Button Gadgets) > Modul: GadgetEX/RequestEX Enumeration" 
        
    ;////////////////////////////////////////////////////////////////////////////////////////////////////////// Reserved Classes
    ;
    ;   Constants: ComboBox
        
         Enumeration 1001 Step 1
             #ComboBox_001: #ComboBox_002: #ComboBox_003: #ComboBox_004: #ComboBox_005: #ComboBox_006: #ComboBox_007: #ComboBox_008
             #ComboBox_009: #ComboBox_010: #ComboBox_011
        EndEnumeration
    
        Enums =  1300 - #PB_Compiler_EnumerationValue
        Debug "Enumeration = 1001 -> " + #PB_Compiler_EnumerationValue +" /Max: 1300 /Free: "+Str(Enums)+" (ComboBox Gadget)"    
        
    ;////////////////////////////////////////////////////////////////////////////////////////////////////////// Reserved Classes
    ;
    ;   Constants: CheckBox
        
         Enumeration 1301 Step 1
             #CheckBox_001: #CheckBox_002: #CheckBox_003: #CheckBox_004: #CheckBox_005
        EndEnumeration
    
        Enums =  1600 - #PB_Compiler_EnumerationValue
        Debug "Enumeration = 1301 -> " + #PB_Compiler_EnumerationValue +" /Max: 1600 /Free: "+Str(Enums)+" (CheckBox Gadget)"  
        
        
    ;////////////////////////////////////////////////////////////////////////////////////////////////////////// Reserved Classes
    ;
    ;   Constants: Text Gadget
        
         Enumeration 1601 Step 1
             #Text_001: #Text_002: #Text_003: #Text_004: #Text_005: #Text_006: #Text_007: #Text_008: #Text_009: #Text_010
             #Text_011: #Text_012: #Text_013: #Text_014: #Text_015: #Text_016: #Text_017: #Text_018: #Text_019
             
             ; CHD Window
             #Text_021: #Text_022: #Text_023: #Text_024
             
        EndEnumeration
    
        Enums =  2100 - #PB_Compiler_EnumerationValue
        Debug "Enumeration = 1601 -> " + #PB_Compiler_EnumerationValue +" /Max: 2100 /Free: "+Str(Enums)+" (Text Gadget)"  
        
    ;////////////////////////////////////////////////////////////////////////////////////////////////////////// Reserved Classes
    ;
    ;   Constants: Frame Gadget
        
         Enumeration 2101 Step 1
             #Frame_001: #Frame_002: #Frame_003: #Frame_004: #Frame_005: #Frame_006: #Frame_007
        EndEnumeration
    
        Enums =  2150 - #PB_Compiler_EnumerationValue
        Debug "Enumeration = 2101 -> " + #PB_Compiler_EnumerationValue +" /Max: 2150 /Free: "+Str(Enums)+" (Frame Gadget)"         
        
    ;////////////////////////////////////////////////////////////////////////////////////////////////////////// Reserved Classes
    ;
    ;   Constants: Tray/PopUpMenu
        
         Enumeration 2151 Step 1
             #PopUpMenu_001: #PopUpMenu_002
        EndEnumeration
    
        Enums =  2200 - #PB_Compiler_EnumerationValue
        Debug "Enumeration = 2151 -> " + #PB_Compiler_EnumerationValue +" /Max: 2200 /Free: "+Str(Enums)+" (Tray/PopUpMenu Gadget)"   
        
    ;////////////////////////////////////////////////////////////////////////////////////////////////////////// Reserved Classes
    ;
    ;   Constants: Background Images
        
         Enumeration 2201 Step 1
             #SkinBase_001: #SkinBase_002
        EndEnumeration
    
        Enums =  2400 - #PB_Compiler_EnumerationValue
        Debug "Enumeration = 2201 -> " + #PB_Compiler_EnumerationValue +" /Max: 2400 /Free: "+Str(Enums)+" (Background Images)"   
        
    ;////////////////////////////////////////////////////////////////////////////////////////////////////////// Reserved Classes
    ;
    ;   Constants: Canvas Gadgets
        
         Enumeration 2401 Step 1
             #SkinCvas_001: #SkinCvas_002
        EndEnumeration
    
        Enums =  2600 - #PB_Compiler_EnumerationValue
        Debug "Enumeration = 2401 -> " + #PB_Compiler_EnumerationValue +" /Max: 2600 /Free: "+Str(Enums)+" (Canvas Gadget)"  
        
    ;////////////////////////////////////////////////////////////////////////////////////////////////////////// Reserved Classes
    ;
    ;   Constants: Icons
        
         Enumeration 2601 Step 1
             #Icon_001
        EndEnumeration
    
        Enums =  2800 - #PB_Compiler_EnumerationValue
        Debug "Enumeration = 2601 -> " + #PB_Compiler_EnumerationValue +" /Max: 2800 /Free: "+Str(Enums)+" (Icons)"  
        
    ;////////////////////////////////////////////////////////////////////////////////////////////////////////// Reserved Classes
    ;
    ;   Constants: Buttons For GadgetEX (Seperate)
        
         Enumeration 2801 Step 1
             #_BTN_GREY4_0N: #_BTN_GREY4_0H: #_BTN_GREY4_0P: #_BTN_GREY4_0D 
             #_BTN_GREY5_0N: #_BTN_GREY5_0H: #_BTN_GREY5_0P: #_BTN_GREY5_0D
             #_BTN_GREY1_1N: #_BTN_GREY1_1H: #_BTN_GREY1_1P: #_BTN_GREY1_1D ;Color 160,160,164
        EndEnumeration
    
        Enums =  3100 - #PB_Compiler_EnumerationValue
        Debug "Enumeration = 2801 -> " + #PB_Compiler_EnumerationValue +" /Max: 3100 /Free: "+Str(Enums)+" (Buttons For GadgetEX (Seperate))" 
        
    ;////////////////////////////////////////////////////////////////////////////////////////////////////////// Reserved Classes
    ;
    ;   Constants: Container
        
         Enumeration 3101 Step 1
             #Contain_001: #ImageBlank: #LOGFILE: 
        EndEnumeration
    
        Enums =  3150 - #PB_Compiler_EnumerationValue
        Debug "Enumeration = 3101 -> " + #PB_Compiler_EnumerationValue +" /Max: 3150 /Free: "+Str(Enums)+" (Container Gadgets)"  
        
    EndDeclareModule
    Module DC
    EndModule
; IDE Options = PureBasic 5.73 LTS (Windows - x64)
; CursorPosition = 84
; FirstLine = 64
; Folding = -
; EnableAsm
; EnableXP
; EnableUnicode