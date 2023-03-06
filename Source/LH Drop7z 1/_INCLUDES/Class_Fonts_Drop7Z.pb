DeclareModule Fonts
	
	Declare 	CatchFont(*Memory, myMemSize)
	Declare.i	InternalFontLoad(SelectFont.i, PbEnumFontID.l, szFontName.s, FontSize.i )
	; Reserved Classes
	;
	; Fonts  700 - 740
	Enumeration 2201 Step 1
		#_FIXPLAIN7_12
		#_DEJAVU_08
		#_XBOXBOOK_09
		#_SEGOEUI08N
		#_SEGOEUI09N
		#_SEGOEUI10N
	EndEnumeration
	
	Enums =  2201 - #PB_Compiler_EnumerationValue
	Debug "Enumeration = 700 -> " + #PB_Compiler_EnumerationValue +" /Max: 2401 /Free: "+Str(Enums)+" (Fonts)" 
	

	
EndDeclareModule

Module Fonts
	
	
	IncludePath "..\..\INCLUDES\_FONTS_EMBEDDED\"
	
	;
	;
	;
	DataSection
		beg_Fixplain7:
		IncludeBinary "FIXPLAIN7.FON"
		end_Fixplain7: 
		
		beg_PlApple:
		IncludeBinary "PLAPPLE.FON";"DEJAVUSANS.TTF"
		end_PlApple: 
		
		beg_XboxBook:
		IncludeBinary "XBOXBOOK.TTF"
		end_XboxBook: 						
	EndDataSection
	
	;
	;
	; Code to Catch Fonts
	Procedure CatchFont(*Memory, myMemSize)
		;
		;
		; load font into memory
		Protected myParam1 = 1
		ProcedureReturn AddFontMemResourceEx_(*Memory, myMemSize, 0, @myParam1)
	EndProcedure
	
	;
	;
	; Code to Catch Fonts
	Procedure.i InternalFontLoad(SelectFont.i, PbEnumFontID.l, szFontName.s, FontSize.i )
		
		Define hMemFont
		Select SelectFont
			Case 1; Fixplain (Amiga)
				hMemFont = Fonts::CatchFont(?beg_Fixplain7, ?end_Fixplain7 - ?beg_Fixplain7) 
				
			Case 2; Pl Apple (Amiga)
				hMemFont = Fonts::CatchFont(?beg_PlApple  , ?end_PlApple   - ?beg_PlApple) 
				
			Case 3; XboxBook (? ...)	
				hMemFont = Fonts::CatchFont(?beg_XboxBook , ?end_XboxBook  - ?beg_XboxBook) 
		EndSelect
		
		ProcedureReturn LoadFont( PbEnumFontID, szFontName, FontSize, #PB_Font_HighQuality )
				
	EndProcedure	
EndModule


	Global FontID_FIXPLAIN7_12 = Fonts::InternalFontLoad(1, Fonts::#_FIXPLAIN7_12,"fixplain7 12",12)
	Global FontID_DEJAVU_08    = Fonts::InternalFontLoad(2, Fonts::#_DEJAVU_08   ,"PL_APPLE 13"    ,12) 
      Global FontID_XBOXBOOK_09  = Fonts::InternalFontLoad(3, Fonts::#_XBOXBOOK_09 ,"Xbox Book"   ,09)	
	;
	;
	; Windows Standard Fonts 
	Global FontID_SEGOEUI08N   = LoadFont(Fonts::#_SEGOEUI08N,"Segoe UI", 08)        
	Global FontID_SEGOEUI09N   = LoadFont(Fonts::#_SEGOEUI09N,"Segoe UI", 09)     
	Global FontID_SEGOEUI10N   = LoadFont(Fonts::#_SEGOEUI10N,"Segoe UI", 10)	
; IDE Options = PureBasic 5.73 LTS (Windows - x64)
; CursorPosition = 81
; FirstLine = 4
; Folding = -
; EnableXP
; EnableUnicode