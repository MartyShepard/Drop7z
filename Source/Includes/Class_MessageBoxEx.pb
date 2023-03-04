DeclareModule MessageBoxExt
	
	Declare.b	Show(hwnd		,	  ; The WindowHandle (without WindowID())
	         	     szCaption.s	,	  ; The Window Title Text
	         	     szText.s	,	  ; The Message Text
	         	     dwStyle	,	  ; Style: 	MB_ABORTRETRYIGNORE
							  ;		MB_CANCELTRYCONTINUE
							  ;		MB_HELP
							  ;		MB_OK
							  ;	      MB_OKCANCEL
							  ;		MB_RETRYCANCEL
							  ;		MB_YESNO
							  ;		MB_YESNOCANCEL
			     dwStyleEx	,	  ; Optional dwStyle
							  ;	      MB_DEFBUTTON1
							  ;		MB_DEFBUTTON2
							  ;		MB_DEFBUTTON3
							  ;		MB_DEFBUTTON4		
							  ;		MB_APPLMODAL
							  ;		MB_SYSTEMMODAL	-  the message box has the WS_EX_TOPMOST style
							  ;		MB_TASKMODAL	-  the message box has the WS_EX_TOPMOST style
			     lpszIcon.i	,	  ; The Icon. This can be: (or use the combination with "DynamicLibrary" and icon id nr from dll)
							  ;		IDI_APPLICATION 
							  ;		IDI_ASTERISK 
							  ;		IDI_ERROR 
							  ;		IDI_EXCLAMATION 
							  ;		IDI_HAND 
							  ;		IDI_INFORMATION 
							  ;		IDI_QUESTION 
							  ;		IDI_WARNING 
							  ;		IDI_WINLOGO 
			     szbutton1.s     = "",; Custom Button Text
			     szbutton2.s     = "",; Custom Button Text
			     szbutton3.s     = "",; Custom Button Text
			     DynamicLibrary.s= "",; Use Custom Icon from dll eq: DynamicLibrary = "shell32.dll"
			     pbFontID.l	   = 0 ); 

	
	#IDOK 	= 1
	#IDCANCEL 	= 2
	#IDABORT 	= 3
	#IDRETRY 	= 4
	#IDIGNORE 	= 5
	#IDYES 	= 6
	#IDNO 	= 7
	#IDTRYAGAIN = 10
	#IDCONTINUE = 11
	#IDPROMPT 	= $FFFF
	
	#MB_USERICON = $80 
EndDeclareModule

