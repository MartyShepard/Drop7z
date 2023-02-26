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
		header.a[1025]      
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
				Debug "Index: ["+RSet (Str( c ), 3," ") +"] Ascii " + RSet (Str( *ARCHEAD\header[c] ), 4," ") + " - Char: " + Chr(*ARCHEAD\header[c])				
			Next	
			
			;ShowMemoryViewer(*ARCHEAD,255 )
	EndProcedure
	;
	;
	;	
	Procedure .s  Process_Header(*ARCHEAD.ARC_HEADER)
		
		Protected actual.i, result.i
		
		
;Index: [504] Ascii   85 - Char: U
;Index: [505] Ascii   80 - Char: P
;Index: [506] Ascii   88 - Char: X
;Index: [507] Ascii   48 - Char: 0

		Bytes = ReadData(*ARCHEAD\pbData, @*ARCHEAD\header[0], 1025)
		If Bytes = 1025

			Debug_Header(*ARCHEAD)
			
			If (*ARCHEAD\header[0] = 'R') And (*ARCHEAD\header[1] = 'a') And (*ARCHEAD\header[2] = 'r')  And (*ARCHEAD\header[3] = '!')
				Debug "RAR Datei"
				ProcedureReturn "RAR"
			EndIf	
			
			If (*ARCHEAD\header[28] = 'R') And (*ARCHEAD\header[29] = 'J') And (*ARCHEAD\header[30] = 'S')  And (*ARCHEAD\header[31] = 'X')
				Debug "ARJ Self Extract found"
				ProcedureReturn "ARJSFX"
			EndIf
			
			If (*ARCHEAD\header[28] = 'R') And (*ARCHEAD\header[29] = 'S') And (*ARCHEAD\header[30] = 'F')  And (*ARCHEAD\header[31] = 'X')
				Debug "RAR Self Extract found"
				ProcedureReturn "RARSFX"
			EndIf		
			
			If (*ARCHEAD\header[504] = 'U') And (*ARCHEAD\header[505] = 'P') And (*ARCHEAD\header[506] = 'X')  And (*ARCHEAD\header[507] = '0')
				Debug "UPX Ausführbare Datei"
				ProcedureReturn "UPX"
			EndIf				
			
			If (*ARCHEAD\header[760] = 'U') And (*ARCHEAD\header[761] = 'P') And (*ARCHEAD\header[762] = 'X')  And (*ARCHEAD\header[763] = '0')
				Debug "UPX Ausführbare Datei"
				ProcedureReturn "UPX"
			EndIf
			
			If (*ARCHEAD\header[0] = 'P') And (*ARCHEAD\header[1] = 'K'); And (*ARCHEAD\header[2] = 3)  And (*ARCHEAD\header[4] = 4)
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
; IDE Options = PureBasic 5.73 LTS (Windows - x64)
; CursorPosition = 89
; FirstLine = 69
; Folding = --
; EnableAsm
; EnableXP