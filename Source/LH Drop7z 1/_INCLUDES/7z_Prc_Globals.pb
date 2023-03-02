

Procedure.s  GetPath_Config(iWhichConfig = 0)
	Protected ProFileConfig$, iDrop7z_Config$, FullFileCurrent$, HistoryLog$
	
	
	FullFileCurrent$ = ProgramFilename()
	FullFileCurrent$ = GetPathPart(FullFileCurrent$)
	
	If (iWhichConfig = 1)
		iDrop7z_Config$ = FullFileCurrent$+"Drop7z.ini"
		ProcedureReturn iDrop7z_Config$       
	EndIf
	
	If (iWhichConfig = 2)
		ProFileConfig$ = FullFileCurrent$+"Drop7z_Profiles.ini"
		ProcedureReturn ProFileConfig$      
	EndIf
	
	If (iWhichConfig = 3)
		HistoryLog$ = FullFileCurrent$+"Drop7z_History.ini"
		ProcedureReturn HistoryLog$      
	EndIf
EndProcedure
;
;
;
Procedure.l _Read_Config_L(Section.s,Key.s,iFile.s) 
	
	iValue.s = Space(255) 
	ValueString.l = GetPrivateProfileString_ (Section, Key, '', iValue, Len(iValue), iFile) 
	iValue = Left(iValue, ValueString) 
	ProcedureReturn Val(iValue) 
	
EndProcedure                                 

