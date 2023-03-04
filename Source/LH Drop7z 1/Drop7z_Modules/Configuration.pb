


DeclareModule CFG
	
	Structure INI_STRUCTURE
		ConfigPath.s{#MAX_PATH}
		ProfilePath.s{#MAX_PATH}
		HistoryPath.s{#MAX_PATH}
		CRCLastPath.s{#MAX_PATH}
		Version.s{128}             
		WindowTitle.s{384}
		Autostart.i
		MiniMized.i
		DesktopX.l
		DesktopY.l
		DesktopW.l
		DesktopH.l
		Sticky.i     			; Window Top Most   
		Instanz.i
		DeleteFiles.i
		AutoClearLt.i
		DontAskMe.i
		CreateSHA1.i            
		PinDirectory.i
		szPinCurrent.s
		HandleExeAsRAR.i
		HandleExeAsZIP.i
		HandleExeAsS7Z.i
		ConvertDelTemp.i
		MoveZIProblems.i
		UnPackOnly.i
		UnpackInSubDirectory.i            
		usFormat.i                  ; Aktuelles Pack Format
		ZipMethodID.i
		CHDszPath.s{#MAX_PATH}      ; Mame's CHDMan Tool
		CHDbClipBoard.i
		CHDbSticky.i
		
	EndStructure    
	
	*Config.INI_STRUCTURE       = AllocateMemory(SizeOf(INI_STRUCTURE))
	
	Declare 	ReadConfig(*Config.INI_STRUCTURE)
	Declare 	WriteConfig(*Config.INI_STRUCTURE)
	Declare 	Make_Config(*Config.INI_STRUCTURE)
	
	Declare.s   AboutMessage()			
	Declare.s 	MakeHistory(szFileHistory.s,Force=0)
	
	Declare.l	Get_AboutMessage_TextHeight(TextGadgetID)
	
EndDeclareModule 

DeclareModule DropPack   
	Declare.i   Compress()
EndDeclareModule  


Module CFG
	;
	;
	; 	
	Procedure.s  Update_OldConfigLocation()
		Protected.s szConfig, szHistory, szProfiles, szCurrent, szSuffix, suSubData
		
		szConfig   = "Drop7z"
		szProfiles = "Profiles"
		szHistory  = "History"
		szSuffix   = ".ini"
		suSubData  = "DropData\"
		
		szCurrent = GetPathPart( ProgramFilename() )
				
		;
		;
		; Check For Old Locations. Move all to Subs Directory
		
		If ( FileSize( szCurrent + suSubData) ! -2 )
			CreateDirectory( szCurrent + suSubData )
		EndIf	
		
		;
		; Check Drop7z.Ini
		If ( FileSize( szCurrent + szConfig + szSuffix) > 0 )
			MoveFile_(  szCurrent + szConfig + szSuffix,  szCurrent + suSubData + szConfig + szSuffix)
		EndIf	
		
		;
		; Check Profiles.Ini		
		If ( FileSize( szCurrent + "Drop7z_Profiles" + szSuffix) > 0 )
			MoveFile_( szCurrent + szConfig + "_" + szProfiles + szSuffix,  szCurrent + suSubData + szProfiles + szSuffix)
		EndIf			
		
		;
		; Check History.Ini		
		If ( FileSize( szCurrent + "Drop7z_History" + szSuffix) > 0 )
			MoveFile_( szCurrent + szConfig + "_" + szHistory + szSuffix,  szCurrent + suSubData + szHistory + szSuffix)
		EndIf
		
	EndProcedure	
	;
	; Akuell Configuration die geschrieben wird
	;    
	Procedure Make_Config(*Config.INI_STRUCTURE)
				
		CreateFile(DC::#_FileConfig,*Config\ConfigPath)
		
		WriteStringN(DC::#_FileConfig, "[DROP.7Z]")
		WriteStringN(DC::#_FileConfig, "# Product Name:=: Drop.7z")        
		WriteStringN(DC::#_FileConfig, "# Version     :=: " + *Config\Version.s)
		WriteStringN(DC::#_FileConfig, "# Copyright   :=: [= Marty =]")        
		WriteStringN(DC::#_FileConfig, "")         
		WriteStringN(DC::#_FileConfig, "[SETTINGS]")
		WriteStringN(DC::#_FileConfig, "Sticky=false")           
		WriteStringN(DC::#_FileConfig, "Desktop.Y=0")
		WriteStringN(DC::#_FileConfig, "Desktop.X=0")               
		WriteStringN(DC::#_FileConfig, "AutoClearLt=false")
		WriteStringN(DC::#_FileConfig, "DeleteFiles=false")
		WriteStringN(DC::#_FileConfig, "DontAskMe=false")                      
		WriteStringN(DC::#_FileConfig, "AutoStart=false")        
		WriteStringN(DC::#_FileConfig, "MiniMized=false") 
		WriteStringN(DC::#_FileConfig, "CreateSHA1=true")                  
		WriteStringN(DC::#_FileConfig, "SingleInstanz=true")
		WriteStringN(DC::#_FileConfig, "PinDirectory=false")
		WriteStringN(DC::#_FileConfig, "PinCurrentVZ=")
		WriteStringN(DC::#_FileConfig, "Profile=")     		
		WriteStringN(DC::#_FileConfig, "")                
		WriteStringN(DC::#_FileConfig, "# Current Pack Format...............")                 
		WriteStringN(DC::#_FileConfig, "usFormat=7z")
		WriteStringN(DC::#_FileConfig, "")
		WriteStringN(DC::#_FileConfig, "# ZIP Options.......................")                 
		WriteStringN(DC::#_FileConfig, "ZipMethodID=0")
		WriteStringN(DC::#_FileConfig, "")
		WriteStringN(DC::#_FileConfig, "# Convert/ Unpack ..................")                 
		WriteStringN(DC::#_FileConfig, "ForceEXEAsRAR=true"	)
		WriteStringN(DC::#_FileConfig, "ForceEXEAsZIP=false"	)
		WriteStringN(DC::#_FileConfig, "ForceEXEAsS7Z=false"	)  
		WriteStringN(DC::#_FileConfig, "DeleteTempDir=true"	)  
		WriteStringN(DC::#_FileConfig, "MoveArchive=false"	)                 
		WriteStringN(DC::#_FileConfig, "UnpackOnly=false"		)
		WriteStringN(DC::#_FileConfig, "UnpackInSubDirectory=true"		)                   
		WriteStringN(DC::#_FileConfig, "# CHD Options.......................")                 
		WriteStringN(DC::#_FileConfig, "CHDManTool=") 
		WriteStringN(DC::#_FileConfig, "ClipBoard=")
		WriteStringN(DC::#_FileConfig, "CHDSticky=")                
		WriteStringN(DC::#_FileConfig, "")         
		WriteStringN(DC::#_FileConfig, "Portable =")      
		WriteStringN(DC::#_FileConfig, "# Add Optional a Path to 7zg.exe")
		WriteStringN(DC::#_FileConfig, "# A:\MyApps\YourApps\OurApps\7zG.exe")
		WriteStringN(DC::#_FileConfig, "# Wthout Double Quotes..............")        
		
		CloseFile(DC::#_FileConfig)
	EndProcedure  
	
	;
	; Resete History und Combobox
	;    
	Procedure.s MakeHistory(szFileHistory.s, Force = 0)
		
		Protected size.i
		
		Select Force
			Case 0                
			Case 1
				DeleteFile(szFileHistory.s,#PB_FileSystem_Force)        
		EndSelect
		
		size.i = FileSize(szFileHistory.s)
		Select size.i
			Case 0,-1
				CreateFile(DC::#_FileHistory,szFileHistory.s)
				CloseFile (DC::#_FileHistory)
		EndSelect
	EndProcedure

	;
	;
	;  Lese Configuration
	Procedure ReadConfig(*Config.INI_STRUCTURE) 
		Protected.i Size
		Protected.s suSubData
		
		Update_OldConfigLocation()
		
		suSubData  = "DropData\"
			
		*Config\Version    	= "1.02.04 Beta FastFertig"
		*Config\WindowTitle	= "Drop7z v"+ *Config\Version +" By Marty Shepard"
		
		*Config\ConfigPath 	= GetPathPart( ProgramFilename() ) + suSubData + "Drop7z.ini"
		*Config\ProfilePath	= GetPathPart( ProgramFilename() ) + suSubData + "Profiles.ini"
		*Config\HistoryPath	= GetPathPart( ProgramFilename() ) + suSubData + "History.ini"
		
		Debug ""
		Debug "Drop 7z Home Directory"
		Debug "Home: "+ ProgramFilename()
		Debug "Conf: "+ *Config\ConfigPath
		Debug "Prof: "+ *Config\ProfilePath
		Debug "Hist: "+ *Config\HistoryPath
		
		Size.i = FileSize(*Config\ConfigPath)
		Select Size.i
			Case 0,-1
				Make_Config(*Config.INI_STRUCTURE)
		EndSelect        
		
		Size.i = FileSize(*Config\HistoryPath)
		Select Size.i
			Case 0,-1
				MakeHistory(*Config\HistoryPath)
		EndSelect       
		
		;
		;Ini Values mit String
		Select (UCase( INIValue::Get_s("SETTINGS", "usFormat" ,*Config\ConfigPath) ) )
			Case "7Z"   : *Config\usFormat = 0
			Case "ZIP"  : *Config\usFormat = 1
			Case "CHD"  : *Config\usFormat = 2
			Default 
				*Config\usFormat = 0
		EndSelect 
		
		*Config\CRCLastPath = INIValue::Get_S("SETTINGS","Directory0"       ,*Config\ConfigPath)
		*Config\CHDszPath	= INIValue::Get_S("SETTINGS","CHDManTool"       ,*Config\ConfigPath) 
		*Config\szPinCurrent= INIValue::Get_S("SETTINGS","PinCurrentVZ"     ,*Config\ConfigPath)
		;
		; Ini Values mit Integer
		*Config\DesktopX    = INIValue::Get_I("SETTINGS","Desktop.X"        ,*Config\ConfigPath)
		*Config\DesktopY    = INIValue::Get_I("SETTINGS","Desktop.Y"        ,*Config\ConfigPath)
		*Config\ZipMethodID = INIValue::Get_I("SETTINGS","ZipMethodID"      ,*Config\ConfigPath)  
		
		;
		; Ini Values mit true/false
		*Config\Autostart   = INIValue::Get_Value("SETTINGS","Autostart"    ,*Config\ConfigPath)
		*Config\MiniMized   = INIValue::Get_Value("SETTINGS","MiniMized"    ,*Config\ConfigPath)
		*Config\Sticky      = INIValue::Get_Value("SETTINGS","Sticky"       ,*Config\ConfigPath)
		*Config\DeleteFiles = INIValue::Get_Value("SETTINGS","DeleteFiles"  ,*Config\ConfigPath)          
		*Config\Instanz     = INIValue::Get_Value("SETTINGS","SingleInstanz",*Config\ConfigPath)
		*Config\AutoClearLt = INIValue::Get_Value("SETTINGS","AutoClearLt"  ,*Config\ConfigPath) 
		*Config\DontAskMe   = INIValue::Get_Value("SETTINGS","DontAskMe"    ,*Config\ConfigPath)
		*Config\CreateSHA1  = INIValue::Get_Value("SETTINGS","CreateSHA1"   ,*Config\ConfigPath)
		*Config\CHDbClipBoard=INIValue::Get_Value("SETTINGS","ClipBoard"    ,*Config\ConfigPath)
		*Config\CHDbSticky  = INIValue::Get_Value("SETTINGS","CHDSticky"    ,*Config\ConfigPath) 
		*Config\PinDirectory= INIValue::Get_Value("SETTINGS","PinDirectory" ,*Config\ConfigPath)
		
		
		
		*Config\HandleExeAsRAR = INIValue::Get_Value("SETTINGS","ForceEXEAsRAR"  ,*Config\ConfigPath)
		*Config\HandleExeAsZIP = INIValue::Get_Value("SETTINGS","ForceEXEAsZIP"  ,*Config\ConfigPath)
		*Config\HandleExeAsS7Z = INIValue::Get_Value("SETTINGS","ForceEXEAsS7Z"  ,*Config\ConfigPath)
		
		
		If (*Config\HandleExeAsRAR = #False ) And (*Config\HandleExeAsZIP = #False) And (*Config\HandleExeAsS7Z = #False) 
			*Config\HandleExeAsRAR = #True
		EndIf
		
		*Config\ConvertDelTemp = INIValue::Get_Value("SETTINGS","DeleteTempDir"  ,*Config\ConfigPath)
		*Config\MoveZIProblems = INIValue::Get_Value("SETTINGS","MoveArchive"    ,*Config\ConfigPath)
		*Config\UnPackOnly	 = INIValue::Get_Value("SETTINGS","UnpackOnly"     ,*Config\ConfigPath)
		
		*Config\UnpackInSubDirectory = INIValue::Get_Value("SETTINGS","UnpackInSubDirectory" ,*Config\ConfigPath)
		
	EndProcedure
	
	;
	;
	;  Schreibe Configuration
	Procedure WriteConfig(*Config.INI_STRUCTURE)   
		;
		; Setze Ini Values mit String oder Integer
		Select *Config\usFormat
			Case 0: INIValue::Set("SETTINGS","usFormat","7Z"    ,*Config\ConfigPath)
			Case 1: INIValue::Set("SETTINGS","usFormat","ZIP"   ,*Config\ConfigPath)
			Case 2: INIValue::Set("SETTINGS","usFormat","CHD"   ,*Config\ConfigPath)                
		EndSelect
		
		INIValue::Set("SETTINGS","ZipMethodID"  ,Str(   *Config\ZipMethodID)    ,*Config\ConfigPath)
		INIValue::Set("SETTINGS","Desktop.X"    ,Str(   *Config\DesktopX )      ,*Config\ConfigPath)
		INIValue::Set("SETTINGS","Desktop.Y"    ,Str(   *Config\DesktopY )      ,*Config\ConfigPath)
		
		;
		; Setze Ini Values mit True/False        
		INIValue::Set_Value("SETTINGS","Autostart"      ,*Config\Autostart      ,*Config\ConfigPath)
		INIValue::Set_Value("SETTINGS","MiniMized"      ,*Config\MiniMized      ,*Config\ConfigPath)
		INIValue::Set_Value("SETTINGS","Sticky"         ,*Config\Sticky         ,*Config\ConfigPath)
		INIValue::Set_Value("SETTINGS","SingleInstanz"  ,*Config\Instanz        ,*Config\ConfigPath) 
		INIValue::Set_Value("SETTINGS","DeleteFiles"    ,*Config\DeleteFiles    ,*Config\ConfigPath)
		INIValue::Set_Value("SETTINGS","AutoClearLt"    ,*Config\AutoClearLt    ,*Config\ConfigPath)
		INIValue::Set_Value("SETTINGS","DontAskMe"      ,*Config\DontAskMe      ,*Config\ConfigPath)
		INIValue::Set_Value("SETTINGS","ClipBoard"      ,*Config\CHDbClipBoard  ,*Config\ConfigPath)
		INIValue::Set_Value("SETTINGS","CHDSticky"      ,*Config\CHDbSticky     ,*Config\ConfigPath)        
		INIValue::Set_Value("SETTINGS","CreateSHA1"     ,*Config\CreateSHA1     ,*Config\ConfigPath)    
		INIValue::Set_Value("SETTINGS","PinDirectory"   ,*Config\PinDirectory   ,*Config\ConfigPath)  
		
		INIValue::Set_Value("SETTINGS","ForceEXEAsRAR"  ,*Config\HandleExeAsRAR ,*Config\ConfigPath)
		INIValue::Set_Value("SETTINGS","ForceEXEAsZIP"  ,*Config\HandleExeAsZIP ,*Config\ConfigPath)
		INIValue::Set_Value("SETTINGS","ForceEXEAsS7Z"  ,*Config\HandleExeAsS7Z ,*Config\ConfigPath)  
		INIValue::Set_Value("SETTINGS","DeleteTempDir"  ,*Config\ConvertDelTemp ,*Config\ConfigPath)  
		INIValue::Set_Value("SETTINGS","MoveArchive"    ,*Config\MoveZIProblems ,*Config\ConfigPath)          
		INIValue::Set_Value("SETTINGS","UnpackOnly"     ,*Config\UnPackOnly	  ,*Config\ConfigPath)  
		
		INIValue::Set_Value("SETTINGS","UnpackInSubDirectory" , *Config\UnpackInSubDirectory , *Config\ConfigPath)
		;
		; Button Info
		If ( *Config\UnPackOnly = #True )
			ButtonEX::Settext(DC::#Button_002,0,"Unpack")
		Else
			ButtonEX::Settext(DC::#Button_002,0,"Convert")
		EndIf
		
	EndProcedure	
	
	;
	;
	;
	Procedure.l Get_AboutMessage_TextHeight(TextGadgetID)
		Protected.s szText
		Protected.i cLF, FontHeight
		
		hDC = GetDC_(GadgetID(TextGadgetID)) 
		
		hFont = SendMessage_(GadgetID(TextGadgetID),#WM_GETFONT,0,0)
		
		If hFont And hDC 
			SelectObject_(hDC,hFont) 
		EndIf 
		
		GetTextExtentPoint32_(hDC, GetGadgetText(TextGadgetID), Len(GetGadgetText(TextGadgetID)) , lpSize.SIZE)
		
		FontHeight = lpSize\cy
		
		szText = GetGadgetText(TextGadgetID)
		cLF    = CountString(szText,#LF$) + 2
		;
		;
		; Font Höhe * Zeilenvorschub
		result = FontHeight * cLF
		
		ProcedureReturn result
	EndProcedure	
	;
	;
	;
	;
	; Drop7z Message Text
	;
	Procedure.s AboutMessage()
		Protected.s szString
		szString=""
		szString + "$" + CFG::*Config\Version
		szString + #LF$ +  ""		
		szString + #LF$ + "Code : Marty Shepard"       
		szString + #LF$ + "Icon : Rob2Seven (RIP)"
		szString + #LF$ + "UnLZX: Help from Infratec"         
		szString + #LF$ + ""
		szString + #LF$ + "Drop.7z is a Desktop Dragn'n'Drop Util "
		szString + #LF$ + " Addon for 7z (Seven Zip) to quickly   "
		szString + #LF$ + "      Compress Files and Folders       "
		szString + #LF$ + "  or Convert to 7z or simple Unpack    "
		szString + #LF$ + ""              
		szString + #LF$ + "Changelog:                             "
		szString + #LF$ + "======================================="
		szString + #LF$ + "Version 1.02.04 Beta                   "        
		szString + #LF$ + ""
		szString + #LF$ + "- Add Missing Convertet Amiga Fonts"
		szString + #LF$ + "  : Fixplain7"
		szString + #LF$ + "  : Pl_Apple"
		szString + #LF$ + "  : XbookBook"		
		szString + #LF$ + "  and additional Font Memory Resource"
		szString + #LF$ + "- Message Box Extend Hook Fix"
		szString + #LF$ + "- Minor Fixes"
		szString + #LF$ + ""   		
		szString + #LF$ + "---------------------------------------" 
		szString + #LF$ + "Version 1.02.03 Beta                   "        
		szString + #LF$ + ""
		szString + #LF$ + "About Design Changes & Code"
		szString + #LF$ + "Show working RAR Volume Number"
		szString + #LF$ + "Progress Count Files in Convert/Unpack"
		szString + #LF$ + ""   		
		szString + #LF$ + "---------------------------------------" 
		szString + #LF$ + "Version 1.02.02 Beta                   "        
		szString + #LF$ + ""
		szString + #LF$ + "Popup Menu Changes"
		szString + #LF$ + "About Changes" 
		szString + #LF$ + "Ini Location changed"
		szString + #LF$ + "Unrar location changed"
		szString + #LF$ + "Crash Fix... i hope this was the last"        
		szString + #LF$ + "Bug fix Password in Mass Packin' "
		szString + #LF$ + "Profile Routine Changes... not yet fin"  
		szString + #LF$ + ""          
		szString + #LF$ + "---------------------------------------" 
		szString + #LF$ + "Version 1.02.00 Beta                   "        
		szString + #LF$ + ""
		szString + #LF$ + "Many BugFixes"
		szString + #LF$ + "Many Design Fixes"
		szString + #LF$ + "Added Convert/ Unpack"
		szString + #LF$ + "Added LZX, ZIP, RAR etc.to Unpack/Conv."
		szString + #LF$ + "Added Exe Identication for SelfExtract"
		szString + #LF$ + "Design Changes"
		szString + #LF$ + "etc .... "
		szString + #LF$ + ""        
		szString + #LF$ + "---------------------------------------"  
		szString + #LF$ + "Version 0.99.95 Beta			   "
		szString + #LF$ + "- Added ISO for CHD Compress           "
		szString + #LF$ + "- Fixed Memory Thread Error by Count   "        
		szString + #LF$ + "---------------------------------------"         
		szString + #LF$ + "Version 0.99.94 Beta                   "
		szString + #LF$ + "- Rewritten Compress Mode (Full)       "
		szString + #LF$ + "- Rewritten Compress Mode (Single)     "        
		szString + #LF$ + "- Optic Changes                        "
		szString + #LF$ + "- Fixed Auto Complete History          "        
		szString + #LF$ + "- Fixed and Optimzed old Codes         "
		szString + #LF$ + "---------------------------------------" 
		szString + #LF$ + ""                
		szString + #LF$ + "Version 0.99.93 Beta                   "
		szString + #LF$ + "- Various Code Changes                 "
		szString + #LF$ + "- About Optics Changed                 "
		szString + #LF$ + "- Fixed Auto Complete History          "
		szString + #LF$ + "- Add Support for M.A.M.E CHDMan       "        
		szString + #LF$ + "---------------------------------------" 
		szString + #LF$ + ""        
		szString + #LF$ + "Version 0.99.92 Beta                   "
		szString + #LF$ + "- Fixed Clearing AutoComplete History  "
		szString + #LF$ + "- Replace DialogRequester              "
		szString + #LF$ + "- Removed Grammatical Erros            "
		szString + #LF$ + "- Fixed old Registry Code              "
		szString + #LF$ + "- Change Button Font                   "
		szString + #LF$ + "- Add Zip Support (Look PopupMenu)     "
		szString + #LF$ + "- Add Zip Options by 7-Zip             "        
		szString + #LF$ + "---------------------------------------"
		szString + #LF$ + ""
		szString + #LF$ + "Version 0.99.8 Quick Fix Beta          "
		szString + #LF$ + "- Broken Autostart with Loading Drop7z "
		szString + #LF$ + " and Profile ini loading Fixed         "
		szString + #LF$ + "---------------------------------------"
		szString + #LF$ + ""
		szString + #LF$ + "Version 0.99.8 Beta                    " 
		szString + #LF$ + "- Small Design and Gui Handle Changes  "
		szString + #LF$ + "  on Combox (Main -and Profile Window) "
		szString + #LF$ + "- Fixed a small bug in Password that   "
		szString + #LF$ + "  does'nt show in the Profile Window   " 
		szString + #LF$ + "  if there Exists but not check marked "
		szString + #LF$ + "  in the Main Window                   "                 
		szString + #LF$ + "- Changed Handle for Profile Ini and   "
		szString + #LF$ + "  Config ini                           "                
		szString + #LF$ + "---------------------------------------"
		szString + #LF$ + ""
		szString + #LF$ + "Version 0.99.7 Beta                    "                 
		szString + #LF$ + "- PB Version Update 5.21 => 5.30       "
		szString + #LF$ + "  DropSevenZip Compiled with 5.30      "
		szString + #LF$ + "- Fixed a small bug in Autostart       "
		szString + #LF$ + "- Added an Excpetion Requester Path =1 " 
		szString + #LF$ + "- Exchanged Destination String with    "
		szString + #LF$ + "  with Combox and AutoComplete History "                  
		szString + #LF$ + "---------------------------------------"
		szString + #LF$ + ""
		szString + #LF$ + "Version 0.99.6 Beta                    "                 
		szString + #LF$ + "- Added 7zSFX Support (SelfExtract)    "              
		szString + #LF$ + "---------------------------------------"
		szString + #LF$ + ""
		szString + #LF$ + "Version 0.99.5 Beta                    "                 
		szString + #LF$ + "- Fixed Destination Path in Single Mode"           
		szString + #LF$ + "---------------------------------------"
		szString + #LF$ + ""
		szString + #LF$ + "Version 0.99.4 Beta                    "                 
		szString + #LF$ + "- Fixed 'Stay On Top' if Open from     "
		szString + #LF$ + "  Tray IconMenu                        "               
		szString + #LF$ + "- Added SendMail                       "
		szString + #LF$ + "- Added new Style Requester (Testing)  " 
		szString + #LF$ + "- Few Small bug fixed                  "
		szString + #LF$ + "- Fixed SingleMode Full Compress       "
		szString + #LF$ + "- Added Send Mail and Hompage Button   "              
		szString + #LF$ + "---------------------------------------"
		szString + #LF$ + ""
		szString + #LF$ + "Version 0.99.3 Beta                    "                 
		szString + #LF$ + "- Fixed Delete Directorys in Single    "               
		szString + #LF$ + "  Mode                                 "
		szString + #LF$ + "- Extended Requester Message if an     " 
		szString + #LF$ + "  Error occured due Delete Files       "
		szString + #LF$ + "- Fixed: a Marked State in the FileList"
		szString + #LF$ + "- Fixed: Catched Abort ExitCode by 7z  "
		szString + #LF$ + "- Optimze DropSevenZip Memory          "  
		szString + #LF$ + "---------------------------------------"
		szString + #LF$ + ""
		szString + #LF$ + "Version 0.99.2 Beta                    " 
		szString + #LF$ + "- Small Bug's Fixed in the  Profile    "               
		szString + #LF$ + "  Editor                               "
		szString + #LF$ + "- Added 'Single Instance' Option       " 
		szString + #LF$ + "- Added 'Don't AskMe' Option for       "
		szString + #LF$ + "  Delete Files                         "
		szString + #LF$ + "- State Fix in the Password Checkbox   "                  
		szString + #LF$ + "---------------------------------------"                
		szString + #LF$ + ""
		szString + #LF$ + "Version 0.99.1 Beta                    " 
		szString + #LF$ + "- Fixed Bug in Delete Files            "
		szString + #LF$ + "  (Allcoate Memory was to small.)      "
		szString + #LF$ + "- State Fix for Size/Items not Disable "
		szString + #LF$ + "- Clear File List doesnt Reset the     "
		szString + #LF$ + "  Password.                            "
		szString + #LF$ + "---------------------------------------"                
		szString + #LF$ + ""
		szString + #LF$ + "Version 0.99.0 Beta                    " 
		szString + #LF$ + "- Many Design Changes                  "
		szString + #LF$ + "- FileList Changes                     "
		szString + #LF$ + "- Add Rename to the Profile Editor     "
		szString + #LF$ + "---------------------------------------"
		szString + #LF$ + ""
		szString + #LF$ + "Version 0.98.8 Alpha                   "
		szString + #LF$ + "- Extended File Lister, Added Size     "
		szString + #LF$ + "- Changed Calculate Function           "
		szString + #LF$ + "- Changed Delete Files in Combination  "
		szString + #LF$ + "  with Compress all Single Files. 7z   "
		szString + #LF$ + "  Interleaved Archive does'nt Delete   "
		szString + #LF$ + "  Use on your own Risk. It's Beta      "
		szString + #LF$ + "- Added 'Auto Clear File List' in the  "
		szString + #LF$ + "  Tray icon and File Lister Popupmenu. "
		szString + #LF$ + "  If not enabled You can Drag'n'drop   "
		szString + #LF$ + "  from Various HD Locations."                
		szString + #LF$ + "---------------------------------------"                 
		szString + #LF$ + ""
		szString + #LF$ + "Version 0.98.7 Alpha                   "
		szString + #LF$ + "- Change: Option Splittet, Start With  "
		szString + #LF$ + "  Windows and Minimized                "
		szString + #LF$ + "- Request: Added Window Stay On Top on "
		szString + #LF$ + "  The Tray Icon Menu                   "
		szString + #LF$ + "- Added: Delete Files after Compressing"
		szString + #LF$ + "  Use on your own Risk. It's Beta      "
		szString + #LF$ + "---------------------------------------" 
		szString + #LF$ + ""
		szString + #LF$ + "Version 0.98.6 Alpha                   "
		szString + #LF$ + "- Fixed: Filehandling Issue in         "
		szString + #LF$ + "  Combination with Directory's /Suffix " 
		szString + #LF$ + "- Fixed: Start with Windows State Fix  " 
		szString + #LF$ + "---------------------------------------"                 
		szString + #LF$ + ""
		szString + #LF$ + "Version 0.98.4 Alpha                   "
		szString + #LF$ + "- Added: Reload/Refresh Button on the  "
		szString + #LF$ + "  Profiles Window                      " 
		szString + #LF$ + "- Fixed: Missing Refresh State on      " 
		szString + #LF$ + "  Program Start" 
		szString + #LF$ + "---------------------------------------"                
		szString + #LF$ + ""
		szString + #LF$ + "Version 0.98.3 Alpha                   "
		szString + #LF$ + "- Fixed: NoSPlit/SplitMode on Profile  "
		szString + #LF$ + "  Window. Corrected Filename.          " 
		szString + #LF$ + "- Fixed: Element 'Open File' and 'Size "
		szString + #LF$ + "  View'. Corrected State Disable/Enable" 
		szString + #LF$ + "- Few Font Changes!                    "
		szString + #LF$ + "- Fixed: Small Bug on Password State   "                 
		szString + #LF$ + "---------------------------------------" 
		szString + #LF$ + ""
		szString + #LF$ + "Version 0.98.2 Alpha                   "
		szString + #LF$ + "- Change: Small Layout Changes         " 
		szString + #LF$ + "- Added : Checkbox for -ssw            " 
		szString + #LF$ + "- Change: On The Profile Window        "                   
		szString + #LF$ + "---------------------------------------" 
		szString + #LF$ + ""
		szString + #LF$ + "Version 0.98.1 Alpha                   "
		szString + #LF$ + "- Change: Detail/Design in the Profile " 
		szString + #LF$ + "  Window" 
		szString + #LF$ + "- Added : 7z -ssw Command-Line Switsh  " 
		szString + #LF$ + "- Added : 7z Default Compression-Types " 
		szString + #LF$ + "- Fixed : Profile Window, Stay On Top  " 
		szString + #LF$ + "  Handle" 
		szString + #LF$ + "---------------------------------------"                 
		szString + #LF$ + ""
		szString + #LF$ + "Version 0.97.1 Alpha                   "
		szString + #LF$ + "- Added : User Option for SplitSize for" 
		szString + #LF$ + "  Multi-Volumes Archives               " 
		szString + #LF$ + "- Fixed : Window Handle if Running 7z  " 
		szString + #LF$ + "- Added : Profile Settings. Save/Store " 
		szString + #LF$ + "  your Individual Settings" 
		szString + #LF$ + "---------------------------------------"
		szString + #LF$ + ""
		szString + #LF$ + "Version 0.97 Useless                   "
		szString + #LF$ + "- Change: Design and Layout            " 
		szString + #LF$ + "- Added : PopupMenu to Filelist Window "  
		szString + #LF$ + "- Request: Option, 150MB Split Archiv  " 
		szString + #LF$ + "- Added : Progress Indicator for       " 
		szString + #LF$ + "  Compress Single Files                " 
		szString + #LF$ + "- Handle Change if Running 7z          " 
		szString + #LF$ + "---------------------------------------" 
		szString + #LF$ + ""
		szString + #LF$ + "Version 0.96 Useless                   "
		szString + #LF$ + "- Design and Layout Changes            " 
		szString + #LF$ + "- Added Option to Split Archives       " 
		szString + #LF$ + "- Add Missing ToolTip for Destination. " 
		szString + #LF$ + "- Add Calculate the Size for Dir/Files " 
		szString + #LF$ + "---------------------------------------"                
		szString + #LF$ + ""
		szString + #LF$ + "Version 0.95 Useless                   "
		szString + #LF$ + "- *First Public Beta Release           " 
		szString + #LF$ + "***************************************" 
		szString + #LF$ + ""
		szString + #LF$ + ""
		szString + #LF$ + "This software is provided as-is,without"
		szString + #LF$ + "any express OR implied warranty. In no "
		szString + #LF$ + "event  will the authors be held liable "
		szString + #LF$ + "For any  damages  arising from the use "
		szString + #LF$ + "ofthis software."
		szString + #LF$ + ""
		szString + #LF$ + "Permission is granted to anyone to use "
		szString + #LF$ + "this software for any purpose,including"
		szString + #LF$ + "commercial applications, and to alter  "
		szString + #LF$ + "it and redistribute it freely subject to"
		szString + #LF$ + "the following restrictions:            "
		szString + #LF$ + ""
		szString + #LF$ + "1. The origin of this software must not"
		szString + #LF$ + "be misrepresented; you must not claim  "
		szString + #LF$ + "original Software.If you use this      "
		szString + #LF$ + "software  IN  a product,anacknowledgment"
		szString + #LF$ + "IN the product documentation would be  "
		szString + #LF$ + "appreciated but is Not required.       "
		szString + #LF$ + ""
		szString + #LF$ + "2. Altered source versions must be     "
		szString + #LF$ + "plainly marked as such,and must not be "
		szString + #LF$ + "misrepresented as being the original   "
		szString + #LF$ + "software."
		szString + #LF$ + ""
		szString + #LF$ + "3. This notice may Not be removed Or   "   
		szString + #LF$ + "altered from any source distribution.  "
		szString + #LF$ + ""
		szString + #LF$ + "4. This software uses Not part of source"
		szString + #LF$ + "code of 7z.7zip is subject To the rules"
		szString + #LF$ + "of the GNU LGPL + unRAR restriction.   "
		szString + #LF$ + "The copyright is owned by Igor Pavlov  "
		szString + #LF$ + "And Alexander Roshal (unRAR)."
		szString + #LF$ + ""
		szString + #LF$ + "This software is intended only As Drag "
		szString + #LF$ + "and Drop frontend for 7z. Do You have  " 
		szString + #LF$ + "Problems With this software? Mail me   "
		szString + #LF$ + ""
		szString + #LF$ + "FF? ... Fast Fertig ..................."        
		ProcedureReturn szString
	EndProcedure	
EndModule
; IDE Options = PureBasic 5.73 LTS (Windows - x64)
; CursorPosition = 369
; FirstLine = 292
; Folding = f0
; EnableAsm
; EnableXP
; UseMainFile = ..\Drop7z.pb
; CurrentDirectory = ..\Drop7z\
; EnableUnicode