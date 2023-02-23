



;///////////// Compress Single
  ButtonEX::Add(DC::#Button_006,105, 442, 83, 20, #_BTN_GREY4_0N, #_BTN_GREY4_0H, #_BTN_GREY4_0P,#_BTN_GREY4_0D,"Single", "Compress", "Compress",GetSysColor_(#COLOR_3DFACE))
  ButtonEX::TooltTip(WindowID(#Window001), DC::#Button_006, "Compress each Files & Folders IN a seperate Archiv","", 1,275)   

;///////////// Compress Normal
  ButtonEX::Add(DC::#Button_003,12, 442, 83, 20, #_BTN_GREY4_0N, #_BTN_GREY4_0H, #_BTN_GREY4_0P,#_BTN_GREY4_0D,"Full", "Compress", "Compress",GetSysColor_(#COLOR_3DFACE))
  ButtonEX::TooltTip(WindowID(#Window001), DC::#Button_003, "",":.....Compress each Files & Folders in a seperate Archiv", 1,275)  

;///////////// Clear List
  ButtonEX::Add(DC::#Button_002,210, 442, 83, 20, #_BTN_GREY4_0N, #_BTN_GREY4_0H, #_BTN_GREY4_0P,#_BTN_GREY4_0D,"Clear List", "Clear List", "Clear List",GetSysColor_(#COLOR_3DFACE))
  ButtonEX::TooltTip(WindowID(#Window001), DC::#Button_002, "",":.....Clear the File List", 1,275) 

;///////////// Compress Profile
  ButtonEX::Add(DC::#Button_005,309, 442, 83, 20, #_BTN_GREY4_0N, #_BTN_GREY4_0H, #_BTN_GREY4_0P,#_BTN_GREY4_0D,"  Profile Editor", "  Profile Editor", "  Profile Editor",GetSysColor_(#COLOR_3DFACE))
  ButtonEX::TooltTip(WindowID(#Window001), DC::#Button_005, "","Open the Profile Window for Add or Edit Custom Settings", 1,275) 


;//////////// Exit
  ButtonEX::Add(DC::#Button_001,404, 442, 83, 20, #_BTN_GREY4_0N, #_BTN_GREY4_0H, #_BTN_GREY4_0P,#_BTN_GREY4_0D,"Quit", "The Drop", "The Drop",GetSysColor_(#COLOR_3DFACE))
  ButtonEX::TooltTip(WindowID(#Window001), DC::#Button_001, "",":.....", 1,275)


;//////////// Browse
  ButtonEX::Add(DC::#Button_004,16, 98, 83, 20, #_BTN_GREY4_0N, #_BTN_GREY4_0H, #_BTN_GREY4_0P,#_BTN_GREY4_0D,"..\", "..\", "..\",GetSysColor_(#COLOR_3DFACE))
  ButtonEX::TooltTip(WindowID(#Window001), DC::#Button_005, "",":.....", 1,275)

; IDE Options = PureBasic 5.31 (Windows - x64)
; CursorPosition = 6
; EnableAsm
; EnableUnicode
; EnableXP
; UseMainFile = 7z_Main_Source.pb
; CurrentDirectory = Release\