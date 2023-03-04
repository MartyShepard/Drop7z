
	Procedure _TrayIconMenu() 
		
		CreatePopupMenu(DC::#PopUpMenu_001)   
		MenuItem(1, "About Drop7Zip")
		MenuBar()     
		MenuItem(2, "Start: Windows")
		MenuItem(15,"Start: Minimiert")
		MenuBar()          
		
		If IsIconic_(WindowID(DC::#_Window_001))          
			MenuItem(3, "Fenster: Zeigen")
		Else
			MenuItem(4, "Fenster: Verstecken")
		EndIf
		
		MenuItem(16, "Fenster: Immer im Vordergrund")        
		MenuItem(6, "Fenster: Position Reseten")
		;MenuItem(25, "Window: Single Instance")        
		;MenuBar()        
		;MenuItem(18, "Auto Clear List")
		;MenuBar()    
		;MenuItem(17, "Delete Files: After Compress")
		;MenuItem(26, "Delete Files: Don't Ask Me")
		;MenuBar()  
		;MenuItem(34, "Create SHA1: Select Files") 
		;MenuItem(30, "Create SHA1: Checksum File")         
		;MenuBar()
		;MenuItem(29, "Clear Complete History")          
		MenuBar()        
		MenuItem(5,  "Quit the Drop")
		
		DropCode::SetMenuCheckMarksTray()
		
	EndProcedure
	;
	;
	;
	Procedure.l _SetPopUpMenu() 
		Protected iDrop7z_Config$, MaxMenuItems.i,  CurrentItem.i, TrayItems.i, TrayID.i, Markiert.i ,CheckMarked.i, State$
		
		CreatePopupMenu(DC::#PopUpMenu_002)
		MenuItem(7, "Packen: Standard Archiv Erstellen")
		MenuItem(8, "Packen: Alle Seperat Packen")       
		MenuItem(9, "Packen: Markierte Dateien Packen")
		MenuBar()
		MenuItem(36, "Format: 7ZP")
		MenuItem(37, "Format: ZIP")  
		OpenSubMenu("Format: ZIP Options")
		MenuItem(40, "Methode: Deflate")
		MenuItem(41, "Methode: Deflate64")
		MenuItem(42, "Methode: BZip2")
		MenuItem(43, "Methode: LZMA")
		MenuItem(44, "Methode: PPMD") 
		CloseSubMenu() 
		MenuItem(38, "Format: CHD")
		OpenSubMenu("Format: CHD Options")
		MenuItem(50, "Chdman Pfad einstellen")
		MenuItem(51, "Fenster im Vordergrund")
		MenuItem(52, "Option: Zwischenablage")
		CloseSubMenu()                            
		MenuBar()   
		MenuItem(60, "Ziel Verzeichnis Pinnen") 
		MenuBar()   		
		MenuItem(75, "Konvertieren <-> Entpacken")
		MenuItem(74, "Unterverzeichnis Entpacken")  		
		MenuBar()         
		OpenSubMenu("Konvert./ Entpack: Optionen")      
		MenuItem(72, "Behandle *.exe als Sfx7z")              
		MenuItem(70, "Behandle *.exe als SfxRAR")
		MenuItem(71, "Behandle *.exe als SfxZIP")            
		MenuBar()            
		MenuItem(73, "Temp Verzeichnis Löschen")          
		;MenuItem(74, "Move ZIP Problems")                  
		CloseSubMenu()                          
		MenuBar()            
		MenuItem(10, "Entferne: Alle Einträge")            
		MenuItem(11, "Entferne: Aktuellen")
		MenuItem(23, "Entferne: Alle Markierte")            
		MenuItem(24, "Entferne: Nicht Markierte")
		MenuBar()            
		;MenuItem(21, "Einträge: Alle Selektieren")
		;MenuItem(22, "Einträge: Selektion umkehren")              
		;MenuBar()            
		MenuItem(19, "Drag'n'Drop: Auto. Entfernen")
		MenuBar()   
		MenuItem(28, "Säubere Zielverzeichnis History")               
		;MenuBar()                 
		;MenuItem(20, "Delete Files: After Compress") 
		;MenuItem(27, "Delete Files: Don't Ask Me")            
		;MenuBar()
		;OpenSubMenu("Extra: Checksum")            
		;MenuItem(31, "Create SHA1: All Items") 
		;MenuItem(32, "Create SHA1: Current Item")
		;MenuItem(33, "Create SHA1: Select Files")
		;MenuItem(35, "Create SHA1: Checksum File")
		;CloseSubMenu()
		MenuBar()              
		OpenSubMenu("Extra: Einstellungen")
		If IsIconic_(WindowID(DC::#_Window_001))          
			MenuItem(3, "Fenster: Zeigen")
		Else
			MenuItem(4, "Fenster: Verstecken")
		EndIf
		
		MenuItem(16, "Fenster: Immer im Vordergrund")        
		MenuItem(6, "Fenster: Position Reseten")
		;MenuItem(25, "Single Instance")             
		CloseSubMenu()             
		OpenSubMenu("Extra: Drop7Zip")                      
		MenuItem(12,"Drop7Zip: About")
		MenuItem(13,"Drop7Zip: Hide")
		MenuItem(14,"Drop7Zip: Beenden")
		CloseSubMenu() 
		
		DropCode::SetMenuCheckMarksPopp()
		
		MaxMenuItems = 35
		;
		; Resete den Status der Menu Einträge
		Debug  ""
		For TrayID = 7 To MaxMenuItems
			Select TrayID
				Case 8,7,9,10,11,21,22,23,24,31,32
					DisableMenuItem(DC::#PopUpMenu_002, TrayID, 1)                    
					
					Debug  "MenuID Reset:"+ TrayID+" = "+GetMenuItemText(DC::#PopUpMenu_002,TrayID)
					
				Default    
			EndSelect
		Next
		
		TrayItems     = CountGadgetItems(DC::#ListIcon_001)        
		;
		; Menüeinträge Checkmarked ?           
		For CurrentItem = 0 To TrayItems
			CheckMarked.i = GetGadgetItemState(DC::#ListIcon_001,CurrentItem)
			If CheckMarked.i = 2: Break: EndIf
		Next          
		
		Select TrayItems
				
			Case 0
				;
				; Alle Menu Einträge sind Deaktivert     
			Default
				;
				; Einträge wurden gefunden
				For TrayID = 7 To MaxMenuItems
					Select TrayID
							;
							; Menu Einträge werden aktivert
						Case 7,8,9,10,11,21,22,31,32,23,24
							DisableMenuItem(DC::#PopUpMenu_002, TrayID, 0)                                                        
							Debug  "MenuID Enabled:"+ TrayID+" = "+GetMenuItemText(DC::#PopUpMenu_002,TrayID)                                                                                                                   
							;
							;
							;  Einträge wurden Markiert, Klick ins Litsbox aber Kein Eintrag gewählt
							;                         
							Markiert.i = GetGadgetState(DC::#ListIcon_001) 
							Select Markiert.i
								Case -1
									Select TrayID
										Case 9,11,32
											DisableMenuItem(DC::#PopUpMenu_002, TrayID, 1)   
											Debug  "MenuID Select-1:"+ TrayID+" = "+GetMenuItemText(DC::#PopUpMenu_002,TrayID)  
									EndSelect
							EndSelect
							;
							;
							; Einträge in der Listbox wurden Markiert                                                        
							Select CheckMarked.i
								Case 2
									Select TrayID  
										Case 23,24,31,32,33
											DisableMenuItem(DC::#PopUpMenu_002,TrayID,0)
											Debug  "MenuID IsChecked:"+ TrayID+" = "+GetMenuItemText(DC::#PopUpMenu_002,TrayID)                                      
									EndSelect
								Case 0
									Select TrayID  
										Case 23,24,31,32,33
											DisableMenuItem(DC::#PopUpMenu_002,TrayID,1)
											Debug  "MenuID NonChecked:"+ TrayID+" = "+GetMenuItemText(DC::#PopUpMenu_002,TrayID)                                      
									EndSelect                                   
							EndSelect                            
						Default                            
					EndSelect                                   
				Next 
				;
				; Comboxbox Multivolume Status
				MultiVolumeState.i = GetGadgetState(DC::#ComboBox_004)
				Select MultiVolumeState.i
					Case 0,1,10
					Default
						DisableMenuItem(DC::#PopUpMenu_002, 8, 1)    
				EndSelect                
		EndSelect                           
	EndProcedure   
	;
	;
	;
	Procedure _SeePopUpMenu(iMenuID.l)
		
		Protected iDrop7z_Config$, TrayMenu.i
		iDrop7z_Config$ = GetPath_Config(1)
		
		
		Select iMenuID.l
			Case 1
				
			Case 2
				;Autostart
				Select CFG::*Config\Autostart
					Case 0: CFG::*Config\Autostart = 1: DropSysF::RegAutostart_Save()
					Case 1: CFG::*Config\Autostart = 0: DropSysF::RegAutostart_Kill() 
				EndSelect                     
				
			Case 3: ShowWindow_(WindowID(DC::#_Window_001),#SW_RESTORE): ProcedureReturn 
			Case 4: ShowWindow_(WindowID(DC::#_Window_001),#SW_MINIMIZE): ProcedureReturn
			Case 5,6
				;Hide/Show          
				Select IsIconic_(WindowID(DC::#_Window_001))
					Case 1
						HideWindow(DC::#_Window_001,1)
						ShowWindow_(WindowID(DC::#_Window_001),#SW_RESTORE)
				EndSelect        
				Select iMenuID
					Case 5
						_Exit_Win(): End      
					Case 6
						CFG::*Config\DesktopH = WindowHeight(DC::#_Window_001,#PB_Window_FrameCoordinate)
						CFG::*Config\DesktopW = WindowWidth(DC::#_Window_001, #PB_Window_FrameCoordinate)
						SetWindowPos_((WindowID(DC::#_Window_001)),#HWND_TOP,50,50,CFG::*Config\DesktopW,CFG::*Config\DesktopH,0)
				EndSelect
				
			Case 15
				;MiniMized
				Select CFG::*Config\MiniMized
					Case 0: CFG::*Config\MiniMized = 1 
					Case 1: CFG::*Config\MiniMized = 0
				EndSelect      
			Case 16
				;Sticky           
				Select CFG::*Config\Sticky
					Case 0: CFG::*Config\Sticky = 1 
					Case 1: CFG::*Config\Sticky = 0
				EndSelect
				StickyWindow(DC::#_Window_001,CFG::*Config\Sticky)
				
			Case 17,20,18,19,26,27
				;Delete Files, AutoClear List Box. Menu Items sind in Mehren Menüs verankert 
				Select iMenuID
					Case 17: TrayMenu.i = DC::#PopUpMenu_001
					Case 20: TrayMenu.i = DC::#PopUpMenu_002
					Case 18: TrayMenu.i = DC::#PopUpMenu_001
					Case 19: TrayMenu.i = DC::#PopUpMenu_002
					Case 26: TrayMenu.i = DC::#PopUpMenu_001
					Case 27: TrayMenu.i = DC::#PopUpMenu_002                      
				EndSelect
				
				Select iMenuID
					Case 17,20
						Select GetMenuItemState(TrayMenu,iMenuID)
							Case 0							
								Request0$ = "Now Look What You've Done" 
								Request1$ = "Attention!"                              
								Request2$ = "Benutze die Option 'Dateien Löschen' auf eigene's Risiko." + #CR$ +
										            "Alle gelöschten Dateien befinden sich im Papierkorb."  + #CR$ +#CR$+
										            "Ordner und Dateien nach dem Packen/Komprimieren Löschen ?" 
										
								iResult = Request::MSG(Request0$, Request1$  ,Request2$,12,0,ProgramFilename(),0,0,DC::#_Window_001)
								Select iResult
									Case 0
										CFG::*Config\DeleteFiles = 1
								EndSelect
								
								
							Case 1
								CFG::*Config\DeleteFiles = 0
						EndSelect
						;
						; AutoClear List Box
					Case 19,20
						Select GetMenuItemState(TrayMenu,iMenuID) 
							Case 0: CFG::*Config\AutoClearLt = 1 
							Case 1: CFG::*Config\AutoClearLt = 0
						EndSelect
						;
						; DontAskMe                   
					Case 26,27
						Select GetMenuItemState(TrayMenu,iMenuID) 
							Case 0: CFG::*Config\DontAskMe = 1 
							Case 1: CFG::*Config\DontAskMe = 0
						EndSelect                    
				EndSelect
				
			Case 21,22
				;
				; Select All, Deselect
				Select MenuID
					Case 21
						For x = 0 To CountGadgetItems(DC::#ListIcon_001)
							SetGadgetItemState(DC::#ListIcon_001,x, 2)
						Next: ProcedureReturn
					Case 22
						For x = 0 To CountGadgetItems(DC::#ListIcon_001)
							SetGadgetItemState(DC::#ListIcon_001,x, 0)
						Next: ProcedureReturn
				EndSelect                          
			Case 12
				;
				; About
				Open_About() 
			Case 25
				;
				; Single Instanz          
				Select CFG::*Config\Instanz
					Case 0: CFG::*Config\Instanz = 1 
					Case 1: CFG::*Config\Instanz = 0
				EndSelect
			Case 30,35
				;
				; CreateSHA1
				Select CFG::*Config\CreateSHA1
					Case 0: CFG::*Config\CreateSHA1 = 1 
					Case 1: CFG::*Config\CreateSHA1 = 0
				EndSelect
				
			Case 36,37,38
				;
				; Pack Format
				If      ( iMenuID = 36 )
					DropCode::SetArchivFormat("7z",0)
					; Ui Elemenet Setzen
					DropCode::SetUIElements7ZP()
					ProcedureReturn 
					
				ElseIf ( iMenuID = 37 )
					DropCode::SetArchivFormat("zip",1)
					; Ui Elemenet Setzen
					DropCode::SetUIElementsZIP(1)
					ProcedureReturn  
					
				ElseIf ( iMenuID = 38 )
					DropCode::SetArchivFormat("chd",2)
					; Ui Elemenet Setzen
					DropCode::SetUIElementsCHD(1)
					ProcedureReturn                          
				EndIf
				
			Case 28,29 
				sLANGUAGE = Windows::Get_Language() 
				
				Request0$ = "Now Look What You've Done" 
				Request1$ = "Clear Autocomplete History"                       
				Request2$ = "Damit werden alle Einträge in der History gelöscht." +#CR$ + #CR$ + "Einträge Löschen?"
				
				iResult = Request::MSG(Request0$, Request1$  ,Request2$,12,1,ProgramFilename(),0,0,DC::#_Window_001)
				Select iResult
					Case 0
						
						If ( GetGadgetText(DC::#String_002) )
							szRemember$ = GetGadgetText(DC::#String_002)
						EndIf	
						
						ClearGadgetItems(DC::#String_002)
						
						If (szRemember$)
							SetGadgetText(DC::#String_002, szRemember$)
						EndIf
						
						CFG::MakeHistory(CFG::*Config\HistoryPath,1)
						
						_ReadConfig_History()
						
						ProcedureReturn
					Default
						ProcedureReturn
				EndSelect
				
			Case 34; Create SHA
				Quersumme::Ceate(0,"",0)
				
			Case 40,41,42,43,44    
				CFG::*Config\ZipMethodID = iMenuID - 40
				
			Case 50
				CFG::*Config\CHDszPath = CHD::Set_UtilityPath()
				INIValue::Set("SETTINGS","CHDManTool", CFG::*Config\CHDszPath, CFG::*Config\ConfigPath.s)
				
			Case 51
				;
				; MAME's CHD Manager immer im Vordergrund
				Select CFG::*Config\CHDbSticky
					Case 0: CFG::*Config\CHDbSticky = 1 
					Case 1: CFG::*Config\CHDbSticky = 0
				EndSelect
				
			Case 52
				;         
				;
				Select CFG::*Config\CHDbClipBoard
					Case 0: CFG::*Config\CHDbClipBoard = 1 
					Case 1: CFG::*Config\CHDbClipBoard = 0
				EndSelect
				
			Case 60
				;
				; Verzeichnis Festsetzen     
				Select CFG::*Config\PinDirectory
					Case 0: CFG::*Config\PinDirectory = 1                 
					Case 1: CFG::*Config\PinDirectory = 0
				EndSelect            
				DropCode::Consolidate_Directory(CFG::*Config\PinDirectory)      
			Case 70
				;
				; Handle Exe as RARSFX 
				CFG::*Config\HandleExeAsRAR = #True
				CFG::*Config\HandleExeAsZIP = #False
				CFG::*Config\HandleExeAsS7z = #False       	
			Case 71
				;
				; Handle Exe as ZIPSFX 
				CFG::*Config\HandleExeAsRAR = #False
				CFG::*Config\HandleExeAsZIP = #True
				CFG::*Config\HandleExeAsS7z = #False 
			Case 72
				;
				; Handle Exe as ZIPSFX 
				CFG::*Config\HandleExeAsRAR = #False
				CFG::*Config\HandleExeAsZIP = #False
				CFG::*Config\HandleExeAsS7z = #True  
			Case 73
				;
				; Lösche [nicht] das Erstellte Tempverzeichnis
				Select CFG::*Config\ConvertDelTemp
					Case 0: CFG::*Config\ConvertDelTemp = 1                   
					Case 1: CFG::*Config\ConvertDelTemp = 0                    
				EndSelect
			Case 74
				;
				; Entpacke dateien in ein Unterverzeichnis (Name Als Archiv)
				Select CFG::*Config\UnpackInSubDirectory
					Case 0: CFG::*Config\UnpackInSubDirectory = 1                   
					Case 1: CFG::*Config\UnpackInSubDirectory = 0                    
				EndSelect           
			Case 75
				;
				; Konvertiere nicht, nur Extrahieren           	
				Select CFG::*Config\UnpackOnly
					Case 0: CFG::*Config\UnpackOnly = 1                   
					Case 1: CFG::*Config\UnpackOnly = 0                    
				EndSelect         	
				
		EndSelect
		
		CFG::WriteConfig(CFG::*Config): CFG::ReadConfig(CFG::*Config): DropSYSF::Process_FreeRam()
	EndProcedure
; IDE Options = PureBasic 5.73 LTS (Windows - x64)
; CursorPosition = 65
; FirstLine = 42
; Folding = -
; EnableAsm
; EnableXP
; UseMainFile = ..\Drop7z.pb
; CurrentDirectory = ..\Drop7z\
; EnableUnicode