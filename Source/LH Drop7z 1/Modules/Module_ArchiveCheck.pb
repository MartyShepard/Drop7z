DeclareModule ArchiveCheck
	
	Declare.s Test_Archive(File.s)
	
	Global.s  szVersionsString	
EndDeclareModule

Module ArchiveCheck
			
	Structure ARC_HEADER
		Path.s
		File.s
		Full.s
		Size.q
		Dest.s
		pbData.l		
		header.a[132102]      
		
	EndStructure 
	
	;
	;
	;      
	Procedure .i  Close_Archive( *ARCHEAD.ARC_HEADER )
		
		If ( *ARCHEAD > 0 )           
			
			If ( *ARCHEAD\pbData > 0 )  
				Debug "Close Unknown File"
				CloseFile( *ARCHEAD\pbData )
			EndIf			
			ClearStructure(*ARCHEAD, ARC_HEADER)
			FreeMemory(*ARCHEAD)
		EndIf    
		ProcedureReturn *ARCHEAD                 
		
	EndProcedure	
	;
	;
	;
	Procedure.i	  Debug_Header(*ARCHEAD.ARC_HEADER)
			For c = 0 To 1024
				Debug "Index: ["+RSet (Str( c ), 6," ") +"] Ascii " + RSet (Str( *ARCHEAD\header[c] ), 4," ") + " - Char: " + Chr(*ARCHEAD\header[c])				
			Next	
			
			;ShowMemoryViewer(*ARCHEAD,255 )
	EndProcedure
	;
	;
	;	
	Procedure .s  Process_Header(*ARCHEAD.ARC_HEADER)
		
		Protected.i actual, result, MaxReadBytes, MinReadBytes
		
		MaxReadBytes = 21137
		MinReadBytes = *ARCHEAD\Size
		
		
		If  ( MinReadBytes  >= MaxReadBytes )
			*ARCHEAD\Size = MaxReadBytes
		EndIf	
			
		szVersionsString = ""
		
		Bytes = ReadData(*ARCHEAD\pbData, @*ARCHEAD\header[0], *ARCHEAD\Size )
		If Bytes = *ARCHEAD\Size 
						
			Debug_Header(*ARCHEAD)
			
			If (*ARCHEAD\header[0] = 'R') And
			   (*ARCHEAD\header[1] = 'a') And
			   (*ARCHEAD\header[2] = 'r') And
			   (*ARCHEAD\header[3] = '!')
				Debug "RAR Datei"
				szVersionsString = "Rar!"
				ProcedureReturn "RAR"
			EndIf	

			
			If ( *ARCHEAD\Size >= 31 )
				If (*ARCHEAD\header[28] = 'R') And
				   (*ARCHEAD\header[29] = 'J') And
				   (*ARCHEAD\header[30] = 'S') And
				   (*ARCHEAD\header[31] = 'X')
					Debug "ARJ Self Extract found"
					szVersionsString = "RJSX ( ARJ Self Extract )"					
					ProcedureReturn "ARJSFX"
				EndIf
			EndIf
			
			If ( *ARCHEAD\Size >= 31 )			
				If (*ARCHEAD\header[28] = 'R') And
				   (*ARCHEAD\header[29] = 'S') And
				   (*ARCHEAD\header[30] = 'F') And
				   (*ARCHEAD\header[31] = 'X')
					Debug "RAR Self Extract found"
					szVersionsString = "RSFX ( RAR Self Extract )"						
					ProcedureReturn "RARSFX"
				EndIf		
			EndIf
			
			If ( *ARCHEAD\Size >= 35 )
				If (*ARCHEAD\header[30] = 'P') And 
				   (*ARCHEAD\header[31] = 'K') And
				   (*ARCHEAD\header[32] = 'L') And
				   (*ARCHEAD\header[33] = 'I') And
				   (*ARCHEAD\header[34] = 'T') And
				   (*ARCHEAD\header[35] = 'E' )
					Debug "PKLITE Self Extract found"
					szVersionsString = "PKLite"					
					ProcedureReturn "ZIPSFX"
				EndIf	
			EndIf
			
			If ( *ARCHEAD\Size >= 54 )
				If (*ARCHEAD\header[30] = 'P') And 
				   (*ARCHEAD\header[31] = 'K') And
				   (*ARCHEAD\header[32] = 'l') And
				   (*ARCHEAD\header[33] = 'i') And
				   (*ARCHEAD\header[34] = 't') And
				   (*ARCHEAD\header[35] = 'e') And
				   (*ARCHEAD\header[48] = '9') And
				   (*ARCHEAD\header[49] = '0') And
				   (*ARCHEAD\header[53] = '9') And
				   (*ARCHEAD\header[54] = '6')			   
					Debug "PKlite(R) 1990-1996 Self Extract found"
					szVersionsString = "PKlite(R) Corp. 1990-1996"					
					ProcedureReturn "ZIPSFX"
				EndIf	
			EndIf			
			
			If ( *ARCHEAD\Size >= 48 )			
				If (*ARCHEAD\header[38] = 'L') And
				   (*ARCHEAD\header[39] = 'H') And
				   (*ARCHEAD\header[40] = 'a') And
				   (*ARCHEAD\header[41] = 'r') And
				   (*ARCHEAD\header[42] = 'c') And
				   (*ARCHEAD\header[46] = 'S') And
				   (*ARCHEAD\header[47] = 'F') And
				   (*ARCHEAD\header[48] = 'X')   
					Debug "LHA Self Extract found"
					szVersionsString = "LHarc SFX"					
					ProcedureReturn "LHASFX"
				EndIf	
			EndIf
			
			
			If ( *ARCHEAD\Size >= 6 )			
				If (*ARCHEAD\header[2] = '-') And
				   (*ARCHEAD\header[3] = 'l') And
				   (*ARCHEAD\header[4] = 'h') And
				   (*ARCHEAD\header[5] = '1') And
				   (*ARCHEAD\header[6] = '-')   
					Debug "LHA 1 found"
					szVersionsString = "LHA 1"					
					ProcedureReturn "LHA"
				EndIf	
			EndIf	
			
			If ( *ARCHEAD\Size >= 6 )			
				If (*ARCHEAD\header[2] = '-') And
				   (*ARCHEAD\header[3] = 'l') And
				   (*ARCHEAD\header[4] = 'h') And
				   (*ARCHEAD\header[5] = '5') And
				   (*ARCHEAD\header[6] = '-')   
					Debug "LHA 5 found"
					szVersionsString = "LHA 5"					
					ProcedureReturn "LHA"
				EndIf	
			EndIf	
					
			If ( *ARCHEAD\Size >= 44 )			
				If (*ARCHEAD\header[36] = 'L') And
				   (*ARCHEAD\header[37] = 'H') And
				   (*ARCHEAD\header[38] = 'A') And
				   (*ARCHEAD\header[40] = 's') And
				   (*ARCHEAD\header[42] = 'S') And
				   (*ARCHEAD\header[43] = 'F') And
				   (*ARCHEAD\header[44] = 'X')   
					Debug "LHA Self Extract found"
					szVersionsString = "LHA's SFX"					
					ProcedureReturn "LHASFX"
				EndIf	
			EndIf			
			
			If ( *ARCHEAD\Size >= 55 )
				If (*ARCHEAD\header[50] = 'P') And 
				   (*ARCHEAD\header[51] = 'K') And
				   (*ARCHEAD\header[52] = 'W') And
				   (*ARCHEAD\header[53] = 'A') And
				   (*ARCHEAD\header[54] = 'R') And
				   (*ARCHEAD\header[55] = 'E' )
					Debug "PKWARE Self Extract found"
					szVersionsString = "PK Ware"					
					ProcedureReturn "ZIPSFX"
				EndIf	
			EndIf
			If ( *ARCHEAD\Size >= 507 )
				If (*ARCHEAD\header[504] = 'U') And
				   (*ARCHEAD\header[505] = 'P') And
				   (*ARCHEAD\header[506] = 'X') And
				   (*ARCHEAD\header[507] = '0')
					Debug "UPX Ausführbare Datei"
					szVersionsString = "UPX"					
					ProcedureReturn "UPX"
				EndIf				
			EndIf
			If ( *ARCHEAD\Size >= 763 )
				If (*ARCHEAD\header[760] = 'U') And
				   (*ARCHEAD\header[761] = 'P') And
				   (*ARCHEAD\header[762] = 'X') And
				   (*ARCHEAD\header[763] = '0')
					Debug "UPX Ausführbare Datei"
					szVersionsString = "UPX"					
					ProcedureReturn "UPX"
				EndIf							
			EndIf
			If ( *ARCHEAD\Size >= 422 )
				If (*ARCHEAD\header[417] = 'W') And
				   (*ARCHEAD\header[418] = 'I') And
				   (*ARCHEAD\header[419] = 'N') And
				   (*ARCHEAD\header[420] = 'S') And
				   (*ARCHEAD\header[421] = 'F') And
				   (*ARCHEAD\header[422] = 'X' )
					Debug "WinZIP Self Extract found"
					szVersionsString = "WinSFX"					
					ProcedureReturn "ZIPSFX"
				EndIf	
			EndIf
			If ( *ARCHEAD\Size >= 422 )						
				If (*ARCHEAD\header[417] = 'W') And
				   (*ARCHEAD\header[418] = 'I') And
				   (*ARCHEAD\header[419] = 'N') And
				   (*ARCHEAD\header[420] = 'S') And
				   (*ARCHEAD\header[421] = 'F') And
				   (*ARCHEAD\header[422] = 'X' )
					Debug "WinZIP Self Extract found"
					szVersionsString = "WinSFX"					
					ProcedureReturn "ZIPSFX"
				EndIf	
			EndIf
			
			If ( *ARCHEAD\Size >= 53 )						
				If (*ARCHEAD\header[37] = 'L') And
				   (*ARCHEAD\header[38] = 'H') And
				   (*ARCHEAD\header[39] = 'i') And
				   (*ARCHEAD\header[40] = 'c') And
				   (*ARCHEAD\header[41] = 'e') And
				   (*ARCHEAD\header[43] = 's') And
				   (*ARCHEAD\header[45] = 'S') And
				   (*ARCHEAD\header[46] = 'F') And
				   (*ARCHEAD\header[47] = 'X') And
				   (*ARCHEAD\header[49] = '1') And
				   (*ARCHEAD\header[50] = '.') And
				   (*ARCHEAD\header[51] = '1') And
				   (*ARCHEAD\header[52] = '4') And
				   (*ARCHEAD\header[53] = 'L')						
					Debug "LHICE/ICE 1.14 Self Extract found";There are copies of LHICE marked as version 1.14. According to Okumura, LHICE is not written by Yoshi.
					szVersionsString = "LHice's SFX v1.14L"					
					ProcedureReturn "LHICE/ICE"
				EndIf	
			EndIf
			
			If ( *ARCHEAD\Size >= 2510 )						
				If (*ARCHEAD\header[2506] = 'P') And
				   (*ARCHEAD\header[2507] = 'K') And
				   (*ARCHEAD\header[2508] = 'S') And
				   (*ARCHEAD\header[2509] = 'F') And
				   (*ARCHEAD\header[2510] = 'X')
					Debug "WinZIP Self Extract found"
					szVersionsString = "PK SFX"					
					ProcedureReturn "ZIPSFX"
				EndIf	
			EndIf
			
			If ( *ARCHEAD\Size >= 132099 )
				If (*ARCHEAD\header[132096] = '7') And
				   (*ARCHEAD\header[132097] = 'z') And
				   (*ARCHEAD\header[132098] = 188) And
				   (*ARCHEAD\header[132099] = 175)
					Debug "7z Self Extract found"
					szVersionsString = "7z SFX"					
					ProcedureReturn "S7ZSFX"
				EndIf	
			EndIf
			
			If ( *ARCHEAD\Size >= 21013 )						
				If (*ARCHEAD\header[21008] = 'W') And
				   (*ARCHEAD\header[21009] = 'i') And
				   (*ARCHEAD\header[21010] = 'n') And
				   (*ARCHEAD\header[21011] = 'Z') And
				   (*ARCHEAD\header[21012] = 'i') And
				   (*ARCHEAD\header[21013] = 'p' )
					Debug "WinZIP Self Extract found"
					szVersionsString = "WinZip"					
					ProcedureReturn "ZIPSFX"
				EndIf	
			EndIf			
			
