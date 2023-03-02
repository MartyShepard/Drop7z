
	;
	; Der ganze Code, Routinen aufbau bis auf die sachne vom Letzten und vorletzten Jahr
	; stammen noch aus der Anfangszeit. ><. Ja vieles ist Müll .....
	;
	
	InitKeyboard()
	UseSHA1Fingerprint()
	UseZipPacker()
	UseLZMAPacker()
	UseTARPacker()
	UseBriefLZPacker()
	
	Structure FULLPATHLIST
		xPath.s ; 
		xFile.s ; 
		xNumB.l
	EndStructure

	Define tb
	
	;	/ AutoComplete
	;
	;
	
	TB_Created.l = RegisterWindowMessage_("TaskbarCreated")

	
	Global _Action1.i           = 0
	Global DirectoryOnly        = 0
	Global Profile_Current.s        = ""

	Global iResult_DeleteFiles  = #False

	Declare Event_GadgetEx_Profile()
	Declare ComboAutoText()

	;
	;
	; AutoComplete
	Structure comboboxinfo 
		cbSize.l
		rcItem.RECT
		rcButton.RECT
		stateButton.l
		hwndCombo.l
		hwndEdit.l
		hwndList.l
	EndStructure

	;
	;

	Global cbinfo.comboboxinfo
	Global oldcomboProc    

	cbinfo\cbsize   = SizeOf(comboboxinfo)


	;
	; 
	; Include Modules
	XIncludeFile "Drop7z_Modules\Constants.pb"
	XIncludeFile ".\_INCLUDES\Class_Fonts_Drop7Z.pb" 
	
	;
	; Include Modules, Global Code Modules
	;   
	XIncludeFile "..\INCLUDES\Class_Process.pb"          

	XIncludeFile "..\INCLUDES\Class_Win_Form.pb"
	XIncludeFile "..\INCLUDES\Class_Win_Style.pb"         
	XIncludeFile "..\INCLUDES\Class_Win_Desk.pb"
	
	XIncludeFile "..\INCLUDES\Class_ListIcon_Sort.pb"          
	XIncludeFile "..\INCLUDES\Class_Tooltip.pb"
	
	XIncludeFile "..\Includes\CLASSES_GUI\SplitterGadgetEx.pb"
	XIncludeFile "..\INCLUDES\CLASSES_GUI\ButtonGadgetEX.pb"
	XIncludeFile "..\INCLUDES\CLASSES_GUI\DialogRequestEX.pb" 
	
	XIncludeFile "..\INCLUDES\Class_Windows.pb"
	
	XIncludeFile "..\INCLUDES\Class_FastFilePeInfo.pb"
	XIncludeFile "..\INCLUDES\Class_FastFileHandle.pb"       
	XIncludeFile "..\INCLUDES\CLASSES_FFS\FastFileSearch.pb"
	
	XIncludeFile "..\INCLUDES\Class_IniCommand.pb"
	
	XIncludeFile "..\INCLUDES\Class_Tooltip.pb"
	
	XIncludeFile "..\INCLUDES\CLASSES_SUB\Math_Bytes.pb"


	;
	; Include Modules Drop7z   
	;    
	
	XIncludeFile "Drop7z_Modules\Configuration.pb"
	
	IncludeFile "Modules\Module_DropLists.pb"
	
	DropLS::CreateStructs()
	
	IncludeFile "Modules\Module_DropLanguage.pb"
	IncludeFile "Modules\Module_DropSysFunctions.pb"         
	IncludeFile "Modules\Module_DropCodes.pb"   
	
	
	
	XIncludeFile "..\INCLUDES\CLASSES_EMU\Mame_CHD_External_Support.pb"
	
	XIncludeFile "Drop7z_Modules\GuiWindow_Main.pb"
	XIncludeFile "Drop7z_Modules\Quersumme.pb"
	
	IncludeFile "_INCLUDES\7z_About_Window.pbf"         ; Mit PB Editor, veraltete Variante
	
	
	IncludeFile "_INCLUDES\_Datas_Sections.pb"
	IncludeFile "_INCLUDES\7z_Struct_Lists.pb"
	
	IncludeFile "_INCLUDES\_WinFunc_Delete.pb"                        
	IncludeFile "_INCLUDES\7z_About_Window.pb"
	
	IncludeFile "_INCLUDES\7z_Prc_Globals.pb"
	IncludeFile "_INCLUDES\_Tray_PopUpMenu.pb"
	
	XIncludeFile "Modules\Module_ArchiveCheck.pb"
	XIncludeFile "Modules\Module_LZX.pb"
	XIncludeFile "Modules\Module_UnRar.pb" 
	
	IncludeFile "Modules\Module_Compress_Full.pb"         ; Updated
	IncludeFile "Modules\Module_Compress_Single.pb"		; Updated
	IncludeFile "Modules\Module_Convert.pb"			; Updated
	
	IncludeFile "_INCLUDES\7z_Profile_Function.pb"
	
	IncludeFile "Modules\Module_DropThread.pb"        
	IncludeFile "_INCLUDES\_GagdetEX_Events.pb"

	;
	; Intialisiere Language System
	
	DropLang::GetLngSysUI()
	Global LHGAME_LANGUAGE = DropLang::GetLngSysUI(-1)     
	
   	
