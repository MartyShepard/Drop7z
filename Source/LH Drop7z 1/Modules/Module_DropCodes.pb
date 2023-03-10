DeclareModule DropCode
    
    Declare     SetMenuCheckMarksTray()
    Declare     SetMenuCheckMarksPopp()
    
    Declare     SetUIElements7ZP(uiState.i = 0)
    Declare     SetUIElementsZIP(uiState.i = 0)
    Declare     SetUIElementsCHD(uiState.i = 0)
    Declare	    SetUIElements_Global(n)
    
    Declare     SetArchivFormat(Format$ = "7z", usFormat = 0)
    Declare.s   GetArchivFormat()
    
    Declare.i   GetDriveType(szPath$)
    
    Declare.s   Locate7z(Variant.i)

    
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
    	
    	  SetMenuItemState(DC::#PopUpMenu_002, 16, CFG::*Config\Sticky)
    	
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
        
        SetMenuItemState(DC::#PopUpMenu_002, 70,CFG::*Config\HandleExeAsRAR)
        SetMenuItemState(DC::#PopUpMenu_002, 71,CFG::*Config\HandleExeAsZIP)
        SetMenuItemState(DC::#PopUpMenu_002, 72,CFG::*Config\HandleExeAsS7Z)        
        SetMenuItemState(DC::#PopUpMenu_002, 73,CFG::*Config\ConvertDelTemp)        
        SetMenuItemState(DC::#PopUpMenu_002, 75,CFG::*Config\UnpackOnly) 
        SetMenuItemState(DC::#PopUpMenu_002, 74,CFG::*Config\UnpackInSubDirectory)
        
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
                    ; Nehmen wir immer das 1etze Verzeichnis was in der Liste sich befindet
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
    
 

EndModule

; IDE Options = PureBasic 5.73 LTS (Windows - x64)
; CursorPosition = 21
; FirstLine = 3
; Folding = -e+
; EnableAsm
; EnableXP
; UseMainFile = ..\Drop7z.pb