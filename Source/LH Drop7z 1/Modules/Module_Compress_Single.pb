﻿;
;
; Grafische 7zOberfläche

DeclareModule DropSPak
    
    Declare.i   Compress()
EndDeclareModule   

Module DropSPak
      
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
        szPrgSfSFX.s	; Selbst Enpackende Archive
        ListErrors.s
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
		Protected.s szMsgNote, szArchivFile
		Protected.b Result
		
		szArchivFile = *P\sz7zArchiv 
		
		If FileSize(szArchivFile ) >= 0

			szMsgNote  = DropLang::GetUIText(32) + ": " + GetFilePart( szArchivFile ) + "                    " + #CRLF$

			Result = MessageBoxExt::Show(DC::#_Window_001		, 
			                             DropLang::GetUIText(20)  ,
			                             szMsgNote			,
			                             #MB_YESNOCANCEL		,
			                             #MB_USERICON  |
			                             #MB_DEFBUTTON2|
			                             #MB_TASKMODAL		,
			                             145				, ; #ID from Shell32 Dll
			                             "Ersetzen"	,
			                             DropLang::GetUIText(35) 	,
			                             DropLang::GetUIText(36)  ,
			                             "shell32.dll"		,
			                             Fonts::#_DEJAVU_08	)
			Select Result
				Case 7
					 ProcedureReturn 0    
				Case 6
					If ( FileSize(  szArchivFile  ) >= 0 )
						DeleteFile(  szArchivFile , #PB_FileSystem_Force)
					EndIf
					ProcedureReturn 0	
				Default
					ProcedureReturn 1
			EndSelect
				    
			; 	    If FileSize( *P\DstPath + *P\sz7zArchiv  ) >= 0
			; 	        
			; 	        szMsgNote$  = GetFilePart( *P\DstPath + *P\sz7zArchiv ) + #CR$ + DropLang::GetUIText(33) 
			; 	        
			;             Request::*MsgEx\User_BtnTextL = DropLang::GetUIText(34) 
			;             Request::*MsgEx\User_BtnTextM = DropLang::GetUIText(35) 
			;             Request::*MsgEx\User_BtnTextR = DropLang::GetUIText(36)  
			;             
			;             Select Request::MSG( DropLang::GetUIText(20), DropLang::GetUIText(32) , szMsgNote$, 16, 1, ProgramFilename(), 0, 0, DC::#_Window_001)
			;                     ;
			;                     ; Akualsieren
			;                 Case 2: ProcedureReturn 0    
			; 	                ;
			; 	                ; Abbruch
			;                 Case 1: ProcedureReturn 1
			;                     ;
			;                     ; Überschreiben
			;                 Case 0:
			;                         If ( FileSize(   *P\DstPath + *P\sz7zArchiv  ) >= 0 )
			;                             DeleteFile(  *P\DstPath + *P\sz7zArchiv  )
			;                             Delay(1000)
			;                         EndIf
			;                         ProcedureReturn 0
			;             EndSelect 		
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
	    
	    SetGadgetText(DC::#String_001, GetFilePart( *P\sz7zArchiv) ); Aktualisere den Dateinam im Vordergrund
	    SetGadgetText(DC::#String_005, GetFilePart( *P\sz7zArchiv,1) ); Aktualisere den Dateinam im Hintergrund
        
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
            
            Request::MSG( DropLang::GetUIText(20) , DropLang::GetUIText(25)  ,DropLang::GetUIText(26) + szFilePath$ , 2, 0, ProgramFilename(),0,0,DC::#_Window_001)  
            ProcedureReturn 11
        EndIf
        
        SetGadgetText(DC::#String_002, Path_CheckEnd( GetGadgetText(DC::#String_002) ) )
        
        ProcedureReturn 0
        
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
                
                Request::MSG( DropLang::GetUIText(20) , DropLang::GetUIText(31) , szMsg, 2, 0, ProgramFilename(),0,0,DC::#_Window_001)
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
					Case 0: *P\szPrgEncrp = " -p" + *P\szPrgPWord + " -mhc=on -mhe=on"      ; Für 7z                        
																	;Case 0: *P\szPrgEncrp = " -p" + *P\szPrgPWord + " -mhe"      ; Für 7z
					Case 1: *P\szPrgEncrp = " -p" + *P\szPrgPWord + " -mem=AES256"		; Für Zip
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
    	
    	*Buffer = AllocateMemory(1024*2)
    	
    	If *Buffer    	       	    
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
    	                    *Buffer = ReAllocateMemory( *Buffer , ReadLen*2): Delay(5)
    	                    Debug    "Buffer Wurde vergrössert     : " + Str (MemorySize( *Buffer ) ) + #CR$+ #CR$
    	                    
    	                ElseIf ( ReadLen <= MemorySize( *Buffer ) )  			        
    	                    *Buffer = ReAllocateMemory( *Buffer , ReadLen*2): Delay(5)
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
    Procedure.i Items_DeSelect()
        
        Count = CountGadgetItems(DC::#ListIcon_001)
        For Item = 0 To Count
            Status = GetGadgetItemState( DC::#ListIcon_001, Item )
            If ( Status >= 2 )
                SetGadgetItemState( DC::#ListIcon_001, Item, 0)
            EndIf            
        Next    
    EndProcedure     
    ;
    ;
    ;
    Procedure.i Items_Count()
        
        Protected Count.i   = 0
        Protected Item.i    = 0
        Protected Marked.i  = 0
        
        ; Berechne Progress
        Count = CountGadgetItems(DC::#ListIcon_001)
        For Item = 0 To Count
            Status = GetGadgetItemState( DC::#ListIcon_001, Item )
            If ( Status >= 2 )
                Marked + 1
            EndIf
        Next    
        
        If ( Marked >= 1 )
            Count = Marked
        EndIf 
        
        ProcedureReturn Count
    EndProcedure
    ;
    ;
    ;
    Procedure.s Generate_Filename(szFile.s)
        
        Protected Position.i  = -1
        
        szFile.s = GetPathPart( szFile )
        If Right(szFile,1) = "\"
            szFile = Left( szFile, Len(szFile)-1 )
        EndIf
        
        szFile = ReverseString(szFile)   
        Position = FindString( szFile, "\", 0)
        If (Position >= 0)
            szFile = Left( szFile, Position-1)
        EndIf    
        szFile = ReverseString(szFile) 
        ProcedureReturn szFile
    EndProcedure    
    ;
    ;
    ;
    Procedure.i zConsoleOut_Ok(*P.PROGRAM_BOOT) 
        
        If (Len(*P\StError) >= 1 )
            Request::MSG( DropLang::GetUIText(20) , DropLang::GetUIText(29) , *P\StError, 2, 2, ProgramFilename(),0,0,DC::#_Window_001)   
            ProcedureReturn 1
        EndIf
        
        If FindString( *P\Logging , "Everything is Ok")
            ProcedureReturn 0 
        EndIf    
    EndProcedure            
    ;
    ;
    ;
    ;
    ;
    ;
    Procedure.i Items_HideDirectory()
        Protected Itm.i     = 0
        Protected szFile.s  = ""
        Protected szPath.s  = ""
        Protected Visible.i = 0
        Protected Count.i   = 0
        
        Count =  CountGadgetItems( DC::#ListIcon_001 )-1
        
        For Itm = 0 To Count
            szPath = GetGadgetItemText( DC::#ListIcon_001,Itm, 0)              
            szFile = GetGadgetItemText( DC::#ListIcon_001,Itm, 1) 
            If  ( Len(szFile) >= 1 )
                Visible = Itm
            EndIf
        Next    
        
        If ( Visible = Count )
            SetGadgetItemAttribute(DC::#ListIcon_001, 0 , #PB_ListIcon_ColumnWidth, 18,0) 
        EndIf
        
    EndProcedure    
    ;
    ;
    ;
    Procedure.i Auto_Select(szCurrent.s)
        Protected Itm.i     = 0
        Protected szFile.s  = ""
        Protected szPath.s  = ""    
        
        For Itm = 0 To CountGadgetItems( DC::#ListIcon_001 )-1
            szPath = GetGadgetItemText( DC::#ListIcon_001,Itm, 0)              
            szFile = GetGadgetItemText( DC::#ListIcon_001,Itm, 1) 
            
            If ( (szPath + szFile ) = szCurrent )
                SetGadgetItemState( DC::#ListIcon_001, Itm, 2 )
                SendMessage_( GadgetID(DC::#ListIcon_001), #LVM_ENSUREVISIBLE, Itm,0)
            EndIf
        Next        
    EndProcedure    
    ;
    ;
    ;
    Procedure   QuitTask(*P.PROGRAM_BOOT)
        FreeMemory(*P)
        
        DropSYSF::Process_FreeRam()       
        
        StickyWindow(DC::#_Window_001,CFG::*Config\Sticky) 
        SetWindowTitle(DC::#_Window_001,CFG::*Config\WindowTitle.s)          
     EndProcedure
    ;
    ;
    ;
    Procedure.i Compress_Looping( *P.PROGRAM_BOOT )
        
        Protected Cnt.i         = 0             ; Zähler für das Progressbar Gadget
        Protected Max.i         = 0             ; Zähler für die anzahl der Dateien
        Protected Chk.s         = ""            ; Für Filesize um zu überprüfen ob die Dateiexitiert
        Protected Lst.s         = ""
        Protected Bra.s         = *P\sz7zArchiv ; Merke das Letzte Archiv bevor im Text Gadget es überschrieben wird
        
        Protected ItemWidth1.i = GetGadgetItemAttribute(DC::#ListIcon_001,0, #PB_ListIcon_ColumnWidth, 0) ; Directory

        NewList   Mis.s()
        
        SetGadgetAttribute(DC::#Progress_001, #PB_ProgressBar_Maximum, Items_Count() ):                       
        
        ;
        ; Verstecke den Column "Verzeichnis" nur wenn in der Liste alle Dateinamen vorhanden sind
        Items_HideDirectory()
        
        ResetList( *P\Collection() )
        
        If ( ListSize( *P\Collection() ) >= 1 )
            
            ForEach *P\Collection()
                
                SetWindowTitle(DC::#_Window_001, DropLang::GetUIText(1) )
                
                Auto_Select( *P\Collection() )                
                
                Cnt.i               + 1
                
                *P\sz7zArchiv       = ""
                *P\Command          = ""
                *P\Logging          = ""
                *P\StError          = ""                
                *P\exitCodeHi       = 0
                *P\exitCodeLo       = 0
                *P\LoProcess        = 0
                *P\HiProcess        = 0
                *P\ulMutex          = 0
                *P\ulThread         = 0
                
                ;
                ; Das Archiv welches erstellt wird
                If ( FileSize( *P\Collection() ) = -2 )
                    ;
                    ; Genenrate Filename from Directory Name
                    *P\sz7zArchiv      =  *P\DstPath + Generate_Filename(*P\Collection())                        
                Else     
                    ;
                    ;  #PB_FileSystem_NoExtension = 1
                    *P\sz7zArchiv      =  *P\DstPath + GetFilePart(*P\Collection(), 1)                              
                EndIf    
                
                ;
                ;
                SetGadgetState(DC::#Progress_001, Cnt)  
                ;
                ; Aktualisere den Dateinam im Hintergrund  
                SetGadgetText(DC::#String_005, GetFilePart( *P\sz7zArchiv ) )                 
                
                ;
                ; Überprüfe oder der Suffix ok ist und
                ; Aktualsiere Gegebenfalls das Text Gadget
                FileSuffix(*P)                    
                
                ; Überprüfe ob die Datei existiert  
                If ( FileExists( *P ) = 1 )
                    ProcedureReturn 1
                EndIf                    
                
                ; Multivolume Archiv Check
                If ( zArchiv_MultiVolume(*P) = 1 )
                    ProcedureReturn 1
                EndIf                    
                                                  
                ;
                ; Lange Dateinamen Füge '"' (Double Quote hinzu)
                Chk                =  *P\sz7zArchiv            
                *P\sz7zArchiv      = " " + Chr(34) + *P\sz7zArchiv + Chr(34)    
                
                ; Setze Commando
                *P\Command         = " a"
                *P\Command         + *P\szPrgSfSFX +
                                     *P\sz7zArchiv +
                                     *P\szPrgModus +
                                     ;*P\szPrgPWord +
                                     *P\szPrgPOFls +
                                     " " + Chr(34) + *P\Collection() + Chr(34)
                
                Debug ""
                Debug "7z Program: " + *P\Program
                Debug "7z Command: " + *P\Command       
                                
                ;
                ;
                Thread_Start(*P)
             
	            ;
	            Delay( 5 )
	            
                Debug ""
                Debug "7z ExitCode (HI): " + *P\exitCodeHi
                Debug "7z ExitCode (LO): " + *P\exitCodeLo          
                
	            ;
	            ;
                If ( zConsoleOut_Ok(*P) = 0 )
                    
                    If ( FileSize( chk ) >= 1 )
                        Max + 1
                        
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
                                    ; Multivolume Archiv ?
                                    *P\Command = ReplaceString( *P\Command, "." + DropCode::GetArchivFormat(), "." + DropCode::GetArchivFormat() + ".001")                           
                                EndIf
                                
                                
                                If ( Len( *P\szPrgPWord ) >= 1 )
                                    *P\Command  + " -r" + *P\szPrgPWord
                                EndIf    
                                
                                SetWindowTitle(DC::#_Window_001, DropLang::GetUIText(2) )                                                          
                                Thread_Start(*P)
                                Delay( 25)
                                zConsoleOut_Ok(*P)
                                    
                            EndIf     
                        EndIf
                        
                    Else
                        AddElement( Mis() ): Mis() = chk
                    EndIf
                    
                    Delay( 5 )
                EndIf
	        Next
	        
	        ; Normalisiere den Drop7z Satus
	        SetGadgetState(DC::#Progress_001, 0)
	        
	        ;
	        ; Füge den Orignalen Dateinamen wieder in das Textgadget
	        SetGadgetText(DC::#String_001, Bra )	        
	        SetGadgetText(DC::#String_005, Bra )
	        
	        If ( Items_Count() =  CountGadgetItems(DC::#ListIcon_001) )
	            ;
	            ; DeSelect items nur wenn ALLE dateien verarbeitet wurden
	            Items_DeSelect()
	            
	            ;
	            ; Springe wieder zum ersten Item
	            SendMessage_( GadgetID(DC::#ListIcon_001), #LVM_ENSUREVISIBLE, 0,0)	            
	        EndIf    
	        	        
	        ;
	        ; Resete die Column Weite für "Verzeichnis"
            SetGadgetItemAttribute(DC::#ListIcon_001, 0 , #PB_ListIcon_ColumnWidth, ItemWidth1,0)
        
            ;
            ; Generell Führe ein vergleich aus ob auch alle Dateien Geschrieben wurden
            If ( ListSize( *P\Collection() ) = Max )
            	ProcedureReturn 0
            EndIf
            
            If ( ListSize( *P\Collection() ) >= Max )
                
                ResetList( Mis() )
                
                ForEach Mis()
                     *p\ListErrors + Mis() +#CR$
                Next    

                ProcedureReturn 1
            EndIf
            
        Else
            

            ProcedureReturn -1    
        EndIf
    EndProcedure    
    ;
    ;
    ;
    Procedure.i Compress()
        Protected.i Result
        SetGadgetState(DC::#Progress_001, 0)
        SetWindowTitle(DC::#_Window_001, DropLang::GetUIText(1) )
        
        *P.PROGRAM_BOOT = AllocateMemory( SizeOf( PROGRAM_BOOT ) *2)
                          InitializeStructure(*P, PROGRAM_BOOT)     
                          
        If ( ListSize( *P\Collection() ) >= 1 )
            ResetList(*P\Collection() )                 
            
            While NextElement( *P\Collection() )
                DeleteElement( *P\Collection() )
            Wend    
            ; FreeList( *P\Collection() )
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
        *p\ListErrors	   = ""
        *P\PrgFlag         = 0
                        
        ; Suche nach 7z Location
        *P\Program         = DropCode::Locate7z(1)
        If (*P\Program = "" )
            QuitTask(*P): ProcedureReturn 10
        EndIf
                
        
        ; Überprüfe Zielverzeichnis
        If Not ( Path_Verify() = 0 )
            QuitTask(*P): ProcedureReturn 11
        EndIf        
        *P\DstPath         = GetGadgetText(DC::#String_002)      
                   
        
        ; Überprüfe ob es ein CDROM ist
        If  ( DropCode::GetDriveType( *P\DstPath ) = 5 )
            Request::MSG( DropLang::GetUIText(20) , 
                          DropLang::GetUIText(27) + Left(*P\DstPath,3), 
                          DropLang::GetUIText(28), 2, 0, ProgramFilename(),0,0,DC::#_Window_001)             
            QuitTask(*P):ProcedureReturn 12
        EndIf
                
        sProgram_DoMultiVol(*P)
        zProgram_DoWortPass(*P)  
        zProgram_DoOpenFile(*P)
        zProgram_DoDictiony(*P)
        zProgram_DoWordSize(*P)
        zProgram_DoBlokSize(*P)
        zProgram_DoPackMode(*P)
        zProgram_DoSfxPackg(*P)            
        
        ; Single Item Compress Mode
        ;
        ; Bei dem Durchlauf von allen items wobei jedes Datei für sich selbst gapckt wird ist
        ; dies nur der erste Dateiname. DAS sammeln der Dateien muss als erstes vorgenommen
        ; werden. 
        ;
        *P\sz7zArchiv      =  GetGadgetText(DC::#String_001)
        
        *P\PrgFlag         = #PB_Program_Hide|
                             #PB_Program_Open|
                             #PB_Program_Read|
                             #PB_Program_Error|
                             #PB_Program_UTF8        
        
        ; Sammle Dateien, Tempfile wird nicht benötigt
            zCollect_Files (*P)
            
        ; Ab hier den Durchlauf starten
            
            Result = Compress_Looping(*P)  
            Select Result
            	Case 0
            		Request::MSG( DropLang::GetUIText(20) , 
            		              DropLang::GetUIText(37) , 
            		              DropLang::GetUIText(38) + #CR$ + "In: " + ListSize( *P\Collection() ) + "/ Out: " + Str(Max) , 2, 0, ProgramFilename(),0,0,DC::#_Window_001)             		
            		
            		
            		
            	Case 1            		            	
            		Request::MSG( DropLang::GetUIText(20) , 
            		              DropLang::GetUIText(29) , 
            		              DropLang::GetUIText(39) + #CR$ + "In: " + ListSize( *P\Collection() ) + "/ Out: " + Str(Max) + #CR$ + Lst, 2, 0, ProgramFilename(),0,0,DC::#_Window_001)  
            		
            		QuitTask(*P)
            		ProcedureReturn 13
            	Case -1
            		Debug ""
            		Debug "7z Archiv. ERROR: Die Liste hat keine Einträge"
            		Request::MSG( DropLang::GetUIText(20) , DropLang::GetUIText(29) , DropLang::GetUIText(30), 2, 0, ProgramFilename(),0,0,DC::#_Window_001)  
            EndSelect
            
          	QuitTask(*P) 
        ; =============================       
      
        ;
        ;
        ;
        ; Delete Files
        ; _Actio_DeleteFiles(iFullPath$,iDestFileist$,1)
       
        ;
        ;
        ;
        ; _SendMailArchive(*P\sz7zArchiv), in Single Variante ... nö
            
                                     

    EndProcedure        
    
EndModule
; IDE Options = PureBasic 5.73 LTS (Windows - x64)
; CursorPosition = 60
; FirstLine = 49
; Folding = 44-Lu-
; EnableAsm
; EnableXP
; UseMainFile = ..\Drop7z.pb
; CurrentDirectory = ..\Drop7z\
; EnableUnicode