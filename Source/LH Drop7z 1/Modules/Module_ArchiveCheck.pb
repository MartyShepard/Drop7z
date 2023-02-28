DeclareModule ArchiveCheck
	
	Declare.s Test_Archive(File.s)
	
	
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
		
		MaxReadBytes = 132102
		MinReadBytes = *ARCHEAD\Size
		
		
		If  ( MinReadBytes  >= MaxReadBytes )
			*ARCHEAD\Size = MaxReadBytes
		EndIf	
			

		Bytes = ReadData(*ARCHEAD\pbData, @*ARCHEAD\header[0], *ARCHEAD\Size )
		If Bytes = *ARCHEAD\Size 
			
; Index: [   417] Ascii   87 - Char: W
; Index: [   ] Ascii   73 - Char: I
; Index: [   ] Ascii   78 - Char: N
; Index: [   ] Ascii   83 - Char: S
; Index: [   ] Ascii   70 - Char: F
; Index: [   ] Ascii   88 - Char: X

			
			Debug_Header(*ARCHEAD)
			
			If (*ARCHEAD\header[0] = 'R') And
			   (*ARCHEAD\header[1] = 'a') And
			   (*ARCHEAD\header[2] = 'r') And
			   (*ARCHEAD\header[3] = '!')
				Debug "RAR Datei"
				ProcedureReturn "RAR"
			EndIf	
			
			If (*ARCHEAD\header[28] = 'R') And
			   (*ARCHEAD\header[29] = 'J') And
			   (*ARCHEAD\header[30] = 'S') And
			   (*ARCHEAD\header[31] = 'X')
				Debug "ARJ Self Extract found"
				ProcedureReturn "ARJSFX"
			EndIf
			
			If (*ARCHEAD\header[28] = 'R') And
			   (*ARCHEAD\header[29] = 'S') And
			   (*ARCHEAD\header[30] = 'F') And
			   (*ARCHEAD\header[31] = 'X')
				Debug "RAR Self Extract found"
				ProcedureReturn "RARSFX"
			EndIf		
			
			If (*ARCHEAD\header[38] = 'L') And
			   (*ARCHEAD\header[39] = 'H') And
			   (*ARCHEAD\header[40] = 'a') And
			   (*ARCHEAD\header[41] = 'r') And
			   (*ARCHEAD\header[42] = 'c') And
			   (*ARCHEAD\header[46] = 'S') And
			   (*ARCHEAD\header[47] = 'F') And
			   (*ARCHEAD\header[48] = 'X')   
				Debug "LHA Self Extract found"
				ProcedureReturn "LHASFX"
			EndIf	
			
			If (*ARCHEAD\header[504] = 'U') And
			   (*ARCHEAD\header[505] = 'P') And
			   (*ARCHEAD\header[506] = 'X') And
			   (*ARCHEAD\header[507] = '0')
				Debug "UPX Ausführbare Datei"
				ProcedureReturn "UPX"
			EndIf				
			
			If (*ARCHEAD\header[760] = 'U') And
			   (*ARCHEAD\header[761] = 'P') And
			   (*ARCHEAD\header[762] = 'X') And
			   (*ARCHEAD\header[763] = '0')
				Debug "UPX Ausführbare Datei"
				ProcedureReturn "UPX"
			EndIf
			
			If (*ARCHEAD\header[132096] = '7') And
			   (*ARCHEAD\header[132097] = 'z') And
			   (*ARCHEAD\header[132098] = 188) And
			   (*ARCHEAD\header[132099] = 175)
				Debug "7z Self Extract found"
				ProcedureReturn "S7ZSFX"
			EndIf			
			
		
			If (*ARCHEAD\header[50] = 'P') And 
			   (*ARCHEAD\header[51] = 'K') And
			   (*ARCHEAD\header[52] = 'W') And
			   (*ARCHEAD\header[53] = 'A') And
			   (*ARCHEAD\header[54] = 'R') And
			   (*ARCHEAD\header[55] = 'E' )
				Debug "PKWARE Self Extract found"
				ProcedureReturn "ZIPSFX"
			EndIf	

			If (*ARCHEAD\header[30] = 'P') And 
			   (*ARCHEAD\header[31] = 'K') And
			   (*ARCHEAD\header[32] = 'L') And
			   (*ARCHEAD\header[33] = 'I') And
			   (*ARCHEAD\header[34] = 'T') And
			   (*ARCHEAD\header[35] = 'E' )
				Debug "PKLITE Self Extract found"
				ProcedureReturn "ZIPSFX"
			EndIf	
			
			If (*ARCHEAD\header[417] = 'W') And
			   (*ARCHEAD\header[418] = 'I') And
			   (*ARCHEAD\header[419] = 'N') And
			   (*ARCHEAD\header[420] = 'S') And
			   (*ARCHEAD\header[421] = 'F') And
			   (*ARCHEAD\header[422] = 'X' )
				Debug "WinZIP Self Extract found"
				ProcedureReturn "ZIPSFX"
			EndIf	
			

			
			If (*ARCHEAD\header[0] = 'P') And
			   (*ARCHEAD\header[1] = 'K'); And (*ARCHEAD\header[2] = 3)  And (*ARCHEAD\header[4] = 4)
				Debug "ZIP Registriert"
				ProcedureReturn "ZIP"
			EndIf			
		EndIf
		
		ProcedureReturn ""
		
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
; IDE Options = PureBasic 6.00 LTS (Windows - x64)
; CursorPosition = 107
; FirstLine = 80
; Folding = --
; EnableAsm
; EnableXP