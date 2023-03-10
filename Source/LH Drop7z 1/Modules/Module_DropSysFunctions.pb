DeclareModule DropSysF
    
    Declare     	Autostart()			; Todo BUGGY
    Declare     	RegAutostart_Save()     ; Für den Menüeintrag (Tray Icon)
    Declare     	RegAutostart_Kill()     ; Für den Menüeintrag (Tray Icon)
    
    Declare     	MultipleInstances()
    Declare     	Process_FreeRam()
    Declare.s   	File_CreateRandom()
    
    Declare     	Window_SetPosition()
    Declare     	Window_SetMinimized()
    
    Declare.i   	Directory_OpenTest()
    Declare		Directory_Open()
    
    Declare.s   RegGetSzString( hKey.l, RegPath$, lpValueName$ ,ulOptions = 0, samDesired.l  = #KEY_ALL_ACCESS )    
EndDeclareModule

Module DropSysF
    ;
    ;
    ;
    Procedure   Process_FreeRam()

      Protected ProcID.l ,ProcError.i
  
        ProcID    =   GetCurrentProcessId_()  
        ProcError =   SetProcessWorkingSetSize_( GetCurrentProcess_() , -1, -1)       
    EndProcedure
    ;
    ;
    ; Setze die Fenster Position auf dem Desktop
    Procedure   Window_SetPosition()
        
        CFG::*Config\DesktopH = WindowHeight(DC::#_Window_001, #PB_Window_FrameCoordinate)
        CFG::*Config\DesktopW = WindowWidth (DC::#_Window_001, #PB_Window_FrameCoordinate)
        
        SetWindowPos_( (WindowID(DC::#_Window_001) ), #HWND_TOP, CFG::*Config\DesktopX, CFG::*Config\DesktopY, CFG::*Config\DesktopW, CFG::*Config\DesktopH,#NUL)        
        
    EndProcedure
    ;
    ;
    ;
    Procedure   Window_SetMinimized()
        
        Select ( CFG::*Config\MiniMized )
            Case 0
                ShowWindow_(WindowID(DC::#_Window_001),#SW_RESTORE)
                ShowWindow_(WindowID(DC::#_Window_001),#SW_SHOW)
            Case 1        
                ShowWindow_(WindowID(DC::#_Window_001),#SW_HIDE)         
                ShowWindow_(WindowID(DC::#_Window_001),#SW_MINIMIZE)
        EndSelect        
    EndProcedure
    ;    
    ;
    ; List ob Drop7z im Autostart liegt
    Procedure.s RegAutostart_Read()
        Protected Size.i    =   #MAX_PATH
        Protected Name.s    =   Space(Size)
        Protected Handle.l  =     -1
        Protected Result.i  =     -1
        Protected szTitle$  =   "Drop7z"        
        Protected RegPath$  =   "SOFTWARE\Microsoft\Windows\CurrentVersion\Run"

        
        ;Protected ProFileConfig$
        ;ProFileConfig$ = GetPath_Config(2)
                       
        Handle = RegOpenKeyEx_(#HKEY_CURRENT_USER, RegPath$, 0, #KEY_ALL_ACCESS, @Key)
        
        If ( Handle = 0 )
            Result = RegQueryValueEx_(Key, szTitle$, 0, 0, @Name, @Size)
            RegCloseKey_(Key)
            
            If ( Result = 0 )
                
                Debug ""
                Debug "Drop7z liegt im Autostart ( " + Name.s + " ) "
                
                ProcedureReturn GetPathPart(Name)               
            EndIf    
        EndIf 
        
        Debug ""
        Debug "Drop7z liegt nicht im Autostart"        
        
        ProcedureReturn ""        
    EndProcedure    
    ;
    ;
    ; Sichert Drop7z in den Autostart
    Procedure   RegAutostart_Save()
        
        Protected szName$   =   ""
        Protected Handle.l  =     -1
        Protected szTitle$  =   "Drop7z"           
        Protected RegPath$  =   "SOFTWARE\Microsoft\Windows\CurrentVersion\Run"
        
        Handle = RegOpenKeyEx_(#HKEY_CURRENT_USER, RegPath$, 0, #KEY_ALL_ACCESS, @Key)        
        If ( Handle = 0 )
            
            If ( RegCreateKeyEx_(#HKEY_CURRENT_USER, RegPath$, 0, 0, #REG_OPTION_NON_VOLATILE, #KEY_ALL_ACCESS, 0, @Name, @KeyInfo) = #ERROR_SUCCESS )
                
                RegSetValueEx_(Name, szTitle$, 0, #REG_SZ,  Chr(34) + ProgramFilename() + Chr(34), 255): RegCloseKey_(Name)
                
                szName$ = RegAutostart_Read() 
                If ( szName$ )
                    Debug "Drop7z liegt nun im Autostart ( " + szName$ + " )"     
                Else                 
                    Debug "ERROR: Konnte Drop7z nicht in den Autostart packen"                     
                EndIf
                
            EndIf                        
        EndIf        
        
    EndProcedure    
    ;
    ;
    ;
    Procedure   RegAutostart_Kill()
        
        Protected szName$   =   ""        
        Protected Handle.l  =     -1
        Protected szTitle$  =   "Drop7z"          
        Protected RegPath$  =   "SOFTWARE\Microsoft\Windows\CurrentVersion\Run"
        
        Handle.l = RegOpenKeyEx_(#HKEY_CURRENT_USER, RegPath$, 0, #KEY_ALL_ACCESS, @hKey.l)
        If ( Handle = 0 )
            
            RegDeleteValue_(hKey,szTitle$)
            
            szName$ = RegAutostart_Read() 
            If ( szName$ )
                Debug "ERROR: Drop7z immer noch im Autostart ( " + szName$ + " ) "     
            Else          
                Debug "Drop7z erfolreich aus dem Autosatrt entfernt"                     
            EndIf                
        EndIf
        
    EndProcedure
    ;
    ;
    ;
    Procedure   Autostart()
        
        ; Überprüfe ob Drop7z im Autosstart liegt und Update die Config 
        
        Select ( CFG::*Config\Autostart )
            Case 1
                ; Config sagt True, dennoch Prüfe und schaue ob Drop7z im Autostart ist
                ;
                ;
                If (RegAutostart_Read() = "")                    
                    INIValue::Set_Value("SETTINGS","AutoStart",0,CFG::*Config\ConfigPath.s): CFG::*Config\Autostart = 0
                EndIf
                ProcedureReturn 
                
            Case 0
                ; Config sagt False, dennoch Prüfe und schaue ob Drop7z im Autostart ist
                ;
                ; Füge dem Autostart Hinzu                
                If ( RegAutostart_Read() )                     
                    INIValue::Set_Value("SETTINGS","AutoStart",1,CFG::*Config\ConfigPath.s): CFG::*Config\Autostart = 1
                    
                    ; AutoStartFolder$ = Chr(34) + ProgramFilename() + Chr(34)
                    
                    If ( LCase( Chr(34) + ProgramFilename() + Chr(34) ) <> LCase( RegAutostart_Read() ) )
                        ;
                        ; Update Autostart
                        RegAutostart_Save()
                    EndIf                                                 
                EndIf                
                ProcedureReturn 
        EndSelect

    EndProcedure    
    ;
    ;
    ;
    Procedure.s RegGetSzString( hKey.l, RegPath$, lpValueName$ ,ulOptions = 0, samDesired.l  = #KEY_ALL_ACCESS )
        
        Protected Size.i    =   #MAX_PATH
        Protected Name.s    =   Space(Size)
        Protected Handle.l  =     -1
        Protected Result.i  =     -1        
        
         Handle = RegOpenKeyEx_(hKey, RegPath$, 0, samDesired, @Key)
         If ( Handle = 0 )
             Result = RegQueryValueEx_(Key, lpValueName$, 0, 0, @Name, @Size)
             RegCloseKey_(Key)
             
             If ( Result = 0 )
                 
                Debug ""
                Debug "Drop7z über der Registry ausgelesen: ( " + Name + " ) "                 
                ProcedureReturn Name
            EndIf    
         EndIf                     
    
     EndProcedure   
    ;
    ;
    ;
     Procedure.s File_CreateRandom()
         
        Protected Size.i    =   #MAX_PATH
        Protected File.s    =   Space(Size)         
         
        GetTempPath_(Size, @File)
        
        File + Str( Random( 100000 ) ) + ".lst"
        
        ProcedureReturn File        
     EndProcedure        
    ;
    ;
    ; Erlaube mehrere Aufruffe von Drop7z ?
    Procedure MultipleInstances()        
        Protected sPhore.l
        
        If ( CFG::*Config\Instanz = 1 )
            ;
            ; Nur eine Instanz von Drop7z Erlaubt
            
            sPhore = CreateSemaphore_(0, 0, 1, GetFilePart( ProgramFilename() ))
   
            If ( sPhore <> 0 ) And ( GetLastError_() = #ERROR_ALREADY_EXISTS)
                ;
                ; Jede nachfolgende Instanz sofort schliessen
                CloseHandle_(sPhore)
                End
            EndIf            
        EndIf
    
    EndProcedure
    ;
    ;
    ; Test Directory Exists
    Procedure.i Directory_OpenTest()
    	
    	Protected.s szDirectory
    	
    	szDirectory = GetGadgetText( DC::#String_002 )
    	;
    	; Check 
    	If ( Len ( szDirectory ) > 0)
    		
    		
    		If Not ( Right( szDirectory , 1)  = "\" )
    			szDirectory + "\"
    		EndIf
    		
    		If Not ( FileSize( szDirectory ) = -2 ) 
    			;
			;			
			; Is not a Directory
    			CFG::*Config\szComboStringInfo = "Ziel Verzeichnis (Nicht Gefunden)"
    			ProcedureReturn #True
    		EndIf	
    			    			
    		
    	Else
    		;
		; 
		; String is Empty
    		CFG::*Config\szComboStringInfo = "Kein Zielverzeichnis vorhanden"
    		ProcedureReturn #True
    	EndIf	
    	
    	CFG::*Config\szComboStringInfo = "Ziel Verzeichnis Öffnen"
    	ProcedureReturn #False

    EndProcedure	
    ;
    ;
    ; Open Dest Directory    
    Procedure.i Directory_Open()
    	
    	Protected.s szDirectory
    	
    	szDirectory = GetGadgetText( DC::#String_002 )
    	
    	If Not ( Directory_OpenTest() )
    		FFH::ShellExec(szDirectory, "open")	
    	EndIf	    	
    	
    	; Declare.i ShellExec(lpFilePath$ = "",Verb$ = "",Paramter$ = "", Mask = #Null, ExShow.i = #SW_SHOWNORMAL, shAdmin.i = #False, Simple = 1)
    	
    EndProcedure
    
EndModule

; IDE Options = PureBasic 5.73 LTS (Windows - x64)
; CursorPosition = 267
; FirstLine = 48
; Folding = DA-
; EnableAsm
; EnableXP
; UseMainFile = ..\Drop7z.pb