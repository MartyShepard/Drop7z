

Protected  nCurrentFontID.l = Fonts::#_DROIDSANS_10
;///////////////////////////////////////////////////////////////////////////// Profile: Use
ButtonEX::Add(DC::#Button_011,236, 96, 83, 20,
              DC::#_BTN_GREY4_0N,
              DC::#_BTN_GREY4_0H,
              DC::#_BTN_GREY4_0P,
              DC::#_BTN_GREY4_0D, "Use This","Use This", "Use This", GetSysColor_(#COLOR_3DFACE),$29D7DA,nCurrentFontID9 )   
SSTTIP::TooltTip(WindowID(DC::#_Window_002), DC::#Button_011, "Use the Current Profile","", 1,275)  
;//////////////////////////////////////////////////////////////////////////// Profile: Rename
ButtonEX::Add(DC::#Button_017,236, 160, 83, 20,
              DC::#_BTN_GREY4_0N,
              DC::#_BTN_GREY4_0H,
              DC::#_BTN_GREY4_0P,
              DC::#_BTN_GREY4_0D, "Rename", "Rename", "Rename",      GetSysColor_(#COLOR_3DFACE),$29D7DA,nCurrentFontID )
SSTTIP::TooltTip(WindowID(DC::#_Window_002), DC::#Button_017, "Delete the Current Profile","", 1,275) 


;//////////////////////////////////////////////////////////////////////////// Profile: Delete
ButtonEX::Add(DC::#Button_015,236, 184, 83, 20,
              DC::#_BTN_GREY4_0N,
              DC::#_BTN_GREY4_0H,
              DC::#_BTN_GREY4_0P,
              DC::#_BTN_GREY4_0D, "Delete", "Delete", "Delete",     GetSysColor_(#COLOR_3DFACE),$29D7DA,nCurrentFontID )
SSTTIP::TooltTip(WindowID(DC::#_Window_002), DC::#Button_015, "Delete the Current Profile","", 1,275) 


;//////////////////////////////////////////////////////////////////////////// Profile: Default
ButtonEX::Add(DC::#Button_014,236, 208, 83, 20, 
              DC::#_BTN_GREY4_0N, 
              DC::#_BTN_GREY4_0H, 
              DC::#_BTN_GREY4_0P,
              DC::#_BTN_GREY4_0D, "Default", "Default", "Default",  GetSysColor_(#COLOR_3DFACE),$29D7DA,nCurrentFontID )
SSTTIP::TooltTip(WindowID(DC::#_Window_002), DC::#Button_014, "Set Current Profile as Default","", 1,275) 


;//////////////////////////////////////////////////////////////////////////// Profile: Save
ButtonEX::Add(DC::#Button_012,236, 232, 83, 20, 
              DC::#_BTN_GREY4_0N, 
              DC::#_BTN_GREY4_0H, 
              DC::#_BTN_GREY4_0P,
              DC::#_BTN_GREY4_0D, " Save", " Save", " Save",     GetSysColor_(#COLOR_3DFACE),$29D7DA,nCurrentFontID )
SSTTIP::TooltTip(WindowID(DC::#_Window_002), DC::#Button_012, "Save Current Profile","", 1,275) 


;//////////////////////////////////////////////////////////////////////////// Profile: Close
ButtonEX::Add(DC::#Button_013,236, 281, 87, 27, 
              DC::#_BTN_GREY1_1N, 
              DC::#_BTN_GREY1_1H, 
              DC::#_BTN_GREY1_1P,
              DC::#_BTN_GREY1_1D, " Close", " Close", " Close",  GetSysColor_(#COLOR_3DFACE),$29D7DA,nCurrentFontID )
SSTTIP::TooltTip(WindowID(DC::#_Window_002), DC::#Button_013, "Close the Profile Editor","", 1,275) 


;//////////////////////////////////////////////////////////////////////////// Profile: Refresh
ButtonEX::Add(DC::#Button_016,236, 136, 83, 20, 
              DC::#_BTN_GREY4_0N, 
              DC::#_BTN_GREY4_0H, 
              DC::#_BTN_GREY4_0P,
              DC::#_BTN_GREY4_0D, "Refresh", "Refresh", "Reresh",  GetSysColor_(#COLOR_3DFACE),$29D7DA,nCurrentFontID )
SSTTIP::TooltTip(WindowID(DC::#_Window_002), DC::#Button_016, "Refresh","", 1,275) 


; IDE Options = PureBasic 5.62 (Windows - x64)
; CursorPosition = 15
; FirstLine = 3
; EnableAsm
; EnableXP
; UseMainFile = ..\Drop7z.pb
; CurrentDirectory = ..\Drop7z\
; EnableUnicode