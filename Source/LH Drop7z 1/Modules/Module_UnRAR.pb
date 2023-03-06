; TS Soft

DeclareModule UnRAR
	#ERAR_SUCCESS             = 0
	#ERAR_END_ARCHIVE         = 10
	#ERAR_NO_MEMORY           = 11
	#ERAR_BAD_DATA            = 12
	#ERAR_BAD_ARCHIVE         = 13
	#ERAR_UNKNOWN_FORMAT      = 14
	#ERAR_EOPEN               = 15
	#ERAR_ECREATE             = 16
	#ERAR_ECLOSE              = 17
	#ERAR_EREAD               = 18
	#ERAR_EWRITE              = 19
	#ERAR_SMALL_BUF           = 20
	#ERAR_UNKNOWN             = 21
	#ERAR_MISSING_PASSWORD    = 22
	
	#RAR_OM_LIST              = 0
	#RAR_OM_EXTRACT           = 1
	#RAR_OM_LIST_INCSPLIT     = 2
	
	#RAR_SKIP                 = 0
	#RAR_TEST                 = 1
	#RAR_EXTRACT              = 2
	
	#RAR_VOL_ASK              = 0
	#RAR_VOL_NOTIFY           = 1
	
	#RAR_DLL_VERSION          = 6
	
	#RAR_HASH_NONE            = 0
	#RAR_HASH_CRC32           = 1
	#RAR_HASH_BLAKE2          = 2
	
	#RHDF_SPLITBEFORE         = $01
	#RHDF_SPLITAFTER          = $02
	#RHDF_ENCRYPTED           = $04
	#RHDF_SOLID               = $10
	#RHDF_DIRECTORY           = $20
	
	Enumeration
		#UCM_CHANGEVOLUME
		#UCM_PROCESSDATA
		#UCM_NEEDPASSWORD
		#UCM_CHANGEVOLUMEW
		#UCM_NEEDPASSWORDW
	EndEnumeration
	
	Structure RARHeaderDataEx
		ArcName.b[1024]
		ArcNameW.w[1024]
		FileName.b[1024]
		FileNameW.w[1024]
		Flags.l
		PackSize.q
		UnpSize.q
		HostOS.l
		FileCRC.l
		FileTime.l
		UnpVer.l
		Method.l
		FileAttr.l
		*CmtBuf
		CmtBufSize.l
		CmtSize.l
		CmtState.l
		DictSize.l
		HashType.l
		Hash.b[32]
		Reserved.l[1014]
	EndStructure
	
	Structure RAROpenArchiveDataEx
		*ArcName
		*ArcNameW
		OpenMode.l
		OpenResult.l
		*CmtBuf
		CmtBufSize.l
		CmtSize.l
		CmtState.l
		Flags.l
		*Callback
		*ChangeVolProc
		UserData.i
		Reserved.l[28]
	EndStructure
	
	Prototype UNRARCALLBACK(msg, UserData, P1, P2)
	Prototype CHANGEVOLPROC(ArcName.s, Mode)
	Prototype PROCESSDATAPROC(*Addr, Size)
	Prototype RAROpenArchive(*ArchiveData.RAROpenArchiveDataEx)
	Prototype RARCloseArchive(hArcData)
	Prototype RARReadHeader(hArcData, *HeaderData.RARHeaderDataEx)
	Prototype RARProcessFile(hArcData, Operation, DestPath.s, DestName.s)
	Prototype RARSetCallback(hArcData, *Callback.UNRARCALLBACK, UserData)
	Prototype RARSetChangeVolProc(hArcData, *ChangeVolProc.CHANGEVOLPROC)
	Prototype RARSetProcessDataProc(hArcData, *ProcessDataProc.PROCESSDATAPROC)
	Prototype RARSetPassword(hArcData, Password.p-ascii)
	Prototype RARGetDllVersion()
	
	Global RAROpenArchive.RAROpenArchive
	Global RARProcessFile.RARProcessFile
	Global RAROpenArchive.RAROpenArchive
	Global RARProcessFile.RARProcessFile
	Global RARReadHeader.RARReadHeader
	Global RARCloseArchive.RARCloseArchive
	Global RARSetCallback.RARSetCallback
	Global RARSetChangeVolProc.RARSetChangeVolProc
	Global RARSetProcessDataProc.RARSetProcessDataProc
	Global RARSetPassword.RARSetPassword
	Global RARGetDllVersion.RARGetDllVersion
	
	Declare  RARUnpackArchiv(FileName.s, DestPath.s = "", Password.s = "", *Callback = 0, szGadgetID = 0, szGadgetID_With = 0)
