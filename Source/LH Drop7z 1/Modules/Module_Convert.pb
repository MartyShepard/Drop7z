﻿;
;
; Grafische 7zOberfläche

DeclareModule DropVert
	
	Declare.i   ConvertArchive()
EndDeclareModule    


Module DropVert
	
	Structure CONVERT_RESULT
		File.s
		FileCount.i
		MismtachSize.i		; 1 Error, 0 OK
		MisMatchFile.i		; 1 Error, 0 OK (File Writte)
		MisMatchZero.i
		FuckUnicode.s
		FickUnicode.i
	EndStructure
		
	Structure PROGRAM_BOOT
		Program.s       ; 7z Path and Programm
		PrgPath.s
		DstPath.s       ; The 7z Destination Path
		Command.s	    ; The 7z Commando
		Logging.s
		PrgFlag.l
		ExError.i  
		StError.s
		Archivname.s
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
		ResultMax.i
		ContinueOnError.i
		List Collection.s()
		List ConvertResult.CONVERT_RESULT()
		List Mis.s()
	EndStructure 
	
	;
	;
	;    
	;
	;
	; Überprpfe ob die Datei existiert und Optionl Lösche diese
	
	Procedure Set_GadgetStatus(n)
		
		Select n
			Case 1 ;Offen 
				
				SetGadgetText(DC::#String_005,GetGadgetText(DC::#String_001)):Debug "HideGadget(DC::#String_001,1)"                                
				HideGadget(DC::#String_005,0):Debug "HideGadget(DC::#String_001,1)"            
				HideGadget(DC::#String_001,1):Debug "HideGadget(DC::#String_001,1)"            
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
				
				HideGadget(DC::#String_001,0) :Debug "HideGadget(DC::#String_001,0)"  
				;Delay(25)
				HideGadget(DC::#String_005,1) :Debug "HideGadget(DC::#String_001,0)"                                                           
				;Delay(25)
				
				SetGadgetText(DC::#String_005,"") :Debug "HideGadget(DC::#String_001,0)"  
				
			Case 1  
		EndSelect
		
		Select CFG::*Config\usFormat
			Case 0: DropCode::SetUIElements7ZP()
			Case 1: DropCode::SetUIElementsZIP(1)
			Case 2: DropCode::SetUIElementsCHD(1)
		EndSelect    
	EndProcedure
	;
	;
	; 
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
					Case 0: *P\szPrgEncrp = "-p" + *P\szPrgPWord + " -mhc=on -mhe=on"      ; Für 7z
					Case 1: *P\szPrgEncrp = "-p" + *P\szPrgPWord + " -mem=AES256"	     ; Für Zip
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
			;While WindowEvent()
			;Wend            	
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
		
		Set_GadgetStatus(0)
		
		FreeMemory(*P)
		
		DropSYSF::Process_FreeRam()       
		
		StickyWindow(DC::#_Window_001,CFG::*Config\Sticky) 
		SetWindowTitle(DC::#_Window_001,CFG::*Config\WindowTitle.s)          
	EndProcedure
	;
	;
	;
	Procedure zPokeSascii(*Mem,Offset.i,String.s); Offset 0-based
		If Len(String)
			For i=1 To Len(String)
				PokeA(*Mem+i-1,Asc(Mid(String,i,1)))
			Next i
			PokeA(*Mem+Len(String),0)
		EndIf
	EndProcedure
	;
	;
	;
	Procedure.s zPeekSascii(*Mem,offset.i,length.i); if Length=-1 then get string until Chr(0) is encountered
		If length=-1
			i=0
			While PeekA(*Mem+i)<>0 ;changed from PeekA(*Mem+i-1)
				result.s+Chr(PeekA(*Mem+i)) ;;changed from PeekA(*Mem+i-1)
				i+1
			Wend
			ProcedureReturn result
		ElseIf length>0
			For i=1 To length
				result.s+Chr(PeekA(*Mem+i-1))
			Next i
			ProcedureReturn result
		EndIf
	EndProcedure
	;
	;
	;	
	Procedure.s Char_Unicode(szLine.s,*P.PROGRAM_BOOT)
		
		*Mem = AllocateMemory(256)
		
		zPokeSascii( *Mem ,0 ,szLine)
		
		ShowMemoryViewer(*Mem,256)
		
		szLine = zPeekSascii(*Mem, 0, -1)
		
		*P\ConvertResult()\FickUnicode = 1
		*P\ConvertResult()\FuckUnicode + szLine + #CRLF$
		
		FreeMemory(*Mem )
		ProcedureReturn szLine
		
	EndProcedure	
	;	
	;
	;
	Procedure.s Char_Check(szLine.s,*P.PROGRAM_BOOT)

		Protected.i i
		Protected.c c
		
		For i = 1 To Len( szLine )			
			c = Asc( Mid( szLine, i,1) )			
			If ( c > 255 )								
				szLine = Char_Unicode(szLine,*P)
			EndIf	
			
		Next

		ProcedureReturn szLine
	EndProcedure	
	;
	;
	;
	Procedure.s	 UnCompressZIP_GenerateDirs(szLocalPath.s)
		
		Protected SubDirCount.i, szMakeDirs.s, i.i
		
		If FindString( szLocalPath, "/" )
			
			SubDirCount = CountString(szLocalPath, "/")
			
			For i = 1 To SubDirCount
				
				szMakeDirs + StringField( szLocalPath, i, "/") + "\"

				If ( FileSize( szMakeDirs ) ! -2 )
					CreateDirectory(szMakeDirs)
					Debug "Make Dirs: " + Chr(34) + szMakeDirs + Chr(34)
				EndIf	
				
				
			Next i
			ReplaceString( szLocalPath, "/", "\", #PB_String_InPlace , 1, SubDirCount)
			
		EndIf					
		ProcedureReturn szLocalPath		
	EndProcedure	
	;
	;
	;		
	Procedure 	 UnCompressZIP(*P.PROGRAM_BOOT, pbPackerPlugin.i)
		Protected.i PackData, Result, SizeLocal, SizePacked, PackType, SizeUnPacked
		Protected.s szFilePack, szDirectory, szPackedFile, szUnPackedFile, szUnicode
		
		AddElement( *P\ConvertResult() ) 

		*P\ConvertResult()\File 		= *P\Collection() 
		*P\ConvertResult()\FileCount 	= 0
		*P\ConvertResult()\MismtachSize = 0
		*P\ConvertResult()\MisMatchFile = 0
		*P\ConvertResult()\MisMatchZero = 0	
		*P\ContinueOnError		  = 0
		*P\Archivname  			= GetGadgetText(DC::#String_002)  + GetFilePart( *P\ConvertResult()\File , #PB_FileSystem_NoExtension)
		
		szDirectory    			= GetPathPart( *P\ConvertResult()\File  ) + GetFilePart( *P\ConvertResult()\File , #PB_FileSystem_NoExtension) + "_[TEMP" + Str( Random(999999,000001) ) + "]\"
		*P\DstPath = szDirectory ; Lösche das _xxxx Temp Verzeichnis
		
		If ( Right( szDirectory, 1) <> "\" )
			szDirectory + "\"
		EndIf	
		
		PackData = OpenPack(#PB_Any, *P\ConvertResult()\File  , pbPackerPlugin )
		If ( PackData > 0 )
			
			;
			; Verzeichnis Anlegen
			Select FileSize( szDirectory )
				Case -1: CreateDirectory( szDirectory )                    
			EndSelect 
			
			If ExaminePack(PackData)
				While NextPackEntry(PackData)			
					
					SizeUnPacked  = -1
					SizePacked    = -1
					SizeLocal	  = -1
					szPackedFile  = ""
					PackType	  = -1
					szUnPackedFile= ""
					
					SizeUnPacked   = PackEntrySize(PackData, #PB_Packer_UncompressedSize)
					SizePacked     = PackEntrySize(PackData, #PB_Packer_CompressedSize  ); Dies wird nur bei BriefLZ-Archiven unterstützt.

					szPackedFile   = PackEntryName(PackData)
					PackType 	   = PackEntryType(PackData)
					
					If ( Len(szPackedFile) = 0 )
						Continue
					EndIf	
					
					Debug "Pack Name: " + Chr(34) +RSet( szPackedFile , 50, " ") + Chr(34) +#CRLF$ +
					      " [ Size UnCompress: " + RSet( Str( SizeUnPacked ), 12, " ") +  #TAB$ +
					      " | Size Compressed: " + RSet( Str( SizePacked   ), 12, " ") + #TAB$ +
					      " ] [ Pack Type = " + Str( PackType ) + " ]"			
										
					;
					; Problem mit Unicode behandlung
					
					szPackedFile = Char_Check(szPackedFile,*P)
																										
					szUnPackedFile = szDirectory + szPackedFile	
					
					szUnPackedFile = UnCompressZIP_GenerateDirs(szUnPackedFile)
					
					Debug "Extract  : " + Chr(34) + szUnPackedFile + Chr(34) + #CRLF$	
					
					SetGadgetText(DC::#String_005,"Extract: "+UCase( GetExtensionPart( *P\ConvertResult()\File ))+":\" + szPackedFile )
					Delay(5)
					;
					; Verzeichnisse werden NICHT "Entpackt". Die müssen angelegt werden
					Select PackType
						Case #PB_Packer_Directory
							;
							; Verzeichnis Anlegen
							Select FileSize( szUnPackedFile )
								Case -1: CreateDirectory( szUnPackedFile )                
							EndSelect 
							
							Continue
					EndSelect					

					Result = UncompressPackFile( PackData , szUnPackedFile)
					If ( Result >= 0)
						
						;Repeat 
						;	Delay( 5 )
						;Until ( FileSize(szUnPackedFile) > 0 )
						;
						; Do a CFile Check heck
						SizeLocal = FileSize( szUnPackedFile )
						*P\ConvertResult()\FileCount + 1
						
						
						If ( SizeLocal <> SizeUnPacked )
							*P\ConvertResult()\MismtachSize = 1
							;
							; FEHLER In DER DATEI LÄNGE 
							Debug "GRÖSSEN FEHLER ON FILE " + *P\ConvertResult()\File 
							MessageRequester( "ERROR", "Dateien Größe Stimmt nicht: " + #CRLF$ +
							                           Chr(34) +szPackedFile 		     + Chr(34) + ": " +Str(SizeUnPacked)  + #CRLF$ +
							                           Chr(34) +GetFilePart( szUnPackedFile) + Chr(34) + ": " +Str(SizeLocal) ,#PB_MessageRequester_Warning)
							
						EndIf						
					Else
						*P\ConvertResult()\MisMatchFile + 1
						bMsgResult = MessageRequester( "ERROR", "Archiv Datei:  "  + #CRLF$ + #CRLF$ +
						                           Chr(34) +  GetFilePart( *P\ConvertResult()\File , #PB_FileSystem_NoExtension) + ":" + szPackedFile + Chr(34) + #CRLF$ +
						                           "Kann nicht verarbeitet werden" + #CRLF$ + #CRLF$ + "( Result = " + Str(Result) + ")" + #CRLF$ +
						                           "Den Konvertierungs Prozess für diese Datei stoppen?",#PB_MessageRequester_Error|#PB_MessageRequester_YesNo )
						;
						; FEHLER In DER DATEI LÄNGE 
						Debug "ENTPACK FEHLER ON FILE " + *P\ConvertResult()\File 
						
						If ( #PB_MessageRequester_Yes = bMsgResult )
							*P\ContinueOnError = 1
							Break;
						EndIf	
					EndIf
					Delay( 5 )
				Wend
			Else
				*P\ConvertResult()\MisMatchZero = 1
			EndIf
			ClosePack(PackData)
			

		Else
			; ERRROR
		EndIf
		
		
	EndProcedure
	;
	;
	;
	Procedure UnCompressRAR(*P.PROGRAM_BOOT)
		Protected.s szDirectory
		Protected.i Result
		Define *Callback
		
		AddElement( *P\ConvertResult() ) 

		*P\ConvertResult()\File 		= *P\Collection() 
		*P\ConvertResult()\FileCount 	= 1
		*P\ConvertResult()\MismtachSize = 0
		*P\ConvertResult()\MisMatchFile = 0
		*P\ConvertResult()\MisMatchZero = 0	
		
		*P\Archivname  			= GetGadgetText(DC::#String_002)  + GetFilePart( *P\ConvertResult()\File , #PB_FileSystem_NoExtension)
		szDirectory    			= GetPathPart( *P\ConvertResult()\File  ) + GetFilePart( *P\ConvertResult()\File , #PB_FileSystem_NoExtension) + "_[TEMP" + Str( Random(999999,000001) ) + "]"
		
		If ( Right( szDirectory, 1) <> "\" )
			szDirectory + "\"
		EndIf	
		
		Result = UnRar::RARUnpackArchiv(*P\ConvertResult()\File, szDirectory, "", 0,  DC::#String_005)					
		
		Debug "UnRAR Result: " + Str( Result )
		If Result = 0
			*P\ConvertResult()\MisMatchFile + 1
		EndIf	
		
		*P\DstPath = szDirectory ; Lösche das _xxxx Temp Verzeichnis
		
		
	EndProcedure	
	;
	;
	;	
	Procedure   UncompressCheck(*P.PROGRAM_BOOT)	
		
		
		Select UCase( GetExtensionPart( *P\Collection() ) )
			Case "RAR", "ARJ"	; Not Yet Supportet
				UnCompressRAR(*P)				
			Case "ZIP", "PK4", "PK3","KPF", "TSU"
				; KPF : QuakeEX
				; TSU : 1st Century After Tsunami 2265
				
				UnCompressZIP(*P, #PB_PackerPlugin_Zip)
			Case "7Z"
				UnCompressZIP(*P, #PB_PackerPlugin_Lzma)		
			Case "TAR", "GZ"
				UnCompressZIP(*P, #PB_PackerPlugin_Tar)
			Case "LZ"
				UnCompressZIP(*P, #PB_PackerPlugin_BriefLZ)					
		EndSelect		
		
	EndProcedure	
	;
	;
	;	
	;
	;
	;

	Procedure.i Compress_Looping( *P.PROGRAM_BOOT )
		
		Protected Cnt.i         = 0             ; Zähler für das Progressbar Gadget
		;Protected Max.i         = 0		    ; Zähler für die anzahl der Dateien
		*P\ResultMax = 0
		Protected Chk.s         = ""		    ; Für Filesize um zu überprüfen ob die Dateiexitiert

		Protected Bra.s         = *P\sz7zArchiv ; Merke das Letzte Archiv bevor im Text Gadget es überschrieben wird
		
		Protected ItemWidth1.i = GetGadgetItemAttribute(DC::#ListIcon_001,0, #PB_ListIcon_ColumnWidth, 0) ; Directory
		
		NewList   *P\Mis()
		
		
		SetGadgetAttribute(DC::#Progress_001, #PB_ProgressBar_Maximum, Items_Count() ):                       
		
		;
		; Verstecke den Column "Verzeichnis" nur wenn in der Liste alle Dateinamen vorhanden sind
		Items_HideDirectory()
		
		ResetList( *P\Collection() )
		
		If ( ListSize( *P\Collection() ) >= 1 )
			
			ForEach *P\Collection()
				
				SetWindowTitle(DC::#_Window_001, "Bitte Warten. 7z Konvertiert die Archiv Daten um..")
				
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
								
				UnCompressCheck( *P )	
				
				If ( *P\ContinueOnError = 1 )
					If ( FileSize( *P\DstPath ) = -2 )
						DeleteDirectory( *P\DstPath, "",  #PB_FileSystem_Recursive|#PB_FileSystem_Force )
					EndIf						
					Continue
				EndIf	
					
				;
				; Das Archiv welches erstellt wird
				;If ( FileSize( *P\Collection() ) = -2 )
				;	;
					*P\sz7zArchiv      =  *P\Archivname
				;Else     
				;	;
				;	;  #PB_FileSystem_NoExtension = 1
				;	*P\sz7zArchiv      =  *P\DstPath + GetFilePart(*P\Collection(), 1)                              
				;EndIf    
				
				;
				;
				SetGadgetState(DC::#Progress_001, Cnt)  
				;
				; Aktualisere den Dateinam im Hintergrund  
				SetGadgetText(DC::#String_005, "Convert To: " + GetFilePart( *P\sz7zArchiv ) )                 
				
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
				                     *P\szPrgPWord +
				                     *P\szPrgPOFls +
				                     " " + Chr(34) + *P\DstPath+ "*" + Chr(34)
				
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
						*P\ResultMax + 1
						
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
						AddElement( *P\Mis() ): *P\Mis() = chk
					EndIf
					
					Delay( 5 )
				EndIf
				
				If ( FileSize( *P\DstPath ) = -2 )
					DeleteDirectory( *P\DstPath, "",  #PB_FileSystem_Recursive|#PB_FileSystem_Force )
				EndIf	
				
				Delay( 5 )
				
				SetGadgetText(DC::#String_005,  GetFilePart( *P\sz7zArchiv ) )  
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
			
			;
			; Übrpüfe auf Ob alle Dateien geschrieben wordenind
			
		EndIf	

	EndProcedure    
	;
	;
	;
	Procedure.i ConvertArchive_Thread(*P)
		

		
		; Ab hier den Durchlauf starten
		
		If  ( Compress_Looping(*P) = 1 )
			QuitTask(*P): ProcedureReturn 13
		EndIf    
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
			
		QuitTask(*P)                              
		
	EndProcedure    
	;
	;
	;	
	Procedure ConvertArchive()
		
		
		
		Protected bUnRarFound.i = #True, szUnrarDLL.s = ""
		
		Protected Lst.s         = ""
		
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
		NewList *P\ConvertResult.CONVERT_RESULT()
		
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
		
		ResetList( *P\Collection() )
		
		If ( ListSize( *P\Collection() ) >= 1 )
			
			ForEach *P\Collection()
				
				Select UCase( GetExtensionPart( *P\Collection() ) )
					Case "7Z"	
						Result = Request::MSG(DropLang::GetUIText(20), "ReCompress", "7z Archiv Re-Komprimieren?",11,-1,"",0,0,DC::#_Window_001 )
						If Result = 1
							If ( ListSize( *P\Collection() ) = 1 )
								QuitTask(*P): ProcedureReturn 0
							EndIf	
							DeleteElement( *P\Collection() )
						EndIf						
					Case "ZIP", "TAR", "PK3", "PK4","KPF", "TSU", "GZ"
						; OK       
					Case "RAR", "ARJ"	

						CompilerIf #PB_Compiler_Processor = #PB_Processor_x64	
							szUnRarDLL = GetPathPart( ProgramFilename() ) + "UnRAR\unrar64.dll"
						CompilerElse
							szUnRarDLL = GetPathPart( ProgramFilename() ) + "UnRAR\unrar.dll"								
						CompilerEndIf
						
						If FileSize( szUnRarDLL ) = -1

							Request::*MsgEx\User_BtnTextL = "Weiter"
							Request::*MsgEx\User_BtnTextR = "Abbruch" 								
							Result = Request::MSG(DropLang::GetUIText(20), "RAR. DLL Not Found", "Rar benötigt die "+ Chr(34) + GetFilePart( szUnrarDLL ) + Chr(34) + " im DropZ Verzeichnis " + GetPathPart( szUnrarDLL ),10,0,"",0,0,DC::#_Window_001 )
							If Result = 0
								If ( ListSize( *P\Collection() ) = 1 )
									QuitTask(*P): ProcedureReturn 0
								EndIf	
								DeleteElement( *P\Collection() )
							Else										
								QuitTask(*P): ProcedureReturn 0
							EndIf							
						EndIf	
						
					Default
						; LZX, LHA
						Request::*MsgEx\User_BtnTextL = "Weiter"
						Request::*MsgEx\User_BtnTextR = "Abbruch" 						
						Result = Request::MSG(DropLang::GetUIText(20), "Can Not Compress", "Kann das Archiv [."+GetExtensionPart( *P\Collection() )+"] nicht IN 7z umwandeln" + #CRLF$ +  *P\Collection(),10,2,"",0,0,DC::#_Window_001 )
						If Result = 0
							If ( ListSize( *P\Collection() ) = 1 )
								QuitTask(*P): ProcedureReturn 0
							EndIf	
							DeleteElement( *P\Collection() )
						Else										
							QuitTask(*P): ProcedureReturn 0
						EndIf							
				EndSelect					
			Next
		Else
			Request::MSG( DropLang::GetUIText(20) , 
			              "Keine Dateien !?!", 
			              "Keine Dateien zum Archivieren", 2, 0, "",0,0,DC::#_Window_001)             
			QuitTask(*P):ProcedureReturn 12		
		EndIf				
		
		;Set_GadgetStatus(1)
		
		_Thread.i = CreateThread( @ConvertArchive_Thread(),*P.PROGRAM_BOOT)
		While IsThread(_Thread)	
			While WindowEvent()
                Wend 
		Wend
		
		While Not IsThread(_Thread)	
			
			Set_GadgetStatus(0)
		If ( ListSize( *P\Collection() ) > 0 )
			szErrorList.s = ""
			If ( ListSize( *P\ConvertResult() ) > 0 )	
				
				ResetList(  *P\ConvertResult() )
				
				FileCount.i
				MismtachSize.i		; 1 Error, 0 OK
				MisMatchFile.i		; 1 Error, 0 OK (File Writte)
				MisMatchZero.i	
				
				ForEach ( *P\ConvertResult() )
					
					If ( *P\ConvertResult()\FileCount = 0 )					     						
						szErrorList + GetFilePart( *P\ConvertResult()\File ) + ": 0 (Keine) Dateien Konvertiert" + #CRLF$
					Else					     
						If ( *P\ConvertResult()\MismtachSize = 1 ) 	
							szErrorList + "[ 1 DATEI IM ARCHIV]: " + GetFilePart( *P\ConvertResult()\File ) + ": Grösse Stimmt nicht" + #CRLF$					
						EndIf
						
						If ( *P\ConvertResult()\MismtachSize > 1 ) 	
							szErrorList + "[ "+*P\ConvertResult()\MismtachSize +" DATEIEN IM ARCHIV]: " + GetFilePart( *P\ConvertResult()\File ) + ": Grösse Stimmt nicht" + #CRLF$				
						EndIf	
						
						If ( *P\ConvertResult()\MisMatchFile = 1 ) 
							szErrorList + "[ 1 DATEI IM ARCHIV]: " +  GetFilePart( *P\ConvertResult()\File ) + ": Fehler im Archiv" + #CRLF$
						EndIf	
						
						If ( *P\ConvertResult()\MisMatchFile > 1 ) 						
							szErrorList + "[ "+ *P\ConvertResult()\MisMatchFile +" DATEI IM ARCHIV]: " +  GetFilePart( *P\ConvertResult()\File ) + ": Fehler im Archiv" + #CRLF$						
						EndIf
						
						If  ( Len( *P\ConvertResult()\FuckUnicode) > 0 )
							szErrorList + "[UNICODE PROBLEM]: " +  GetFilePart( *P\ConvertResult()\File ) + ":" + #CRLF$ + *P\ConvertResult()\FuckUnicode
						EndIf	
					EndIf
					
				Next
				
				If Len (szErrorList ) > 0
					szErrorList = #CRLF$ + "Quell Archiv Fehler:" + #CRLF$ + szErrorList
				EndIf
			
				ResetList(*P\ConvertResult() )                 
				
				While NextElement( *P\ConvertResult() )
					DeleteElement( *P\ConvertResult() )
				Wend    
			  				
			EndIf	

			If ( ListSize( *P\Collection() ) = *P\ResultMax ) And ( Len( szErrorList ) = 0 )
				Request::MSG( DropLang::GetUIText(20) , 
				              "Konvertierungs Status Erfogreich" , 
				               "Alle 7z Archiv(e) Komprimiert", 2, 0, "",0,0,DC::#_Window_001)   
				ProcedureReturn 0
				
			ElseIf  ( ListSize( *P\Collection() ) > *P\ResultMax )
				
				ResetList( *P\Mis() )
				
				ForEach *P\Mis()
					Lst + #CR$ + *P\Mis()
				Next    
				
				Request::MSG( DropLang::GetUIText(20) , 
				             "Konvertierungs Status" , 
				             "7z Archiv(e) Komprimiert " + Str(*P\ResultMax) + " von " + ListSize( *P\Collection() ) + Lst + #CRLF$ + szErrorList, 2, 0,"",0,0,DC::#_Window_001)  
				ProcedureReturn 1
			EndIf
			
		Else
			
			Debug ""
			Debug "7z Archiv. ERROR: Die Liste hat keine Einträge"
			Request::MSG( DropLang::GetUIText(20) , DropLang::GetUIText(29) , DropLang::GetUIText(30), 2, 0, ProgramFilename(),0,0,DC::#_Window_001)  
			ProcedureReturn 1           
		EndIf
		
	Wend

	EndProcedure	
EndModule
; IDE Options = PureBasic 6.00 LTS (Windows - x64)
; CursorPosition = 1105
; FirstLine = 800
; Folding = vyAcm---
; EnableAsm
; EnableXP
; UseMainFile = ..\Drop7z.pb
; CurrentDirectory = ..\Drop7z\
; CompileSourceDirectory
; EnableUnicode