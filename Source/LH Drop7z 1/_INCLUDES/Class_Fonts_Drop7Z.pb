﻿DeclareModule Fonts
;////////////////////////////////////////////////////////////////////////////////////////////////////////// Reserved Classes
;
;   Fonts  700 - 740
Enumeration 2201 Step 1
    #_AMIGA_12      :#_DIGITAL7_12  :#_FIXPLAIN7_12 :#_PLAPPLE_13  :#_ABERDEEN_12 :#_THING_12
    #_XBOXBOOK_08   :#_XBOXBOOK_09  :#_XBOXBOOK_10  :#_XBOXBOOK_11
    #_DROIDSANS_08  :#_DROIDSANS_09 :#_DROIDSANS_10 :#_DROIDSANS_11:#_DROIDSANS_14:#_DROIDSANS_16
    #_DROIDSANSB16
    #_DROIDMONO_08  :#_DROIDMONO_09 :#_DROIDMONO_10 :#_DROIDMONO_11
    #_DEJAVU_08     :#_DEJAVU_09    :#_DEJAVU_10
    #_LIBSANSR_08   :#_LIBSANSR_09  :#_LIBSANSR_10
    #_LIBMONOR_08   :#_LIBMONOR_09  :#_LIBMONOR_10
    #_SEGOEUI08N    :#_SEGOEUI09N   :#_SEGOEUI10N   :#_SEGOEUI11N   
    #_SEGOEUI08B    :#_SEGOEUI09B   :#_SEGOEUI10B   :#_SEGOEUI11B
    #_SUIMONO_08    :#_SUIMONOB08: 
    #_EUROSTILE_12  :#_EUROSTILE_24 :#_EUROSTILE_28
EndEnumeration
Enums =  2201 - #PB_Compiler_EnumerationValue
Debug "Enumeration = 700 -> " + #PB_Compiler_EnumerationValue +" /Max: 2401 /Free: "+Str(Enums)+" (Fonts)" 
;////////////////////////////////////////////////////////////////////////////////////////////////////////////FONTLISTE

IncludePath "..\..\INCLUDES\_FONTS_EMBEDDED\"

 DataSection
;     BEG_ATOPAZ:
;     IncludeBinary "ATOPAZ.FON"
;     END_ATOPAZ:
;     
;     BEG_DEJAVUSANS:
;     IncludeBinary "DEJAVUSANS.TTF"    
;     END_DEJAVUSANS: 
;     
;     BEG_DIGITAL7:
;     IncludeBinary "DIGITAL7.TTF"
;     END_DIGITAL7:
;     
     BEG_FIXPLAIN7:
     IncludeBinary "FIXPLAIN7.FON"
     END_FIXPLAIN7:
;     
;     BEG_LIBERATIONSANSR:
;     IncludeBinary "LIBERATIONSANSR.TTF"  
;     END_LIBERATIONSANSR:
;     
;     BEG_LIBERATIONMONOR:
;     IncludeBinary "LIBERATIONMONOR.TTF" 
;     END_LIBERATIONMONOR:
;     
;     BEG_XBOXBOOK:
;     IncludeBinary "XBOXBOOK.TTF"  
;     END_XBOXBOOK:
;     
;     BEG_DROIDSANS:
;     IncludeBinary "DROIDSANS.TTF"  
;     END_DROIDSANS:
;     
;     BEG_DROIDMONO:
;     IncludeBinary "DROIDSANSMONO.TTF"  
;     END_DROIDMONO:
;     
;     BEG_EUROSTILE:
;     IncludeBinary "EUROSTILE.TTF"  
;     END_EUROSTILE:
;     
;     BEG_PLAPPLE:
;     IncludeBinary "PLAPPLE.FON"  
;     END_PLAPPLE:
;     
;     BEG_ABERDEEN:
;     IncludeBinary "ABERDEEN.FON"  
;     END_ABERDEEN:
;     
;     BEG_THING:
;     IncludeBinary "THING.FON"  
;     END_THING:
;     
 EndDataSection


