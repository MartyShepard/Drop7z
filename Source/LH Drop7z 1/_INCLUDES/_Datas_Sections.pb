
UsePNGImageDecoder()

DataSection    
	;//----------------------------------------------;Grey1 (Size 83x27)
	_BTN_GREY1_1N:
	IncludeBinary "..\_GUI_Images\BUTTONS\Grey1_Normal.png"
	_BTN_GREY1_1H:
	IncludeBinary "..\_GUI_Images\BUTTONS\Grey1_Hover.png"
	_BTN_GREY1_1P:
	IncludeBinary "..\_GUI_Images\BUTTONS\Grey1_Pressed.png"
	_BTN_GREY1_1D:
	IncludeBinary "..\_GUI_Images\BUTTONS\Grey1_Disabled.png"
	
	_BTN_GREY4_0N:
	IncludeBinary "..\_GUI_Images\BUTTONS\Grey4_Normal.png"
	_BTN_GREY4_0H:
	IncludeBinary "..\_GUI_Images\BUTTONS\Grey4_Hover.png"
	_BTN_GREY4_0P:
	IncludeBinary "..\_GUI_Images\BUTTONS\Grey4_Pressed.png"
	_BTN_GREY4_0D:
	IncludeBinary "..\_GUI_Images\BUTTONS\Grey4_Disabled.png"
	
	_BTN_GREY5_0N:
	IncludeBinary "..\_GUI_Images\BUTTONS\N54x22.png"
	_BTN_GREY5_0H:
	IncludeBinary "..\_GUI_Images\BUTTONS\H54x22.png"
	_BTN_GREY5_0P:
	IncludeBinary "..\_GUI_Images\BUTTONS\P54x22.png"
	_BTN_GREY5_0D:
	IncludeBinary "..\_GUI_Images\BUTTONS\D54x22.png"    
EndDataSection


CatchImage(DC::#_BTN_GREY1_1N, ?_BTN_GREY1_1N): CatchImage(DC::#_BTN_GREY1_1H, ?_BTN_GREY1_1H): CatchImage(DC::#_BTN_GREY1_1P, ?_BTN_GREY1_1P): CatchImage(DC::#_BTN_GREY1_1D, ?_BTN_GREY1_1D)
CatchImage(DC::#_BTN_GREY4_0N, ?_BTN_GREY4_0N): CatchImage(DC::#_BTN_GREY4_0H, ?_BTN_GREY4_0H): CatchImage(DC::#_BTN_GREY4_0P, ?_BTN_GREY4_0P): CatchImage(DC::#_BTN_GREY4_0D, ?_BTN_GREY4_0D)
CatchImage(DC::#_BTN_GREY5_0N, ?_BTN_GREY5_0N): CatchImage(DC::#_BTN_GREY5_0H, ?_BTN_GREY5_0H): CatchImage(DC::#_BTN_GREY5_0P, ?_BTN_GREY5_0P): CatchImage(DC::#_BTN_GREY5_0D, ?_BTN_GREY5_0D)


#_ICO_T01 = 781: #_ICO_T02 = 782: #_BCK_T01 = 784

; Special For Requester
DataSection
	_Icon_Top:
	IncludeBinary "..\_GUI_IMAGES\DROP7Z\50x50.png"
	
	_Icon_Tray:
	IncludeBinary "..\_GUI_IMAGES\ICONS\drop7ztray.ico"
	
	_About_Image:
	IncludeBinary "..\_GUI_IMAGES\DROP7Z\drop7ztray60.png"
	
	_BackGround:
	IncludeBinary "..\_GUI_IMAGES\USER_INTERFACE\MainGui.png"
	
	_BackGround_Profiles:
	IncludeBinary "..\_GUI_IMAGES\USER_INTERFACE\MainGui_Profiles.png"
	
	_BackGround_crc:
	IncludeBinary "..\_GUI_IMAGES\USER_INTERFACE\crc.png"    
	
EndDataSection

CatchImage(DC::#Icon_001, ?_Icon_Top): CatchImage(#_ICO_T01, ?_Icon_Tray): CatchImage(#_ICO_T02, ?_About_Image):CatchImage(DC::#SkinBase_001, ?_BackGround)
CatchImage(#_BCK_T01, ?_BackGround_Profiles)  
CatchImage(DC::#SkinBase_002, ?_BackGround_crc)

; IDE Options = PureBasic 5.73 LTS (Windows - x64)
; CursorPosition = 12
; FirstLine = 1
; EnableAsm
; EnableXP
; EnableUnicode