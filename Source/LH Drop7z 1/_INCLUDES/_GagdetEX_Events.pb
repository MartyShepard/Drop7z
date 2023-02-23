

Procedure Event_GadgetEx_Events()
	Select EventGadget()
			
			
			;**********************************************************************************************************************    
		Case DC::#Button_001    
			Select BUTTONEX::ButtonExEvent(DC::#Button_001)  
				Case BUTTONEX::#ButtonGadgetEx_Entered:  
					
				Case BUTTONEX::#ButtonGadgetEx_Released
				Case BUTTONEX::#ButtonGadgetEx_Pressed:       _Exit_Win():End
			EndSelect  
			
			;**********************************************************************************************************************    
		Case DC::#Button_002    
			Select BUTTONEX::ButtonExEvent(DC::#Button_002)  
				Case BUTTONEX::#ButtonGadgetEx_Entered:
					
				Case BUTTONEX::#ButtonGadgetEx_Released
				Case BUTTONEX::#ButtonGadgetEx_Pressed      ; BUTTONEX::SetState(DC::#Button_002,0):_Clear_FileList()
					BUTTONEX::SetState(DC::#Button_002,0)      
					
					
					iMax  = CountGadgetItems(DC::#ListIcon_001)
					If iMax <> 0
						
						Select INIValue::Get_Value("SETTINGS","CreateSHA1",CFG::*Config\ConfigPath.s) 
							Case 1                             
								GUI04::ConsoleWindow()
							Default
						EndSelect
						
						ComboAutoText() 
						;
						; Vorab querverweisung
						;Select ( DropCode::GetArchivFormat() )
								;
								; Compress Full Action
							;Case "7z", "zip"
								_Disable_Enable_Gadets(1)
								nError = DropVert::ConvertArchive()
								If ( nError >= 10 )
									;
									; Alles was grösse ist als 10 wird als Fehler behandelt
								EndIf    
								;_Disable_Enable_Gadets(0)								                             								
						;EndSelect    
						
						If IsWindow(DC::#_Window_004)                                
							HideWindow(DC::#_Window_004,1)
							StickyWindow(DC::#_Window_004,0): 
							SetForegroundWindow_(WindowID(DC::#_Window_001))
							CloseWindow(DC::#_Window_004)
						EndIf                          
						DropSYSF::Process_FreeRam()
					Else
						Request::MSG( DropLang::GetUIText(20) , DropLang::GetUIText(21)  ,DropLang::GetUIText(22), 2,1,ProgramFilename(),0,0,DC::#_Window_001)
					EndIf                    					
			EndSelect  
			
			;**********************************************************************************************************************    
		Case DC::#Button_003
			Select BUTTONEX::ButtonExEvent(DC::#Button_003)  
				Case BUTTONEX::#ButtonGadgetEx_Entered: 
					
				Case BUTTONEX::#ButtonGadgetEx_Released
				Case BUTTONEX::#ButtonGadgetEx_Pressed:        BUTTONEX::SetState(DC::#Button_003,0)   
					iMax  = CountGadgetItems(DC::#ListIcon_001)
					If iMax <> 0
						ComboAutoText() 
						
						Select INIValue::Get_Value("SETTINGS","CreateSHA1",CFG::*Config\ConfigPath.s) 
							Case 1                             
								GUI04::ConsoleWindow()
							Default
						EndSelect
						
						;
						; Vorab querverweisung
						Select ( DropCode::GetArchivFormat() )
								;
								; Compress Full Action
							Case "7z", "zip"
								_Disable_Enable_Gadets(1)
								nError = DropPack::Compress()
								If ( nError >= 10 )
									;
									; Alles was grösse ist als 10 wird als Fehler behandelt
								EndIf    
								_Disable_Enable_Gadets(0)
								
							Case "chd"
								nError = CHD::Compress()
								If ( nError >= 9 )
									
								ElseIf ( nError >= 1 ) And ( nError <= 8 )
									CHD::MessagesRequest(nError)
								Else
									CHD::Start_Manager()
								EndIf
						EndSelect
						
						If IsWindow(DC::#_Window_004)                                
							HideWindow(DC::#_Window_004,1)
							StickyWindow(DC::#_Window_004,0): 
							SetForegroundWindow_(WindowID(DC::#_Window_001))
							CloseWindow(DC::#_Window_004)
						EndIf                              
						DropSYSF::Process_FreeRam()
					Else
						
						Request::MSG( DropLang::GetUIText(20) , DropLang::GetUIText(21)  ,DropLang::GetUIText(22), 2,1,ProgramFilename(),0,0,DC::#_Window_001)
					EndIf
			EndSelect  
			
			;**********************************************************************************************************************    
		Case DC::#Button_006    
			Select BUTTONEX::ButtonExEvent(DC::#Button_006)  
				Case BUTTONEX::#ButtonGadgetEx_Entered:     
					
				Case BUTTONEX::#ButtonGadgetEx_Released
				Case BUTTONEX::#ButtonGadgetEx_Pressed
					
					BUTTONEX::SetState(DC::#Button_006,0)      
					
					
					iMax  = CountGadgetItems(DC::#ListIcon_001)
					If iMax <> 0
						
						Select INIValue::Get_Value("SETTINGS","CreateSHA1",CFG::*Config\ConfigPath.s) 
							Case 1                             
								GUI04::ConsoleWindow()
							Default
						EndSelect
						
						ComboAutoText() 
						;
						; Vorab querverweisung
						Select ( DropCode::GetArchivFormat() )
								;
								; Compress Full Action
							Case "7z", "zip"
								_Disable_Enable_Gadets(1)
								nError = DropSpak::Compress()
								If ( nError >= 10 )
									;
									; Alles was grösse ist als 10 wird als Fehler behandelt
								EndIf    
								_Disable_Enable_Gadets(0)
								
							Case "chd"                                 
								CHD::Compress_SingleFiles(p)
								
								nError = CHD::Compress()
								If ( nError >= 9 )
									
								ElseIf ( nError >= 1 ) And ( nError <= 8 )
									CHD::MessagesRequest(nError)
								Else
									CHD::Start_Manager()
								EndIf                              
								
						EndSelect    
						
						If IsWindow(DC::#_Window_004)                                
							HideWindow(DC::#_Window_004,1)
							StickyWindow(DC::#_Window_004,0): 
							SetForegroundWindow_(WindowID(DC::#_Window_001))
							CloseWindow(DC::#_Window_004)
						EndIf                          
						DropSYSF::Process_FreeRam()
					Else
						Request::MSG( DropLang::GetUIText(20) , DropLang::GetUIText(21)  ,DropLang::GetUIText(22), 2,1,ProgramFilename(),0,0,DC::#_Window_001)
					EndIf                    
			EndSelect               
			
			;**********************************************************************************************************************    
		Case DC::#Button_005    
			Select BUTTONEX::ButtonExEvent(DC::#Button_005)  
				Case BUTTONEX::#ButtonGadgetEx_Entered:      
					
				Case BUTTONEX::#ButtonGadgetEx_Released
				Case BUTTONEX::#ButtonGadgetEx_Pressed:       BUTTONEX::SetState(DC::#Button_005,0)
					Open_Profile()                       
			EndSelect
			
			;**********************************************************************************************************************    
		Case DC::#Button_004    
			Select BUTTONEX::ButtonExEvent(DC::#Button_004)  
				Case BUTTONEX::#ButtonGadgetEx_Entered:      
					
				Case BUTTONEX::#ButtonGadgetEx_Released
				Case BUTTONEX::#ButtonGadgetEx_Pressed:       BUTTONEX::SetState(DC::#Button_004,0):_Browse_DestinationPath()
			EndSelect                
	EndSelect
EndProcedure


; IDE Options = PureBasic 6.00 LTS (Windows - x64)
; CursorPosition = 47
; FirstLine = 14
; Folding = -
; EnableAsm
; EnableXP
; UseMainFile = ..\Drop7z.pb
; CurrentDirectory = ..\Drop7z\
; EnableUnicode