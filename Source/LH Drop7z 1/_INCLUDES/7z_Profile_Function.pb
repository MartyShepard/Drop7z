;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
;/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Procedure _Profile_FillList_SizeDict()
	ForEach SizeDict()
		With SizeDict()
			AddGadgetItem(DC::#ComboBox_011,\Num,\sSize)
		EndWith 
	Next
	
	ForEach SizeWord()
		With SizeWord()
			AddGadgetItem(DC::#ComboBox_006,\Num,\sSize)
		EndWith 
	Next
	
	ForEach SizeBlock()
		With SizeBlock()
			AddGadgetItem(DC::#ComboBox_007,\Num,\sSize)
		EndWith 
	Next     
	
	ForEach SizeSplit()
		With SizeSplit()
			AddGadgetItem(DC::#ComboBox_008,\Num,\sSize)
		EndWith 
	Next 
	
	ForEach Compression()
		With Compression()
			AddGadgetItem(DC::#ComboBox_009,\Num,\sType)
		EndWith 
	Next     
EndProcedure




;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 

Procedure  _Profile_SaveAs_Default()
	Protected Profile_Default$
	Protected iDrop7z_Config$
	iDrop7z_Config$ = GetPath_Config(1)
	
	Profile_Default$ = GetGadgetText(DC::#ComboBox_010)
	If Len(Profile_Default$) <> 0    
		INIValue::Set("PROFILES","Default",Profile_Default$,iDrop7z_Config$) 
		SetGadgetText(DC::#Text_013,"Default Profile: "+Profile_Default$)
		
	EndIf
EndProcedure         

;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
;/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////   
Procedure.s _Profile_Read_Default()
	Protected Profile_Default$
	Protected iDrop7z_Config$
	iDrop7z_Config$ = GetPath_Config(1)
	
	Profile_Default$ =  INIValue::Get_S("PROFILES","Default",iDrop7z_Config$)
	
	If Len(Profile_Default$) <> 0
		SetGadgetText(DC::#Text_013,"Default Profile: "+Profile_Default$)
		ProcedureReturn Profile_Default$
	EndIf
	
	
	ProcedureReturn "Default Profile (Not Set)"    
	SetGadgetText(DC::#Text_013,"Default Profile: Not Set")
	
	
EndProcedure  

;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
Procedure _Profile_Load_FromINI(_ComboxBoxID,_Profile.s)
	Protected ProFileConfig$
	
	ProFileConfig$ =  GetPath_Config(2)
	If Len(_Profile) <> 0 And _ComboxBoxID = DC::#ComboBox_010
		If OpenPreferences(ProFileConfig$,#PB_Preference_GroupSeparator)
			If ExaminePreferenceGroups()
				
				While NextPreferenceGroup()
					If _Profile = PreferenceGroupName()
						
						iTemp1.s = ReadPreferenceString("SizeDict", "12")
						iTemp2.s = ReadPreferenceString("SizeWord", "7")
						iTemp3.s = ReadPreferenceString("SizeBlock", "3")
						iTemp4.s = ReadPreferenceString("Level", "5")
						
						SetGadgetState(DC::#ComboBox_011,Val(iTemp1))
						SetGadgetState(DC::#ComboBox_006,Val(iTemp2))
						SetGadgetState(DC::#ComboBox_007,Val(iTemp3))
						SetGadgetState(DC::#ComboBox_009,Val(iTemp4))                      
						
						SetUserArcs$ = ReadPreferenceString("SizeArcs","0")
						
						n = FindString(SetUserArcs$,"_State",1)
						If n <> 0
							SetGadgetState(DC::#ComboBox_008,Val(SetUserArcs$))
						Else
							SetGadgetText(DC::#ComboBox_008,SetUserArcs$)
						EndIf
						
						SetGadgetText(DC::#String_004,"")
						Desktop$ = ReadPreferenceString("Password","")
						If Len(Desktop$) <> 0
							SetGadgetText(DC::#String_004,Desktop$)
						EndIf
						SendMessage_(GadgetID(DC::#ComboBox_010), #CB_SETEDITSEL, 0, Len(PreferenceGroupName()) << 16 + Len(PreferenceGroupName()))             
						
						ProcedureReturn
					EndIf
				Wend
			EndIf            
		EndIf
	EndIf
EndProcedure

;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
Procedure _Profile_Refresh_List(Profile$ = "")
	
	Protected ProFileConfig$
	ProFileConfig$ =  GetPath_Config(2)
	If Len(Profile$) = 0
		Profile$ = GetGadgetText(DC::#ComboBox_010)
	EndIf
	
	ClearGadgetItems(DC::#ComboBox_010)
	
	If OpenPreferences(ProFileConfig$,#PB_Preference_GroupSeparator)
		If ExaminePreferenceGroups()
			While NextPreferenceGroup()
				SendMessage_(GadgetID(DC::#ComboBox_010),#CB_ADDSTRING,0,PreferenceGroupName())
				SendMessage_(GadgetID(DC::#ComboBox_010), #CB_SETEDITSEL, 0, Len(PreferenceGroupName()) << 16 + Len(PreferenceGroupName()))                        
			Wend
		EndIf      
	EndIf
	
	If OpenPreferences(ProFileConfig$,#PB_Preference_GroupSeparator)  
		If ExaminePreferenceGroups() ;1 Normal or Rad by Config
			While NextPreferenceGroup()
				If (LCase(Profile$) = LCase(PreferenceGroupName()))
					SetGadgetText(DC::#ComboBox_010,Profile$)
					SendMessage_(GadgetID(DC::#ComboBox_010), #CB_SETEDITSEL, 0, Len(PreferenceGroupName()) << 16 + Len(PreferenceGroupName()))             
					
					ProcedureReturn
				EndIf
			Wend
		EndIf
		
	EndIf
	
	
EndProcedure

;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 


Procedure _Profile_Save_Check(prf$)
	
	Protected iResult.i
	Protected ProFileConfig$
	ProFileConfig$ =  GetPath_Config(2)
	
	If OpenPreferences(ProFileConfig$,#PB_Preference_GroupSeparator)  
		If ExaminePreferenceGroups()
			While NextPreferenceGroup()
				If (LCase(prf$) = LCase(PreferenceGroupName()))
					
					sLANGUAGE = Windows::Get_Language() 
					
					Request0$ = "Now Look What You've Done" 
					Request1$ =  "Replace the Current Profile!"                
					Select sLANGUAGE
						Case 407              
							Request2$ = #LF$+#LF$+"Das Profil: '" +PreferenceGroupName()+ "' Existiert. Mit den eingestellten werten überschreiben ?"  
						Default
							Request2$ = #LF$+#LF$+"Profile: '" +PreferenceGroupName()+ "' exists. Replace with the current settings ?"
					EndSelect
					;iResult = RequestEX::MSG(Request0$, Request1$, Request2$,1,0,"",1,ProgramFilename())   
					iResult = Request::MSG(Request0$, Request1$  ,Request2$,1,0,ProgramFilename())
					Select iResult
						Case 0
							ProcedureReturn #True
						Case 1
							ProcedureReturn #False
					EndSelect
				EndIf
			Wend
		EndIf
	EndIf
	ProcedureReturn 3
EndProcedure 

;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 

Procedure  _Profile_Save_Current_Settings(iAskUser = 1)
	
	Protected Profile_Settings$, nSizeSplit.i, UserSizeL.l, UserSizeS.s, SizeArcs.s, iPos.i, iResult.i
	Protected iDesktop$
	Protected ProFileConfig$
	ProFileConfig$  = GetPath_Config(2)
	
	Profile_Settings$ = GetGadgetText(DC::#ComboBox_010)
	If iAskUser = 1
		iResult.i = _Profile_Save_Check(Profile_Settings$)
	EndIf
	If iAskUser = 0
		iResult.i = #True
	EndIf
	
	If iResult.i = #True Or  iResult.i = 3 
		
		If OpenPreferences(ProFileConfig$,#PB_Preference_GroupSeparator)       
			PreferenceGroup(Profile_Settings$)
			
			WritePreferenceLong("SizeDict", GetGadgetState(DC::#ComboBox_011))
			WritePreferenceLong("SizeWord", GetGadgetState(DC::#ComboBox_006))
			WritePreferenceLong("SizeBlock", GetGadgetState(DC::#ComboBox_007))             
			WritePreferenceLong("Level", GetGadgetState(DC::#ComboBox_009))                  
			
			nSizeSplit  = GetGadgetState(DC::#ComboBox_008)    
			If nSizeSplit = -1
				UserSizeL.l = Val(GetGadgetText(DC::#ComboBox_008))
				UserSizeS.s = LCase(GetGadgetText(DC::#ComboBox_008))
				iPos.i = FindString(UserSizeS,"gb",1)
				
				If iPos.i <> 0 And UserSizeL <> 0
					SizeArcs.s = Str(UserSizeL)+"GB"
				ElseIf UserSizeL <> 0
					SizeArcs.s = Str(UserSizeL)+"MB"
				Else
					SizeArcs.s = "0_State"
				EndIf
			Else
				SizeArcs.s = Str(nSizeSplit)+"_State"
			EndIf          
			
			WritePreferenceString("SizeArcs", SizeArcs)                
			
			iDesktop$ = GetGadgetText(DC::#String_004)
			If Len(iDesktop$) <> 0
				WritePreferenceString("Password", iDesktop$)
			EndIf
			
		EndIf
		_Profile_Refresh_List(Profile_Settings$)
		SetGadgetText(DC::#ComboBox_010,Profile_Settings$)
		SendMessage_(GadgetID(DC::#ComboBox_010), #CB_SETEDITSEL, 0, Len(Profile_Settings$) << 16 + Len(Profile_Settings$))
		
		
	EndIf
	
	
	
	If iResult.i = #False: EndIf
	
EndProcedure

;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
Procedure _Profile_Load_FromGUI(_Profile.s)   ;Current Settings
	Protected ProFileConfig$
	Protected iDrop7z_Config$
	iDrop7z_Config$ = GetPath_Config(1) 
	ProFileConfig$  = GetPath_Config(2)
	
	If OpenPreferences(ProFileConfig$,#PB_Preference_GroupSeparator)  
		If ExaminePreferenceGroups()
			While NextPreferenceGroup()
				If (LCase(_Profile) = LCase(PreferenceGroupName()))
					SetGadgetText(DC::#ComboBox_010,_Profile)
					SendMessage_(GadgetID(DC::#ComboBox_010), #CB_SETEDITSEL, 0, Len(PreferenceGroupName()) << 16 + Len(PreferenceGroupName()))             
					_Profile_Load_FromINI(DC::#ComboBox_010,_Profile)
					ProcedureReturn
				EndIf
			Wend
		EndIf
	EndIf        
	
	SetGadgetState(DC::#ComboBox_011,12) ; Default Settings
	SetGadgetState(DC::#ComboBox_006,7)
	SetGadgetState(DC::#ComboBox_007,12)
	SetGadgetState(DC::#ComboBox_008,0)      
	SetGadgetState(DC::#ComboBox_009,5)
	
	If Len(_Profile) = 0 Or Len(_Profile) <> 0   
		
		SetGadgetState(DC::#ComboBox_011,GetGadgetState(DC::#ComboBox_001))
		SetGadgetState(DC::#ComboBox_006,GetGadgetState(DC::#ComboBox_002))
		SetGadgetState(DC::#ComboBox_007,GetGadgetState(DC::#ComboBox_003))
		SetGadgetState(DC::#ComboBox_009,GetGadgetState(DC::#ComboBox_011))    
		
		nSizeSplit  = GetGadgetState(DC::#ComboBox_004)
		
		If nSizeSplit = -1
			UserSizeL.l = Val(GetGadgetText(DC::#ComboBox_004))
			UserSizeS.s = LCase(GetGadgetText(DC::#ComboBox_004))
			nUserTry2 = FindString(UserSizeS,"gb",1)
			
			If nUserTry2 <> 0 And UserSizeL <> 0
				SetGadgetText(DC::#ComboBox_008,UserSizeS)
			ElseIf UserSizeL <> 0
				SetGadgetText(DC::#ComboBox_008,UserSizeS+"MB")
			Else
				SetGadgetState(DC::#ComboBox_008,0)
			EndIf
		Else
			SetGadgetState(DC::#ComboBox_008,nSizeSplit)
		EndIf
		
		Profile_Default$ = INIValue::Get_S("PROFILES","Default",iDrop7z_Config$)
		If Len(Profile_Default$) <> 0
			
			SetGadgetText(DC::#ComboBox_010,"Not Found: "+_Profile)
			SendMessage_(GadgetID(DC::#ComboBox_010), #CB_SETEDITSEL, Len(_Profile), -1)             
			
			ProcedureReturn
		EndIf
		If Len(Profile_Default$) = 0 
			SetGadgetText(DC::#ComboBox_010,"Default Profile (Not Set)")
			ProcedureReturn
		EndIf
	EndIf
	
	
EndProcedure 


;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
Procedure _Profile_Load_FromGUI_Password()
	Protected iDesktop$
	
	iDesktop$    = GetGadgetText(DC::#String_003)
	
	If GetGadgetState(DC::#CheckBox_001) = 1        
		SetGadgetText(DC::#String_004,iDesktop$)
		SendMessage_(GadgetID(DC::#String_004), #EM_SETSEL, Len(GetGadgetText(DC::#String_004)), -1)
		SetActiveGadget(DC::#String_004)
		ProcedureReturn    
	EndIf
	
	If (Len(iDesktop$) <> 0)
		SetGadgetText(DC::#String_004,iDesktop$)
		SendMessage_(GadgetID(DC::#String_004), #EM_SETSEL, Len(GetGadgetText(DC::#String_004)), -1)
		SetActiveGadget(DC::#String_004)
		ProcedureReturn       
	EndIf
	
	SetGadgetText(DC::#String_004,"")
EndProcedure   
;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
;/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////   

Procedure _Profile_Events(_iEevent.l)
	_Profile.s = GetGadgetText(DC::#ComboBox_010)          
	_Profile_Load_FromINI(DC::#ComboBox_010,_Profile.s)  
EndProcedure

;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
Procedure _Profile_TakeOver()
	Delay(250)
	Profile_Current.s = GetGadgetText(DC::#ComboBox_010)
	
	SetGadgetState(DC::#ComboBox_001,GetGadgetState(DC::#ComboBox_011))
	SetGadgetState(DC::#ComboBox_002,GetGadgetState(DC::#ComboBox_006))
	SetGadgetState(DC::#ComboBox_003,GetGadgetState(DC::#ComboBox_007))
	SetGadgetState(DC::#ComboBox_005,GetGadgetState(DC::#ComboBox_009))
	
	nSizeSplit  = GetGadgetState(DC::#ComboBox_008)
	
	If nSizeSplit = -1
		UserSizeL.l = Val(GetGadgetText(DC::#ComboBox_008))
		UserSizeS.s = LCase(GetGadgetText(DC::#ComboBox_008))
		nUserTry2 = FindString(UserSizeS,"gb",1)
		
		If nUserTry2 <> 0 And UserSizeL <> 0
			SetGadgetText(DC::#ComboBox_004,UserSizeS)
		ElseIf UserSizeL <> 0
			SetGadgetText(DC::#ComboBox_004,UserSizeS+"MB")
		Else
			SetGadgetState(DC::#ComboBox_004,0)
		EndIf
	Else
		SetGadgetState(DC::#ComboBox_004,nSizeSplit)
	EndIf
	
	iDesktop$    = GetGadgetText(DC::#String_004)
	
	If Len(iDesktop$) <> 0
		SetGadgetState(DC::#CheckBox_001,1)
		DisableGadget(DC::#String_003,0)
		SetGadgetText(DC::#String_003,iDesktop$)
	EndIf        
	If Len(iDesktop$) = 0
		SetGadgetState(DC::#CheckBox_001,0)
		DisableGadget(DC::#String_003,1)   
	EndIf
	
	Profile_Default$ = GetGadgetText(DC::#ComboBox_010)
	If Len(Profile_Default$) <> 0
		SetGadgetText(DC::#Text_003,Profile_Default$)
	Else
		SetGadgetText(DC::#Text_003,"Profile: Not Set")     
	EndIf 
	
	If ( Profile_Default$ = "Default Profile (Not Set)" ) Or ( Profile_Default$ = "")
		INIValue::Set("SETTINGS","Profile" ,"" ,CFG::*Config\ConfigPath) 		
	Else	
		INIValue::Set("SETTINGS","Profile" ,Profile_Default$ ,CFG::*Config\ConfigPath) 
	EndIf
	
EndProcedure
;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 

Procedure _Profile_Delete_Check(_Removed_Profile.s)
	Protected iDrop7z_Config$,_Profile.s
	iDrop7z_Config$ = GetPath_Config(1)  
	
	_Profile_Refresh_List() 
	SetGadgetState(DC::#ComboBox_010,0)
	
	_Profile.s = GetGadgetText(DC::#ComboBox_010) 
	If Len(_Profile.s) <> 0
		
		_Profile_Load_FromINI(DC::#ComboBox_010,_Profile.s)
		SetGadgetText(DC::#ComboBox_010,_Profile.s)
		SetGadgetText(DC::#Text_003,_Profile.s)
		SendMessage_(GadgetID(DC::#ComboBox_010), #CB_SETEDITSEL, 0, Len(_Profile.s) << 16 + Len(_Profile.s))             
		
	Else
		SetGadgetText(DC::#ComboBox_010,"Default Profile")          
		SetGadgetState(DC::#ComboBox_011,13)
		SetGadgetState(DC::#ComboBox_006,7)
		SetGadgetState(DC::#ComboBox_007,12)
		SetGadgetState(DC::#ComboBox_008,0)
		SetGadgetState(DC::#ComboBox_009,5)         
		SetGadgetText(DC::#String_004,iDesktop$)
		SetGadgetText(DC::#Text_003,"Profile: Not Set")
		
		SendMessage_(GadgetID(DC::#ComboBox_010), #CB_SETEDITSEL, 0, Len("Default Profile") << 16 + Len("Default Profile"))                      
	EndIf
	
	Profile_Default$ = INIValue::Get_S("PROFILES","Default",iDrop7z_Config$)
	If Profile_Default$ = _Removed_Profile        
		INIValue::Set("PROFILES","Default","",iDrop7z_Config$) 
		SetGadgetText(DC::#Text_013,"Default Profile: Not Set")
		SetGadgetText(DC::#Text_003,"Profile: Not Set")  
		ProcedureReturn
	Else
		_Profile_Refresh_List(Profile_Default$)
	EndIf
	
EndProcedure

;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 

Procedure _Profile_Delete(iAskUser = 1)
	Protected ProFileConfig$
	ProFileConfig$  = GetPath_Config(2)
	_Profile.s = GetGadgetText(DC::#ComboBox_010) 
	If OpenPreferences(ProFileConfig$,#PB_Preference_GroupSeparator)  
		If ExaminePreferenceGroups()
			While NextPreferenceGroup()
				If _Profile = PreferenceGroupName()
					If iAskUser = 1
						
						sLANGUAGE = Windows::Get_Language() 
						
						Request0$ = "Now Look What You've Done" 
						Request1$ = "Delete Profile: "+PreferenceGroupName()                
						Select sLANGUAGE
							Case 407              
								Request2$ = #LF$+#LF$+"Das Profil: '" +PreferenceGroupName()+ "' Löschen ?"      
							Default
								Request2$ = #LF$+#LF$+"Delete the Profile: '" +PreferenceGroupName()+ "' ?"   
						EndSelect
						;iResult = RequestEX::MSG(Request0$, Request1$, Request2$,1,0,"",1,ProgramFilename())
						iResult = Request::MSG(Request0$, Request1$  ,Request2$,1,0,ProgramFilename())
						Select iResult
							Case 0
								RemovePreferenceGroup(_Profile)
								If iAskUser = 1
									_Profile_Delete_Check(_Profile)
								EndIf                               
							Case 1
								
						EndSelect        
					EndIf
				EndIf
			Wend
		EndIf
	EndIf        
	
EndProcedure   
;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 


Procedure  _Profile_Rename()
	
	Protected Profile_NewName$
	Protected iDrop7z_Config$
	Protected ProFileConfig$
	iDrop7z_Config$ = GetPath_Config(1)   
	ProFileConfig$  = GetPath_Config(2)
	Profile_Default$ = GetGadgetText(DC::#ComboBox_010)
	
	If OpenPreferences(ProFileConfig$,#PB_Preference_GroupSeparator)  
		If ExaminePreferenceGroups()
			While NextPreferenceGroup()
				If Profile_Default$ = PreferenceGroupName()
					Profile_NewName$ = InputRequester("Rename Profile","Rename The Current Profile:",Profile_Default$)
					
					If Len(Profile_NewName$) <> 0
						_Profile_Delete(0)
						SetGadgetText(DC::#ComboBox_010,Profile_NewName$)
						SendMessage_(GadgetID(DC::#ComboBox_010), #CB_SETEDITSEL, 0, Len(Profile_NewName$) << 16 + Len(Profile_NewName$))                      
						
						_Profile_Save_Current_Settings(0)
						
						Profile_Default_Old$ = INIValue::Get_S("PROFILES","Default",iDrop7z_Config$)
						If LCase(Profile_Default_Old$) = LCase(Profile_Default$)
							_Profile_SaveAs_Default()
						EndIf
						
						ProcedureReturn
					EndIf
					If Len(Profile_NewName$) = 0
												
						Request0$ = "Now Look What You've Done" 
						Request1$ = "Need a Profile Name!"                					
						Request2$ = #LF$+"Kein Profile Namen angegeben für '" +Profile_Default$+ "'"         
						iResult = Request::MSG(Request0$, Request1$  ,Request2$,1,0,ProgramFilename(),0,0, DC::#_Window_001)
						
						ProcedureReturn
					EndIf
				EndIf
			Wend
		EndIf
	EndIf
	
	sLANGUAGE = Windows::Get_Language() 
	
	Request0$ = "Now Look What You've Done" 
	Request1$ = "Missing Settings!"               
	Select sLANGUAGE
		Case 407              
			Request2$ = #LF$+"Für das Profil '" +Profile_Default$+ "' fehlen die einstellungen"         
		Default
			Request2$ =  #LF$+"MIssing Settings for Profile '" +Profile_Default$+ "'"  
	EndSelect
	;iResult = RequestEX::MSG(Request0$, Request1$, Request2$,1,0,"",1,ProgramFilename())
	iResult = Request::MSG(Request0$, Request1$  ,Request2$,1,0,ProgramFilename())
	
EndProcedure 

;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 

Procedure _CB_Profiles(hwnd, uMsg, wParam, lParam) 
	PB_Result = #PB_ProcessPureBasicEvents
	
	Select uMsg 
		Case #WM_COMMAND
			;Select (wParam>>16) & $FFFF
			;Case #CBN_SELCHANGE
			If (wParam>>16) = #CBN_SELCHANGE And lParam = GadgetID(DC::#ComboBox_010) 
				_Profile_Load_FromINI(DC::#ComboBox_010,GetGadgetItemText(DC::#ComboBox_010,GetGadgetState(DC::#ComboBox_010),0))
			EndIf
			;Case #CBN_CLOSEUP
			;Case #CBN_SELENDOK
			
	EndSelect
	
	;EndSelect
	ProcedureReturn PB_Result
EndProcedure 


Procedure OpenWindow_500(x = 0, y = 0, width = 346, height = 358)
	OpenWindow(DC::#_Window_002, x, y, width, height, "", #PB_Window_SystemMenu | #PB_Window_Invisible | #PB_Window_Tool | #PB_Window_ScreenCentered, WindowID(DC::#_Window_001))
EndProcedure
;/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
;/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Procedure.s Open_Profile() 
	
	Protected.l FontID
	
	FontID.l   = Fonts::#_FIXPLAIN7_12
	
	Profile_Current.s = GetGadgetText(DC::#Text_003)
	OpenWindow_500():
	
	HideWindow(DC::#_Window_002, 1)
	
	
	ImageGadget(DC::#ImageGadget_003,0, 0, 346, 356,ImageID(#_BCK_T01))
	DisableGadget(DC::#ImageGadget_003, #True)
	
	TextGadget(DC::#Text_001, 23, 21, 200, 16, "  Custom Profiles Settings")
	SetGadgetColor(DC::#Text_001, #PB_Gadget_FrontColor,RGB(0, 175, 255))
	SetGadgetColor(DC::#Text_001, #PB_Gadget_BackColor,RGB(82,82,82))
	SetGadgetFont (DC::#Text_001, FontID(FontID) )
	
	FrameGadget(DC::#Frame_003, 6, 6, 334, 346, "", #PB_Frame_Flat)
	FrameGadget(DC::#Frame_004, 20, 80, 192, 180, "", #PB_Frame_Flat)
	FrameGadget(DC::#Frame_002, 20, 270, 192, 50, "", #PB_Frame_Flat)
	;FrameGadget(DC::#Frame_005, 223, 270, 109, 50, "", #PB_Frame_Flat)
	
	TextGadget(DC::#Text_012, 32, 230, 90, 18, "Split Archive")
	SetGadgetColor(DC::#Text_012, #PB_Gadget_BackColor,RGB(167,167,167))
	SetGadgetFont(DC::#Text_012, FontID(Fonts::#_SEGOEUI10N))
	
	TextGadget(DC::#Text_014, 32, 92, 90, 18, "Compression")
	SetGadgetColor(DC::#Text_014, #PB_Gadget_BackColor,RGB(167,167,167))
	SetGadgetFont(DC::#Text_014, FontID(Fonts::#_SEGOEUI10N))
	
	TextGadget(DC::#Text_015, 32, 128, 90, 18, "Dictionary Size")
	SetGadgetColor(DC::#Text_015, #PB_Gadget_BackColor,RGB(167,167,167))
	SetGadgetFont(DC::#Text_015, FontID(Fonts::#_SEGOEUI10N))
	
	TextGadget(DC::#Text_016, 32, 160, 90, 18, "Word Size:")
	SetGadgetColor(DC::#Text_016, #PB_Gadget_BackColor,RGB(167,167,167))
	SetGadgetFont(DC::#Text_016, FontID(Fonts::#_SEGOEUI10N))
	
	TextGadget(DC::#Text_017, 32, 192, 90, 18, "Solid Block Size:")
	SetGadgetColor(DC::#Text_017, #PB_Gadget_BackColor,RGB(167,167,167))
	SetGadgetFont(DC::#Text_017, FontID(Fonts::#_SEGOEUI10N))
	
	TextGadget(DC::#Text_018, 28, 272, 160, 18, "Encryption Password")
	SetGadgetColor(DC::#Text_018, #PB_Gadget_BackColor,RGB(167,167,167))
	SetGadgetFont(DC::#Text_018, FontID(Fonts::#_SEGOEUI10N))
	
	TextGadget(DC::#Text_013, 22, 330, 308, 16, "")
	SetGadgetColor(DC::#Text_013, #PB_Gadget_BackColor,RGB(82,82,82))
	SetGadgetColor(DC::#Text_013, #PB_Gadget_FrontColor,RGB(225,225,226))
	SetGadgetFont(DC::#Text_013, FontID(Fonts::#_SEGOEUI09N))
	
	ComboBoxGadget(DC::#ComboBox_010, 28, 40, 300, 24, #CBS_SORT|#PB_ComboBox_Editable)
	SetGadgetFont(DC::#ComboBox_010, FontID(Fonts::#_SEGOEUI10N))   
	;SetWindowLongPtr_(GadgetID(DC::#ComboBox_010), #GWL_WNDPROC, @ComboCallBackColor())
	
	
	ComboBoxGadget(DC::#ComboBox_009, 130, 92, 70, 22) : SetGadgetFont(DC::#ComboBox_009, FontID(Fonts::#_SEGOEUI09N)); Compession 
	ComboBoxGadget(DC::#ComboBox_011, 130, 128, 70, 22): SetGadgetFont(DC::#ComboBox_011, FontID(Fonts::#_SEGOEUI09N)); Dictionoary
	
	ComboBoxGadget(DC::#ComboBox_006, 130, 160, 70, 22): SetGadgetFont(DC::#ComboBox_006, FontID(Fonts::#_SEGOEUI09N))
	ComboBoxGadget(DC::#ComboBox_007, 130, 192, 70, 22): SetGadgetFont(DC::#ComboBox_007, FontID(Fonts::#_SEGOEUI09N))
		
	
	ComboBoxGadget(DC::#ComboBox_008, 130, 230, 70, 22, #PB_ComboBox_Editable)
	SetGadgetFont (DC::#ComboBox_008, FontID(Fonts::#_SEGOEUI09N))
	
	StringGadget  (DC::#String_004, 29, 293,173, 16, "",#PB_String_BorderLess)
	SetGadgetFont (DC::#String_004, FontID(Fonts::#_SEGOEUI09N))
	SetGadgetColor(DC::#String_004, #PB_Gadget_BackColor,RGB(200,200,200))
	
	XIncludeFile "..\_INCLUDES\_Form_ButtonsGui_Profile.pb"
	
	_Profile_FillList_SizeDict()
	
	
	iPos = FindString(Profile_Current.s,"Profile: ",1)
	If iPos =  0
		Profile_Current.s = _Profile_Read_Default()
	Else
		Profile_Current.s = ReplaceString(Profile_Current.s,"Profile: ","")
		_Profile_Read_Default()
	EndIf
	
	
	_Profile_Refresh_List()
	_Profile_Load_FromGUI(Profile_Current.s)
	_Profile_Load_FromGUI_Password()
	EnableWindow_(WindowID(DC::#_Window_002), #True): SetActiveWindow(DC::#_Window_002) 
	
	
	SetWindowCallback(@_CB_Profiles(),DC::#_Window_002)
	
	HideWindow(DC::#_Window_002,0)
	StickyWindow(DC::#_Window_002,1)
	
	Global _ProfileQuit = #False
	
	Repeat    
		_Profile_EventID.l = WaitWindowEvent() 
		
		Select _Profile_EventID 
				
			Case #PB_Event_CloseWindow 
				_ProfileQuit = #True           
			Case #PB_Event_Gadget 
				Select EventGadget()
					Case DC::#ComboBox_009    :_SetCompression_Mode(DC::#ComboBox_009,DC::#ComboBox_011,DC::#ComboBox_006,DC::#ComboBox_007)                       
					Case DC::#ComboBox_010    :_Profile_Events(EventType()) 
						
				EndSelect
				
				Select EventGadget()
						;**********************************************************************************************************************    
					Case DC::#Button_011    
						Select BUTTONEX::ButtonExEvent(DC::#Button_011)  
							Case BUTTONEX::#ButtonGadgetEx_Entered:     
								
							Case BUTTONEX::#ButtonGadgetEx_Released
							Case BUTTONEX::#ButtonGadgetEx_Pressed:       _Profile_TakeOver():_ProfileQuit = #True 
						EndSelect     
						;**********************************************************************************************************************    
					Case DC::#Button_014    
						Select BUTTONEX::ButtonExEvent(DC::#Button_014)  
							Case BUTTONEX::#ButtonGadgetEx_Entered:     
								
							Case BUTTONEX::#ButtonGadgetEx_Released
							Case BUTTONEX::#ButtonGadgetEx_Pressed:       _Profile_SaveAs_Default()
						EndSelect     
						;**********************************************************************************************************************    
					Case DC::#Button_012    
						Select BUTTONEX::ButtonExEvent(DC::#Button_012)  
							Case BUTTONEX::#ButtonGadgetEx_Entered:   
								
							Case BUTTONEX::#ButtonGadgetEx_Released
							Case BUTTONEX::#ButtonGadgetEx_Pressed:       _Profile_Save_Current_Settings()    
						EndSelect     
						;**********************************************************************************************************************    
					Case DC::#Button_013    
						Select BUTTONEX::ButtonExEvent(DC::#Button_013)  
							Case BUTTONEX::#ButtonGadgetEx_Entered:      
								
							Case BUTTONEX::#ButtonGadgetEx_Released
							Case BUTTONEX::#ButtonGadgetEx_Pressed:       _ProfileQuit = #True   
						EndSelect
						;**********************************************************************************************************************    
					Case DC::#Button_015    
						Select BUTTONEX::ButtonExEvent(DC::#Button_015)  
							Case BUTTONEX::#ButtonGadgetEx_Entered:     
								
							Case BUTTONEX::#ButtonGadgetEx_Released
							Case BUTTONEX::#ButtonGadgetEx_Pressed:       _Profile_Delete()
						EndSelect            
						;**********************************************************************************************************************    
					Case DC::#Button_016    
						Select BUTTONEX::ButtonExEvent(DC::#Button_016)  
							Case BUTTONEX::#ButtonGadgetEx_Entered:     
								
							Case BUTTONEX::#ButtonGadgetEx_Released
							Case BUTTONEX::#ButtonGadgetEx_Pressed
								_Profile_Refresh_List()
						EndSelect
						;**********************************************************************************************************************    
					Case DC::#Button_017    
						Select BUTTONEX::ButtonExEvent(DC::#Button_017)  
							Case BUTTONEX::#ButtonGadgetEx_Entered:      
								
							Case BUTTONEX::#ButtonGadgetEx_Released
							Case BUTTONEX::#ButtonGadgetEx_Pressed:       _Profile_Rename()
						EndSelect                            
				EndSelect
		EndSelect   
	Until _ProfileQuit = #True
	
	EnableWindow_(WindowID(DC::#_Window_001), #True) :SetActiveWindow(DC::#_Window_001)
	
	StickyWindow(DC::#_Window_002,0)
	
	_SetButtonState()
	
	SSTTIP::ToolTipMode(2,DC::#Button_011)
	SSTTIP::ToolTipMode(2,DC::#Button_012)
	SSTTIP::ToolTipMode(2,DC::#Button_013)
	SSTTIP::ToolTipMode(2,DC::#Button_014)
	SSTTIP::ToolTipMode(2,DC::#Button_015)
	SSTTIP::ToolTipMode(2,DC::#Button_016)
	SSTTIP::ToolTipMode(2,DC::#Button_017)
	
	CloseWindow(DC::#_Window_002) 
EndProcedure 
; IDE Options = PureBasic 5.73 LTS (Windows - x64)
; CursorPosition = 610
; FirstLine = 579
; Folding = ---
; EnableAsm
; EnableXP
; UseMainFile = ..\Drop7z.pb
; CurrentDirectory = ..\Drop7z\
; EnableUnicode