;
;
; Combo Liste. Dateien aus der text Datei hinzufügen
Procedure ComboAutoText_Additems(iFile$)  
	
	SendMessage_(GadgetID(DC::#String_002),#CB_ADDSTRING,0,iFile$)
	
	If OpenFile(DC::#_FileHistory, CFG::*Config\HistoryPath.s)
		
		FileSeek(DC::#_FileHistory, Lof(DC::#_FileHistory))
		WriteStringN(DC::#_FileHistory, iFile$)
		
		CloseFile(DC::#_FileHistory)
		
	EndIf
EndProcedure
;
;
;    
Procedure.i ComboAutoText()
	
	Protected iCBText$,iCBMax, indexCB,iCompare$, iNotFound = 0
	
	Protected HistoryLog$
	
	HistoryLog$ = GetCurrentDirectory() + "Drop7z_History.ini"    
	
	iCBText$ = GetGadgetText(DC::#String_002)
	
	If ( Len(iCBText$) = 0 Or Len(iCBText$) = 1 )
		ProcedureReturn
	EndIf
	
	iCBText$ = ReverseString(iCBText$)
	iPos     = FindString(iCBText$,"\",1)
	iCBText$ = ReverseString(iCBText$)
	
	If (iPos = 0) 
		iCBText$ = iCBText$+"\"
		SetGadgetText(DC::#String_002,iCBText$)
		
		; Cursor Position in der Comboxbox Setzen
		SendMessage_(GadgetID(DC::#String_002), #CB_SETEDITSEL, 0, Len(iCBText$) << 16 + Len(iCBText$))
	EndIf
	
	iCBMax = CountGadgetItems(DC::#String_002)
	
	If      (iCBMax = 0)
		
		ComboAutoText_Additems(iCBText$)

		
	ElseIf  (iCBMax >= 1)
		
		For indexCB = 0 To iCBMax
			iCompare$ = GetGadgetItemText(DC::#String_002,indexCB)
			
			If LCase(iCompare$) = LCase(iCBText$)
				iNotFound = 1
			EndIf
		Next
		
		If (iNotFound = 0)
			ComboAutoText_Additems(iCBText$)
		EndIf
      
	EndIf
	
	If ( CFG::*Config\PinDirectory = #True )		
		SetGadgetText( DC::#String_002, CFG::*Config\szPinCurrent)
	EndIf		
EndProcedure  

;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 

Procedure.i ComboAutoComplete(hWnd, uMsg, wParam, lParam)
	Protected result
	Protected acg
	Protected spos.l
	Protected epos.l
	Protected matchesfound
	Protected x
	Protected match
	Protected ks
	Protected addchar$
	Protected key
	
	Select uMsg
			
		Case #WM_CHAR
			acg=GetActiveGadget()
			SendMessage_(hwnd, #EM_GETSEL, @spos.l, @epos.l)
			
			matchesfound=0
			For x=0 To CountGadgetItems(acg)-1
				If LCase(Left(GetGadgetText(acg),spos)+LCase(Chr(wParam)))=LCase(Left(GetGadgetItemText(acg,x),spos+1)) And epos=Len(GetGadgetText(acg))
					matchesfound+1:match=x
					If matchesfound>1
						Break
					EndIf
				EndIf
			Next x
			
			If matchesfound=1
				ks=GetKeyState_(#VK_SHIFT)
				If ks<2:addchar$=LCase(Chr(wparam))
				Else
					addchar$=UCase(Chr(wparam))
				EndIf
				SetGadgetText(acg,Left(GetGadgetText(acg),spos)+addchar$+Mid(GetGadgetItemText(acg,match),spos+2))
				GadgetToolTip(acg,Left(GetGadgetText(acg),spos)+addchar$+Mid(GetGadgetItemText(acg,match),spos+2))  
				SendMessage_(hwnd, #EM_SETSEL, spos+1, epos+999)
				result=0
			Else
				result = CallWindowProc_(oldcomboproc, hWnd, uMsg, wParam, lParam)
			EndIf
			
		Case #WM_KEYDOWN
			acg=GetActiveGadget()
			key=wParam
			If key=#VK_RETURN And DC::#String_002 = acg; return key   
				ComboAutoText()
			EndIf
			
		Default
			result = CallWindowProc_(oldcomboproc, hWnd, uMsg, wParam, lParam)
	EndSelect
	ProcedureReturn result
EndProcedure



;SetWindowLong_(GadgetID(DC::#String_002), #GWL_STYLE, GetWindowLong_(GadgetID(DC::#String_002), #GWL_STYLE) | #CBS_SORT)      
;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 

;////////////// Combox Box Neu ////////////////////////////////////////////////////////     
Global oldcombproc, BackBrush
BackBrush = CreateSolidBrush_(RGB(200,200,200))

Procedure ComboCallBackColor( hWnd.l, Message.l, wParam.l, lParam.l )
	
	

	
	If  (Message = 512)
		
		;SendMessage_(hWnd,#BS_VCENTER, 5,#Null)
	
		
	EndIf	
	
	
	If  (Message = #WM_CTLCOLOREDIT) Or (Message = #WM_CTLCOLORLISTBOX)
	
		
		SetBkMode_(wParam,#TRANSPARENT)
		; SetTextColor_(wParam,#Yellow)
		SetBkColor_(wParam,RGB(128,128,128))
		Result = BackBrush
		
	Else
		
		Result = CallWindowProc_(oldcombproc, hWnd, Message, wParam, lParam )
	EndIf
	
	ProcedureReturn Result
	
EndProcedure     
    	;	    
    	;    		    style = GetWindowLong_(GadgetID(DC::#String_002), #GWL_EXSTYLE) 
    	;newstyle = style &(~#WS_EX_CLIENTEDGE) 
    	;SetWindowLong_(GadgetID(DC::#String_002), #GWL_EXSTYLE, newstyle) 
    	;
    	;

Procedure _ReadConfig_History()
	
	Protected HistoryString$
	
	If (FileSize(CFG::*Config\HistoryPath.s) <> -1)
		If ReadFile(DC::#_FileHistory, CFG::*Config\HistoryPath.s)
			x=0
			While Eof(DC::#_FileHistory) = 0 
				HistoryString$ = ReadString(DC::#_FileHistory)
				
				If Len(HistoryString$) <> 0
					x=x+1
					;AddGadgetItem(DC::#String_002,x-1,iHistory$)
					SendMessage_(GadgetID(DC::#String_002),#CB_ADDSTRING,0,HistoryString$)
				EndIf                
			Wend
			CloseFile(DC::#_FileHistory)
		EndIf
	EndIf
EndProcedure
;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 



Procedure _Exit_Win()
	CFG::*Config\DesktopX = WindowX(DC::#_Window_001)
	CFG::*Config\DesktopY = WindowY(DC::#_Window_001)
	CFG::WriteConfig(CFG::*Config): CloseWindow(DC::#_Window_001)
EndProcedure 

;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
;/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Procedure _RecycleFile(file$)
	Protected iError.i, sTemp.s,SHFileOp.SHFILEOPSTRUCT
	
	*ptrFile = AllocateMemory(StringByteLength(file$) + 8)
	PokeS(*ptrFile,file$)  
	
	SHFileOp.SHFILEOPSTRUCT
	SHFileOp\pFrom = *ptrFile
	SHFileOp\pTo = #Null
	SHFileOp\wFunc = #FO_DELETE
	SHFileOp\fFlags = #FOF_ALLOWUNDO | #FOF_NOCONFIRMATION |#FOF_NOERRORUI;  #FOF_SILENT
	
	iError.i = SHFileOperation_(@SHFileOp)
	Debug iError.i
	ProcedureReturn iError.i
EndProcedure


;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
;/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Procedure _FillList_SizeDict()
	Protected ProFileConfig$   
	Protected iDrop7z_Config$
	iDrop7z_Config$ = GetPath_Config(1)    
	ProFileConfig$ = GetPath_Config(2)
	
	
	
	ForEach SizeDict()
		With SizeDict()
			AddGadgetItem(DC::#ComboBox_001,\Num,\sSize)
		EndWith 
	Next
	
	ForEach SizeWord()
		With SizeWord()
			AddGadgetItem(DC::#ComboBox_002,\Num,\sSize)
		EndWith 
	Next
	
	ForEach SizeBlock()
		With SizeBlock()
			AddGadgetItem(DC::#ComboBox_003,\Num,\sSize)
		EndWith 
	Next     
	
	ForEach SizeSplit()
		With SizeSplit()
			AddGadgetItem(DC::#ComboBox_004,\Num,\sSize)
		EndWith 
	Next 
	
	SetGadgetState(DC::#ComboBox_001,12)
	SetGadgetState(DC::#ComboBox_002,7)
	SetGadgetState(DC::#ComboBox_003,12)
	SetGadgetState(DC::#ComboBox_004,0)      
	
	
	ForEach Compression()
		With Compression()
			AddGadgetItem(DC::#ComboBox_005,\Num,\sType)
		EndWith 
	Next 
	SetGadgetState(DC::#ComboBox_005,5) 
	
	
	
	Profile_Current.s = INIValue::Get_S("PROFILES","Default",CFG::*Config\ConfigPath.s)
	If Len(Profile_Current) <> 0   
		
		SetGadgetText(DC::#Text_003,"Profile: "+Profile_Current)
		GadgetToolTip(DC::#Text_003,"Default Saved Profile (Start): "+Profile_Current)        
		If OpenPreferences(ProFileConfig$,#PB_Preference_GroupSeparator)
			If ExaminePreferenceGroups()
				While NextPreferenceGroup()
					If Profile_Current = PreferenceGroupName()
						
						SetGadgetState(DC::#ComboBox_001,ReadPreferenceLong("SizeDict", 12))
						SetGadgetState(DC::#ComboBox_002,ReadPreferenceLong("SizeWord", 7))
						SetGadgetState(DC::#ComboBox_003,ReadPreferenceLong("SizeBlock", 12))
						SetGadgetState(DC::#ComboBox_005,ReadPreferenceLong("Level", 5))
						
						SetUserArcs$ = ReadPreferenceString("SizeArcs","0")
						
						n = FindString(SetUserArcs$,"_State",1)
						If n <> 0
							SetGadgetState(DC::#ComboBox_004,Val(SetUserArcs$))
						Else
							SetGadgetText(DC::#ComboBox_004,SetUserArcs$)
						EndIf
						
						Desktop$ = ReadPreferenceString("Password","")
						If Len(Desktop$) <> 0
							SetGadgetText(DC::#String_003,Desktop$)
						EndIf
					EndIf
				Wend
			EndIf            
		EndIf
	Else
		SetGadgetText(DC::#Text_003,"Profile: Not Set")
		GadgetToolTip(DC::#Text_003,"Default Saved Profile (Start): Not Set")  
		Profile_Current = "Default Profile"
	EndIf
EndProcedure
;/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
;/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Procedure _CB_TrayIcon(hwnd, uMsg, wParam, lParam) 
	Shared TB_Created
	PB_Result = #PB_ProcessPureBasicEvents
	
	Select uMsg
		Case TB_Created
			
			AddSysTrayIcon(0, WindowID(DC::#_Window_001),  ImageID(#_ICO_T01))  
			
		Case  #WM_SIZE
			Select wParam 
				Case #SIZE_MINIMIZED 
					ShowWindow_(WindowID(DC::#_Window_001),#SW_HIDE)
				Case #SIZE_RESTORED 
					ShowWindow_(WindowID(DC::#_Window_001),#SW_SHOW)
				Case #SIZE_MAXIMIZED      
			EndSelect
	EndSelect    
	ProcedureReturn PB_Result
EndProcedure 

Procedure.s FormatFileSize(Size.f)
	Size / 1024
	If Size < 1024 ; KiloByte
		If Size < 100
			size$ = StrD(Size,2) ; '3.21 KB'
		ElseIf Size < 100
			size$ = StrD(Size,1) ; '32.1 KB'
		Else
			size$ = StrD(Size,0) ; '321 KB'
		EndIf
		If Left(StringField(size$,2,"."), 1) = "0" : size$ = StringField(size$,1,".") : EndIf
		ProcedureReturn size$+" KB"
		
	ElseIf Size < 1048576 ; MegaByte
		Size / 1024
		If Size < 10
			size$ = StrD(Size, 2) ; '6.54' MB'
		ElseIf Size < 100
			size$ = StrD(Size, 1) ; '65.4' MB
		Else
			size$ = StrD(Size, 0) ; '654' MB
		EndIf
		If Left(StringField(size$,2,"."), 1) = "0" : size$ = StringField(size$,1,".") : EndIf
		ProcedureReturn size$+" MB"
		
	Else ; GigaByte
		Size / 1048576
		If Size < 10
			size$ = StrD(Size, 2) ; '1.23 GB'
		ElseIf Size < 100
			size$ = StrD(Size, 1) ; '12.3 GB'
		Else
			size$ = StrD(Size, 0) ; '123 GB'
		EndIf
		If Left(StringField(size$,2,"."), 1) = "0" : size$ = StringField(size$,1,".") : EndIf
		ProcedureReturn size$+" GB"
	EndIf
EndProcedure

;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 

Procedure.q GetDirectorySize(Path.s, rekursiv = #True)
	
	Protected dir.l, Size.q, entry.s
	
	If Not Right(Path, 1) = "\"
		Path+"\"
	EndIf
	dir = ExamineDirectory(#PB_Any, Path, "")
	If dir
		While NextDirectoryEntry(dir)
			entry = DirectoryEntryName(dir)
			If entry = "." Or entry = ".."
				Continue
			ElseIf DirectoryEntryType(dir) = #PB_DirectoryEntry_File
				Size + DirectoryEntrySize(dir)
			ElseIf rekursiv
				Size + GetDirectorySize(Path+entry+"\", rekursiv)
			EndIf
		Wend
		FinishDirectory(dir)    
	EndIf
	ProcedureReturn Size
EndProcedure

;/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
;/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Procedure _Clear_FileList()
	
	Protected GaItemWidth1.i = 100 ; Directory
	Protected GaItemWidth2.i = 119 ; Files
	Protected GaItemWidth3.i = 56	 ; Size  
	
	ClearGadgetItems(DC::#ListIcon_001)
	SendMessage_(GadgetID(DC::#ListIcon_001), #LVM_SETCOLUMNWIDTH,0,GaItemWidth1.i)
	SendMessage_(GadgetID(DC::#ListIcon_001), #LVM_SETCOLUMNWIDTH,1,GaItemWidth2.i)
	SendMessage_(GadgetID(DC::#ListIcon_001), #LVM_SETCOLUMNWIDTH,2,GaItemWidth3.i)
	
	SetGadgetText(DC::#String_001, DropLang::GetUIText(17) )    
	
	SetGadgetText(DC::#String_002,"") 
	SetGadgetText(DC::#Text_002,"")
	
	SetGadgetState(DC::#Progress_001, 0)  
	
	GadgetToolTip(DC::#String_001,"")
	GadgetToolTip(DC::#String_002,"")
	GadgetToolTip(DC::#String_001,"")
	
	
EndProcedure  

;/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
;/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Procedure Calculate_Size()
	
	Protected iFullSize.f, szMessage.s
	
	
	SetGadgetText(DC::#Text_002, DropLang::GetUIText(12) ) 
	
	iFullSize.f = 0
	
	iMax  = CountGadgetItems(DC::#ListIcon_001)
	If iMax <> 0 
		
		SetGadgetText(DC::#Text_002, DropLang::GetUIText(18) )
		
		For i = 0 To iMax-1
			
			File$ = GetGadgetItemText(DC::#ListIcon_001,i,1) ;Files
			Path$ = GetGadgetItemText(DC::#ListIcon_001,i,0) ;Folders
			
			FileSize = FileSize(Path$+File$)
			If FileSize = -2
				iFullSize = iFullSize + GetDirectorySize(Path$+File$)
			Else
				If FileSize <> -2 And FileSize <> 0
					iFullSize = iFullSize + FileSize(Path$+File$)
				EndIf
			EndIf
		Next
		
		szMessage = DropLang::GetUIText(12)
		szMessage + RSet( FormatFileSize(iFullSize), 10, Chr(32) )
		szMessage + "    " +DropLang::GetUIText(19)
		szMessage + RSet( Str(iMax), 8, "0" )
		
		;SetGadgetText(DC::#Text_002, WhatEver$ + szMessage)
		
		SetGadgetText(DC::#Text_002, WhatEver$ + szMessage)
		ProcedureReturn
	EndIf
EndProcedure

;/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
;/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Procedure _Clear_FileList_Single() 
	RemoveGadgetItem(DC::#ListIcon_001, GetGadgetState(DC::#ListIcon_001))
	iMax  = CountGadgetItems(DC::#ListIcon_001)
	If iMax = 0
		_Clear_FileList()
	EndIf
	If iMax <> 0
		Calculate_Size()
	EndIf
EndProcedure  

;/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
;/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Procedure _Clear_FileList_Marked() 
	iMax  = CountGadgetItems(DC::#ListIcon_001)
	For x = 0 To iMax
		iMarkState = GetGadgetItemState(DC::#ListIcon_001, x)
		If  iMarkState = 2 Or iMarkState = 3
			RemoveGadgetItem(DC::#ListIcon_001,x)
		EndIf
	Next 
	
	If iMax = 0
		_Clear_FileList()
		ProcedureReturn
	EndIf
	If iMax <> 0
		Calculate_Size()
	EndIf
	
EndProcedure  

;/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
;/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Procedure _Clear_FileList_NonMarked() 
	iMax  = CountGadgetItems(DC::#ListIcon_001)
	For x = 0 To iMax
		iMarkState = GetGadgetItemState(DC::#ListIcon_001, x)
		If  iMarkState = 0 Or iMarkState = 1
			RemoveGadgetItem(DC::#ListIcon_001,x)
		EndIf
	Next 
	
	If iMax = 0
		_Clear_FileList()
		ProcedureReturn
	EndIf
	If iMax <> 0
		Calculate_Size()
	EndIf
	
EndProcedure  

;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
;/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Procedure _SetCompression_Mode(_CpmGadgetID1,_CpmGadgetID2,_CpmGadgetID3,_CpmGadgetID4)
	
	CMode = GetGadgetState(_CpmGadgetID1)
	If CMode = 0 
		SetGadgetState(_CpmGadgetID2,21) ; Store
		SetGadgetState(_CpmGadgetID3,12)        
		SetGadgetState(_CpmGadgetID4,10)            
	EndIf
	
	If CMode = 1 
		SetGadgetState(_CpmGadgetID2,0) ; Fast
		SetGadgetState(_CpmGadgetID3,3)        
		SetGadgetState(_CpmGadgetID4,7)          
	EndIf   
	If CMode = 2 
		SetGadgetState(_CpmGadgetID2,1) ; Fast
		SetGadgetState(_CpmGadgetID3,4)        
		SetGadgetState(_CpmGadgetID4,7)          
	EndIf
	If CMode = 3 
		SetGadgetState(_CpmGadgetID2,8) ; Normal
		SetGadgetState(_CpmGadgetID3,4)        
		SetGadgetState(_CpmGadgetID4,12)          
	EndIf 
	If CMode = 4 
		SetGadgetState(_CpmGadgetID2,10) ; Max
		SetGadgetState(_CpmGadgetID3,6)        
		SetGadgetState(_CpmGadgetID4,13)        
	EndIf
	If CMode = 5
		SetGadgetState(_CpmGadgetID2,12) ; Ultra
		SetGadgetState(_CpmGadgetID3,6)        
		SetGadgetState(_CpmGadgetID4,13)           
	EndIf       
EndProcedure  
;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
;/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Procedure _SetButtonState()
	
	;     Select CFG::*Config\usFormat
	;         Case 0: PackFormat$ = "7z" : addSzLen = 0
	;         Case 1: PackFormat$ = "zip": addSzLen = 1
	;         Case 2: PackFormat$ = "chd": addSzLen = 1       	
	;     EndSelect 
	
	PackFormat$ = DropCode::GetArchivFormat()
	;
	; Länge des Suffix dazu berechnen
	Select Len(PackFormat$)
		Case 2: addSzLen = 0
		Case 1: addSzLen = 1
	EndSelect		
	
	If ( UCase(PackFormat$) = "CHD")
		SetGadgetState(DC::#CheckBox_005,0)
	EndIf
	
	If GetGadgetState(DC::#CheckBox_005) = 1
		Tmp$ = GetGadgetText(DC::#String_001)
		Str$ = LCase(Tmp$)
		iLng = Len(Str$)
		
		iSuffix$ = GetExtensionPart(Str$)
		
		If LCase(iSuffix$) = "exe" And FindString(Str$,".exe",iLng-4) <> 0
			ProcedureReturn
		EndIf        
		
		If LCase(iSuffix$) = "001" And FindString(Str$,".001",iLng-4) <> 0 
			Tmp$ = Left(Tmp$,iLng- (7+addSzLen) )
			Tmp$ = Tmp$+".exe"
		EndIf        
		
		
		If LCase(iSuffix$) = PackFormat$ And FindString(Str$,"."+PackFormat$,iLng-3) <> 0 
			Tmp$ = Left(Tmp$,iLng- (3+addSzLen) )
			Tmp$ = Tmp$+".exe"
		EndIf
		SetGadgetText(DC::#String_001,Tmp$): GadgetToolTip(DC::#String_001,GetGadgetText(DC::#String_001))
		ProcedureReturn
	EndIf
	
	
	nSizeSplit  = GetGadgetState(DC::#ComboBox_004)
	If nSizeSplit <> -1
		SelectElement(SizeSplit(),nSizeSplit)
		
		Tmp$ = GetGadgetText(DC::#String_001)
		Str$ = LCase(Tmp$)
		iLng = Len(Str$)
		
		If nSizeSplit = 0 Or nSizeSplit = 1 Or nSizeSplit = 10
			ButtonEX::Disable(DC::#Button_006,0)
			
			
			iSuffix$ = GetExtensionPart(Str$)
			
			If LCase(iSuffix$) = PackFormat$ And FindString(Str$,"."+PackFormat$,iLng-3) <> 0
				ProcedureReturn
			EndIf
			
			If LCase(iSuffix$) = "exe" And FindString(Str$,".exe",iLng-4) <> 0 
				Tmp$ = Left(Tmp$,iLng-4)
				Tmp$ = Tmp$+"."+PackFormat$
				SetGadgetText(DC::#String_001,Tmp$): GadgetToolTip(DC::#String_001,GetGadgetText(DC::#String_001)):ProcedureReturn
			EndIf
			
			If LCase(iSuffix$) = "001" And FindString(Str$,".001",iLng-4) <> 0 
				Tmp$ = Left(Tmp$,iLng- (7+addSzLen) )
				Tmp$ = Tmp$+"."+PackFormat$
			EndIf
			
			If LCase(iSuffix$) <> "001" And FindString(Str$,".001",iLng-4) = 0 
				Tmp$ = Tmp$+"."+PackFormat$
			EndIf  
		Else
			
			ButtonEX::Disable(DC::#Button_006,1)
			
			iSuffix$ = GetExtensionPart(Str$)
			If LCase(iSuffix$) = "001" And FindString(Str$,".001",iLng-4) <> 0
				ProcedureReturn
			EndIf
			
			If LCase(iSuffix$) = "exe" And FindString(Str$,".exe",iLng-4) <> 0 
				Tmp$ = Left(Tmp$,iLng-4)
				Tmp$ = Tmp$+"."+PackFormat$
				SetGadgetText(DC::#String_001,Tmp$): GadgetToolTip(DC::#String_001,GetGadgetText(DC::#String_001)):ProcedureReturn
			EndIf
			
			If LCase(iSuffix$) = PackFormat$ And FindString(Str$,"."+PackFormat$,iLng-3) <> 0 
				Tmp$ = Left(Tmp$,iLng-(3+addSzLen) )
				Tmp$ = Tmp$+"."+PackFormat$+".001"
			EndIf
			
			
			If LCase(iSuffix$) <> PackFormat$ And FindString(Str$,"."+PackFormat$,iLng-3) = 0 
				Tmp$ = Tmp$+"."+PackFormat$+".001"
			EndIf
			
		EndIf
	ElseIf nSizeSplit = -1
		
		ButtonEX::Disable(DC::#Button_006,1)    
		Tmp$ = GetGadgetText(DC::#String_001)
		Str$ = LCase(Tmp$)
		iLng = Len(Str$)
		UserSizeL.l = Val(GetGadgetText(DC::#ComboBox_004))
		If  UserSizeL <> 0
			
			iSuffix$ = GetExtensionPart(Str$)
			If LCase(iSuffix$) = PackFormat$ And FindString(Str$,"."+PackFormat$,iLng-3) <> 0 
				Tmp$ = Left(Tmp$,iLng-3)
				Tmp$ = Tmp$+"."+PackFormat$+".001"
			EndIf
			
			If LCase(iSuffix$) <> PackFormat$ And FindString(Str$,"."+PackFormat$,iLng-3) = 0 
				Tmp$ = Tmp$+"."+PackFormat$+".001"
				SetGadgetText(DC::#String_001,Tmp$): GadgetToolTip(DC::#String_001,GetGadgetText(DC::#String_001)):ProcedureReturn
			EndIf
			
			If LCase(iSuffix$) = "exe" And FindString(Str$,".exe",iLng-4) <> 0 
				Tmp$ = Left(Tmp$,iLng-4)
				Tmp$ = Tmp$+"."+PackFormat$+".001"
			EndIf
			
		EndIf
	EndIf          
	
	SetGadgetText(DC::#String_001,Tmp$): GadgetToolTip(DC::#String_001,GetGadgetText(DC::#String_001))
	
	
EndProcedure

;/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
;/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Procedure.s _SetDestination_String(iArchiv_DestPath$)
	
	iArchiv_DestPath$ = ReverseString(iArchiv_DestPath$)
	
	iFind = FindString(iArchiv_DestPath$,"\",3)
	If iFind <> -1
		
		iStr$ = Mid(iArchiv_DestPath$,1,iFind)
		iStr$ = ReplaceString(iStr$,"\","")                     
		iStr$ = ReverseString(iStr$)         
	EndIf               
	iFind = FindString(iArchiv_DestPath$,"\",2)
	If iFind <> -1
		iKill$ = Mid(iArchiv_DestPath$,1,iFind) 
		iKill$ = ReverseString(iKill$)  
		iKill$ = ReplaceString(iKill$,"\","")
	EndIf
	
	iArchiv_DestPath$ = ReverseString(iArchiv_DestPath$)
	ProcedureReturn iKill$
EndProcedure            

;/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
;/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Procedure _Disable_Enable_Gadets(n)
	
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
			HideGadget(DC::#String_005,1) :Debug "HideGadget(DC::#String_001,0)"                                                           						
			SetGadgetText(DC::#String_005,"") :Debug "HideGadget(DC::#String_001,0)"  
			
		Case 1  
	EndSelect
	
	Select CFG::*Config\usFormat
		Case 0: DropCode::SetUIElements7ZP(n)
		Case 1: DropCode::SetUIElementsZIP(1)
		Case 2: DropCode::SetUIElementsCHD(1)
	EndSelect    
	
	If ( CFG::*Config\PinDirectory = #True )		
		DisableGadget(DC::#String_002,1)
		ButtonEX::Disable(DC::#Button_004,1)   
	EndIf	
EndProcedure

;/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
;/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Procedure _SetAction_Drop_SubRoutine1(iStr$,iArchiv_DestPath$)
	SetGadgetText(DC::#String_001,iStr$)
	
	If Len(iArchiv_DestPath$) <> 0
		SetGadgetText(DC::#String_002,iArchiv_DestPath$)
		
	EndIf
	_SetButtonState()
	GadgetToolTip(DC::#String_002,GetGadgetText(DC::#String_002))
	GadgetToolTip(DC::#String_001,GetGadgetText(DC::#String_001))
	ComboAutoText()
EndProcedure

;/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
;/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

;
;
;
Import "Kernel32.lib"
	GetLongPathNameW(cShort.p-Unicode, *cLong, nBuffLen.l)
	GetShortPathNameW(cLong.p-Unicode, *cShort, nBuffLen.l)        
EndImport
;
;    
;
Procedure.s GetLongFromShort(cShort.s)
	Protected cLong.s, length.l
	
	length = GetLongPathNameW(cShort, @cLong, 0)
	If length
		cLong = Space(length)
		If GetLongPathNameW(cShort, @cLong, length * SizeOf(Character))
			ProcedureReturn PeekS(@cLong, -1, #PB_Unicode)
		EndIf    
	EndIf
EndProcedure
;
;    
;
Procedure.s GetShortFromLong(cLong.s)
	Protected cShort.s, length.l
	
	length = GetLongPathNameW(cLong, @cShort, 0)
	If length
		cShort = Space(length)
		If GetShortPathNameW(cLong, @cShort, length * SizeOf(Character))
			ProcedureReturn PeekS(@cShort, -1, #PB_Unicode)
		EndIf    
	EndIf
EndProcedure    
;
;
;
Procedure.s  _SetAction_Drop()
	
	szDropFile.s
	
	Protected GaItemWidth1.i = 10 ; Directory
	Protected GaItemWidth2.i = 209; Files
	Protected GaItemWidth3.i = 56	; Size  
	Protected GaItemWidthY.i = GaItemWidth1+GaItemWidth2+GaItemWidth3
	
	Protected State_ClearFileList$,iMax.i, iMaxCount.i,iElement.i,iStr$,iStO$,Path$,File$,ListName$,iPos.i,iLength.i,FileSize.q
	Protected DirectoryOnly.i
	Protected iDrop7z_Config$
	iDrop7z_Config$ = GetPath_Config(1)    
	
	SetGadgetState(DC::#Progress_001, 0)
	
	
	State_ClearFileList$ = INIValue::Get_S("SETTINGS","AutoClearLt",iDrop7z_Config$)
	If LCase(State_ClearFileList$) = "true"
		ClearGadgetItems(DC::#ListIcon_001)
	EndIf
	
	szDropFile = EventDropFiles()
	;szDropFile = GetLongFromShort( szDropFile )
	;szDropFile = GetShortFromLong( szDropFile )    
	Debug "Dropped Datei         :" + szDropFile
	Debug "Länge der Datei + Path:" + Len(szDropFile)
	Debug "Short (8.3)   :" + GetLongFromShort(szDropFile)
	Debug "Long Filename :" + GetShortFromLong(szDropFile)	    
	
	iMax  = CountString(szDropFile, Chr(10)) + 1
	
	
	iMaxCount  = CountGadgetItems(DC::#ListIcon_001)
	If iMaxCount <> 0 And LCase(State_ClearFileList$) <> "true"
		
		iElement = 1
		
		For x = 1 To iMax
			Path$ = GetPathPart(StringField(szDropFile, x, Chr(10)))  
			File$ = GetFilePart(StringField(szDropFile, x, Chr(10)))
			
			
			For i = 0 To iMaxCount-1
				iStr$ = GetGadgetItemText(DC::#ListIcon_001,i,1) ;Files      
				iStO$ = GetGadgetItemText(DC::#ListIcon_001,i,0) ;Folders                 
				
				ListName$ = iStO$+iStr$
				ListName$ = ReverseString(ListName$)
				iPos = FindString(ListName$,"\",1)
				If iPos = 1
					iLength   = Len(ListName$)
					ListName$ = Mid(ListName$,2,iLength-1)
					
				EndIf
				ListName$ = ReverseString(ListName$)
				
				If LCase(Path$+File$) = LCase(ListName$)
					Path$ = "": File$ = "" : iElement = 0
					
				EndIf                         
				
			Next i
			
			If iElement = 1
				FileSize = FileSize(Path$+File$)
				If FileSize = -2 
					If (LHGAME_LANGUAGE = 407): SetGadgetText(DC::#Text_002,"Größe: ...Berechne"): EndIf      
					If (LHGAME_LANGUAGE = 409): SetGadgetText(DC::#Text_002,"Size: ...Calculate"): EndIf  
					AddGadgetItem(DC::#ListIcon_001, -1,Path$+File$ +"\" + Chr(10) + ""+ Chr(10) + FormatFileSize(GetDirectorySize(Path$+File$)))
				ElseIf FileSize <> -2 And FileSize <> 0
					If (LHGAME_LANGUAGE = 407): SetGadgetText(DC::#Text_002,"Größe: ...Berechne"): EndIf      
					If (LHGAME_LANGUAGE = 409): SetGadgetText(DC::#Text_002,"Size: ...Calculate"): EndIf  
					AddGadgetItem(DC::#ListIcon_001, -1,Path$ + Chr(10) +File$+ Chr(10) + FormatFileSize(FileSize(Path$+File$)))
				EndIf                     
			EndIf                      
		Next x
	Else
		For i = 1 To iMax
			
			Path$ = GetPathPart(StringField(szDropFile, i, Chr(10)))  
			File$ = GetFilePart(StringField(szDropFile, i, Chr(10)))
			
			FileSize = FileSize(Path$+File$)
			
			If FileSize = -2
				If (LHGAME_LANGUAGE = 407): SetGadgetText(DC::#Text_002,"Größe: ...Berechne"): EndIf      
				If (LHGAME_LANGUAGE = 409): SetGadgetText(DC::#Text_002,"Size: ...Calculate"): EndIf  
				AddGadgetItem(DC::#ListIcon_001, -1,Path$+File$ +"\" + Chr(10) + ""+ Chr(10) + FormatFileSize(GetDirectorySize(Path$+File$)))
			ElseIf FileSize <> -2 And FileSize <> 0
				If (LHGAME_LANGUAGE = 407): SetGadgetText(DC::#Text_002,"Größe: ...Berechne"): EndIf      
				If (LHGAME_LANGUAGE = 409): SetGadgetText(DC::#Text_002,"Size: ...Calculate"): EndIf  
				AddGadgetItem(DC::#ListIcon_001, -1,Path$ + Chr(10) +File$+ Chr(10) + FormatFileSize(FileSize(Path$+File$)))
			EndIf
		Next i          
	EndIf
	
	
	
	
	Calculate_Size()
	
	iMax  = CountGadgetItems(DC::#ListIcon_001)
	If iMax <> 0 
		
		SetGadgetItemAttribute(DC::#ListIcon_001,0,#PB_ListIcon_ColumnWidth,56,2) 
		
		State_ClearFileList$ = INIValue::Get_S("SETTINGS","AutoClearLt",iDrop7z_Config$)
		If LCase(State_ClearFileList$) = "true"
			
			For i = 0 To iMax-1
				iStr$ = GetGadgetItemText(DC::#ListIcon_001,i,1) ;Files
				iLen  = Len(iStr$)
				
				iStO$ = GetGadgetItemText(DC::#ListIcon_001,i,0) ;Folders
				iLeO  = Len(iStO$)
				
				If iLen = 0 And iLeO <> 0
					DirectoryOnly = 1
				EndIf
				If iLen <> 0 And iLeO = 0
					DirectoryOnly = 0
				EndIf
				If iLen <> 0 And iLeO <> 0
					DirectoryOnly = 2
				EndIf
				
				SendMessage_(GadgetID(DC::#ListIcon_001), #LVM_SETCOLUMNWIDTH,0,#LVSCW_AUTOSIZE)
				SendMessage_(GadgetID(DC::#ListIcon_001), #LVM_SETCOLUMNWIDTH,1,#LVSCW_AUTOSIZE)
			Next i
		Else  
			DirectoryOnly = 3
		EndIf      
		
		;SendMessage_(GadgetID(DC::#ListIcon_001), #LVM_SETCOLUMNWIDTH,0,#LVSCW_AUTOSIZE)
		;SendMessage_(GadgetID(DC::#ListIcon_001), #LVM_SETCOLUMNWIDTH,1,#LVSCW_AUTOSIZE)
		
		;   iWidth1 =  GetGadgetItemAttribute(DC::#ListIcon_001,0,#PB_ListIcon_ColumnWidth,0)
		;   iWidth2 =  GetGadgetItemAttribute(DC::#ListIcon_001,0,#PB_ListIcon_ColumnWidth,1)
		;   iWidth3 =  GetGadgetItemAttribute(DC::#ListIcon_001,0,#PB_ListIcon_ColumnWidth,2)
		;   iWidthY = iWidth1+iWidth2+iWidth3
		;   
		;   If  iWidth2 <= GaItemWidth2 Or iWidth1 <= GaItemWidth1
		;       ;Debug "Original:"+ GaItemWidth2 : Debug "Current :"+ iWidth2: 
		;       iWidthY =  GaItemWidthY-iWidthY
		;       ;Debug "Benötigt File:"+ iWidthY 
		;       SendMessage_(GadgetID(DC::#ListIcon_001), #LVM_SETCOLUMNWIDTH,1,iWidth2+iWidthY)
		
		
		;      EndIf
		
		
		;/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		If DirectoryOnly = 2 And iMax = 1                                     ;Prüfe und Hole aus der 1 Spalte den Dateianmen
			iArchiv_DestPath$ = GetGadgetItemText(DC::#ListIcon_001,0,0)       
			
			iExtension$    = GetExtensionPart(iStr$)
			
			;         Select CFG::*Config\usFormat
			;             Case 0: iStr$= ReplaceString(iStr$,iExtension$,"7z")
			;             Case 1: iStr$= ReplaceString(iStr$,iExtension$,"zip")
			;         EndSelect 
			
			iStr$ = ReplaceString(iStr$,iExtension$, DropCode::GetArchivFormat())
			
			
			SetGadgetText(DC::#String_001,iStr$)
			SetGadgetText(DC::#String_002,iArchiv_DestPath$)
			
			GadgetToolTip(DC::#String_001,iStr$)
			GadgetToolTip(DC::#String_002,iArchiv_DestPath$)
			
			
			SetActiveWindow(DC::#_Window_001)
			SetActiveGadget(DC::#String_001)
			SetForegroundWindow_(WindowID(DC::#_Window_001))
			;
			; Setze den Cursor an das Ende
			SendMessage_(GadgetID(DC::#String_001),#EM_SETSEL,Len(GetGadgetText(DC::#String_001)) ,Len(GetGadgetText(DC::#String_001)))
			
			_SetButtonState()
			ComboAutoText()
			
			If  ( CFG::*Config\PinDirectory = 1 )
				DropCode::Consolidate_Directory(2)
			EndIf    
			
			ProcedureReturn 
		EndIf
		
		;/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		If DirectoryOnly = 1 And iMax = 1                                    ;Prüfe und Hole aus der 1 Spalte den Verzeichnis Namen
			
			iArchiv_DestPath$ = GetGadgetItemText(DC::#ListIcon_001,0,0)            
			iKill$ = _SetDestination_String(iArchiv_DestPath$)
			
			LngDestStr= Len(iArchiv_DestPath$)
			LngKillStr = Len(iKill$+"\")
			iArchiv_DestPath$ = Left(iArchiv_DestPath$,LngDestStr-LngKillStr)
			
			;iArchiv_DestPath$ = ReplaceString(iArchiv_DestPath$,iKill$+"\","")
			
			;iStr$ = iKill$+".7z"
			
			_SetAction_Drop_SubRoutine1(iKill$,iArchiv_DestPath$)
			
			ProcedureReturn 
		EndIf
		
		
		;/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		If DirectoryOnly = 2 And  iMax >=2 ;Prüfe und Hole - Verzeichnisse und Dateien
			
			iArchiv_DestPath$ = GetGadgetItemText(DC::#ListIcon_001,0,0)  
			iKill$ = _SetDestination_String(iArchiv_DestPath$)
			
			
			
			If Len(GetGadgetItemText(DC::#ListIcon_001,0,1)) = 0
				LngDestStr= Len(iArchiv_DestPath$)
				LngKillStr = Len(iKill$+"\")
				iArchiv_DestPath$ = Left(iArchiv_DestPath$,LngDestStr-LngKillStr)       
				iKill$ = _SetDestination_String(iArchiv_DestPath$)
			EndIf
			
			If Len(iKill$) = 0
				iKill$ = "Root-Packed-"+Left(iArchiv_DestPath$,1)
			EndIf
			;iStr$ = iKill$+".7z"
			
			_SetAction_Drop_SubRoutine1(iKill$,iArchiv_DestPath$)
			
			ProcedureReturn 
		EndIf
		
		;/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		If DirectoryOnly = 1 And  iMax >=2 ;Prüfe und Hole - Nur Verzeichne
			
			iArchiv_DestPath$ = GetGadgetItemText(DC::#ListIcon_001,0,0)  
			iKill$ = _SetDestination_String(iArchiv_DestPath$)
			
			LngDestStr= Len(iArchiv_DestPath$)
			LngKillStr = Len(iKill$+"\")
			iArchiv_DestPath$ = Left(iArchiv_DestPath$,LngDestStr-LngKillStr)
			
			iKill$ = _SetDestination_String(iArchiv_DestPath$)
			
			If Len(iKill$) = 0
				iKill$ = "Root-Packed-"+Left(iArchiv_DestPath$,1)
			EndIf
			
			;iStr$ = iKill$+".7z"
			
			_SetAction_Drop_SubRoutine1(iKill$,iArchiv_DestPath$)        
			ProcedureReturn 
		EndIf 
		
		;/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		If DirectoryOnly = 3
			
			iStr$ = GetGadgetItemText(DC::#ListIcon_001,0,1): iLen  = Len(iStr$) ;       
			iStO$ = GetGadgetItemText(DC::#ListIcon_001,0,0): iLeO  = Len(iStO$) ;Folders
			
			If iMax = 1 And iLeO <> 0 And iLen <> 0                                  ;Prüfe und Hole aus der 1 Spalte den Dateianmen
				iArchiv_DestPath$ = GetGadgetItemText(DC::#ListIcon_001,0,0)       
				
				iExtension$    = GetExtensionPart(iStr$)
				;             Select CFG::*Config\usFormat
				;                 Case 0: iStr$= ReplaceString(iStr$,iExtension$,"7z")
				;                 Case 1: iStr$= ReplaceString(iStr$,iExtension$,"zip")
				;             EndSelect             
				;iStr$          = ReplaceString(iStr$,iExtension$,"7z")
				
				iStr$= ReplaceString(iStr$,iExtension$, DropCode::GetArchivFormat()) 
				
				_SetAction_Drop_SubRoutine1(iStr$,iArchiv_DestPath$) 
				ProcedureReturn            
			EndIf
			
			If iMax = 1 And iLeO <> 0 And iLen = 0     
				iArchiv_DestPath$ = GetGadgetItemText(DC::#ListIcon_001,0,0)            
				iKill$ = _SetDestination_String(iArchiv_DestPath$)
				
				LngDestStr= Len(iArchiv_DestPath$)
				LngKillStr = Len(iKill$+"\")
				iArchiv_DestPath$ = Left(iArchiv_DestPath$,LngDestStr-LngKillStr)
				
				_SetAction_Drop_SubRoutine1(iKill$,iArchiv_DestPath$) 
				ProcedureReturn        
			EndIf
			
			If iMax >=2
				iArchiv_DestPath$ = GetGadgetItemText(DC::#ListIcon_001,0,0)            
				iKill$ = _SetDestination_String(iArchiv_DestPath$)
				
				LngDestStr= Len(iArchiv_DestPath$)
				LngKillStr = Len(iKill$+"\")
				iArchiv_DestPath$ = Left(iArchiv_DestPath$,LngDestStr-LngKillStr)
				
				If Len(iKill$) = 0
					iKill$ = "Root-"+Left(iArchiv_DestPath$,1)
				EndIf        
				
				
				iArchiv_DestPath$ = ReplaceString(iArchiv_DestPath$,iKill$+"\","")
				
				
				iTime$ = FormatDate("%yyyy-%mm-%dd -- %hh;%ii;%ss", Date()) 
				If (LHGAME_LANGUAGE = 407): iStr$ = "Verschiedene "+iTime$ :EndIf      
				If (LHGAME_LANGUAGE = 409): iStr$ = "Various "+iTime$      :EndIf 
				
				If  Len(GetGadgetText(DC::#String_002)) = 0
					iArchiv_DestPath$ = GetGadgetItemText(DC::#ListIcon_001,0,0) 
				Else
					iArchiv_DestPath$ = ""
				EndIf
				
				_SetAction_Drop_SubRoutine1(iStr$,iArchiv_DestPath$) 
				ProcedureReturn 
			EndIf
			
		EndIf  
	EndIf
	
EndProcedure 

;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 

Procedure.s REG_GetSzValue(hKey.l, Path$,  lpValueName$, ulOptions = 0, samDesired.l  = #KEY_ALL_ACCESS)
	Protected Size
	Protected Result
	Protected Key
	Protected lpResultName$
	
	Size  =   #MAX_PATH
	Name$ =   Space(Size)
	
	Result=   RegOpenKeyEx_(hKey,Path,0,samDesired,@Key)
	If ( Result = 0 )
		RegQueryValueEx_(Key,@lpValueName,0,0,@lpResultName,@Size)
		RegCloseKey_(Key)
		ProcedureReturn Name$
	EndIf
	
	ProcedureReturn Str(Result)
	
EndProcedure

;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
; Procedure.s _Get7z_Locations()
;     
;     Protected iDrop7z_Config$, iExecute$, iTry.i, Handle.l
;     iDrop7z_Config$ = GetPath_Config(1)    
;     iExecute$ = INIValue::Get_S("SETTINGS","Portable",iDrop7z_Config$)
;     
;     If Len(iExecute$) <> 0
;         iExecute$ =  iExecute$
;         iTry = FileSize(iExecute$)
;         If (iTry) <> -1
;            iExecute$ = Chr(34)+iExecute$+Chr(34)
;             ProcedureReturn iExecute$
;         EndIf
;     EndIf
; 
;     
;     
;     iTry = FileSize(GetCurrentDirectory()+"7zG.exe")
;      If (iTry) <> -1
;         iExecute$ = Chr(34)+GetCurrentDirectory()+"7zG.exe"+Chr(34)
;         ProcedureReturn iExecute$
;     Else
;         
;         ; 32Bit
;         iTry = FileSize("C:\Program Files (x86)\7-Zip\7zG.exe")
;         If (iTry) <> -1
;             iExecute$ = Chr(34)+"C:\Program Files (x86)\7-Zip\7zG.exe"+Chr(34)
;             ProcedureReturn iExecute$
;         Else
;             
;             iExecute$ = REG_GetSzValue(#HKEY_LOCAL_MACHINE, "SOFTWARE\7-Zip","Path")
;             iExecute$ = iExecute$+"7zG.exe"
;     
;             iTry = FileSize(iExecute$)
;         
;             If (iTry) <> -1
;                 iExecute$ = Chr(34)+iExecute$+Chr(34)            
;                 ProcedureReturn iExecute$
;             Else     
;                 
;                 ; 64Bit
;                 iTry = FileSize("c:\Program Files\7-Zip\7zG.exe")
;                 If (iTry) <> -1
;                     iExecute$ = Chr(34)+"c:\Program Files\7-Zip\7zG.exe"+Chr(34)
;                     ProcedureReturn iExecute$
;                 Else
;                     
;                     iExecute$ = REG_GetSzValue(#HKEY_LOCAL_MACHINE, "SOFTWARE\7-Zip","Path64")
;                     iExecute$ = iExecute$+"7zG.exe"
;     
;                     iTry = FileSize(iExecute$)
;         
;                     If (iTry) <> -1
;                         iExecute$ = Chr(34)+iExecute$+Chr(34)            
;                         ProcedureReturn iExecute$
;                     EndIf
;                 EndIf
;             EndIf
;         EndIf
;     EndIf
; 
;     
; 
;     Request0$ = "Now Look What You've Done" 
;     Request1$ = "[= Exit Program =]"        
;     Select Windows::Get_Language() 
;         Case 407              
;             Request2$ = "7z wurde nicht gefunden:"+#CR$+
;                         "1. Drop 7z Config: "+INIValue::Get_S("SETTINGS","Portable",iDrop7z_Config$)+" /Ini)"+#CR$+
;                         "2. Unter HKEY_LOCAL_MACHINE\SOFTWARE\7-Zip"+#CR$+
;                         "3. "+Chr(34)+"C:\Programme (x86)\7-Zip\7zG.exe"+Chr(34)+#CR$+
;                         "4. "+Chr(34)+"c:\Programme\7-Zip\7zG.exe"+Chr(34)+ "Nur 64bit"            
;         Default
;             Request2$ = "No 7z Found:"+#CR$+
;                         "1. Drop 7z Config: "+INIValue::Get_S("SETTINGS","Portable",iDrop7z_Config$)+" /Ini)"+#CR$+
;                         "2. at HKEY_LOCAL_MACHINE\SOFTWARE\7-Zip"+#CR$+
;                         "3. in "+Chr(34)+"C:\Programme (x86)\7-Zip\7zG.exe"+Chr(34)+#CR$+
;                         "4. in "+Chr(34)+"c:\Programme\7-Zip\7zG.exe"+Chr(34)+ "Nur 64bit" 
;         EndSelect
;     
;         Request::MSG(Request0$, Request1$  ,Request2$,6,2,ProgramFilename(),0,0,DC::#_Window_001)
;     End
; EndProcedure


;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
Procedure _Actio_DeleteFiles_Loop(ForFilePath$)
	Protected iMax.i ,iError.i, iPathLength,iErrorResult.i
	iMax  = CountGadgetItems(DC::#ListIcon_001)
	If iMax <> 0
		For i = 0 To iMax-1
			iStr$ = GetGadgetItemText(DC::#ListIcon_001,i,1) ;Files      
			iStO$ = GetGadgetItemText(DC::#ListIcon_001,i,0) ;Folders 
			
			;Debug "Listing: "+iStO$+iStr$: Debug "Delete : "+ForFilePath
			
			If (iStO$+iStr$ = ForFilePath$) And (Len(iStO$+iStr$) <> 0) And (Len(ForFilePath$) <> 0)
				If FileSize(iStO$+iStr$) <> 0
					iError.i = _RecycleFile(iStO$+iStr$);Debug "Delete To Recycle Bin: "+ForFilePath$
					
					Delay(1)
					If Not iError.i = 0
						iError.i = _Delete_ErrorCode(iStO$+iStr$,iError.i)
						If iError.i = 0: RemoveGadgetItem(DC::#ListIcon_001,ListItem.i): EndIf
						ProcedureReturn iError.i                                         
					EndIf
					RemoveGadgetItem(DC::#ListIcon_001,i)
					ProcedureReturn 0
				EndIf
				
			EndIf
		Next
	EndIf
	ProcedureReturn 0
EndProcedure              
;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
;/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////       

;      Procedure Create_SHA1_File(iFullPath$,iSizeSplit$) 
;          Protected  State$, FileList$, SHAFILE$, SHASUME$, iResult, Name$, ExSH$, f.WIN32_FIND_DATA, StringGadgetFile$, PartNum, PartExt$
;               
;          
;          iDrop7z_Config$ = GetPath_Config(1)
;          
;          FileList$ = GetPathPart(iFullPath$)+GetFilePart(iFullPath$,#PB_FileSystem_NoExtension)+".sha"
;          
;          State$ = LCase(INIValue::Get_S("SETTINGS","CreateSHA1",iDrop7z_Config$)) 
;          If (State$ = "true")
;              
;              GUI04::ConsoleWindow()
;                 
;                 SetGadgetText(DC::#Text_019,"Drop7z: Create CRC")               
;                 AddGadgetItem(DC::#ListIcon_002,-1,"")
;                 AddGadgetItem(DC::#ListIcon_002,-1,"")
;                 
;                 SendMessage_(GadgetID(DC::#ListIcon_002),#LVM_SETIMAGELIST,#LVSIL_SMALL,ImageList_Create_(1,17,#ILC_COLORDDB,0,0))
;                 HideWindow(DC::#_Window_004,0): SetForegroundWindow_(WindowID(DC::#_Window_004))
;                 StickyWindow(DC::#_Window_004,1)
;                 
;                 
;             Select Len(iSizeSplit$)
;               Case 0                 
;                   CreateFile(DC::#_TempFile,FileList$)
;                   SetWindowTitle(DC::#_Window_001,LHCrSH1.s)
;                   
;                   SHACOUNT = CountString(iFullPath$,Chr(34))
;                   For i = 0 To SHACOUNT
;                     iFullPath$ = ReplaceString(iFullPath$,Chr(34),"",0,1)
;                   Next   
;                   
;                   SetGadgetItemText(DC::#ListIcon_002, 0, GetFilePart(iFullPath$)) 
;                   SetGadgetItemText(DC::#ListIcon_002, 1, "CRC File: "+GetFilePart(FileList$))                    
;                   
;                   SHAFILE$ = GetFilePart(iFullPath$)
;                   SHASUME$ = SHA1FileFingerprint(iFullPath$): Delay(100)
;                   SetGadgetText(DC::#String_005,"SHA1: "+SHAFILE$)
;                   
;                   WriteStringN(DC::#_TempFile, SHASUME$+" *"+SHAFILE$,#PB_Ascii)
;                   CloseFile(DC::#_TempFile): SetWindowTitle(DC::#_Window_001,CFG::*Config\WindowTitle): Delay(100): ProcedureReturn
;                   
;               Default
;                   CreateFile(DC::#_TempFile,FileList$)                     
;                   
;                   iResult = FindFirstFile_(GetPathPart(iFullPath$)+"*.7z.*", f)
;                   Select iResult
;                       Case #INVALID_HANDLE_VALUE
;                           Debug "#INVALID_HANDLE_VALUE"
;                       Default
;                           
;                           SetWindowTitle(DC::#_Window_001,LHCrSH1.s)
;                           Name$ = PeekS(@f\cFileName[0])
;                           ExSH$ = LCase(GetExtensionPart(Name$))
;                           
;                           Select ExSH$
;                               Case "sha"
;                               Case "7z"    
;                               Default
;                                   
;                                   PartNum = ValF(ExSH$)
;                                   Select PartNum
;                                       Case 0
;                                       Default
;                                           
;                                           SetGadgetItemText(DC::#ListIcon_002, 0, Name$) 
;                                           SetGadgetItemText(DC::#ListIcon_002, 1, "CRC File: "+GetFilePart(FileList$))                                             
;                                           
;                                           SHAFILE$ = Name$
;                                           SHASUME$ = SHA1FileFingerprint(GetPathPart(iFullPath$)+Name$): Delay(100)
;                                           SetGadgetText(DC::#String_005,"SHA1: "+SHAFILE$)
;                                           WriteStringN(DC::#_TempFile, SHASUME$+" *"+SHAFILE$,#PB_Ascii) 
;                                   EndSelect
;                                   
;                           EndSelect
;                           
;                           While FindNextFile_(iResult, f)
;                               If iResult
;                                   
;                                   Name$ = PeekS(@f\cFileName[0])
;                                   ExSH$ = LCase(GetExtensionPart(Name$))
;                                   Select ExSH$
;                                       Case "sha"
;                                       Case "7z"
;                                       Default
;                                           
;                                           PartNum = ValF(ExSH$)
;                                           Select PartNum
;                                               Case 0
;                                               Default      
;                                                   
;                                                   SetGadgetItemText(DC::#ListIcon_002, 0, Name$) 
;                                                   SetGadgetItemText(DC::#ListIcon_002, 1, "CRC File: "+GetFilePart(FileList$))                                                   
;                                                   
;                                                   SHAFILE$ = Name$
;                                                   SHASUME$ = SHA1FileFingerprint(GetPathPart(iFullPath$)+Name$): Delay(100)  
;                                                   WriteStringN(DC::#_TempFile, SHASUME$+" *"+SHAFILE$,#PB_Ascii)
;                                                   SetGadgetText(DC::#String_005,"SHA1: "+SHAFILE$)
;                                           EndSelect    
;                                   EndSelect                         
;                               EndIf     
;                           Wend                  
;                           
;                   EndSelect
;                   CloseFile(DC::#_TempFile) : SetWindowTitle(DC::#_Window_001,CFG::*Config\WindowTitle.s):  Delay(100)
;                   
;                   SetGadgetText(DC::#Text_019,"Drop7z: Create CRC: Finished")
;                   Delay(3500)
;             
;                   HideWindow(DC::#_Window_004,1): SetForegroundWindow_(WindowID(DC::#_Window_001))
;                   StickyWindow(DC::#_Window_004,0): CloseWindow(DC::#_Window_004)                   
;                   ProcedureReturn 
;           EndSelect
;       EndIf
;   EndProcedure
;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 

;   Procedure _GetDriveType(iDestFileist$,num.i)
;     Protected result
;     
;                  
;              If ReadFile(0, iDestFileist$) And num=1
;                  While Eof(0) = 0
;                      iDriveString$ = ReadString(0)                     
;                      iDrive$ = Left(iDriveString$,1)
;                      If Len(iDrive$) <> 0
;                         DriveResult=GetDriveType_(iDrive$+":\")
;                         Select DriveResult
;                             Case 1; "Virtuelles Laufwerk"                    
;                             Case 2; "Diskettenlaufwerk"                            
;                             Case 3; "Festplatte"
;                             Case 4;"Netzwerk" 
;                             Case 5;"CD-Rom"
;                                 Debug iDriveString$
;                                 ProcedureReturn 1
;                             Case 6; "Ram-Disk"
;                         EndSelect                        
;                     EndIf
;                  Wend                  
;                   ProcedureReturn 0
;              EndIf
;              
;              If num=2             
;                 iDrive$ = Left(iDestFileist$,1)
;                                        
;                 DriveResult=GetDriveType_(iDrive$+":\")
;                 Select DriveResult
;                         Case 1; "Virtuelles Laufwerk" 
;  ;                           ProcedureReturn 1
;                         Case 2; "Diskettenlaufwerk"                            
;                         Case 3; "Festplatte"
;                         Case 4;"Netzwerk" 
;                         Case 5;"CD-Rom"
;                             ProcedureReturn 1
;                         Case 6; "Ram-Disk"
;                 EndSelect                        
;                 ProcedureReturn 0
;              EndIf             
;   EndProcedure


;
Procedure _Actio_DeleteFiles(iFullPath$,iDestFileist$,iFormat)
	
	Protected iResult.i, iTempDelete$, iError.i, iResult_DeleteFiles = #False
	
	
	Select CFG::*Config\DeleteFiles
		Case 1            
			;
			;Check For Drives
			;iDrive = _GetDriveType(iDestFileist$,1)
			If iDrive = 1
				iResult_DeleteFiles = #False
			EndIf 
			
			Select CFG::*Config\DontAskMe
				Case 1
					iResult_DeleteFiles = #True
				Case 0                   
					
					Request0$ = "Now Look What You've Done" 
					Request1$ = "Delete Files ?"        
					Select Windows::Get_Language() 
						Case 407              
							Request2$ = "Sollen alle Dateien/Verzeichnisse gelöscht werden ?."          
						Default
							Request2$ = "Do You want Delete Directories and Files?"    
					EndSelect
					
					iResult = Request::MSG(Request0$, Request1$  ,Request2$,12,1,ProgramFilename(),0,0,DC::#_Window_001)
					Select iResult.i
						Case 1           
							iResult_DeleteFiles = #True                 
						Default
							iResult_DeleteFiles = #False
							
					EndSelect            
			EndSelect                                
		Case 0
	EndSelect
	
	Select iResult_DeleteFiles
		Case #True
			
			;             Select CFG::*Config\usFormat
			;                 Case 0: PackFormat$ = "7z"
			;                 Case 1: PackFormat$ = "zip"
			;             EndSelect 
			
			PackFormat$ = DropCode::GetArchivFormat()
			
			If ReadFile(0, iDestFileist$)
				While Eof(0) = 0
					iTempDelete$ = ReadString(0)
					
					If (Len(iTempDelete$) <> 0)
						If Not (iFullPath$) = (Chr(34)+iTempDelete$+Chr(34))
							
							If FileSize(iTempDelete$+"\") = -2
								
								If iFormat = 1 
									iError.i = _Actio_DeleteFiles_Loop(iTempDelete$)
									If Not iError.i = 0
										Break;
									EndIf
								EndIf
								If iFormat = 2
									iSuffix$ = LCase(GetExtensionPart(iTempDelete$))
									If iSuffix$ <> PackFormat$
										iError.i = _Actio_DeleteFiles_Loop(iTempDelete$)
										If Not iError.i = 0
											Break;
										EndIf                                    
									EndIf
								EndIf                          
								
							Else
								If iFormat = 1
									iError.i = _Actio_DeleteFiles_Loop(iTempDelete$)
									If Not iError.i = 0
										Break;
									EndIf
								EndIf
								If iFormat = 2
									iSuffix$ = LCase(GetExtensionPart(iTempDelete$))
									If iSuffix$ <> PackFormat$
										iError.i = _Actio_DeleteFiles_Loop(iTempDelete$)
										If Not iError.i = 0
											Break;
										EndIf                                    
									EndIf
								EndIf
								
							EndIf
							SetWindowTitle(DC::#_Window_001,"Drop7z v"+LHBuild+" ..Delete: "+GetFilePart(iTempDelete$))
						EndIf
						
					EndIf
					
				Wend            
				CloseFile(0) 
				
				iMax  = CountGadgetItems(DC::#ListIcon_001)
				If iMax = 0 
					_Clear_FileList()
				EndIf
				If iMax <> 0
					Calculate_Size()
				EndIf 
			EndIf
		Default
	EndSelect
	ProcedureReturn
EndProcedure


;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
Procedure _Select_LeftListBox()
	
	iMax  = CountGadgetItems(DC::#ListIcon_001)
	iMarked = 0
	For x = 0 To iMax
		iMarkState = GetGadgetItemState(DC::#ListIcon_001, x)
		If  iMarkState = 1
			SetGadgetItemState(DC::#ListIcon_001,x,2|1)
			ProcedureReturn
		EndIf
		If  iMarkState = 3
			SetGadgetItemState(DC::#ListIcon_001,x,1)
			ProcedureReturn
		EndIf              
	Next 
	
	
EndProcedure
;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
Procedure _Browse_DestinationPath()
	
	iAltDestPath$ = GetGadgetText(DC::#String_002)
	If Len(iAltDestPath$) = 0 Or FileSize(iAltDestPath$) <> -2
		iAltDestPath$ = GetHomeDirectory()
		ComboAutoText()
	EndIf
	
	iAltDestPath$ = PathRequester("Select Destination Path for The 7z Archive",iAltDestPath$)
	If iAltDestPath$
		SetGadgetText(DC::#String_002,iAltDestPath$)
		ComboAutoText()
	EndIf
EndProcedure




;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
Procedure _SetGadetEncState()
	If GetGadgetState(DC::#CheckBox_001) = 0
		DisableGadget(DC::#String_003,1)
		ProcedureReturn
	EndIf
	DisableGadget(DC::#String_003,0)
	ProcedureReturn
EndProcedure

;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
Procedure _SendMailArchive(iAttachment$)
	
	If GetGadgetState(DC::#CheckBox_004) = 1
		
		Protected sMailCommand$, sMailto$, sSubject$, sBody$, sAttachement$, sRecipient$, MailtoProgramm$, iPos.i
		
		sMailto$    = "mailto:"
		sCC$        = ""     
		sBetreff$   = "Here is your Archive!"
		sBodyMsg$   = "Look at the Attachment"      
		sAttachement$ = iAttachment$
		
		sMailCommand$ = sMailto$ + "&Recipient="+sCC$+ "&Subject="+sBetreff$+ "&Body="+sBodyMsg$+ "&Attachement="+sAttachement$
		
		MailtoProgramm$ = REG_GetSzValue(#HKEY_CLASSES_ROOT, "mailto\shell\open\command","")
		
		iPos.i = FindString(LCase(MailtoProgramm$),"outlook.exe")
		If iPos.i <> 0
			RunProgram("OUTLOOK.EXE"," /a "+sAttachement$,"")
			ProcedureReturn
		Else
			iResult = ShellExecute_(Handle,"open",sMailCommand$, nil, nil, SW_SHOWNORMAL)
			If iResult = 31
				
				sLANGUAGE = Windows::Get_Language() 
				
				Request0$ = "Now Look What You've Done" 
				Request1$ = "Can't Mail Attachment!"                 
				Select sLANGUAGE
					Case 407              
						Request2$ = "Es ist keine Anwendung mit der erweiterung mailto: verknüpft"     
					Default
						Request2$ = "There is no application associated With the given file name extension:'mailto'" 
				EndSelect
				Request::MSG(Request0$, Request1$  ,Request2$,2,0,ProgramFilename(),0,0,DC::#_Window_001)
			EndIf
			ProcedureReturn
		EndIf
	EndIf   
	ProcedureReturn
EndProcedure

Procedure _SetSelfExtractet()
	If GetGadgetState(DC::#CheckBox_005) = 0
		DisableGadget(DC::#ComboBox_004,0)
		_SetButtonState()
		ProcedureReturn
	EndIf
	If GetGadgetState(DC::#CheckBox_005) = 1
		SetGadgetState(DC::#ComboBox_004,1)
		DisableGadget(DC::#ComboBox_004,1)
		_SetButtonState()
		ProcedureReturn
	EndIf
EndProcedure



; IDE Options = PureBasic 5.73 LTS (Windows - x64)
; CursorPosition = 825
; FirstLine = 771
; Folding = ------
; EnableAsm
; EnableXP
; UseMainFile = ..\Drop7z.pb
; CurrentDirectory = ..\Release\
; EnableUnicode