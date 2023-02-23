

  ;////////////////////////////////////////////////////////////////////////////////////////////////////////////FONTLISTE


  DataSection
;       BEG_ATOPAZ:
;         IncludeBinary "..\LH_Game_Start_HYBRID\Fonts_Embedded\ATOPAZ.FON"
;       END_ATOPAZ:

;       BEG_DEJAVUSANS:
;         IncludeBinary "..\LH_Game_Start_HYBRID\Fonts_Embedded\DEJAVUSANS.TTF"    
;       END_DEJAVUSANS: 

;       BEG_DIGITAL7:
;         IncludeBinary "..\LH_Game_Start_HYBRID\Fonts_Embedded\DIGITAL7.TTF"
;       END_DIGITAL7:

      BEG_FIXPLAIN7:
        IncludeBinary "..\..\LH Game Start\INCLUDES_CLS\_FONTS_EMBEDDED\FIXPLAIN7.FON"
      END_FIXPLAIN7:

;       BEG_LIBERATIONSANSR:
;         IncludeBinary "..\LH_Game_Start_HYBRID\Fonts_Embedded\LIBERATIONSANSR.TTF"  
;       END_LIBERATIONSANSR:
; 
;       BEG_LIBERATIONMONOR:
;         IncludeBinary "..\LH_Game_Start_HYBRID\Fonts_Embedded\LIBERATIONMONOR.TTF" 
;       END_LIBERATIONMONOR:

;       BEG_XBOXBOOK:
;         IncludeBinary "..\LH_Game_Start_HYBRID\Fonts_Embedded\XBOXBOOK.TTF"  
;       END_XBOXBOOK:
      
      BEG_DROIDSANS:
        IncludeBinary "..\..\LH Game Start\INCLUDES_CLS\_FONTS_EMBEDDED\DROIDSANS.TTF"  
      END_DROIDSANS:
      
      BEG_DROIDMONO:
        IncludeBinary "..\..\LH Game Start\INCLUDES_CLS\_FONTS_EMBEDDED\DROIDSANSMONO.TTF"  
      END_DROIDMONO:
      
;       BEG_EUROSTILE:
;         IncludeBinary "..\LH_Game_Start_HYBRID\Fonts_Embedded\EUROSTILE.TTF"  
;       END_EUROSTILE:

      BEG_PLAPPLE:
        IncludeBinary "..\..\LH Game Start\INCLUDES_CLS\_FONTS_EMBEDDED\PLAPPLE.FON"  
      END_PLAPPLE:

  EndDataSection

  
  AMREx$ = "1"
  OpenLibrary(0,"gdi32.dll")  
;     Global FontID_AMIGA             = CallFunction(0,"AddFontMemResourceEx",?BEG_ATOPAZ,?END_ATOPAZ-?BEG_ATOPAZ,0,@AMREx$)
    ;Global FontID_DEJAVU            = CallFunction(0,"AddFontMemResourceEx",?BEG_DEJAVUSANS,?END_DEJAVUSANS-?BEG_DEJAVUSANS,0,@AMREx$)
;     Global FontID_DIGITAL7          = CallFunction(0,"AddFontMemResourceEx",?BEG_DIGITAL7,?END_DIGITAL7-?BEG_DIGITAL7,0,@AMREx$)
    Global FontID_FIXPLAIN7         = CallFunction(0,"AddFontMemResourceEx",?BEG_FIXPLAIN7,?END_FIXPLAIN7-?BEG_FIXPLAIN7,0,@AMREx$)
    ;Global FontID_LIBERATIONSANSR   = CallFunction(0,"AddFontMemResourceEx",?BEG_LIBERATIONSANSR,?END_LIBERATIONSANSR-?BEG_LIBERATIONSANSR,0,@AMREx$)
    ;Global FontID_LIBERATIONMONOR   = CallFunction(0,"AddFontMemResourceEx",?BEG_LIBERATIONMONOR,?END_LIBERATIONMONOR-?BEG_LIBERATIONMONOR,0,@AMREx$)
    ;Global FontID_XBOXBOOK          = CallFunction(0,"AddFontMemResourceEx",?BEG_XBOXBOOK,?END_XBOXBOOK-?BEG_XBOXBOOK,0,@AMREx$)
    Global FontID_DROIDSANS         = CallFunction(0,"AddFontMemResourceEx",?BEG_DROIDSANS,?END_DROIDSANS-?BEG_DROIDSANS,0,@AMREx$)
    Global FontID_DROIDMONO         = CallFunction(0,"AddFontMemResourceEx",?BEG_DROIDMONO,?END_DROIDMONO-?BEG_DROIDMONO,0,@AMREx$)
    ;Global FontID_EUROSTILE         = CallFunction(0,"AddFontMemResourceEx",?BEG_EUROSTILE,?END_EUROSTILE-?BEG_EUROSTILE,0,@AMREx$)