; AMREx$ = "1"
; OpenLibrary(0,"gdi32.dll")  
;    Global FontID_AMIGA             = CallFunction(0,"AddFontMemResourceEx",?BEG_ATOPAZ,?END_ATOPAZ-?BEG_ATOPAZ,0,@AMREx$)
;    Global FontID_DEJAVU            = CallFunction(0,"AddFontMemResourceEx",?BEG_DEJAVUSANS,?END_DEJAVUSANS-?BEG_DEJAVUSANS,0,@AMREx$)
;    Global FontID_DIGITAL7          = CallFunction(0,"AddFontMemResourceEx",?BEG_DIGITAL7,?END_DIGITAL7-?BEG_DIGITAL7,0,@AMREx$)
     FontID_FIXPLAIN7         = CallFunction(0,"AddFontMemResourceEx",?BEG_FIXPLAIN7,?END_FIXPLAIN7-?BEG_FIXPLAIN7,0,@"1")
;    Global FontID_LIBERATIONSANSR   = CallFunction(0,"AddFontMemResourceEx",?BEG_LIBERATIONSANSR,?END_LIBERATIONSANSR-?BEG_LIBERATIONSANSR,0,@AMREx$)
;    Global FontID_LIBERATIONMONOR   = CallFunction(0,"AddFontMemResourceEx",?BEG_LIBERATIONMONOR,?END_LIBERATIONMONOR-?BEG_LIBERATIONMONOR,0,@AMREx$)
;    Global FontID_XBOXBOOK          = CallFunction(0,"AddFontMemResourceEx",?BEG_XBOXBOOK,?END_XBOXBOOK-?BEG_XBOXBOOK,0,@AMREx$)
;    Global FontID_DROIDSANS         = CallFunction(0,"AddFontMemResourceEx",?BEG_DROIDSANS,?END_DROIDSANS-?BEG_DROIDSANS,0,@AMREx$)
;    Global FontID_DROIDMONO         = CallFunction(0,"AddFontMemResourceEx",?BEG_DROIDMONO,?END_DROIDMONO-?BEG_DROIDMONO,0,@AMREx$)
;    Global FontID_EUROSTILE         = CallFunction(0,"AddFontMemResourceEx",?BEG_EUROSTILE,?END_EUROSTILE-?BEG_EUROSTILE,0,@AMREx$)
;    Global FontID_PLAPPLE           = CallFunction(0,"AddFontMemResourceEx",?BEG_PLAPPLE,?END_PLAPPLE-?BEG_PLAPPLE,0,@AMREx$)
;    Global FontID_ABERDEEN          = CallFunction(0,"AddFontMemResourceEx",?BEG_ABERDEEN,?END_ABERDEEN-?BEG_ABERDEEN,0,@AMREx$)    
;    Global FontID_THING             = CallFunction(0,"AddFontMemResourceEx",?BEG_THING,?END_THING-?BEG_THING,0,@AMREx$) 

; CloseLibrary(0)  

