DeclareModule DropCode
    
    Declare     SetMenuCheckMarksTray()
    Declare     SetMenuCheckMarksPopp()
    
    Declare     SetUIElements7ZP(uiState.i = 0)
    Declare     SetUIElementsZIP(uiState.i = 0)
    Declare     SetUIElementsCHD(uiState.i = 0)
    Declare		SetUIElements_Global(n)
    
    Declare     SetArchivFormat(Format$ = "7z", usFormat = 0)
    Declare.s   GetArchivFormat()
    
    Declare.i   GetDriveType(szPath$)
    
    Declare.s   Locate7z(Variant.i)
    Declare.s   szMsgAboutText()
    
    Declare     Consolidate_Directory(uOption.i = 0)

EndDeclareModule

Module DropCode
    
    ;
    ;
    ; Setze den Status der Checkmarks im Tray
    Procedure   SetMenuCheckMarksTray()
        
        SetMenuItemState(DC::#PopUpMenu_001, 02, CFG::*Config\Autostart)
        SetMenuItemState(DC::#PopUpMenu_001, 15, CFG::*Config\MiniMized)
        SetMenuItemState(DC::#PopUpMenu_001, 16, CFG::*Config\Sticky)
        
        Select CFG::*Config\DeleteFiles
            Case 0
                DisableMenuItem(DC::#PopUpMenu_001, 26, 1)
            Case 1
                DisableMenuItem(DC::#PopUpMenu_001, 26, 0)
        EndSelect
        
        SetMenuItemState(DC::#PopUpMenu_001, 17, CFG::*Config\DeleteFiles)
        SetMenuItemState(DC::#PopUpMenu_001, 18, CFG::*Config\AutoClearLt)
        SetMenuItemState(DC::#PopUpMenu_001, 25, CFG::*Config\Instanz)
        SetMenuItemState(DC::#PopUpMenu_001, 26, CFG::*Config\DontAskMe)
        SetMenuItemState(DC::#PopUpMenu_001, 30, CFG::*Config\CreateSHA1) 
        
    EndProcedure
    ;
    ;
    ; Setze den Status der Checkmarks im Popup Menu
    Procedure   SetMenuCheckMarksPopp()
        
        SetMenuItemState(DC::#PopUpMenu_002, 19, CFG::*Config\AutoClearLt)
        SetMenuItemState(DC::#PopUpMenu_002, 27, CFG::*Config\DontAskMe) 
        SetMenuItemState(DC::#PopUpMenu_002, 35, CFG::*Config\CreateSHA1)
        
        ;
        ; Pack Format Custom Menu Checkmarks
        ;
        Select (CFG::*Config\usFormat)
            Case 0
                SetMenuItemState(DC::#PopUpMenu_002, 36, 1)
                SetMenuItemState(DC::#PopUpMenu_002, 37, 0)
                SetMenuItemState(DC::#PopUpMenu_002, 38, 0)                 
            Case 1
                SetMenuItemState(DC::#PopUpMenu_002, 36, 0)
                SetMenuItemState(DC::#PopUpMenu_002, 37, 1) 
                SetMenuItemState(DC::#PopUpMenu_002, 38, 0)
            Case 2
                SetMenuItemState(DC::#PopUpMenu_002, 36, 0)
                SetMenuItemState(DC::#PopUpMenu_002, 37, 0)
                SetMenuItemState(DC::#PopUpMenu_002, 38, 1)                 
        EndSelect
        
        ;
        ; Pack Format Custom Menu ZIP Checkmarks
        ;        
        SetMenuItemState(DC::#PopUpMenu_002, 40, 0)
        SetMenuItemState(DC::#PopUpMenu_002, 41, 0)      
        SetMenuItemState(DC::#PopUpMenu_002, 42, 0)      
        SetMenuItemState(DC::#PopUpMenu_002, 43, 0)
        SetMenuItemState(DC::#PopUpMenu_002, 44, 0)
        SetMenuItemState(DC::#PopUpMenu_002, 40 + CFG::*Config\ZipMethodID, 1)
        
        Select CFG::*Config\DeleteFiles
            Case 0
                DisableMenuItem(DC::#PopUpMenu_002, 27, 1)
            Case 1
                DisableMenuItem(DC::#PopUpMenu_002, 27, 0)
        EndSelect
        SetMenuItemState(DC::#PopUpMenu_002, 20, CFG::*Config\DeleteFiles)
        SetMenuItemState(DC::#PopUpMenu_002, 51, CFG::*Config\CHDbSticky)        
        SetMenuItemState(DC::#PopUpMenu_002, 52, CFG::*Config\CHDbClipBoard)
        
        SetMenuItemState(DC::#PopUpMenu_002, 60, CFG::*Config\PinDirectory)        
        
    EndProcedure
    ;
    ;
    ; Setze das Aktuelle Archiv Format mit dem Drop7z arbeiten soll
    Procedure   SetArchivFormat(Format$ = "7z", usFormat = 0)
        
        Protected Title$ = Format$
        Protected  MultiVolume = #False
        
        ; usFormat =
        ; 0 = .7z/
        ; 1 = .zip
        ; 2 = .chd
        ;
        CFG::*Config\usFormat = usFormat 
        
        Sz$ = GetGadgetText(DC::#String_001)
        If (Sz$)
            SzOldExtension$ = UCase( GetExtensionPart(Sz$) )
            
            ; Check Filename for Multivolume
            If (SzOldExtension$ = "001")
                Sz$ =  ReplaceString(Sz$, ".001" ,"")  
                SzOldExtension$ = UCase( GetExtensionPart(Sz$) )
                MultiVolume = #True
            EndIf         
            
            If  (SzOldExtension$)
                If Not ( SzOldExtension$ = UCase(Format$) )
                    
                    SzDefExtension$ = Format$
                    
                    Sz$ = ReplaceString(Sz$, GetExtensionPart(Sz$) ,SzDefExtension$)
                    If (MultiVolume = #True)
                        Sz$ = Sz$ + ".001"
                    EndIf
                    SetGadgetText(DC::#String_001,Sz$)
                EndIf
            EndIf    
        EndIf
        SetGadgetText(DC::#Frame_006, ReplaceString(Title$, Left(Title$, 3) ,UCase( Left(Title$, 3) ) ,0,1,1) )    
    EndProcedure    
    Procedure.s GetArchivFormat()
        
        Select CFG::*Config\usFormat
            Case 0: ProcedureReturn "7z"
            Case 1: ProcedureReturn "zip"
            Case 2: ProcedureReturn "chd"
            Default
                ProcedureReturn "7z"
        EndSelect   
    EndProcedure    
    ;
    ;
    ; UI Elemenet An und ausschalten (Für 7Z)
    Procedure   SetUIElements7ZP(uiState.i = 0)
        
        ; Ui Elemenet Setzen
        DisableGadget(DC::#ComboBox_001,uiState)
        DisableGadget(DC::#ComboBox_002,uiState)
        DisableGadget(DC::#ComboBox_003,uiState)
        DisableGadget(DC::#ComboBox_004,uiState)        
        DisableGadget(DC::#CheckBox_005,uiState)
        ButtonEX::Disable(DC::#Button_005,uiState) ; Profile
        ;ButtonEX::Disable(DC::#Button_006,uiState) ; Single Compress
        
    EndProcedure
    
    ;
    ;
    ; UI Elemenet An und ausschalten (für ZIP)
    Procedure   SetUIElementsZIP(uiState.i = 0)
        
        ; Ui Elemenet Setzen
        DisableGadget(DC::#ComboBox_001,uiState)
        DisableGadget(DC::#ComboBox_002,uiState)
        DisableGadget(DC::#ComboBox_003,uiState)
        DisableGadget(DC::#CheckBox_005,uiState)
        ButtonEX::Disable(DC::#Button_005,uiState) ; Profile
        ;ButtonEX::Disable(DC::#Button_006,uiState) ; Single Compress
        
    EndProcedure
    
    ;
    ;
    ; UI Elemenet An und ausschalten (für CHD)
    Procedure   SetUIElementsCHD(uiState.i = 0)
        
        ; Ui Elemenet Setzen
        DisableGadget(DC::#ComboBox_001,uiState)
        DisableGadget(DC::#ComboBox_002,uiState)
        DisableGadget(DC::#ComboBox_003,uiState)
        DisableGadget(DC::#ComboBox_004,uiState)        
        DisableGadget(DC::#CheckBox_005,uiState)
        ButtonEX::Disable(DC::#Button_005,uiState) ; Profile
        ;ButtonEX::Disable(DC::#Button_006,uiState) ; Single Compress
        
    EndProcedure       
    ;
	;
    ;
    Procedure   SetUIElements_Global(n)
    	
    	Select n
    		Case 1 ;Offen 
    			
    			SetGadgetText(DC::#String_005,GetGadgetText(DC::#String_001))                               
    			HideGadget(DC::#String_005,0)          
    			HideGadget(DC::#String_001,1)           
    	EndSelect        
    	
    	DisableGadget(DC::#String_002,n)
    	If GetGadgetState(DC::#CheckBox_001) = 1
    		DisableGadget(DC::#String_003,n)
    	EndIf
    	If GetGadgetState(DC::#CheckBox_001) = 0
    		DisableGadget(DC::#String_003,1)
    	EndIf
    	
    	If GetGadgetState(DC::#CheckBox_005) = 1
    		DisableGadget(DC::#ComboBox_004,1)
    	EndIf
    	If GetGadgetState(DC::#CheckBox_005) = 0
    		DisableGadget(DC::#ComboBox_004,n)
    	EndIf
    	
    	DisableGadget(DC::#CheckBox_005,n)     
    	DisableGadget(DC::#CheckBox_004,n)    
    	DisableGadget(DC::#CheckBox_001,n)   
    	ButtonEX::Disable(DC::#Button_001,n)
    	DisableGadget(DC::#ComboBox_003,n)    
    	ButtonEX::Disable(DC::#Button_006,n)  
    	DisableGadget(DC::#CheckBox_002,n)    
    	ButtonEX::Disable(DC::#Button_004,n)   
    	DisableGadget(DC::#ComboBox_002,n)
    	ButtonEX::Disable(DC::#Button_003,n)    
    	DisableGadget(DC::#ComboBox_001,n)
    	ButtonEX::Disable(DC::#Button_005,n) 
    	DisableGadget(DC::#ComboBox_005,n)
    	ButtonEX::Disable(DC::#Button_002,n)   
    	DisableGadget(DC::#CheckBox_003,n)      
    	DisableGadget(DC::#String_001,n) 
    	
    	Select n
    		Case 0 ;Offen 
    			HideGadget(DC::#String_001,0)
    			HideGadget(DC::#String_005,1)                                                         
    			SetGadgetText(DC::#String_005,"")  
    		Case 1  
    	EndSelect
    	
    	Select CFG::*Config\usFormat
    		Case 0: SetUIElements7ZP()
    		Case 1: SetUIElementsZIP(1)
    		Case 2: SetUIElementsCHD(1)
    	EndSelect
    	
        If  ( CFG::*Config\PinDirectory = 1 )
            DisableGadget(DC::#String_002,1)
        EndIf      	
    	
    EndProcedure        
    ;
    ;
    ; Verzeichnis Befestigen und nicht ändern
    ; 1 = Hinzufügen zur Ini
    ; 0 = System Standard
    ; 2 = Beim Starten von Drop7z
    Procedure   Consolidate_Directory(uOption.i = 0)
        
        Protected  szString$, CntItems.i
        
        DisableGadget(DC::#String_002, 1): ButtonEX::Disable(DC::#Button_004,1)
        
        
        Select uOption
            Case 0
                ;
                ;
                CFG::*Config\szPinCurrent = ""
                DisableGadget(DC::#String_002, 0): ButtonEX::Disable(DC::#Button_004,0)
                ProcedureReturn
                
            Case 1
                ;
                ;
                szString$ = GetGadgetText( DC::#String_002)
                If ( szString$ = "" )
                    
                    CntItems = CountGadgetItems(DC::#String_002)
                    If ( CntItems = 0 )
                        ;
                        ; Keine Verzeichnisse in der Liste
                        ProcedureReturn 
                    EndIf
                    
                    ;
                    ; Nehmen wir immer das 1ste Verzeichnis was in der Liste sich befindet
                    szString$ = GetGadgetItemText(DC::#String_002,1)
                    
                EndIf     
                CFG::*Config\szPinCurrent = szString$ 
                
                SetGadgetText( DC::#String_002, CFG::*Config\szPinCurrent)
                INIValue::Set("SETTINGS","PinCurrentVZ", CFG::*Config\szPinCurrent, CFG::*Config\ConfigPath.s)
                
                ProcedureReturn
                
            Case 2
                ;
                ;
                SetGadgetText( DC::#String_002, CFG::*Config\szPinCurrent)
                ProcedureReturn 
        EndSelect
    EndProcedure    
    ;
    ;
    ; Variant: 0 = Die Grafische Version 7zg.exe
    ; Variant: 1 = Die Consolen Version  7z.exe
    ; Variant: 2 = Dll Version
    Procedure.s Locate7z(Variant.i)
        
        Protected szPath$       = ""
        Protected szFile$       = ""
        
        Protected szWin86$      = "C:\Program Files (x86)\"
        Protected szWin64$      = "C:\Program Files\"
        Protected szInstall$    = "7-zip\"
        
        Protected srRegPath$    = "SOFTWARE\7-Zip"
        Protected szRegData$    = "Path"
        
        
        Select ( Variant )
            Case 0: szFile$ = "7zG.exe"
            Case 1: szFile$ = "7z.exe"
        EndSelect       
        
        ;
        ; Portbale Variante wie B:\Tools\Start\Test\        
        szPath$ = INIValue::Get_S("SETTINGS","Portable", CFG::*Config\ConfigPath )
        If Not ( FileSize( szPath$ ) = -2 )
            If ( FileSize( szPath$ +  szFile$) >= 4096 )
                ProcedureReturn  szPath$ + szFile$
            EndIf
        EndIf
        
        ;
        ; Versuche es im Programm Ordner von Drop7z
        szPath$ = GetPathPart( ProgramFilename() )
        If ( FileSize( szPath$ ) = -2 ) 
            If ( FileSize( szPath$ +  szFile$) >= 4096 )
                ProcedureReturn  szPath$ +  szFile$
            EndIf
        EndIf
        
        ;
        ; Versuche es im Programm Ordner von Drop7z
        szPath$ = GetCurrentDirectory()
        If ( FileSize( szPath$ ) = -2 ) 
            If ( FileSize( szPath$ +  szFile$) >= 4096 )
                ProcedureReturn  szPath$ +  szFile$
            EndIf
        EndIf

        ;
        ; Versuche es in den Windows Verzeichnissen 64Bit()
        szPath$ = szWin64$ +  szInstall$
        If ( FileSize( szPath$ ) = -2 ) 
            If ( FileSize( szPath$ +  szFile$) >= 4096 )
                ProcedureReturn  szPath$ +  szFile$
            EndIf
        EndIf        
        
        ;
        ; Versuche es in den Windows Verzeichnissen 32Bit()
        szPath$ = szWin64$ +  szInstall$
        If ( FileSize( szPath$ ) = -2 ) 
            If ( FileSize( szPath$ +  szFile$) >= 4096 )
                ProcedureReturn  szPath$ +  szFile$
            EndIf
        EndIf         
        
        ;
        ; Versuche es in der Windows Registry 64Bit()        
        szPath$ = DropSysF::RegGetSzString( #HKEY_LOCAL_MACHINE, srRegPath$, szRegData$ + "64")  
        If ( FileSize( szPath$ ) = -2 )
            If ( FileSize( szPath$ +  szFile$) >= 4096 )
                ProcedureReturn  szPath$ +  szFile$
            EndIf            
        EndIf
        
        ;
        ; Versuche es in der Windows Registry 32Bit()        
        szPath$ = DropSysF::RegGetSzString( #HKEY_LOCAL_MACHINE, srRegPath$, szRegData$ )  
        If ( FileSize( szPath$ ) = -2 )
            If ( FileSize( szPath$ +  szFile$) >= 4096 )
                ProcedureReturn  szPath$ +  szFile$
            EndIf            
        EndIf
        
        Request::MSG( DropLang::GetUIText(20) , szFile$ + DropLang::GetUIText(23)  ,DropLang::GetUIText(24), 6, 2, ProgramFilename(), 0, 0, DC::#_Window_001)
        
        ProcedureReturn ""
        
    EndProcedure
    ;
    ;
    ;
    Procedure.i GetDriveType(szPath$)
        
        Protected Drive.s
        Protected Error.i
        
        Drive = Left(szPath$,1)
        
        Select GetDriveType_( Drive + ":\" )
            Case 1                              ; Virtuelles Laufwerk" 
            Case 2                              ; Disketten Laufwerk
            Case 3                              ; Festplatte
            Case 4                              ; Netzwerk 
            Case 5: ProcedureReturn 5           ; CD-Rom/ DVD-Laufwerk                    
            Case 6                              ; Ram-Disk
        EndSelect                       
        
        ProcedureReturn 0           
EndProcedure    
    
    ;
    ; Drop7z Message Text
    ;
    Procedure.s szMsgAboutText()
        Protected _AboutMsg.s = ""
        
        _AboutMsg=      CFG::*Config\WindowTitle.s
        _AboutMsg+#LF$+ ""
        _AboutMsg+#LF$+"Code: Marty Shepard"
        _AboutMsg+#LF$+"Icon: Rob2Seven (RIP)"
        _AboutMsg+#LF$+""
        _AboutMsg+#LF$+"Drop.7z is a Desktop Dragn'n'Drop Util "
        _AboutMsg+#LF$+"  addon for 7z (Seven Zip) to quickly  "
        _AboutMsg+#LF$+"      Compress Files and Folders       "
        _AboutMsg+#LF$+""              
        _AboutMsg+#LF$+"Changelog:                             "
        _AboutMsg+#LF$+"======================================="
        _AboutMsg+#LF$+"Version 0.99.95 Beta                   "
        _AboutMsg+#LF$+"- Added ISO for CHD Compress           "
        _AboutMsg+#LF$+"- Fixed Memory Thread Error by Count   "        
        _AboutMsg+#LF$+"---------------------------------------"         
        _AboutMsg+#LF$+"Version 0.99.94 Beta                   "
        _AboutMsg+#LF$+"- Rewritten Compress Mode (Full)       "
        _AboutMsg+#LF$+"- Rewritten Compress Mode (Single)     "        
        _AboutMsg+#LF$+"- Optic Changes                        "
        _AboutMsg+#LF$+"- Fixed Auto Complete History          "        
        _AboutMsg+#LF$+"- Fixed and Optimzed old Codes         "
        _AboutMsg+#LF$+"---------------------------------------" 
        _AboutMsg+#LF$+""                
        _AboutMsg+#LF$+"Version 0.99.93 Beta                   "
        _AboutMsg+#LF$+"- Various Code Changes                 "
        _AboutMsg+#LF$+"- About Optics Changed                 "
        _AboutMsg+#LF$+"- Fixed Auto Complete History          "
        _AboutMsg+#LF$+"- Add Support for M.A.M.E CHDMan       "        
        _AboutMsg+#LF$+"---------------------------------------" 
        _AboutMsg+#LF$+""        
        _AboutMsg+#LF$+"Version 0.99.92 Beta                   "
        _AboutMsg+#LF$+"- Fixed Clearing AutoComplete History  "
        _AboutMsg+#LF$+"- Replace DialogRequester              "
        _AboutMsg+#LF$+"- Removed Grammatical Erros            "
        _AboutMsg+#LF$+"- Fixed old Registry Code              "
        _AboutMsg+#LF$+"- Change Button Font                   "
        _AboutMsg+#LF$+"- Add Zip Support (Look PopupMenu)     "
        _AboutMsg+#LF$+"- Add Zip Options by 7-Zip             "        
        _AboutMsg+#LF$+"---------------------------------------"
        _AboutMsg+#LF$+""
        _AboutMsg+#LF$+"Version 0.99.8 Quick Fix Beta          "
        _AboutMsg+#LF$+"- Broken Autostart with Loading Drop7z "
        _AboutMsg+#LF$+" and Profile ini loading Fixed         "
        _AboutMsg+#LF$+"---------------------------------------"
        _AboutMsg+#LF$+""
        _AboutMsg+#LF$+"Version 0.99.8 Beta                    " 
        _AboutMsg+#LF$+"- Small Design and Gui Handle Changes  "
        _AboutMsg+#LF$+"  on Combox (Main -and Profile Window) "
        _AboutMsg+#LF$+"- Fixed a small bug in Password that   "
        _AboutMsg+#LF$+"  does'nt show in the Profile Window   " 
        _AboutMsg+#LF$+"  if there Exists but not check marked "
        _AboutMsg+#LF$+"  in the Main Window                   "                 
        _AboutMsg+#LF$+"- Changed Handle for Profile Ini and   "
        _AboutMsg+#LF$+"  Config ini                           "                
        _AboutMsg+#LF$+"---------------------------------------"
        _AboutMsg+#LF$+""
        _AboutMsg+#LF$+"Version 0.99.7 Beta                    "                 
        _AboutMsg+#LF$+"- PB Version Update 5.21 => 5.30       "
        _AboutMsg+#LF$+"  DropSevenZip Compiled with 5.30      "
        _AboutMsg+#LF$+"- Fixed a small bug in Autostart       "
        _AboutMsg+#LF$+"- Added an Excpetion Requester Path =1 " 
        _AboutMsg+#LF$+"- Exchanged Destination String with    "
        _AboutMsg+#LF$+"  with Combox and AutoComplete History "                  
        _AboutMsg+#LF$+"---------------------------------------"
        _AboutMsg+#LF$+""
        _AboutMsg+#LF$+"Version 0.99.6 Beta                    "                 
        _AboutMsg+#LF$+"- Added 7zSFX Support (SelfExtract)    "              
        _AboutMsg+#LF$+"---------------------------------------"
        _AboutMsg+#LF$+""
        _AboutMsg+#LF$+"Version 0.99.5 Beta                    "                 
        _AboutMsg+#LF$+"- Fixed Destination Path in Single Mode"           
        _AboutMsg+#LF$+"---------------------------------------"
        _AboutMsg+#LF$+""
        _AboutMsg+#LF$+"Version 0.99.4 Beta                    "                 
        _AboutMsg+#LF$+"- Fixed 'Stay On Top' if Open from     "
        _AboutMsg+#LF$+"  Tray IconMenu                        "               
        _AboutMsg+#LF$+"- Added SendMail                       "
        _AboutMsg+#LF$+"- Added new Style Requester (Testing)  " 
        _AboutMsg+#LF$+"- Few Small bug fixed                  "
        _AboutMsg+#LF$+"- Fixed SingleMode Full Compress       "
        _AboutMsg+#LF$+"- Added Send Mail and Hompage Button   "              
        _AboutMsg+#LF$+"---------------------------------------"
        _AboutMsg+#LF$+""
        _AboutMsg+#LF$+"Version 0.99.3 Beta                    "                 
        _AboutMsg+#LF$+"- Fixed Delete Directorys in Single    "               
        _AboutMsg+#LF$+"  Mode                                 "
        _AboutMsg+#LF$+"- Extended Requester Message if an     " 
        _AboutMsg+#LF$+"  Error occured due Delete Files       "
        _AboutMsg+#LF$+"- Fixed: a Marked State in the FileList"
        _AboutMsg+#LF$+"- Fixed: Catched Abort ExitCode by 7z  "
        _AboutMsg+#LF$+"- Optimze DropSevenZip Memory          "  
        _AboutMsg+#LF$+"---------------------------------------"
        _AboutMsg+#LF$+""
        _AboutMsg+#LF$+"Version 0.99.2 Beta                    " 
        _AboutMsg+#LF$+"- Small Bug's Fixed in the  Profile    "               
        _AboutMsg+#LF$+"  Editor                               "
        _AboutMsg+#LF$+"- Added 'Single Instance' Option       " 
        _AboutMsg+#LF$+"- Added 'Don't AskMe' Option for       "
        _AboutMsg+#LF$+"  Delete Files                         "
        _AboutMsg+#LF$+"- State Fix in the Password Checkbox   "                  
        _AboutMsg+#LF$+"---------------------------------------"                
        _AboutMsg+#LF$+""
        _AboutMsg+#LF$+"Version 0.99.1 Beta                    " 
        _AboutMsg+#LF$+"- Fixed Bug in Delete Files            "
        _AboutMsg+#LF$+"  (Allcoate Memory was to small.)      "
        _AboutMsg+#LF$+"- State Fix for Size/Items not Disable "
        _AboutMsg+#LF$+"- Clear File List doesnt Reset the     "
        _AboutMsg+#LF$+"  Password.                            "
        _AboutMsg+#LF$+"---------------------------------------"                
        _AboutMsg+#LF$+""
        _AboutMsg+#LF$+"Version 0.99.0 Beta                    " 
        _AboutMsg+#LF$+"- Many Design Changes                  "
        _AboutMsg+#LF$+"- FileList Changes                     "
        _AboutMsg+#LF$+"- Add Rename to the Profile Editor     "
        _AboutMsg+#LF$+"---------------------------------------"
        _AboutMsg+#LF$+""
        _AboutMsg+#LF$+"Version 0.98.8 Alpha                   "
        _AboutMsg+#LF$+"- Extended File Lister, Added Size     "
        _AboutMsg+#LF$+"- Changed Calculate Function           "
        _AboutMsg+#LF$+"- Changed Delete Files in Combination  "
        _AboutMsg+#LF$+"  with Compress all Single Files. 7z   "
        _AboutMsg+#LF$+"  Interleaved Archive does'nt Delete   "
        _AboutMsg+#LF$+"  Use on your own Risk. It's Beta      "
        _AboutMsg+#LF$+"- Added 'Auto Clear File List' in the  "
        _AboutMsg+#LF$+"  Tray icon and File Lister Popupmenu. "
        _AboutMsg+#LF$+"  If not enabled You can Drag'n'drop   "
        _AboutMsg+#LF$+"  from Various HD Locations."                
        _AboutMsg+#LF$+"---------------------------------------"                 
        _AboutMsg+#LF$+""
        _AboutMsg+#LF$+"Version 0.98.7 Alpha                   "
        _AboutMsg+#LF$+"- Change: Option Splittet, Start With  "
        _AboutMsg+#LF$+"  Windows and Minimized                "
        _AboutMsg+#LF$+"- Request: Added Window Stay On Top on "
        _AboutMsg+#LF$+"  The Tray Icon Menu                   "
        _AboutMsg+#LF$+"- Added: Delete Files after Compressing"
        _AboutMsg+#LF$+"  Use on your own Risk. It's Beta      "
        _AboutMsg+#LF$+"---------------------------------------" 
        _AboutMsg+#LF$+""
        _AboutMsg+#LF$+"Version 0.98.6 Alpha                   "
        _AboutMsg+#LF$+"- Fixed: Filehandling Issue in         "
        _AboutMsg+#LF$+"  Combination with Directory's /Suffix " 
        _AboutMsg+#LF$+"- Fixed: Start with Windows State Fix  " 
        _AboutMsg+#LF$+"---------------------------------------"                 
        _AboutMsg+#LF$+""
        _AboutMsg+#LF$+"Version 0.98.4 Alpha                   "
        _AboutMsg+#LF$+"- Added: Reload/Refresh Button on the  "
        _AboutMsg+#LF$+"  Profiles Window                      " 
        _AboutMsg+#LF$+"- Fixed: Missing Refresh State on      " 
        _AboutMsg+#LF$+"  Program Start" 
        _AboutMsg+#LF$+"---------------------------------------"                
        _AboutMsg+#LF$+""
        _AboutMsg+#LF$+"Version 0.98.3 Alpha                   "
        _AboutMsg+#LF$+"- Fixed: NoSPlit/SplitMode on Profile  "
        _AboutMsg+#LF$+"  Window. Corrected Filename.          " 
        _AboutMsg+#LF$+"- Fixed: Element 'Open File' and 'Size "
        _AboutMsg+#LF$+"  View'. Corrected State Disable/Enable" 
        _AboutMsg+#LF$+"- Few Font Changes!                    "
        _AboutMsg+#LF$+"- Fixed: Small Bug on Password State   "                 
        _AboutMsg+#LF$+"---------------------------------------" 
        _AboutMsg+#LF$+""
        _AboutMsg+#LF$+"Version 0.98.2 Alpha                   "
        _AboutMsg+#LF$+"- Change: Small Layout Changes         " 
        _AboutMsg+#LF$+"- Added : Checkbox for -ssw            " 
        _AboutMsg+#LF$+"- Change: On The Profile Window        "                   
        _AboutMsg+#LF$+"---------------------------------------" 
        _AboutMsg+#LF$+""
        _AboutMsg+#LF$+"Version 0.98.1 Alpha                   "
        _AboutMsg+#LF$+"- Change: Detail/Design in the Profile " 
        _AboutMsg+#LF$+"  Window" 
        _AboutMsg+#LF$+"- Added : 7z -ssw Command-Line Switsh  " 
        _AboutMsg+#LF$+"- Added : 7z Default Compression-Types " 
        _AboutMsg+#LF$+"- Fixed : Profile Window, Stay On Top  " 
        _AboutMsg+#LF$+"  Handle" 
        _AboutMsg+#LF$+"---------------------------------------"                 
        _AboutMsg+#LF$+""
        _AboutMsg+#LF$+"Version 0.97.1 Alpha                   "
        _AboutMsg+#LF$+"- Added : User Option for SplitSize for" 
        _AboutMsg+#LF$+"  Multi-Volumes Archives               " 
        _AboutMsg+#LF$+"- Fixed : Window Handle if Running 7z  " 
        _AboutMsg+#LF$+"- Added : Profile Settings. Save/Store " 
        _AboutMsg+#LF$+"  your Individual Settings" 
        _AboutMsg+#LF$+"---------------------------------------"
        _AboutMsg+#LF$+""
        _AboutMsg+#LF$+"Version 0.97 Useless                   "
        _AboutMsg+#LF$+"- Change: Design and Layout            " 
        _AboutMsg+#LF$+"- Added : PopupMenu to Filelist Window "  
        _AboutMsg+#LF$+"- Request: Option, 150MB Split Archiv  " 
        _AboutMsg+#LF$+"- Added : Progress Indicator for       " 
        _AboutMsg+#LF$+"  Compress Single Files                " 
        _AboutMsg+#LF$+"- Handle Change if Running 7z          " 
        _AboutMsg+#LF$+"---------------------------------------" 
        _AboutMsg+#LF$+""
        _AboutMsg+#LF$+"Version 0.96 Useless                   "
        _AboutMsg+#LF$+"- Design and Layout Changes            " 
        _AboutMsg+#LF$+"- Added Option to Split Archives       " 
        _AboutMsg+#LF$+"- Add Missing ToolTip for Destination. " 
        _AboutMsg+#LF$+"- Add Calculate the Size for Dir/Files " 
        _AboutMsg+#LF$+"---------------------------------------"                
        _AboutMsg+#LF$+""
        _AboutMsg+#LF$+"Version 0.95 Useless                   "
        _AboutMsg+#LF$+"- *First Public Beta Release           " 
        _AboutMsg+#LF$+"***************************************" 
        _AboutMsg+#LF$+""
        _AboutMsg+#LF$+""
        _AboutMsg+#LF$+"This software is provided as-is,without"
        _AboutMsg+#LF$+"any express OR implied warranty. In no "
        _AboutMsg+#LF$+"event  will the authors be held liable "
        _AboutMsg+#LF$+"For any  damages  arising from the use "
        _AboutMsg+#LF$+"ofthis software."
        _AboutMsg+#LF$+""
        _AboutMsg+#LF$+"Permission is granted to anyone to use "
        _AboutMsg+#LF$+"this software for any purpose,including"
        _AboutMsg+#LF$+"commercial applications, and to alter  "
        _AboutMsg+#LF$+"it and redistribute it freely subject to"
        _AboutMsg+#LF$+"the following restrictions:            "
        _AboutMsg+#LF$+""
        _AboutMsg+#LF$+"1. The origin of this software must not"
        _AboutMsg+#LF$+"be misrepresented; you must not claim  "
        _AboutMsg+#LF$+"original Software.If you use this      "
        _AboutMsg+#LF$+"software  IN  a product,anacknowledgment"
        _AboutMsg+#LF$+"IN the product documentation would be  "
        _AboutMsg+#LF$+"appreciated but is Not required.       "
        _AboutMsg+#LF$+""
        _AboutMsg+#LF$+"2. Altered source versions must be     "
        _AboutMsg+#LF$+"plainly marked as such,and must not be "
        _AboutMsg+#LF$+"misrepresented as being the original   "
        _AboutMsg+#LF$+"software."
        _AboutMsg+#LF$+""
        _AboutMsg+#LF$+"3. This notice may Not be removed Or   "   
        _AboutMsg+#LF$+"altered from any source distribution.  "
        _AboutMsg+#LF$+""
        _AboutMsg+#LF$+"4. This software uses Not part of source"
        _AboutMsg+#LF$+"code of 7z.7zip is subject To the rules"
        _AboutMsg+#LF$+"of the GNU LGPL + unRAR restriction.   "
        _AboutMsg+#LF$+"The copyright is owned by Igor Pavlov  "
        _AboutMsg+#LF$+"And Alexander Roshal (unRAR)."
        _AboutMsg+#LF$+""
        _AboutMsg+#LF$+"This software is intended only As Drag "
        _AboutMsg+#LF$+"and Drop frontend for 7z. Do You have  " 
        _AboutMsg+#LF$+"Problems With this software? Mail me   "
        _AboutMsg+#LF$+""
        _AboutMsg+#LF$+"FF? ... Fast Fertig ..................."        
        ProcedureReturn _AboutMsg
    EndProcedure

EndModule

; IDE Options = PureBasic 5.73 LTS (Windows - x64)
; CursorPosition = 443
; FirstLine = 58
; Folding = DA+
; EnableAsm
; EnableXP
; UseMainFile = ..\Drop7z.pb