;     Global FontID_PLAPPLE           = CallFunction(0,"AddFontMemResourceEx",?BEG_PLAPPLE,?END_PLAPPLE-?BEG_PLAPPLE,0,@AMREx$)
  CloseLibrary(0)  
      
;     Global FontID_AMIGA_12      =LoadFont(#PB_Any,"Amiga Topaz  /ck!",12)
;     Global FontID_DIGITAL7_12   =LoadFont(#PB_Any,"Digital-7",12)
    Global FontID_FIXPLAIN7_12  =LoadFont(#PB_Any,"fixplain7 12",12)
;     Global FontID_PLAPPLE_13  =LoadFont(#PB_Any,"PL_Apple 13",13)

;     Global FontID_XBOXBOOK_08  =LoadFont(#PB_Any,"Xbox Book",08)
;     Global FontID_XBOXBOOK_09  =LoadFont(#PB_Any,"Xbox Book",09)
;     Global FontID_XBOXBOOK_10  =LoadFont(#PB_Any,"Xbox Book",10)
   
    Global FontID_DROIDSANS_08  =LoadFont(#PB_Any,"Droid Sans",08)
    Global FontID_DROIDSANS_09  =LoadFont(#PB_Any,"Droid Sans",09)
    Global FontID_DROIDSANS_10  =LoadFont(#PB_Any,"Droid Sans",10)

    Global FontID_DROIDMONO_08  =LoadFont(#PB_Any,"Droid Mono",08)
    Global FontID_DROIDMONO_09  =LoadFont(#PB_Any,"Droid Mono",09)
    Global FontID_DROIDMONO_10  =LoadFont(#PB_Any,"Droid Mono",10)

;     Global FontID_DEJAVU_08     =LoadFont(#PB_Any,"DejaVu Sans",08)    
;     Global FontID_DEJAVU_09     =LoadFont(#PB_Any,"DejaVu Sans",09)
;     Global FontID_DEJAVU_10     =LoadFont(#PB_Any,"DejaVu Sans",10)

;     Global FontID_LIBSANSR_08   =LoadFont(#PB_Any,"Liberation Sans",08)
;     Global FontID_LIBSANSR_09   =LoadFont(#PB_Any,"Liberation Sans",09)
;     Global FontID_LIBSANSR_10   =LoadFont(#PB_Any,"Liberation Sans",10)    

;     Global FontID_LIBMONOR_08   =LoadFont(#PB_Any,"Liberation Mono",08)
;     Global FontID_LIBMONOR_09   =LoadFont(#PB_Any,"Liberation Mono",09)
;     Global FontID_LIBMONOR_10   =LoadFont(#PB_Any,"Liberation Mono",10)
    
;     Global FontID_EUROSTILE_12 =LoadFont(#PB_Any,"Eurostile",12)
    
    ; Windows Standard
    Global FontID_SUIMONO_08    =LoadFont(#PB_Any,"Segoe UI Mono", 8)
    Global FontID_SEGOEUI09N    =LoadFont(#PB_Any,"Segoe UI", 09)
    Global FontID_SEGOEUI10N    =LoadFont(#PB_Any,"Segoe UI", 10)
    Global FontID_SEGOEUI11N    =LoadFont(#PB_Any,"Segoe UI", 11)
    Global FontID_SEGOEUI09B    =LoadFont(#PB_Any,"Segoe UI", 09,#PB_Font_Bold)
    Global FontID_SEGOEUI10B    =LoadFont(#PB_Any,"Segoe UI", 10,#PB_Font_Bold)
    Global FontID_SEGOEUI11B    =LoadFont(#PB_Any,"Segoe UI", 11,#PB_Font_Bold)    
                      

; IDE Options = PureBasic 5.30 (Windows - x64)
; CursorPosition = 47
; FirstLine = 19
; EnableUnicode
; EnableXP
; UseMainFile = ..\7z_Main_Source.pb
; CurrentDirectory = ..\Release\