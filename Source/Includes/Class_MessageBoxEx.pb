DeclareModule MessageBoxExt
	
	Declare.b	Show(hwnd, szCaption.s, szText.s,  dwStyle.i, dwStyleEx.i, lpszIcon.i, szbutton1.s = "", szbutton2.s ="", szbutton3.s ="")
	
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
	
EndDeclareModule

Module MessageBoxExt
		
	Global.i lhHook, ldwStyle
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
				Debug "Messagebox Extended: Hook Procedure Message " + Str(uMsg)
		EndSelect
		ProcedureReturn #False
	EndProcedure
	;
	;
	;
	Procedure.b Show(hwnd, szCaption.s, szText.s,  dwStyle.i, dwStyleEx.i, lpszIcon.i, szbutton1.s = "", szbutton2.s ="", szbutton3.s ="")
		
		Protected Messagebox.MSGBOXPARAMS
		
		#MB_USERICON = $80 

		If ( hwnd <> 0 )
			hwnd = WindowID(hwnd)
		EndIf
		
		Messagebox\cbSize		= SizeOf(MSGBOXPARAMS) 
		Messagebox\hwndOwner	= hwnd ; change to windowID(#your window) if needed
		Messagebox\hInstance	= 0
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
		
		lhHook   = SetWindowsHookEx_ (#WH_CBT, @MsgBoxHookProc (), hInstance, hThreadId)
		
		ProcedureReturn MessageBoxIndirect_(@Messagebox)
		
	EndProcedure
	
EndModule

CompilerIf #PB_Compiler_IsMainFile
Result.b = MessageboxExt::Show(0, "Search for program...", "Please select the drive to search...", #MB_ABORTRETRYIGNORE, #MB_USERICON | #MB_DEFBUTTON2|#MB_TASKMODAL, #IDI_INFORMATION,"Search C:\", "Search D:\", "Cancel")
Debug Result


If Result.b=MessageBoxExt::#IDABORT ; Yes or #IDNO for no...
	Beep_(100,50)
	Debug "#IDABORT"
EndIf

End
CompilerEndIf
; IDE Options = PureBasic 5.73 LTS (Windows - x64)
; CursorPosition = 120
; FirstLine = 128
; Folding = --
; EnableAsm
; EnableXP