; 			If ( *ARCHEAD\Size >= 129 )						
; 				If (*ARCHEAD\header[128] = 'P') And
; 				   (*ARCHEAD\header[129] = 'E') 
; 					Debug "M$ZIP Self Extract found"
; 					szVersionsString = "M$ZIP"					
; 					ProcedureReturn "ZIPSFX"
; 				EndIf	
; 			EndIf			
						
			If (*ARCHEAD\header[0] = 'P') And
			   (*ARCHEAD\header[1] = 'K'); And (*ARCHEAD\header[2] = 3)  And (*ARCHEAD\header[4] = 4)
				Debug "ZIP Registriert"
				szVersionsString = "PK"				
				ProcedureReturn "ZIP"
			EndIf	
						
		EndIf
					
		 szVersionsString = ""
		ProcedureReturn "UNKNOWN"
		
	EndProcedure 
	;
	;
	; * Process a single archive. *
	;
	Procedure .s  Test_Archive(File.s)
		
		Protected Headed.s
		If ( FileSize( File ) > 0 )
			
			*ARCHEAD.ARC_HEADER  = AllocateMemory(SizeOf(ARC_HEADER))
			InitializeStructure(*ARCHEAD, ARC_HEADER)
			
			*ARCHEAD\Size         	= FileSize( File )
			*ARCHEAD\Full         	= File
			*ARCHEAD\Path         	= GetPathPart( File  )
			*ARCHEAD\File         	= GetFilePart( File , #PB_FileSystem_NoExtension)
						
			*ARCHEAD\pbData       	= ReadFile( #PB_Any,  *ARCHEAD\Full )
					
			
			If ( *ARCHEAD\pbData = 0 )            
				Debug File + ": Datei ist von einem anderen programm geöffnet/ File is in Use"
				Close_Archive(*ARCHEAD)
				ProcedureReturn "-2"
			EndIf
			
			Debug "Opened :" + File + #CR$
						
			Headed = Process_Header(*ARCHEAD.ARC_HEADER)				
			
			Close_Archive( *ARCHEAD )
			
			    
		EndIf			          
		ProcedureReturn Headed
	EndProcedure	
EndModule
; IDE Options = PureBasic 5.73 LTS (Windows - x64)
; CursorPosition = 316
; FirstLine = 34
; Folding = --
; EnableAsm
; EnableXP