Module MessageBoxExt
		
	Global.i lhHook, ldwStyle
	Global.l hFont
	Global.s szDlgButton1, szDlgButton2, szDlgButton3
	;
	;
	;	
	Procedure MsgBoxHookProc (uMsg, wParam, lParam)
		Select uMsg
			;Case #WH_CBT 
			;	Debug "Messagebox Extended: Hook Procedure #WH_CBT " + Str(uMsg)
			Case #HCBT_ACTIVATE
				
				#MB_CANCELTRYCONTINUE = 6
				
				*tagDRAWITEMSTRUCT.DRAWITEMSTRUCT 
				
				*tagDRAWITEMSTRUCT = lParam
				
				;SetWindowText_ (wParam, szDlgTitle)
				;SetDlgItemText_ (wParam, #IDPROMPT, szDlgMessage)
				
				Select ldwStyle
					Case #MB_OK				; 1 Button
						If ( Len( szDlgButton1 ) > 0 )
							SetDlgItemText_ ( wParam, #IDOK    , szDlgButton1 )
						EndIf
						
					Case #MB_OKCANCEL			; 2 Buttons
						If ( Len( szDlgButton1 ) > 0 )
							SetDlgItemText_ ( wParam, #IDOK    , szDlgButton1 )
						EndIf
						If ( Len( szDlgButton2 ) > 0 )
							SetDlgItemText_ ( wParam, #IDCANCEL, szDlgButton2 )
						EndIf				
						
					Case #MB_YESNO			; 2 Buttons
						
						If ( Len( szDlgButton1 ) > 0 )
							SetDlgItemText_ ( wParam, #IDYES    , szDlgButton1 )
						EndIf
						If ( Len( szDlgButton2 ) > 0 )
							SetDlgItemText_ ( wParam, #IDNO	, szDlgButton2 )
						EndIf	
						
					Case #MB_RETRYCANCEL		; 2 Buttons	
						If ( Len( szDlgButton1 ) > 0 )
							SetDlgItemText_ ( wParam, #IDRETRY    , szDlgButton1 )
						EndIf
						If ( Len( szDlgButton2 ) > 0 )
							SetDlgItemText_ ( wParam, #IDCANCEL	  , szDlgButton2 )
						EndIf
						
					Case #MB_YESNOCANCEL		; 3 Buttons
						If ( Len( szDlgButton1 ) > 0 )
							SetDlgItemText_ ( wParam, #IDYES    , szDlgButton1 )
						EndIf
						If ( Len( szDlgButton2 ) > 0 )
							SetDlgItemText_ ( wParam, #IDNO	, szDlgButton2 )
						EndIf	
						If ( Len( szDlgButton3 ) > 0 )
							SetDlgItemText_ ( wParam, #IDCANCEL	  , szDlgButton3 )
						EndIf	
						
					Case #MB_ABORTRETRYIGNORE	; 3 Buttons	
						If ( Len( szDlgButton1 ) > 0 )
							SetDlgItemText_ ( wParam, #IDABORT    , szDlgButton1 )
						EndIf
						If ( Len( szDlgButton2 ) > 0 )
							SetDlgItemText_ ( wParam, #IDRETRY	, szDlgButton2 )
						EndIf	
						If ( Len( szDlgButton3 ) > 0 )
							SetDlgItemText_ ( wParam, #IDIGNORE	  , szDlgButton3 )
						EndIf	
						
					Case #MB_CANCELTRYCONTINUE	; 3 Buttons	
						If ( Len( szDlgButton1 ) > 0 )
							SetDlgItemText_ ( wParam, #IDCANCEL    , szDlgButton1 )
						EndIf
						If ( Len( szDlgButton2 ) > 0 )
							SetDlgItemText_ ( wParam, #IDTRYAGAIN , szDlgButton2 )
						EndIf	
						If ( Len( szDlgButton3 ) > 0 )
							SetDlgItemText_ ( wParam, #IDCONTINUE  , szDlgButton3 )
						EndIf										
				EndSelect	
				
				
				
				UnhookWindowsHookEx_ (lhHook)
			Default
				CompilerIf #PB_Compiler_IsMainFile
					Debug "Messagebox Extended: Hook Procedure Message " + Str(uMsg)
				CompilerEndIf	
		EndSelect
		ProcedureReturn #False
	EndProcedure
	;
	;
	;
	Procedure.b Show(hwnd, szCaption.s, szText.s,  dwStyle, dwStyleEx, lpszIcon.i, szbutton1.s = "", szbutton2.s ="", szbutton3.s ="",DynamicLibrary.s ="", pbFontID.l = 0)
		
		Protected Messagebox.MSGBOXPARAMS
		
		

		If ( hwnd <> 0 )
			hwnd = WindowID(hwnd)
		EndIf
					
		Messagebox\cbSize		= SizeOf(MSGBOXPARAMS) 
		Messagebox\hwndOwner	= hwnd ; change to windowID(#your window) if needed
		
		If ( Len( DynamicLibrary ) > 0 )			
			
			Messagebox\hInstance	= LoadLibrary_(DynamicLibrary)
		Else	
			Messagebox\hInstance	= 0
		EndIf
		
		Messagebox\lpszText	= @szText
		Messagebox\lpszCaption	= @szCaption 
		
		; lookup other dwStyles under SDK MessageBoxEx Function <<<---
			;MB_ABORTRETRYIGNORE
			;MB_CANCELTRYCONTINUE
			;MB_HELP
			;MB_OK
			;MB_OKCANCEL
			;MB_RETRYCANCEL
			;MB_YESNO
			;MB_YESNOCANCEL
		
		; dwStyleEx
			;MB_DEFBUTTON1
			;MB_DEFBUTTON2
			;MB_DEFBUTTON3
			;MB_DEFBUTTON4		
			;MB_APPLMODAL
			;MB_SYSTEMMODAL	-  the message box has the WS_EX_TOPMOST style
			;MB_TASKMODAL		
		Messagebox\dwStyle	= dwStyle|dwStyleEx
		
		;{ more lpszIcon options 
			;IDI_APPLICATION 
			;IDI_ASTERISK 
			;IDI_ERROR 
			;IDI_EXCLAMATION 
			;IDI_HAND 
			;IDI_INFORMATION 
			;IDI_QUESTION 
			;IDI_WARNING 
			;IDI_WINLOGO 
		;}		
		Messagebox\lpszIcon=lpszIcon
		
		hInstance 	= GetModuleHandle_ (0)
		hThreadId 	= GetCurrentThreadId_()
		
		;
		;
		; Change MessageBox Button Text	
		szDlgButton1 = ""
		szDlgButton2 = ""
		szDlgButton3 = ""		
		szDlgButton1 = szbutton1
		szDlgButton2 = szbutton2
		szDlgButton3 = szbutton3
		
		ldwStyle = 0
		ldwStyle = dwStyle
		
		If ( pbFontID > 0 )
			pbFontID = FontID( pbFontID )	
		EndIf	
		
			
       		
		
		CompilerIf #PB_Compiler_IsMainFile
			
		*LogFont.LogFont = AllocateMemory( SizeOf( LogFont ) )					
		GetObject_(pbFontID, SizeOf(LOGFONT), *LogFont); 
        	
			szFontFamilie.s = ""				
			For i = 0 To 1023
				If *LogFont\lfFaceName[i] = 0
					Break
				EndIf	
				
				szFontFamilie + Chr( *LOGFONT\lfFaceName[i])					
			Next	
			Debug "Front    			: " + szFontFamilie		
			Debug "Font Width 		: " + Str( *LogFont\lfWidth )	
			Debug "Font Height		: " + Str( *LogFont\lfHeight)			
			
		            Select *LogFont\lfWeight
		                Case #FW_DONTCARE   : Debug "Font Weight 		: " + Str( *LogFont\lfWeight ) + " = #FW_DONTCARE"
		                Case #FW_THIN       : Debug "Font Weight 		: " + Str( *LogFont\lfWeight ) + " = #FW_THIN"
		                Case #FW_EXTRALIGHT : Debug "Font Weight 		: " + Str( *LogFont\lfWeight ) + " = #FW_EXTRALIGHT"
		                Case #FW_ULTRALIGHT : Debug "Font Weight 		: " + Str( *LogFont\lfWeight ) + " = #FW_ULTRALIGHT"                 
		                Case #FW_LIGHT      : Debug "Font Weight 		: " + Str( *LogFont\lfWeight ) + " = #FW_LIGHT"                
		                Case #FW_NORMAL     : Debug "Font Weight 		: " + Str( *LogFont\lfWeight ) + " = #FW_NORMAL"  
		                Case #FW_REGULAR    : Debug "Font Weight 		: " + Str( *LogFont\lfWeight ) + " = #FW_REGULAR"          
		                Case #FW_MEDIUM     : Debug "Font Weight 		: " + Str( *LogFont\lfWeight ) + " = #FW_MEDIUM"      
		                Case #FW_SEMIBOLD   : Debug "Font Weight 		: " + Str( *LogFont\lfWeight ) + " = #FW_SEMIBOLD"       
		                Case #FW_DEMIBOLD   : Debug "Font Weight 		: " + Str( *LogFont\lfWeight ) + " = #FW_DEMIBOLD"          
		                Case #FW_BOLD       : Debug "Font Weight 		: " + Str( *LogFont\lfWeight ) + " = #FW_BOLD"
		                Case #FW_EXTRABOLD  : Debug "Font Weight 		: " + Str( *LogFont\lfWeight ) + " = #FW_EXTRABOLD"          
		                Case #FW_ULTRABOLD  : Debug "Font Weight 		: " + Str( *LogFont\lfWeight ) + " = #FW_ULTRABOLD"            
		                Case #FW_HEAVY      : Debug "Font Weight 		: " + Str( *LogFont\lfWeight ) + " = #FW_HEAVY"       
		                Case #FW_BLACK      : Debug "Font Weight 		: " + Str( *LogFont\lfWeight ) + " = #FW_BLACK"       
		          EndSelect
		          			
			Debug "Font Italic 		: " + Str( *LogFont\lfItalic )				
			Debug "Font Charset 		: " + Str( *LogFont\lfCharSet )	
			Debug "Font Out Precision 	: " + Str( *LogFont\lfOutPrecision )	
			Debug "Font Clip Precision 	: " + Str( *LogFont\lfClipPrecision )
			Debug "Font Quality		: " + Str( *LogFont\lfQuality )
			Debug "Font PitchAndFamily	: " + Str( *LogFont\lfPitchAndFamily )
			
			
		hFont = CreateFontIndirect_(@LogFont)
		SendMessage_(hwnd, #WM_SETFONT, hFont, 1)
		

		CompilerEndIf
		
		
		lhHook   = SetWindowsHookEx_ (#WH_CBT, @MsgBoxHookProc (), hInstance, hThreadId)
		

		
		ProcedureReturn MessageBoxIndirect_(@Messagebox)
		
	EndProcedure
	
EndModule

CompilerIf #PB_Compiler_IsMainFile
	
	pbFont.l = LoadFont (#PB_Any, "CRAMPS", 15)

	
Result.b = MessageboxExt::Show(0, "Search for program...", "Please select the drive to search...", #MB_ABORTRETRYIGNORE, #MB_USERICON | #MB_DEFBUTTON2|#MB_TASKMODAL, 10,"Search C:\", "Search D:\", "Cancel", "shell32.dll", pbFont)
Debug Result


If Result.b=MessageBoxExt::#IDABORT ; Yes or #IDNO for no...
	Beep_(100,50)
	Debug "#IDABORT"
EndIf

End
CompilerEndIf
; IDE Options = PureBasic 5.73 LTS (Windows - x64)
; CursorPosition = 274
; FirstLine = 207
; Folding = --
; EnableAsm
; EnableXP