EndDeclareModule

Module UnRAR
	EnableExplicit
	
	Define DLL
	;Global VolClose.i
	
	CompilerIf #PB_Compiler_Processor = #PB_Processor_x64
		DLL = OpenLibrary(#PB_Any, GetPathPart( ProgramFilename() ) +"UnRAR\unrar64.dll")
		If DLL = 0
			DLL = OpenLibrary(#PB_Any, GetPathPart( ProgramFilename() ) +"DropData\UnRAR\unrar64.dll")
		EndIf
		
	CompilerElse
		DLL = OpenLibrary(#PB_Any, GetPathPart( ProgramFilename() ) +"UnRAR\unrar.dll")
		If DLL = 0
			DLL = OpenLibrary(#PB_Any, GetPathPart( ProgramFilename() ) +"DropData\UnRAR\unrar.dll")
		EndIf		
	CompilerEndIf
	
	If DLL
		RAROpenArchive        = GetFunction(DLL, "RAROpenArchiveEx")
		CompilerIf #PB_Compiler_Unicode
			RARProcessFile        = GetFunction(DLL, "RARProcessFileW")
		CompilerElse
			RARProcessFile        = GetFunction(DLL, "RARProcessFile")
		CompilerEndIf
		RARReadHeader         = GetFunction(DLL, "RARReadHeaderEx")
		RARCloseArchive       = GetFunction(DLL, "RARCloseArchive")
		RARSetCallback        = GetFunction(DLL, "RARSetCallback")
		RARSetChangeVolProc   = GetFunction(DLL, "RARSetChangeVolProc")
		RARSetProcessDataProc = GetFunction(DLL, "RARSetProcessDataProc")
		RARSetPassword        = GetFunction(DLL, "RARSetPassword")
		RARGetDllVersion      = GetFunction(DLL, "RARGetDllVersion")
	EndIf
		
	Procedure Volume_Progress(ArcName.s)
		Protected.s szExtension, szPart
		
		CompilerIf #PB_Compiler_IsMainFile

			
		CompilerElse
		
		If IsGadget( DC::#Frame_006 )
			
			szExtension = GetExtensionPart( ArcName )
			
			If ( FindString( ArcName, ".part" ) > 0 )
				szPart = GetFilePart	 ( ArcName, #PB_FileSystem_NoExtension)
				szPart = GetExtensionPart( szPart )			
				szPart = ReplaceString( szPart, "part", "")
				szPart = RSet( szPart, 3, "0")
				szExtension = szPart															
			EndIf
			
			SetGadgetText( DC::#Frame_006, szExtension )
		EndIf	
		
		CompilerEndIf
	EndProcedure
	;
	;
	;
	Procedure Callback(msg, UserData, P1, P2)
		Protected Result.i

		Protected PWD.s, szMsgNote.s
		
		If UserData
			PWD = PeekS(UserData)
			
		EndIf
		Select msg
			Case #UCM_NEEDPASSWORD
				If PWD = ""
					PWD = InputRequester("Archive Benötigt Password", "Password required:", "");, #PB_InputRequester_Password)
				EndIf
				If PWD
					PokeS(P1, PWD, P2, #PB_Ascii)
					ProcedureReturn #True
				EndIf
			Case #UCM_NEEDPASSWORDW
				If PWD = ""
					PWD = InputRequester("Archive Benötigt Password", "Password required:", "");, #PB_InputRequester_Password)
				EndIf
				If PWD
					PokeS(P1, PWD, P2, #PB_Unicode)
					ProcedureReturn #True
				EndIf
			Case #UCM_CHANGEVOLUME	
				Select P2
					Case 0
						
						szMsgNote = "Benötige das nächste Volume:                       " + #CRLF$	+ Chr(34) + PeekS(P1, -1, #PB_Ascii)  + Chr(34) + #CRLF$	
						
						Result = MessageBoxExt::Show(DC::#_Window_001		, 
						                                "RAR Volume Benötigt ... "  ,
						                                szMsgNote			,
						                                #MB_YESNO			,
						                                #MB_USERICON  |
						                                #MB_DEFBUTTON1|
						                                #MB_TASKMODAL		,
						                                6				, ; #ID from Shell32 Dll
						                                "Ok"	,
						                                "Abbruch"	,
						                                ""				,
						                                "shell32.dll"		,
						                                Fonts::#_FIXPLAIN7_12	)
						
						;Result = MessageRequester("RAR Volume Benötigt ... ", , #PB_MessageRequester_Info | #MB_RETRYCANCEL )	
						If Result = 7						
							ProcedureReturn -1
						EndIf
					Case 1
						;
						; OK Found
						Volume_Progress( PeekS(P1, -1, #PB_Ascii) )
						CompilerIf #PB_Compiler_IsMainFile
							Debug "A: " + Chr(34) + PeekS(P1, -1, #PB_Ascii) + Chr(34)
						CompilerEndIf
				EndSelect
			Case #UCM_CHANGEVOLUMEW
				Select P2
					Case 0						
						szMsgNote = "Benötige das nächste Volume:                       " + #CRLF$	+ Chr(34) + PeekS(P1, -1, #PB_Unicode) + Chr(34) + #CRLF$			
						
						Result = MessageBoxExt::Show(DC::#_Window_001		, 
						                                "RAR Volume Benötigt ... "  ,
						                                szMsgNote			,
						                                #MB_YESNO			,
						                                #MB_USERICON  |
						                                #MB_DEFBUTTON1|
						                                #MB_TASKMODAL		,
						                                6				, ; #ID from Shell32 Dll
						                                "Ok"	,
						                                "Abbruch"	,
						                                ""				,
						                                "shell32.dll"		,
						                                Fonts::#_FIXPLAIN7_12	)
						
						;Result = MessageRequester("RAR Volume Benötigt ... ", , #PB_MessageRequester_Info | #MB_RETRYCANCEL )	
						If Result = 7						
							ProcedureReturn -1
						EndIf						
					Case 1
						;
						; OK Found
						Volume_Progress( PeekS(P1, -1, #PB_Ascii) )
						CompilerIf #PB_Compiler_IsMainFile
							Debug "B: " + Chr(34) + PeekS(P1, -1, #PB_Ascii) + Chr(34)
						CompilerEndIf
				EndSelect
				
		
		EndSelect
	EndProcedure
	
		
	
	Procedure UnCompressSetInfo(szString.s, szGadgetID.i, szTextWidth.i)
		
		Protected.s szInfo, szNew, szPts, szDir
		Protected.i StringMaxLen, DefaulLenght, FreeLenght, InputLenght, SubDirCount, i, u
		
		If ( Right( szString, 1) = "/" )
			ProcedureReturn 
		EndIf
		Delay( 5 )
			
			szInfo		= szString
			
			StringMaxLen 	= 50; Len("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABBBBBBNNNNN"); Maximale Gadgte Länge
			DefaulLenght 	= 14; Len("Extract: ZIP:\")					    ; Text Länge die Berücksichtig werden muss
			
			FreeLenght	= StringMaxLen - DefaulLenght
			
			InputLenght  	= Len( szInfo ) +4

			If ( InputLenght > FreeLenght )
				
				
				SubDirCount = CountString(szString, "/")
				
				
				For i = SubDirCount To 1 Step -1

					szDir = StringField( szInfo, i, "/") + "/"
					SzNew = szDir + SzNew 
					
					InputLenght = Len( SzNew )
					
					If ( InputLenght < FreeLenght )									
						Break
					EndIf	
				Next
												
				If ( SubDirCount > 1 ) And ( SubDirCount <= 4 )
					For u = 0 To SubDirCount-1
						SzNew = "./" + SzNew
					Next				
				Else
					If ( SubDirCount > 2 ) 
						SzNew = "./../" + SzNew
					EndIf
				EndIf	
				
				SzNew + GetFilePart( szString )
				
				InputLenght  	= Len( SzNew )
								
				If ( InputLenght > FreeLenght )
					Repeat
						InputLenght - 1
						SzNew      = Right( SzNew, InputLenght )							
						InputLenght = Len( SzNew )
						
					Until ( InputLenght  < FreeLenght )
					szInfo = ".." + SzNew
						
				Else					
					szInfo = SzNew
				EndIf	
				
			EndIf
			Debug "Verkürzte Version: " + szInfo
			
			
		SetGadgetText(szGadgetID,"Extract: RAR:\" + szInfo)	
					
		ProcedureReturn					
		
	EndProcedure
	
	Procedure RARUnpackArchiv(FileName.s, DestPath.s = "", Password.s = "", *Callback = 0, szGadgetID = 0, szGadgetID_With = 0)
		Protected i.i
		Protected  szFilename.s
		Protected raropen.RAROpenArchiveDataEx
		Protected rarheader.RARHeaderDataEx
		Protected hRAR, NoError = #True
		
		;VolClose = 0
		
		CompilerIf #PB_Compiler_Unicode
			raropen\ArcNameW = @Filename
		CompilerElse
			raropen\ArcName = @Filename
			If DestPath
				CharToOem_(DestPath, DestPath)
			EndIf
		CompilerEndIf
		
		raropen\OpenMode = #RAR_OM_EXTRACT
		If Password
			raropen\UserData = @Password
		EndIf
		If *Callback
			raropen\Callback = *Callback
		Else
			raropen\Callback = @Callback()
		EndIf
		
		hRAR = RAROpenArchive(raropen)
		
		If hRAR
				
			While RARReadHeader(hRAR, rarheader) = #ERAR_SUCCESS				
				
; 				If IsThread(raropen\Callback )
; 					Debug "HALLO"
; 				EndIf	
; 				If VolClose = -1
; 					KillThread( @Callback() )
; 					Break
; 				EndIf
				
				szFilename = ""				
				For i = 0 To 1023
					If rarheader\FileNameW[i] = 0
						Break
					EndIf	
					
					szFilename + PeekS( @rarheader\FileNameW[i], 1)					
				Next			
				
				CompilerIf #PB_Compiler_IsMainFile				
					If Len( szFilename ) > 0					
						Debug "UnRAR Module - Extract File " + szFilename
					EndIf	
				CompilerEndIf
				
				If ( IsGadget( szGadgetID ) And Len( szFilename ) > 0 )
					UnCompressSetInfo(szFilename, szGadgetID, szGadgetID_With)					
				EndIf	
					
				If RARProcessFile(hRAR, #RAR_EXTRACT, DestPath, #Null$) <> #ERAR_SUCCESS					
					
					NoError = #False
				EndIf
			Wend
			RARCloseArchive(hRAR)
		EndIf
		ProcedureReturn NoError
	EndProcedure
	
EndModule

CompilerIf #PB_Compiler_IsMainFile
	
	Debug UnRar::RARUnpackArchiv("D:\System Down\Mods\Succubus Demons of the Past-CODEX\Succubus.Demons.of.the.Past-CODEX.part1.rar", "B:\TestPack\" )
	
CompilerEndIf	

; IDE Options = PureBasic 5.73 LTS (Windows - x64)
; CursorPosition = 210
; FirstLine = 202
; Folding = -4-
; EnableAsm
; EnableXP