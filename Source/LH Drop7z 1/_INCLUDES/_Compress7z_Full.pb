;
;
; Grafische 7zOberfläche

DeclareModule DropPack
    
    Declare.i   Compress()
EndDeclareModule    


Module DropPack
      
    Structure PROGRAM_BOOT
        Program.s       ; 7z Path and Programm
        PrgPath.s
        DstPath.s       ; The 7z Destination Path
        Command.s       ; The 7z Commando
        Logging.s
        PrgFlag.l
        ExError.i  
        StError.s
        sz7zArchiv.s    ; The 7zArchiv
        szTempFile.s    ; File to hold the List
        szPrgPWord.s    ; Secret
        szPrgEncrp.s    ; Secret, Encryption
        szPrgPOFls.s    ; Open Files
        szPrgMulti.s    ; Grösse der Multivolume Archive
        szPrgSDict.s    ; Dictionary
        szPrgSWord.s    ; Word Size
        szPrgSBlok.s    ; Block Size
        szPrgModus.s    ; Compression Mode
        szPrgSfSFX.s    ; Selbst Enpackende Archive
        ulMutex.l
        ulThread.l
        LoProcess.l
        HiProcess.l
        bForceBreak.i
        exitCodeHi.i
        exitCodeLo.i
        List Collection.s()
    EndStructure 
        
    ;
    ;
    ;    
    ;
    ;
    ; Überprpfe ob die Datei existiert und Optionl Lösche diese
	
	Procedure.i FileExists(*P.PROGRAM_BOOT)
	    
	    ; Check For File Exists		    
	    Protected szMsgNote$
	    
	    If FileSize( *P\DstPath + *P\sz7zArchiv  ) >= 0
	        
	        szMsgNote$  = GetFilePart( *P\DstPath + *P\sz7zArchiv ) + #CR$ + DropLang::GetUIText(33) 
	        
            Request::*MsgEx\User_BtnTextL = DropLang::GetUIText(34) 
            Request::*MsgEx\User_BtnTextM = DropLang::GetUIText(35) 
            Request::*MsgEx\User_BtnTextR = DropLang::GetUIText(36)  
            
            Select Request::MSG( DropLang::GetUIText(20), DropLang::GetUIText(32) , szMsgNote$, 16, 1, ProgramFilename(), 0, 0, DC::#_Window_001)
                    ;
                    ; Akualsieren
                Case 2: ProcedureReturn 0    
	                ;
	                ; Abbruch
                Case 1: ProcedureReturn 1
                    ;
                    ; Überschreiben
                Case 0:
                        If ( FileSize(   *P\DstPath + *P\sz7zArchiv  ) >= 0 )
                            DeleteFile(  *P\DstPath + *P\sz7zArchiv  )
                            Delay(1000)
                        EndIf
                        ProcedureReturn 0
            EndSelect 		
        EndIf
        
    EndProcedure
    ;
    ;
    ;
    Procedure.s FileVolume_RemoveNum(szFile$)        
        ;
        ; Entferne .001
        If ( Right(szFile$,4) = ".001" )
            szFile$ = ReplaceString( szFile$ ,".001", "" )
        EndIf	
        ProcedureReturn szFile$
    EndProcedure    
    ;
    ;
    ;
    Procedure   FileSuffix(*P.PROGRAM_BOOT)
        Protected sfFmt.s = ""
        Protected chars.i = 0
        Protected multi.i = #False
        
        sfFmt = DropCode::GetArchivFormat()
        chars = Len( sfFmt ) + 1 ; +1 the Dot ".7z"
        
        ;
        ; Multivolume Archiv
        If ( Right( *P\sz7zArchiv, 4 ) = ".001" )
            multi = #True
            *P\sz7zArchiv = ReplaceString( *P\sz7zArchiv ,".001", "" )
        EndIf
        
        
	    If Not ( Right( *P\sz7zArchiv, chars) = "." + sfFmt )
	         *P\sz7zArchiv + "." + sfFmt
	    EndIf	         
	    
	    ;
	    ; Multivolume Archiv, hänge wieder 001 dran
	    If (multi = #True)
	         *P\sz7zArchiv + "." + "001"
	    EndIf    
	    
	    SetGadgetText(DC::#String_001, *P\sz7zArchiv ); Aktualisere den Dateinam im Vordergrund
	    SetGadgetText(DC::#String_005, *P\sz7zArchiv ); Aktualisere den Dateinam im Hintergrund
        
    EndProcedure
    ;
	;
    ; Überprüft ob am ende des Zeilverzeichnis ein backslah dran hängt
	Procedure.s Path_CheckEnd(szDestPath.s)
	    
	    If Not Right(szDestPath,1) = "\"
	        szDestPath + "\"
	        ProcedureReturn szDestPath
	    EndIf
	    ProcedureReturn szDestPath
	EndProcedure
	;
    ;
	;
    Procedure.i Path_Verify()                
        
        Protected szFilePath$ = GetGadgetText(DC::#String_002)
        
        If Not (FileSize( Path_CheckEnd( szFilePath$ ) ) = -2 )
            
            If (szFilePath$)
                szFilePath$ = " :" + #CR$ + Chr(34) + szFilePath$ + Chr(34)
            Else
                szFilePath$ = #CR$ + Chr(34) + szFilePath$ + Chr(34)
            EndIf
            
            Request::MSG( DropLang::GetUIText(20) , DropLang::GetUIText(25)  ,DropLang::GetUIText(26) + szFilePath$ , 2, 0, ProgramFilename())
            ProcedureReturn 11
        EndIf
        
        SetGadgetText(DC::#String_002, Path_CheckEnd( GetGadgetText(DC::#String_002) ) )
        
        ProcedureReturn 0
        
    EndProcedure
    ;
    ;
    ;
    Procedure   zWrite_TempFile(*P.PROGRAM_BOOT)  
        
        *P\szTempFile = DropSysF::File_CreateRandom()
        
        If Not ( CreateFile( DC::#_TempFile, *P\szTempFile ) )
            ProcedureReturn 1
        EndIf

    EndProcedure
    ;
    ;
    ;
    Procedure   zDelete_TempFile(*P.PROGRAM_BOOT)
        
        If ( FileSize( *P\szTempFile ) >= 1 )
             DeleteFile( *P\szTempFile)
        EndIf    
        
    EndProcedure
    ;    
    ;
    ;
    Procedure.i zCollect_Write(*P.PROGRAM_BOOT)
        
        
        If ( ListSize( *P\Collection() ) >=1 )
            
            ResetList( *P\Collection() )
            
            Debug ""
            Debug "7zArchiv - Schreibe in die Datei: " + *P\szTempFile
            Debug "7zArchiv - List Grösse          : " + Str( ListSize( *P\Collection() ) )
            
            If OpenFile ( DC::#_TempFile, *P\szTempFile )
                ForEach *P\Collection()             
                    WriteStringN(DC::#_TempFile, *P\Collection() )            
                    Debug "         > " + *P\Collection()
                Next    
                CloseFile( DC::#_TempFile)
                ProcedureReturn 0
            EndIf
        Else
            
            Debug ""
            Debug "7z Archiv. ERROR: Die Liste hat keine Einträge"
            Request::MSG( DropLang::GetUIText(20) , DropLang::GetUIText(29) , DropLang::GetUIText(30), 2, 0, ProgramFilename())  
            ProcedureReturn 1
        EndIf
    EndProcedure
    ;
    ;
    ; Sammle alle markierten Dateien
    Procedure   zCollect_Files_AllMarked(*P.PROGRAM_BOOT)
        Protected Item.i  = -1
        Protected Count.i = -1
        Protected Path$   = ""
        Protected File$   = ""
        Protected Status  = -1
                
        Count = CountGadgetItems(DC::#ListIcon_001)
        
        For Item = 0 To Count
            Status = GetGadgetItemState( DC::#ListIcon_001, Item )
            If ( Status >= 2 )
                Path$ = GetGadgetItemText( DC::#ListIcon_001,Item, 0)              
                File$ = GetGadgetItemText( DC::#ListIcon_001,Item, 1)
            
                If ( File$  = "" )
                    File$ = ""
                EndIf
                            
                AddElement( *P\Collection() ): *P\Collection()  = Path$ + File$
                
                If ( Item = Count-1 )
                    ResetList( *P\Collection() )
                    ProcedureReturn 
                EndIf
            EndIf    
        Next
            
    EndProcedure    
    ;
    ;
    ; Sammle alle Dateien
    Procedure   zCollect_Files_NonMarked(*P.PROGRAM_BOOT)
        
        Protected Item.i  = -1
        Protected Count.i = -1
        Protected Path$   = ""
        Protected File$   = ""
        
        Count = CountGadgetItems(DC::#ListIcon_001)
        For Item = 0 To Count
            Path$ = GetGadgetItemText( DC::#ListIcon_001,Item, 0)              
            File$ = GetGadgetItemText( DC::#ListIcon_001,Item, 1)
            
            If (File$ = "")
                File$ = ""
            EndIf    
            

            AddElement( *P\Collection() ): *P\Collection()  = Path$ + File$
            
            If ( Item = Count-1 )
                ResetList( *P\Collection() )
                ProcedureReturn 
            EndIf    
        Next
            
    EndProcedure      
    ;
    ;
    ; Sammle alle Dateien und ein Normales Archiv erstellen über die *.lst Datei
    Procedure   zCollect_Files(*P.PROGRAM_BOOT)
        
        Protected bCheck  = #False                  ; #False ist immer NULL
        Protected cnt.i   = -1
        Protected max.i   = -1
        Protected Status.i= -1
        

        Debug #PB_ListIcon_ThreeState 
  
        max = CountGadgetItems(DC::#ListIcon_001)
        
        For cnt = 0 To max
            Status = GetGadgetItemState(DC::#ListIcon_001, cnt)
            
            ;
            ; ListIcon Status
            ; #PB_ListIcon_Selected = 1
            ; #PB_ListIcon_Checked  = 2
            ; #PB_ListIcon_Inbetween= 4            
            ;            
            If ( Status >= 2 )  
                zCollect_Files_AllMarked(*P)
                ProcedureReturn 
            EndIf            
        Next
        
        If ( Status = 0 )
            zCollect_Files_NonMarked(*P)
        EndIf    
                    
    EndProcedure

    ;
    ;
    ;
    Procedure.i zArchiv_MultiVolume( *P.PROGRAM_BOOT )
        
        Protected szMVF.s = ""
        Protected szMsg.s = ""
        Protected sfFmt.s = ""
        
        If ( GetGadgetState(DC::#ComboBox_004) >= 1 )
            
            sfFmt = DropCode::GetArchivFormat()
            szMVF = ReplaceString( *P\sz7zArchiv ,"." + sfFmt + ".001", "." + sfFmt )
            
            If ( FileSize( *P\DstPath +  szMVF) >=0 )
                
                Select ( DropLang::GetLngSysUI(-1) )
                    Case 407
                        szMsg = "Kann kein Multivolume Archiv (." + DropCode::GetArchivFormat() + ".001) erstellen weil ein " + #CR$ +
                                DropCode::GetArchivFormat() + " Archiv im Verzeichnis: " + Chr(34) + *P\DstPath + Chr(34) + " existiert."
                    Default
                        szMsg = "Can't create a Multivolume Archiv (."+DropCode::GetArchivFormat()+".001) because a " + #CR$ +
                                DropCode::GetArchivFormat() + " Archiv File exists in the Directory: "+ Chr(34) + *P\DstPath + Chr(34)
                EndSelect        
                
                Request::MSG( DropLang::GetUIText(20) , DropLang::GetUIText(31) , szMsg, 2, 0, ProgramFilename())
                ProcedureReturn 1
            EndIf
            
        EndIf    
        
        ;
        ; Entferne .001
        *P\sz7zArchiv = FileVolume_RemoveNum(*P\sz7zArchiv)    
        
        ProcedureReturn 0        
    EndProcedure    
    ;
    ;
    ;
    Procedure   zProgram_DoWortPass(*P.PROGRAM_BOOT)        
        If ( GetGadgetState(DC::#CheckBox_001) = 1 )
            
            If (Len( GetGadgetText(DC::#String_003) ) >= 1)                            
                *P\szPrgPWord = GetGadgetText(DC::#String_003)
                
                Select CFG::*Config\usFormat
                    Case 0: *P\szPrgEncrp = "-p" + *P\szPrgPWord + " -mhc=on -mhe=on"      ; Für 7z
                    Case 1: *P\szPrgEncrp = "-p" + *P\szPrgPWord + " -mem=AES256"          ; Für Zip
                EndSelect                 
            EndIf    
        EndIf                   
    EndProcedure
    ;
    ;
    ;
    Procedure   zProgram_DoOpenFile(*P.PROGRAM_BOOT)
        
        If GetGadgetState(DC::#CheckBox_003) = 1
            *p\szPrgPOFls    = " -ssw"
        EndIf
        
    EndProcedure
    ;
    ;
    ;
    Procedure   sProgram_DoMultiVol(*P.PROGRAM_BOOT)
        
        Protected nItem.i  =  0
        Protected ulSize.i =  0
        Protected szSize.s = ""
        Protected ulPosn.i = -1
        
        nItem  = GetGadgetState(DC::#ComboBox_004)
        
        If (nItem >= 0 )
            SelectElement( DropLS::SizeSplit(), nItem )
            
            Select ( nItem )
                Case 0, 1, 10   :  *P\szPrgMulti = ""                                             : ProcedureReturn
                Default         :  *P\szPrgMulti = " -v" + Str( DropLS::SizeSplit()\iSize ) + "m" : ProcedureReturn 
            EndSelect
        Else
            
            ;
            ; Benutzer Definierte Grössen
            If ( nItem = -1 )
                ulSize = Val  ( GetGadgetText(DC::#ComboBox_004) )
                szSize = LCase( GetGadgetText(DC::#ComboBox_004) )
                    
                ulPosn = FindString( szSize, "gb", 1 )
                
                If ( ulPosn >=1 And ulSize >= 1 ) 
                    ;
                    ; in Gigabyte
                    *P\szPrgMulti = " -v" + Str(ulSize) + "g": ProcedureReturn

                ElseIf  ( ulSize >= 1)                     
                    ;
                    ; in Megabyte
                    *P\szPrgMulti = " -v" + Str(ulSize) + "m": ProcedureReturn 
                    
                Else
                    ;
                    ;
                    *P\szPrgMulti = ""
                EndIf 
            EndIf                    
        EndIf      
        
    EndProcedure
    ;
    ;
    ;
    Procedure   zProgram_DoDictiony(*P.PROGRAM_BOOT)
        
        Protected nItem.i = 0
        
        nItem = GetGadgetState(DC::#ComboBox_001)

        SelectElement( DropLs::SizeDict(), nItem )        
        
        If ( nItem = 0 )
            *p\szPrgSDict = ":d" + Str( DropLs::SizeDict()\iSize ) + "b"
        Else
            *p\szPrgSDict = ":d" + Str( DropLs::SizeDict()\iSize ) + "m"            
        EndIf
        
    EndProcedure
    ;
    ;
    ;
    Procedure   zProgram_DoWordSize(*P.PROGRAM_BOOT)
        
        Protected nItem.i = 0

        nItem = GetGadgetState(DC::#ComboBox_002)

        SelectElement( DropLs::SizeWord(), nItem )                
        *p\szPrgSWord = ":fb" + Str( DropLs::SizeWord()\iSize )
    EndProcedure
    ;
    ;
    ;
    Procedure   zProgram_DoBlokSize(*P.PROGRAM_BOOT)
        
        Protected nItem.i = 0        
        
        nItem  = GetGadgetState(DC::#ComboBox_003)
        
        If ( nItem >= 1 )
            
            Select ( nItem )
                Case 19:        *P\szPrgSBlok = " -ms=on" :ProcedureReturn 
                Case 21:        *P\szPrgSBlok = " -ms=off":ProcedureReturn 
            EndSelect        
            
            SelectElement(  DropLs::SizeBlock(), nItem )
            
            Select ( GetGadgetState(DC::#ComboBox_002) )
                Case 00 To 09:  *P\szPrgSBlok = " -ms=" + Str( DropLs::SizeBlock()\iSize ) + "m"
                Case 10 To 17:  *P\szPrgSBlok = " -ms=" + Str( DropLs::SizeBlock()\iSize ) + "g"                    
            EndSelect  
        EndIf
    EndProcedure    
    ;
    ;
    ;
    Procedure   zProgram_DoPackMode(*P.PROGRAM_BOOT)
        
        Protected nItem.i = 0    
        Protected MethodID$
        
        nItem   = GetGadgetState(DC::#ComboBox_005)
        
        SelectElement( DropLs::Compression(), nItem)
        
        
        If ( nItem >= 1 )
            
            Select CFG::*Config\usFormat
                    
                Case 0 
                    ;
                    ; 7z LZMA2 Archive
                    *P\szPrgModus = " -mmt=on -m0=LZMA2" + *p\szPrgSDict + *P\szPrgEncrp + *P\szPrgSBlok + *P\szPrgMulti + " -mx" + Str( DropLs::Compression()\iLevel )
                    
                Case 1
                    ;
                    ; Zip and MethodID                    
                    Select CFG::*Config\ZipMethodID
                        Case 0: MethodID$ = "Deflate"
                        Case 1: MethodID$ = "Deflate64"
                        Case 2: MethodID$ = "BZip2"
                        Case 3: MethodID$ = "LZMA"
                        Case 4: MethodID$ = "PPMD"
                    EndSelect
                            
                    *P\szPrgModus = " -mm=" + MethodID$ + " -mmt=on -mtc=on -mx" + Str( DropLs::Compression()\iLevel ) + *P\szPrgMulti
                    ; + 
            EndSelect  

        Else
            
            *P\szPrgModus = " -mmt=on -mx" + Str( DropLs::Compression()\iLevel )
            
        EndIf
        
    EndProcedure
    ;
    ;
    ;
    Procedure   zProgram_DoSfxPackg(*P.PROGRAM_BOOT)
        
        Protected nItem.i = 0  
        
        nItem = GetGadgetState(DC::#CheckBox_005)
        
        If ( nItem = 1 )
            Select CFG::*Config\usFormat
                    Case 0: *P\szPrgSfSFX = " -sfx7z.sfx "
                    Case 1: ; Keine Selbstentpackende ZIP Archive bei 7Zip
            EndSelect
        EndIf 
        
    EndProcedure
    ;	
    ;
	;
    Procedure 	Thread_HandleIO(*P.PROGRAM_BOOT)
    	
    	Protected ReadLen.i, WriteLen.i, Error$
    	
    	*Buffer = AllocateMemory(1024)
    	
    	If *Buffer
    	    
    	    StickyWindow( DC::#_Window_001,#False)  
    	    
    	    *P\LoProcess = RunProgram(*P\Program, *P\Command, *P\DstPath, *P\PrgFlag, #PB_Program_UTF8):
    	    
    	    If IsProgram(*P\LoProcess)
    	        *P\HiProcess = OpenProcess_(#PROCESS_QUERY_INFORMATION, 0, ProgramID(*P\LoProcess)) 	
    	    EndIf
    	    Delay(5) 
    	        	    
    	    If *P\LoProcess    	          	        
    	        Repeat
    	            
    	            ReadLen = AvailableProgramOutput(*P\LoProcess)
    	            If ReadLen
    	                
    	                Debug #CR$ + "Speichergrösse ProgrammOutput: " + Str( ReadLen )
    	                Debug        "Speichergrösse des Buffers   : " + Str (MemorySize( *Buffer ) )    			        
    	                
    	                If ( ReadLen >= MemorySize( *Buffer ) )                            
    	                    *Buffer = ReAllocateMemory( *Buffer , ReadLen): Delay(5)
    	                    Debug    "Buffer Wurde vergrössert     : " + Str (MemorySize( *Buffer ) ) + #CR$+ #CR$
    	                    
    	                ElseIf ( ReadLen <= MemorySize( *Buffer ) )  			        
    	                    *Buffer = ReAllocateMemory( *Buffer , ReadLen): Delay(5)
    	                    Debug    "Buffer wurde verkleinert     : " + Str (MemorySize( *Buffer ) ) + #CR$+ #CR$
    	                    
    	                EndIf     
    	                
    	                ReadLen = ReadProgramData(*P\LoProcess, *Buffer, ReadLen)
    	                If ReadLen        					    
    	                    *P\Logging = PeekS(*Buffer, ReadLen, #PB_UTF8)
    	                    Debug *P\Logging
    	                EndIf
    	            EndIf
    	            
    	            Error$ = ReadProgramError(*P\LoProcess, #PB_UTF8)
    	            If Len(Error$)
    	                Debug *P\StError
    	                *P\StError = Error$
    	            EndIf
    	            
    	            Delay(1)
    	                	        
    	        Until ( *P\LoProcess = 0 ) Or (IsProgram(*P\LoProcess) = 0) Or Not ProgramRunning(*P\LoProcess)
    	        
    	        GetExitCodeProcess_(*P\HiProcess, @exitCodeH)
    	        GetExitCodeProcess_(*P\LoProcess, @exitCodeL)
    	        
    	        *P\exitCodeHi = exitCodeH
    	        *P\exitCodeLo = exitCodeL
    	        
    	        If ( *P\exitCodeHi >=1 ) And ( *P\exitCodeLo >=1 )
    	            
    	            Debug "exitCodeH:" + Str(*P\exitCodeHi)
    	            Debug "exitCodeL:" + Str(*P\exitCodeLo)    		        
    	            Debug *P\StError
    	        EndIf
    	        
    	        CloseProgram(*P\LoProcess)
    	        
    	    EndIf
    	    
    	    FreeMemory(*Buffer)
    	EndIf
    	
    EndProcedure    
    ;
    ;
    ;
	Procedure 	Thread_Prep(*P.PROGRAM_BOOT) 
		LockMutex(*P\ulMutex)
		
		Thread_HandleIO(*P.PROGRAM_BOOT)        
				
		UnlockMutex(*P\ulMutex)
		ProcedureReturn
	EndProcedure    
    ;
    ;
    ;
    Procedure   Thread_Start(*P.PROGRAM_BOOT)
               
            *P\ulMutex      = CreateMutex()
        
        	*P\ulThread     = 0 
        	*P\ulThread     = CreateThread(@Thread_Prep(),*P)
        	*p\bForceBreak  = #False
        	
        	;
            ; Multivolume Archiv ?             	
        	If ( GetGadgetState(DC::#ComboBox_004) >= 1 )  
        	    
        	    MultiVolumeCnt.i= 1                     
        	    MultiVolumeNum.s= "00"                    
        	    NewFileName.s   = FileVolume_RemoveNum(*P\sz7zArchiv)
        	    
        	    NewFileName.s   = ReplaceString( NewFileName, Chr(34), "",0,1, CountString(NewFileName, Chr(34) ) )
        	    NewFileName.s   = Trim(NewFileName.s)
        	EndIf

                                   
        	While IsThread(*P\ulThread)        	    
            	While WindowEvent()
            	Wend            	
            	Delay(25)
            	
            	If IsThread( *P\ulThread )
        	        ;
                    ; Multivolume Archiv ?              	    
            	    If ( GetGadgetState(DC::#ComboBox_004) >= 1 )
            	        ;
                        ; Multivolume Archiv ?              	                               	        
            	        If ( FileSize( NewFileName + "." + MultiVolumeNum + Str(MultiVolumeCnt) ) >= 1 )
            	            MultiVolumeCnt + 1
            	            
            	            If ( MultiVolumeCnt >= 10) And ( MultiVolumeCnt <= 99)
            	                MultiVolumeNum = "0"
            	            EndIf    
            	            
            	            If ( MultiVolumeCnt >= 100)            	            
            	                MultiVolumeNum = ""
            	            EndIf                   	            
            	            Delay(1)
            	        Else
            	            SetGadgetText(DC::#String_005, GetFilePart(NewFileName) + "." + MultiVolumeNum + Str(MultiVolumeCnt-1)  ); Aktualisere den Dateinam im Hintergrund
            	            Delay(1)
            	        EndIf
            	    EndIf
            	EndIf
            	
            Wend         
            
     EndProcedure      
    ;
    ;
    ;
    Procedure.i Compress()
        
        SetGadgetState(DC::#Progress_001, 0)
        SetWindowTitle(DC::#_Window_001, DropLang::GetUIText(1) )
        
        *P.PROGRAM_BOOT = AllocateMemory( SizeOf( PROGRAM_BOOT ) )
                          InitializeStructure(*P, PROGRAM_BOOT)     
                          
        If ( ListSize( *P\Collection() ) >= 1 )
             FreeList( *P\Collection() )
        EndIf    
        
        NewList *P\Collection.s()
                
        *P\Program         = ""
        *P\DstPath         = ""
        *P\Logging         = ""        
        *P\ExError         = 0        
        *P\StError         = ""
        *P\sz7zArchiv      = ""
        *P\szPrgModus      = ""
        *P\szPrgMulti      = ""
        *P\szPrgPOFls      = ""
        *P\szPrgPWord      = ""
        *P\szPrgSBlok      = ""
        *P\szPrgSDict      = ""
        *P\szPrgSfSFX      = ""
        *P\szPrgSWord      = ""
        *P\szTempFile      = ""
        *P\PrgFlag         = 0
                        
        ; Suche nach 7z Location
        *P\Program         = DropCode::Locate7z(0)
        If (*P\Program = "" )
            ProcedureReturn 10
        EndIf
                
        
        ; Überprüfe Zielverzeichnis
        If Not ( Path_Verify() = 0 )
            ProcedureReturn 11
        EndIf        
        *P\DstPath         = GetGadgetText(DC::#String_002)      
                   
        
        ; Überprüfe ob es ein CDROM ist
        If  ( DropCode::GetDriveType( *P\DstPath ) = 5 )
            Request::MSG( DropLang::GetUIText(20) , DropLang::GetUIText(27) + Left(*P\DstPath,3), DropLang::GetUIText(28), 2, 0, ProgramFilename())            
            ProcedureReturn 12
        EndIf
        
        
        *P\Command         = " a"
        sProgram_DoMultiVol(*P)
        zProgram_DoWortPass(*P)  
        zProgram_DoOpenFile(*P)
        zProgram_DoDictiony(*P)
        zProgram_DoWordSize(*P)
        zProgram_DoBlokSize(*P)
        zProgram_DoPackMode(*P)
        zProgram_DoSfxPackg(*P)        
        
        
      
        *P\sz7zArchiv      =  GetGadgetText(DC::#String_001)
        
        ;
        ; Überprüfe oder der Suffix ok ist und Aktualsiere das Text Gadget
        FileSuffix(*P)
        
        ; Überprüfe ob die Datei existiert  
        If ( FileExists( *P ) = 1 )
            ProcedureReturn 13
        EndIf
        
         ; Multivolume Archiv Check
        If ( zArchiv_MultiVolume(*P) = 1 )
            ProcedureReturn 15
        EndIf
        
        ; Sammle Dateien        
        zWrite_TempFile(*P)
        zCollect_Files (*P)
        
        If ( zCollect_Write (*P) = 1 )
            ProcedureReturn 14
        EndIf        
        
        *P\sz7zArchiv      = " " + Chr(34) + *P\DstPath + *P\sz7zArchiv + Chr(34)
        
        ; Setze Commando
        *P\Command         + *P\szPrgSfSFX +
                             *P\sz7zArchiv +
                             *P\szPrgModus +
                             *P\szPrgPWord +
                             *P\szPrgPOFls +
                             " @"+ *p\szTempFile
        
        Debug ""
        Debug "7z Program: " + *P\Program
        Debug "7z Command: " + *P\Command       
        
        *P\PrgFlag         = #PB_Program_Open|
                             #PB_Program_Read|
                             #PB_Program_Error|
                             #PB_Program_UTF8        
        
        ; Final ... starte 
        Thread_Start(*P)
        
        Debug ""
        Debug "7z ExitCode (HI): " + *P\exitCodeHi
        Debug "7z ExitCode (LO): " + *P\exitCodeLo          
        ;
        ;
        ; Verify & test
        If ( (*P\exitCodeHi = 0) And ( *P\exitCodeLo = 0) )
            
            ;
            ;
            ; Generate SHA1 Files           
            ;  Quersumme::Create_SHA1_File( *P\sz7zArchiv ,*P\szPrgMulti)
       
            If ( GetGadgetState(DC::#CheckBox_002) = 1 )
                                   
                *P\Command  = " t " + *P\sz7zArchiv
                
                If ( GetGadgetState(DC::#ComboBox_004) >= 1 )
                    ;
                    ; Multivolume Archiv ?
                    *P\Command + ".001"
                EndIf
                
                
                If ( Len( *P\szPrgPWord ) >= 1 )
                    *P\Command  + " -r" + *P\szPrgPWord
                EndIf    
                
                SetWindowTitle(DC::#_Window_001, DropLang::GetUIText(2) )
                
                Thread_Start(*P)
           EndIf     
       EndIf 
       

       
       ;
       ;
       ; Delete Files
       ; _Actio_DeleteFiles(iFullPath$,iDestFileist$,1)
       
       ;
       ;
       ;
       ; _SendMailArchive(*P\sz7zArchiv)
       
       
       ;
       ; Lösche die Tempopäre Datei
       zDelete_TempFile(*P)
          FreeMemory(*P)
       
        ;
        ; Leere Den Ram
       DropSYSF::Process_FreeRam()
       
       StickyWindow(DC::#_Window_001,CFG::*Config\Sticky) 
       SetWindowTitle(DC::#_Window_001,CFG::*Config\WindowTitle.s)                               

    EndProcedure    
    
    
EndModule
; IDE Options = PureBasic 5.62 (Windows - x64)
; CursorPosition = 41
; Folding = DAAA9
; EnableAsm
; EnableXP
; UseMainFile = ..\Drop7z.pb
; CurrentDirectory = ..\Drop7z\
; EnableUnicode