;     Global FontID_AMIGA_12          =LoadFont(#_AMIGA_12,"Amiga Topaz  /ck!",12)
;     Global FontID_DIGITAL7_12       =LoadFont(#_DIGITAL7_12,"Digital-7",12)
Global FontID_FIXPLAIN7_12      =LoadFont(#_FIXPLAIN7_12,"fixplain7 12",12,#PB_Font_HighQuality)
;    Global FontID_PLAPPLE_13        =LoadFont(#_PLAPPLE_13,"PL_Apple 13",13) 
;    Global FontID_ABERDEEN          =LoadFont(#_ABERDEEN_12,"Aberdeen 15",12) 
;    Global FontID_THING             =LoadFont(#_THING_12,"Xen 11",12)

Global FontID_XBOXBOOK_08       =LoadFont(#_XBOXBOOK_08,"Xbox Book",08,#PB_Font_HighQuality)
Global FontID_XBOXBOOK_09       =LoadFont(#_XBOXBOOK_09,"Xbox Book",09,#PB_Font_HighQuality)
Global FontID_XBOXBOOK_10       =LoadFont(#_XBOXBOOK_10,"Xbox Book",10,#PB_Font_HighQuality)
Global FontID_XBOXBOOK_11       =LoadFont(#_XBOXBOOK_11,"Xbox Book",11,#PB_Font_HighQuality)

;    Global FontID_DROIDSANS_08      =LoadFont(#_DROIDSANS_08 ,"Droid Sans",08,#PB_Font_HighQuality)
;    Global FontID_DROIDSANS_09      =LoadFont(#_DROIDSANS_09 ,"Droid Sans",09,#PB_Font_HighQuality)
Global FontID_DROIDSANS_10      =LoadFont(#_DROIDSANS_10 ,"Droid Sans",10,#PB_Font_HighQuality) 
Global FontID_DROIDSANS_11      =LoadFont(#_DROIDSANS_11 ,"Droid Sans",11,#PB_Font_HighQuality)
;     Global FontID_DROIDSANS_14      =LoadFont(#_DROIDSANS_14 ,"Droid Sans",14,#PB_Font_HighQuality)     
;     Global FontID_DROIDSANS_16      =LoadFont(#_DROIDSANS_16 ,"Droid Sans",16,#PB_Font_HighQuality) 
;     Global FontID_DROIDSANSB16      =LoadFont(#_DROIDSANSB16 ,"Droid Sans",16,#PB_Font_Bold|#PB_Font_HighQuality) 


Global FontID_DROIDMONO_08      =LoadFont(#_DROIDMONO_08,"Droid Mono",08,#PB_Font_HighQuality)
;     Global FontID_DROIDMONO_09      =LoadFont(#_DROIDMONO_09,"Droid Mono",09,#PB_Font_HighQuality)
;     Global FontID_DROIDMONO_10      =LoadFont(#_DROIDMONO_10,"Droid Mono",10,#PB_Font_HighQuality)
;     Global FontID_DROIDMONO_11      =LoadFont(#_DROIDMONO_11,"Droid Mono",11,#PB_Font_HighQuality)

Global FontID_DEJAVU_08         =LoadFont(#_DEJAVU_08,"DejaVu Sans",08)    
;     Global FontID_DEJAVU_09         =LoadFont(#_DEJAVU_09,"DejaVu Sans",09)
;     Global FontID_DEJAVU_10         =LoadFont(#_DEJAVU_10,"DejaVu Sans",10)

;     Global FontID_LIBSANSR_08       =LoadFont(#_LIBSANSR_08,"Liberation Sans",08)
;     Global FontID_LIBSANSR_09       =LoadFont(#_LIBSANSR_09,"Liberation Sans",09)
;     Global FontID_LIBSANSR_10       =LoadFont(#_LIBSANSR_10,"Liberation Sans",10)       

;     Global FontID_LIBMONOR_08       =LoadFont(#_LIBMONOR_08,"Liberation Mono",08)
;     Global FontID_LIBMONOR_09       =LoadFont(#_LIBMONOR_09,"Liberation Mono",09)
;     Global FontID_LIBMONOR_10       =LoadFont(#_LIBMONOR_10,"Liberation Mono",10)

;     Global FontID_EUROSTILE_12      =LoadFont(#_EUROSTILE_12,"Eurostile",12,#PB_Font_HighQuality)
;     Global FontID_EUROSTILE_24      =LoadFont(#_EUROSTILE_24,"Eurostile",24,#PB_Font_HighQuality)    
;     Global FontID_EUROSTILE_28      =LoadFont(#_EUROSTILE_28,"Eurostile",28,#PB_Font_HighQuality) 

; Windows Standard
Global FontID_SEGOEUI08N        =LoadFont(#_SEGOEUI08N,"Segoe UI", 08)        
Global FontID_SEGOEUI09N        =LoadFont(#_SEGOEUI09N,"Segoe UI", 09)     
Global FontID_SEGOEUI10N        =LoadFont(#_SEGOEUI10N,"Segoe UI", 10)
Global FontID_SEGOEUI11N        =LoadFont(#_SEGOEUI11N,"Segoe UI", 11)

;     Global FontID_SEGOEUI08B        =LoadFont(#_SEGOEUI08B,"Segoe UI", 08,#PB_Font_Bold|#PB_Font_HighQuality)    
;     Global FontID_SEGOEUI09B        =LoadFont(#_SEGOEUI09B,"Segoe UI", 09,#PB_Font_Bold|#PB_Font_HighQuality)
;     Global FontID_SEGOEUI10B        =LoadFont(#_SEGOEUI10B,"Segoe UI", 10,#PB_Font_Bold|#PB_Font_HighQuality)
;     Global FontID_SEGOEUI11B        =LoadFont(#_SEGOEUI11B,"Segoe UI", 11,#PB_Font_Bold|#PB_Font_HighQuality)    
;     
;     Global FontID_SUIMONO_08        =LoadFont(#_SUIMONO_08,"Segoe UI Mono", 8)
;     Global FontID_SUIMONOB08        =LoadFont(#_SUIMONOB08,"Segoe UI Mono", 8,#PB_Font_Bold)     

EndDeclareModule
Module Fonts
EndModule

   
; IDE Options = PureBasic 5.73 LTS (Windows - x64)
; CursorPosition = 144
; FirstLine = 93
; Folding = -
; EnableXP
; EnableUnicode