
Protected.s szButtonText1, szButtonText2, szButtonText3, szButtonText4, szButtonText5, szButtonText6, szButtonText7

	szButtonText1 = "Übernehmen"
	szButtonText2 = " Umbennen "
	szButtonText3 = " Löschen  "
	szButtonText4 = " Standard "
	szButtonText5 = " Speichern"
	szButtonText6 = " Abbruch  "
	szButtonText7 = " Neuladen "
	;
	;Profile: Use
	ButtonEX::Add(DC::#Button_011,236, 96, 83, 20,
	              DC::#_BTN_GREY4_0N,
	              DC::#_BTN_GREY4_0H,
	              DC::#_BTN_GREY4_0P,
	              DC::#_BTN_GREY4_0D, szButtonText1, szButtonText1, szButtonText1, GetSysColor_(#COLOR_3DFACE),$29D7DA,FontID )   
	SSTTIP::TooltTip(WindowID(DC::#_Window_002), DC::#Button_011, "Übernimmt das gewählte Profil und schließt das Fenster","", 1,275)  
	;
	;Profile: Rename
	ButtonEX::Add(DC::#Button_017,236, 160, 83, 20,
	              DC::#_BTN_GREY4_0N,
	              DC::#_BTN_GREY4_0H,
	              DC::#_BTN_GREY4_0P,
	              DC::#_BTN_GREY4_0D, szButtonText2, szButtonText2, szButtonText2, GetSysColor_(#COLOR_3DFACE),$29D7DA,FontID )
	SSTTIP::TooltTip(WindowID(DC::#_Window_002), DC::#Button_017, "Das Aktuelle Profil umbennen","", 1,275) 
	;
	;Profile: Delete
	ButtonEX::Add(DC::#Button_015,236, 184, 83, 20,
	              DC::#_BTN_GREY4_0N,
	              DC::#_BTN_GREY4_0H,
	              DC::#_BTN_GREY4_0P,
	              DC::#_BTN_GREY4_0D, szButtonText3, szButtonText3, szButtonText3, GetSysColor_(#COLOR_3DFACE),$29D7DA,FontID )
	SSTTIP::TooltTip(WindowID(DC::#_Window_002), DC::#Button_015, "Löscht das Aktuell gewählte Profil","", 1,275) 
	;
	;Profile: Default
	ButtonEX::Add(DC::#Button_014,236, 208, 83, 20, 
	              DC::#_BTN_GREY4_0N, 
	              DC::#_BTN_GREY4_0H, 
	              DC::#_BTN_GREY4_0P,
	              DC::#_BTN_GREY4_0D, szButtonText4, szButtonText4, szButtonText4, GetSysColor_(#COLOR_3DFACE),$29D7DA,FontID )
	SSTTIP::TooltTip(WindowID(DC::#_Window_002), DC::#Button_014, "Setzt das Aktuell gewählte Profil als Standard","", 1,275) 
	;
	;Profile: Save
	ButtonEX::Add(DC::#Button_012,236, 232, 83, 20, 
	              DC::#_BTN_GREY4_0N, 
	              DC::#_BTN_GREY4_0H, 
	              DC::#_BTN_GREY4_0P,
	              DC::#_BTN_GREY4_0D, szButtonText5, szButtonText5, szButtonText5, GetSysColor_(#COLOR_3DFACE),$29D7DA,FontID )
	SSTTIP::TooltTip(WindowID(DC::#_Window_002), DC::#Button_012, "Speichert das Aktuelle Profil","", 1,275) 
	;
	;Profile: Close
	ButtonEX::Add(DC::#Button_013,236, 281,83, 20, 
	              DC::#_BTN_GREY4_0N, 
	              DC::#_BTN_GREY4_0H, 
	              DC::#_BTN_GREY4_0P,
	              DC::#_BTN_GREY4_0D, szButtonText6,szButtonText6, szButtonText6, GetSysColor_(#COLOR_3DFACE),$29D7DA,FontID )
	SSTTIP::TooltTip(WindowID(DC::#_Window_002), DC::#Button_013, "Schließt das Profil Fenster ohne Profil übernahme","", 1,275) 
	;
	;Profile: Refresh
	ButtonEX::Add(DC::#Button_016,236, 136, 83, 20, 
	              DC::#_BTN_GREY4_0N, 
	              DC::#_BTN_GREY4_0H, 
	              DC::#_BTN_GREY4_0P,
	              DC::#_BTN_GREY4_0D, szButtonText7, szButtonText7, szButtonText7, GetSysColor_(#COLOR_3DFACE),$29D7DA,FontID )
	SSTTIP::TooltTip(WindowID(DC::#_Window_002), DC::#Button_016, "Lädt die Profileaus der Datei neu ein","", 1,275) 


; IDE Options = PureBasic 5.73 LTS (Windows - x64)
; CursorPosition = 64
; FirstLine = 2
; EnableAsm
; EnableXP
; UseMainFile = ..\Drop7z.pb
; CurrentDirectory = ..\Drop7z\
; EnableUnicode