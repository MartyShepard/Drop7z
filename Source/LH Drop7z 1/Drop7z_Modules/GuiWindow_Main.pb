DeclareModule GUI00
	
	Declare OpenWin(x = 0, y = 0, width = 494, height = 472)
	Declare MakeWin()
EndDeclareModule

DeclareModule GUI04   
	Declare ConsoleWindow()
EndDeclareModule

Module GUI00
	
	Prototype.l NoBorder(Gadget.l, String_1.p-unicode,String_2.p-unicode)

	;
	;
	;
	Procedure OpenWin(x = 0, y = 0, width = 494, height = 472)
		OpenWindow(DC::#_Window_001, x, y, width, height, CFG::*Config\WindowTitle.s, #PB_Window_SystemMenu | #PB_Window_Invisible | #PB_Window_ScreenCentered)
	EndProcedure
	
	
	;
	;
	;
	Procedure MakeWin()
		ImageGadget(DC::#ImageGadget_002,0, 0, 495, 472,ImageID(DC::#SkinBase_001))
		DisableGadget(DC::#ImageGadget_002, #True)
		
		PackFormat$ = DropCode::GetArchivFormat()
		
		TextGadget(DC::#Frame_006, 336, 13, 146, 12, ReplaceString(PackFormat$, Left(PackFormat$, 3) ,UCase( Left(PackFormat$, 3) ) ,0,1,1), #PB_Text_Right); Alt
		
		SetGadgetColor(DC::#Frame_006, #PB_Gadget_FrontColor,RGB(0 , 175, 255))
		SetGadgetColor(DC::#Frame_006, #PB_Gadget_BackColor, RGB(82,  82,  82))
		SetGadgetFont(DC::#Frame_006, FontID(Fonts::#_FIXPLAIN7_12))
		
		
		TextGadget(DC::#Frame_007, 373, 83, 110, 12,  DropLang::GetUIText(5), #PB_Text_Right)    	    
		SetGadgetColor(DC::#Frame_007, #PB_Gadget_FrontColor,RGB(0, 175, 255))
		SetGadgetColor(DC::#Frame_007, #PB_Gadget_BackColor,RGB(82,82,82))
		SetGadgetFont(DC::#Frame_007, FontID(Fonts::#_FIXPLAIN7_12))
		
		TextGadget(DC::#Text_008, 18, 180, 108, 18, "Compression")
		SetGadgetFont(DC::#Text_008, FontID(Fonts::#_SEGOEUI10N))
		TextGadget(DC::#Text_006, 18, 207, 110, 18, "Dictionary Size")        
		SetGadgetFont(DC::#Text_006, FontID(Fonts::#_SEGOEUI10N))
		TextGadget(DC::#Text_004, 18, 234, 108, 18, "Word Size")
		SetGadgetFont(DC::#Text_004, FontID(Fonts::#_SEGOEUI10N))
		TextGadget(DC::#Text_005, 18, 261, 108, 18, "Solid Block Size")
		SetGadgetFont(DC::#Text_005, FontID(Fonts::#_SEGOEUI10N))
		TextGadget(DC::#Text_007, 34, 340, 162, 18, "Encryption Password")
		SetGadgetFont(DC::#Text_007, FontID(Fonts::#_SEGOEUI10N))
		TextGadget(DC::#Text_009, 18, 290, 108, 18, "Split Archives")
		SetGadgetFont(DC::#Text_009, FontID(Fonts::#_SEGOEUI10N))  
		
		;
		; Grösse
		TextGadget(DC::#Text_002, 208, 140, 280, 14,"" )
		SetGadgetFont(DC::#Text_002, FontID(Fonts::#_FIXPLAIN7_12))
		SetGadgetColor(DC::#Text_002, #PB_Gadget_BackColor,RGB(82,82,82))
		SetGadgetColor(DC::#Text_002, #PB_Gadget_FrontColor,RGB(225,225,226)) 
		
		;
		; Profile Namen
		TextGadget(DC::#Text_003, 15, 140, 193, 14, DropLang::GetUIText(13) )
		GadgetToolTip(DC::#Text_003, DropLang::GetUIText(14) )
		SetGadgetFont(DC::#Text_003, FontID(Fonts::#_FIXPLAIN7_12))
		SetGadgetColor(DC::#Text_003, #PB_Gadget_BackColor,RGB(82,82,82))
		SetGadgetColor(DC::#Text_003, #PB_Gadget_FrontColor,RGB(225,225,226))
		
		;
		; Dateiname Im Hintegrund wenn Drop7z am Packen ist
		TextGadget(DC::#String_005,94, 28, 394, 17, "")
		SetGadgetColor(DC::#String_005, #PB_Gadget_FrontColor,RGB(0, 175, 255))
		SetGadgetColor(DC::#String_005, #PB_Gadget_BackColor,RGB(82,82,82))
		SetGadgetFont(DC::#String_005, FontID(Fonts::#_SEGOEUI10N))     	
		HideGadget(DC::#String_005,1)
		
		
		;
		; String für die Dateinamen
		StringGadget(DC::#String_001, 90, 28, 398, 17, "", #PB_String_BorderLess)
		SetGadgetColor(DC::#String_001, #PB_Gadget_BackColor,RGB(82,82,82))
		SetGadgetColor(DC::#String_001, #PB_Gadget_FrontColor,RGB(225,225,226))
		SetGadgetFont(DC::#String_001, FontID(Fonts::#_SEGOEUI10N))   
		;
		; Modified String Gadget as Combox
		ComboBoxGadget(DC::#String_002, 67, 100, 415, 24, #CBS_SORT|#PB_ComboBox_Editable)
		SetGadgetFont(DC::#String_002, FontID(Fonts::#_SEGOEUI10N))  
	
		StringGadget(DC::#String_003, 18, 357, 166, 19, ""); Password
		SetGadgetFont(DC::#String_003, FontID(Fonts::#_SEGOEUI09N))
		
		ComboBoxGadget(DC::#ComboBox_005, 122, 177, 68, 22)
		SetGadgetFont(DC::#ComboBox_005, FontID(Fonts::#_SEGOEUI09N)); Compression
		
		ComboBoxGadget(DC::#ComboBox_001, 122, 204, 68, 22)
		SetGadgetFont(DC::#ComboBox_001, FontID(Fonts::#_SEGOEUI09N)) ;Dictioniary
		
		ComboBoxGadget(DC::#ComboBox_002, 122, 231, 68, 22)
		SetGadgetFont(DC::#ComboBox_002, FontID(Fonts::#_SEGOEUI09N)); Wordsize
		
		ComboBoxGadget(DC::#ComboBox_003, 122, 258, 68, 22)
		SetGadgetFont(DC::#ComboBox_003, FontID(Fonts::#_SEGOEUI09N)); Blocksize
		
		ComboBoxGadget(DC::#ComboBox_004, 122, 287, 68, 22, #PB_ComboBox_Editable)
		GadgetToolTip(DC::#ComboBox_004, DropLang::GetUIText(6) )
		SetGadgetFont(DC::#ComboBox_004, FontID(Fonts::#_SEGOEUI09N))
		
		
		
		CheckBoxGadget(DC::#CheckBox_001, 17, 321, 129, 18, "Encrypt Filenames")
		GadgetToolTip(DC::#CheckBox_001, DropLang::GetUIText(7) )   
		SetGadgetFont(DC::#CheckBox_001, FontID(Fonts::#_SEGOEUI10N))
		
		
		CheckBoxGadget(DC::#CheckBox_002, 17, 386, 79, 18, "Verify")    
		GadgetToolTip(DC::#CheckBox_002, DropLang::GetUIText(8) )
		SetGadgetFont(DC::#CheckBox_002, FontID(Fonts::#_SEGOEUI10N))    
		
		CheckBoxGadget(DC::#CheckBox_003, 103, 386, 79, 18, "Open Files")
		GadgetToolTip(DC::#CheckBox_003, DropLang::GetUIText(9) )
		SetGadgetFont(DC::#CheckBox_003, FontID(Fonts::#_SEGOEUI10N))
		
		CheckBoxGadget(DC::#CheckBox_004, 17, 407, 79, 18, "Send Mail")    
		GadgetToolTip(DC::#CheckBox_004, DropLang::GetUIText(10) )
		SetGadgetFont(DC::#CheckBox_004, FontID(Fonts::#_SEGOEUI10N))
		
		CheckBoxGadget(DC::#CheckBox_005, 103, 407, 79, 18, "Self Extract")    
		GadgetToolTip(DC::#CheckBox_005, DropLang::GetUIText(11) )
		SetGadgetFont(DC::#CheckBox_005, FontID(Fonts::#_SEGOEUI10N))            
		
		ListIconGadget(DC::#ListIcon_001, 208, 166, 280, 264, "", 100, #PB_ListIcon_CheckBoxes | #PB_ListIcon_MultiSelect | #PB_ListIcon_FullRowSelect)
		SetGadgetColor(DC::#ListIcon_001, #PB_Gadget_BackColor,RGB(160,160,160))
		SetGadgetFont(DC::#ListIcon_001, FontID(Fonts::#_SEGOEUI08N))
		SendMessage_(GadgetID(DC::#ListIcon_001),#LVM_SETEXTENDEDLISTVIEWSTYLE,0,#LVS_EX_LABELTIP|#LVS_EX_CHECKBOXES)
		
		ImageGadget(DC::#Button_007, 23, 3, 52, 51, ImageID(DC::#Icon_001))
		GadgetToolTip(DC::#Button_007, "..HM?")
		
		ProgressBarGadget(DC::#Progress_001, 5, 64, 484, 10, 0, 0)
		
		;///////////// Compress Single
		
		Protected  nCurrentFontID.l = Fonts::#_FIXPLAIN7_12
		ButtonEX::Add(DC::#Button_006,105, 442, 83, 20, 
		              DC::#_BTN_GREY4_0N, 
		              DC::#_BTN_GREY4_0H, 
		              DC::#_BTN_GREY4_0P,
		              DC::#_BTN_GREY4_0D,"Single", "Compress", "Compress",GetSysColor_(#COLOR_3DFACE),$29D7DA,nCurrentFontID)
		;ButtonEX::TooltTip(WindowID(DC::#_Window_001), DC::#Button_006, "Compress each Files & Folders IN a seperate Archiv","", 1,275)   
		
		;///////////// Compress Normal
		ButtonEX::Add(DC::#Button_003,12, 442, 83, 20, 
		              DC::#_BTN_GREY4_0N, 
		              DC::#_BTN_GREY4_0H, 
		              DC::#_BTN_GREY4_0P,
		              DC::#_BTN_GREY4_0D,"Standard", "Compress", "Compress",GetSysColor_(#COLOR_3DFACE),$29D7DA,nCurrentFontID)
		;ButtonEX::TooltTip(WindowID(DC::#_Window_001), DC::#Button_003, "",":.....Compress each Files & Folders in a seperate Archiv", 1,275)  
		
		;///////////// Clear List
		ButtonEX::Add(DC::#Button_002,210, 442, 83, 20,
		              DC::#_BTN_GREY4_0N,
		              DC::#_BTN_GREY4_0H,
		              DC::#_BTN_GREY4_0P,
		              ;DC::#_BTN_GREY4_0D,"Clear", "FileList", "FileList",GetSysColor_(#COLOR_3DFACE),$29D7DA,nCurrentFontID)
		DC::#_BTN_GREY4_0D,"Convert", "Archiv(e)", "Archiv(e)",GetSysColor_(#COLOR_3DFACE),$29D7DA,nCurrentFontID)
		;ButtonEX::TooltTip(WindowID(DC::#_Window_001), DC::#Button_002, "",":.....Clear the File List", 1,275) 
		
		;
		; Button Info
		If ( CFG::*Config\UnPackOnly = #True )
			ButtonEX::Settext(DC::#Button_002,0,"Unpack")
		Else
			ButtonEX::Settext(DC::#Button_002,0,"Convert")
		EndIf
		
		;///////////// Compress Profile
		ButtonEX::Add(DC::#Button_005,309, 442, 83, 20,
		              DC::#_BTN_GREY4_0N,
		              DC::#_BTN_GREY4_0H,
		              DC::#_BTN_GREY4_0P,
		              DC::#_BTN_GREY4_0D,"Profile", "Edit", "Edit",GetSysColor_(#COLOR_3DFACE),$29D7DA,nCurrentFontID)
		;ButtonEX::TooltTip(WindowID(DC::#_Window_001), DC::#Button_005, "","Open the Profile Window for Add or Edit Custom Settings", 1,275) 
		
		
		;//////////// Exit
		ButtonEX::Add(DC::#Button_001,404, 442, 83, 20,
		              DC::#_BTN_GREY4_0N, 
		              DC::#_BTN_GREY4_0H, 
		              DC::#_BTN_GREY4_0P,
		              DC::#_BTN_GREY4_0D,"Quit", "The Drop", "The Drop",GetSysColor_(#COLOR_3DFACE),$29D7DA,nCurrentFontID)
		;ButtonEX::TooltTip(WindowID(DC::#_Window_001), DC::#Button_001, "",":.....", 1,275)
		
		
		;
		; Verzeichnis Requester
		ButtonEX::Add(DC::#Button_004,13, 101, 54, 22,
		              DC::#_BTN_GREY5_0N, 
		              DC::#_BTN_GREY5_0H,
		              DC::#_BTN_GREY5_0P,
		              DC::#_BTN_GREY5_0D,"", "", "",GetSysColor_(#COLOR_3DFACE))
		
		
		GadgetToolTip(DC::#Button_003, "Komprimiere Standard als Archiv: 7Z, ZIP, CHD")
		GadgetToolTip(DC::#Button_006, "Massenkomprimierung als Einzelne Archive: 7Z, ZIP, CHD")
		GadgetToolTip(DC::#Button_002, "KPF, LZX (Amiga), PK3, PK4, RAR (VOL,SFX), TAR, TGZ, TSU, ZIP (SFX)")    	
		GadgetToolTip(DC::#String_002, "Zielverzeichnis. Gilt nur für das Packen/Komprimieren (Standard/Single).")
		GadgetToolTip(DC::#ListIcon_001, "Verzeichnis Datei Liste. Mehr Optionen gibt es über die Rechte Maustaste")
		SSTTIP::TooltTip(WindowID(DC::#_Window_001), DC::#Button_004, "Zielverzeichnis wählen ...","", 1,275) 
	EndProcedure
EndModule        

Module GUI04
	
	;
	;
	; Openwindow
	Procedure OpenWin(x = 0, y = 0, width = 300, height = 110)
		If (width = 0 And height = 0)
			OpenWindow(DC::#_Window_004, x, y, 300, 110, "",#PB_Window_BorderLess|#PB_Window_Invisible|#PB_Window_ScreenCentered)
			
		Else    
			OpenWindow(DC::#_Window_004, x, y, width, height, "",#PB_Window_BorderLess|#PB_Window_Invisible)
		EndIf
	EndProcedure  
	
	;
	;
	; Erstellung der GuiObjecte
	Procedure GuiObjects(ChangedX,ChangedY,WindowsX)
		
		OpenWin(ChangedX,ChangedY) 
		
		CanvasGadget(DC::#SkinCvas_002,0, 0, 300, 110)
		
		StartDrawing( CanvasOutput(DC::#SkinCvas_002) )
		DrawImage( ImageID(DC::#SkinBase_002), 0, 0)
		StopDrawing()
		
		DisableGadget(DC::#SkinCvas_002, #True)         
		
		ContainerGadget(DC::#Contain_001,10 ,50, 280, 35,#PB_Container_BorderLess )
		
		ListIconGadget(DC::#ListIcon_002, 0, 0, GadgetWidth(DC::#Contain_001), GadgetHeight(DC::#Contain_001) + GetSystemMetrics_(#SM_CYHSCROLL) + 1, "", 280, #PB_ListIcon_AlwaysShowSelection| #PB_ListIcon_FullRowSelect| #LVS_NOCOLUMNHEADER )
		
		SetGadgetFont (DC::#ListIcon_002, FontID(Fonts::#_DEJAVU_08) ) 
		SetGadgetColor(DC::#ListIcon_002, #PB_Gadget_FrontColor, RGBA(25, 136, 236, 0))             
		SetGadgetColor(DC::#ListIcon_002, #PB_Gadget_BackColor , RGBA(10, 10, 10, 0)) 
		
		SetWindowLongPtr_( GadgetID(DC::#ListIcon_002), #GWL_EXSTYLE,0 )
		
		SendMessage_( GadgetID(DC::#ListIcon_002), #LVM_SETEXTENDEDLISTVIEWSTYLE, 0, #LVS_EX_LABELTIP)  
		
		CloseGadgetList()
				
		FORM::TextObject(DC::#Text_019, 64,4,234, 14, FontID(Fonts::#_XBOXBOOK_09), RGB(225, 225, 226), RGB(102, 102, 102), "")
	EndProcedure  
	
	
	;
	;
	Procedure ConsoleWindow()
		
		Protected Primary_ScreenX, Primary_ScreenY, iTaskLeiste.l, ChangedX, ChangedY ,ToolWindowID.l, TB_TaskBar,TB___Start            
		
		If Transparenz.l < 1: Transparenz.l = 245: EndIf
		
		SystemParametersInfo_(#SPI_GETWORKAREA,0,@DesktopWorkArea.RECT,0)
		
		Primary_ScreenX = GetSystemMetrics_(#SM_CXSCREEN)
		
		ProcessEX::TaskListCreate(): iTaskLeiste.l = ProcessEX::TaskListGetPID("explorer.exe")
		If (iTaskLeiste.l <> 0)          
			Primary_ScreenY = GetSystemMetrics_(#SM_CYSCREEN)-DesktopWorkArea\Bottom
			Primary_ScreenY = GetSystemMetrics_(#SM_CYSCREEN)-Primary_ScreenY
			
			TB_TaskBar = FindWindow_("Shell_TrayWnd",0)
			TB___Start = FindWindow_(0,"Start")
			
			If Not (IsWindowVisible_(TB_TaskBar))
				Primary_ScreenY = GetSystemMetrics_(#SM_CYSCREEN)         
			EndIf              
		Else
			Primary_ScreenY = GetSystemMetrics_(#SM_CYSCREEN) 
		EndIf    
		
		OpenWin()
		WindowsX = WindowWidth(DC::#_Window_004): WindowsY = WindowHeight(DC::#_Window_004): CloseWindow(DC::#_Window_004)
		
		ChangedX = Primary_ScreenX-WindowsX-6: ChangedY = Primary_ScreenY-WindowsY-6  
		GuiObjects(ChangedX,ChangedY,WindowsX)
		
		SetWindowLongPtr_(WindowID(DC::#_Window_004),#GWL_EXSTYLE,GetWindowLongPtr_(WindowID(DC::#_Window_004),#GWL_EXSTYLE) | #WS_EX_LAYERED)
		SetLayeredWindowAttributes_(WindowID(DC::#_Window_004), 0,  Transparenz, #LWA_ALPHA) 
		
		
	EndProcedure  
EndModule

; IDE Options = PureBasic 5.73 LTS (Windows - x64)
; CursorPosition = 88
; FirstLine = 45
; Folding = --
; EnableAsm
; EnableXP
; UseMainFile = ..\Drop7z.pb
; CurrentDirectory = ..\Drop7z\
; EnableUnicode