;/////////////////////////////////////////////////////////////////////////////////////// Pre

CFG::ReadConfig(CFG::*Config) 

iDrop7z_Config$  = CFG::*Config\ConfigPath.s


; 
; Single/Multi Instanz
DropSysF::MultipleInstances()

;
; Information über den Autosatrt
DropSysF::Autostart()


Global GaItemWidth1.i = 100 ; Directory
Global GaItemWidth2.i = 119 ; Files
Global GaItemWidth3.i = 56  ; Size

;/////////////////////////////////////////////////////////////////////////////////////// Window

GUI00::OpenWin()
GUI00::MakeWin()

DropCode::SetUIElements_Global(0)


GetComboBoxInfo_(GadgetID(DC::#String_002),@cbinfo)

tb              = cbinfo.comboboxinfo\hwndedit
oldcomboproc    = SetWindowLongPtr_(tb, #GWL_WNDPROC, @ComboAutoComplete())    
oldcombproc     = SetWindowLongPtr_(GadgetID(DC::#String_002), #GWL_WNDPROC, @ComboCallBackColor())



;///////////////////////////////////////////////////////////////////////////////// AutoComplete

;
; Immer in Front ?
StickyWindow(DC::#_Window_001,CFG::*Config\Sticky) 

;
; BootUp, Setze Window Position
DropSysF::Window_SetPosition()

;
;
DropSysF::Window_SetMinimized()        

;
; Enable Drag'n' Drop
EnableWindowDrop(DC::#_Window_001,  #PB_Drop_Files , #PB_Drag_Copy)   

;
; Callback für das Tray Icon
SetWindowCallback(@_CB_TrayIcon(),DC::#_Window_001)

AddSysTrayIcon(#_ICO_T01, WindowID(DC::#_Window_001),  ImageID(#_ICO_T01))    
SysTrayIconToolTip(#_ICO_T01, CFG::*Config\WindowTitle.s)


RemoveGadgetColumn(DC::#ListIcon_001,0)

AddGadgetColumn(DC::#ListIcon_001,0, DropLang::GetUIText(15) ,GaItemWidth1)
AddGadgetColumn(DC::#ListIcon_001,1, DropLang::GetUIText(16) ,GaItemWidth2)
AddGadgetColumn(DC::#ListIcon_001,2, DropLang::GetUIText(12) ,GaItemWidth3)

SetGadgetText(DC::#String_001, DropLang::GetUIText(17) )
GadgetToolTip(DC::#String_001, DropLang::GetUIText(17) )

SetGadgetText(DC::#String_003,"")

SetGadgetState(DC::#CheckBox_001,0)
DisableGadget(DC::#String_003,1) 

SetGadgetState(DC::#CheckBox_002,1)
DisableGadget(DC::#Button_006,0) 

;
;
_FillList_SizeDict()                   

_ReadConfig_History()

;
; Leere Den Ram
DropSYSF::Process_FreeRam()

;
; Lege fest ob das Verzeichnis gespeert ist
If  ( CFG::*Config\PinDirectory = 1 )
	DropCode::Consolidate_Directory(2)
EndIf     


;/////////////////////////////////////////////////////////////////////////////////////// Code: Window
Repeat
 
    
	MainEvent       = WaitWindowEvent()
	MainEventWindow = EventWindow()
	MainEventGadget = EventGadget() ;// GadgetID
	MainEventType   = EventType()
	MainEventMenu   = EventMenu()
	MainEventParam  = EventwParam()
	MainEventParami = EventlParam()
	MainEventData   = EventData()
	
	
	; Remember: Damit in For Next und so schleifen das Gadget nichtgebliock wird Create Thread benutzen
	
	Select MainEvent
			
		Case #WM_KEYDOWN
			Select MainEventGadget      
				Case DC::#ListIcon_001 
					Select MainEventParam      
						Case #VK_DELETE
							_Clear_FileList_Single() 
					EndSelect 
			EndSelect     
			;//////////////////////////////////////////////////////////////////////////////// Code: Main Source
		Case #PB_Event_Gadget
			Select MainEventType
					
				Case #PB_EventType_LeftClick
					Select MainEventGadget
						Case DC::#ListIcon_001 : _Select_LeftListBox()
							
						Case DC::#String_001   : GadgetToolTip(DC::#String_001,GetGadgetText(DC::#String_001))               
						Case DC::#CheckBox_001   : _SetGadetEncState()                           
						Case DC::#Button_007   : Open_About()
						Case DC::#CheckBox_005   : _SetSelfExtractet() 
							
					EndSelect
					
				Case #PB_EventType_Change
					
					Select MainEventGadget                      
						Case DC::#ComboBox_004  :   _SetButtonState()
						Case DC::#ComboBox_005  :   _SetCompression_Mode(DC::#ComboBox_005,DC::#ComboBox_001,DC::#ComboBox_002,DC::#ComboBox_003)                        
						Case DC::#String_002    :   Debug GetGadgetText(DC::#String_002): 
							
					EndSelect                    
			EndSelect
			
			GadgetEx_EventResult = Event_GadgetEx_Events() 
			;//////////////////////////////////////////////////////////////////////////////// Code: PopUpMenü
			Select MainEventType
				Case #PB_EventType_RightClick
					
					Select MainEventGadget
						Case  DC::#ListIcon_001
							_SetPopUpMenu()
							DisplayPopupMenu(DC::#PopUpMenu_002, WindowID(DC::#_Window_001))
					EndSelect   
					
			EndSelect             
			
			
			;//////////////////////////////////////////////////////////////////////////////// Code: Drag & Drop
		Case #PB_Event_WindowDrop 
			If EventDropType() = #PB_Drop_Files : _SetAction_Drop() : EndIf
			
			;//////////////////////////////////////////////////////////////////////////////// Code: Tray icon
		Case #PB_Event_SysTray
			Select MainEventType
				Case  #PB_EventType_RightClick
					_TrayIconMenu()
					DisplayPopupMenu(DC::#PopUpMenu_001, WindowID(DC::#_Window_001))
					
				Case  #PB_EventType_LeftClick 
					Select IsIconic_(WindowID(DC::#_Window_001))
						Case 1
							ShowWindow_(WindowID(DC::#_Window_001),#SW_RESTORE) 
						Case 0    
							CFG::*Config\DesktopX = WindowX(DC::#_Window_001)
							CFG::*Config\DesktopY = WindowY(DC::#_Window_001)
							ShowWindow_(WindowID(DC::#_Window_001),#SW_MINIMIZE)
							CFG::WriteConfig(CFG::*Config): CFG::ReadConfig(CFG::*Config): DropSYSF::Process_FreeRam()
					EndSelect
					StickyWindow(DC::#_Window_001,CFG::*Config\Sticky)                     
			EndSelect   
			
			
			;//////////////////////////////////////////////////////////////////////////////// Code: Menu         
		Case #PB_Event_Menu       
			Select MainEventMenu 
				Case 100
				Case 1 : Open_About()
				Case 2 : _SeePopUpMenu(2)                        
				Case 3 : _SeePopUpMenu(3)  
				Case 4 : _SeePopUpMenu(4)                    
				Case 5 : _SeePopUpMenu(5):Break:End                          
				Case 6 : _SeePopUpMenu(6)
					;//////////////////////////////////////////////////////////////////////////////////////////////////                       
				Case 7 :                 
					Select CountGadgetItems(DC::#ListIcon_001)
						Case 0
							Request::MSG( DropLang::GetUIText(20) , DropLang::GetUIText(21)  ,DropLang::GetUIText(22), 2,1,ProgramFilename(),0,0,DC::#_Window_001)
						Default
							
							
							Select INIValue::Get_Value("SETTINGS","CreateSHA1",CFG::*Config\ConfigPath.s) 
								Case 1                             
									GUI04::ConsoleWindow()
								Default
							EndSelect
							
							;
							; Vorab querverweisung
							Select ( DropCode::GetArchivFormat() )
									;
									; Compress Full Action
								Case "7z", "zip"
									_Disable_Enable_Gadets(1)
									nError = DropPack::Compress()
									If ( nError >= 10 )
										;
										; Alles was grösse ist als 10 wird als Fehler behandelt
									EndIf    
									_Disable_Enable_Gadets(0)
									
								Case "chd"
							EndSelect
							
							If IsWindow(DC::#_Window_004)                                
								HideWindow(DC::#_Window_004,1)
								StickyWindow(DC::#_Window_004,0): 
								SetForegroundWindow_(WindowID(DC::#_Window_001))
								CloseWindow(DC::#_Window_004)
							EndIf   
							DropSYSF::Process_FreeRam()                 
					EndSelect
					
					;//////////////////////////////////////////////////////////////////////////////////////////////////            
				Case 8, 9
					
					Select CountGadgetItems(DC::#ListIcon_001)
						Case 0
							Request::MSG( DropLang::GetUIText(20) , DropLang::GetUIText(21)  ,DropLang::GetUIText(22), 2,1,ProgramFilename(),0,0,DC::#_Window_001)
						Default
							
							Select INIValue::Get_Value("SETTINGS","CreateSHA1",CFG::*Config\ConfigPath.s) 
								Case 1                             
									GUI04::ConsoleWindow()
								Default
							EndSelect  
							
							
							Select ( DropCode::GetArchivFormat() )
									;
									; Compress Full Action
								Case "7z", "zip"
									_Disable_Enable_Gadets(1)
									nError = DropSpak::Compress()
									If ( nError >= 10 )
										;
										; Alles was grösse ist als 10 wird als Fehler behandelt
									EndIf    
									_Disable_Enable_Gadets(0)
									
								Case "chd"                                   
									
							EndSelect                                        
							DropSYSF::Process_FreeRam()
					EndSelect
					
					
					
					;//////////////////////////////////////////////////////////////////////////////////////////////////                                                                  
				Case 10 : _Clear_FileList()
				Case 11 : _Clear_FileList_Single()                  
				Case 12 : _SeePopUpMenu(12)
				Case 13 : _SeePopUpMenu(4)                    
				Case 14 : _SeePopUpMenu(14):Break:End
				Case 15 : _SeePopUpMenu(15)
				Case 16 : _SeePopUpMenu(16)
				Case 17 : _SeePopUpMenu(17)
				Case 18 : _SeePopUpMenu(18)
				Case 19 : _SeePopUpMenu(19)
				Case 20 : _SeePopUpMenu(20)
				Case 21 : _SeePopUpMenu(21)
				Case 22 : _SeePopUpMenu(22)
				Case 23 : _Clear_FileList_Marked()
				Case 24 : _Clear_FileList_NonMarked() 
				Case 25 : _SeePopUpMenu(25)
				Case 26 : _SeePopUpMenu(26) 
				Case 27 : _SeePopUpMenu(27)
				Case 28 : _SeePopUpMenu(28)
				Case 29 : _SeePopUpMenu(29)
				Case 30 : _SeePopUpMenu(30)
				Case 31 : _SeePopUpMenu(31) 
				Case 32 : _SeePopUpMenu(32) 
				Case 33 : _SeePopUpMenu(33) 
				Case 34 : _SeePopUpMenu(34) 
				Case 35 : _SeePopUpMenu(35)
				Case 36 : _SeePopUpMenu(36)         ; Use 7zip
				Case 37 : _SeePopUpMenu(37)		; Use ZIP
				Case 38 : _SeePopUpMenu(38)		; Use CHD                    
				Case 40 : _SeePopUpMenu(40)		; Zip Options: Deflate
				Case 41 : _SeePopUpMenu(41)		; Zip Options: Deflate64
				Case 42 : _SeePopUpMenu(42)		; Zip Options: BZip2
				Case 43 : _SeePopUpMenu(43)		; Zip Options: LZMA
				Case 44 : _SeePopUpMenu(44)		; Zip Options: PPMD
				Case 50 : _SeePopUpMenu(50)		; CHD
				Case 51 : _SeePopUpMenu(51)		; CHD  Sticky Window                   
				Case 52 : _SeePopUpMenu(52)		; CHD Force Overwrite
				Case 60 : _SeePopUpMenu(60)		; CHD Force Overwrite 
				Case 70 : _SeePopUpMenu(70)	
				Case 71 : _SeePopUpMenu(71)						
				Case 72 : _SeePopUpMenu(72)						
				Case 73 : _SeePopUpMenu(73)					
				Case 74 : _SeePopUpMenu(74)
				Case 75 : _SeePopUpMenu(75)						
					
			EndSelect
			
			;//////////////////////////////////////////////////////////////////////////////// Code: End Session            
		Case #PB_Event_CloseWindow
			CFG::*Config\DesktopX = WindowX(DC::#_Window_001)
			CFG::*Config\DesktopY = WindowY(DC::#_Window_001)
			ShowWindow_(WindowID(DC::#_Window_001),#SW_MINIMIZE)
			CFG::WriteConfig(CFG::*Config): CFG::ReadConfig(CFG::*Config): DropSYSF::Process_FreeRam()            
	EndSelect
	
	
	
ForEver

; IDE Options = PureBasic 5.73 LTS (Windows - x64)
; CursorPosition = 242
; FirstLine = 206
; EnableThread
; EnableXP
; EnableOnError
; UseIcon = _GUI_IMAGES\ICONS\drop7ztray.ico
; Executable = ..\LH Drop7z 1 (Beta Versions)\Drop7z x64.exe
; CurrentDirectory = Drop7z\
; Compiler = PureBasic 5.73 LTS (Windows - x64)
; EnableUnicode