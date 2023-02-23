;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
Procedure _Action_SingleFullPack(t)
    
    
    Select CFG::*Config\usFormat
        Case 0: PackFormat$ = "7z"
        Case 1: PackFormat$ = "zip"
    EndSelect  
    
    SetGadgetState(DC::#Progress_001, 0)
    
    SetGadgetState(DC::#ComboBox_004,0) 
    iPacket$    = "" :Encrypt$   = "" :iDestPath$  = "" :iDesktop$   = "" :iOpenFiles$ = ""
    
    iMax  = CountGadgetItems(DC::#ListIcon_001)
    If iMax <> 0 
        SetWindowTitle(DC::#_Window_001, DropLang::GetUIText(1) )
      
        _Disable_Enable_Gadets(1)
        i7Z_Execute$ = _Get7z_Locations()
        iPacket$     = GetGadgetText(DC::#String_001)
        
        iDestPath$   = GetGadgetText(DC::#String_002)
        If Len(iDestPath$) = 1
            
            sLANGUAGE = Windows::Get_Language() 
        
            Request0$ = "Now Look What You've Done" 
            Request1$ = "Missing Directory!"                 
            Select sLANGUAGE
                Case 407              
                Request2$ = #LF$+"Verzeichnis nicht gefunden:"+#LF$+"'"+iDestPath$+"'"      
                Default
                Request2$ =  #LF$+"Missing Directory"+#LF$+"'"+iDestPath$+"' ..Not Found!"   
            EndSelect
            ;iResult = RequestEX::MSG(Request0$, Request1$, Request2$,1,0,"",1,ProgramFilename())
            iResult = Request::MSG(Request0$, Request1$  ,Request2$,1,0,ProgramFilename())
            _Disable_Enable_Gadets(0)
            SetWindowTitle(DC::#_Window_001,CFG::*Config\WindowTitle.s)
            ProcedureReturn           
        EndIf
        
        iDestPath$   = ReverseString(iDestPath$)
        iPos = FindString(iDestPath$,"\",1)
        If Not iPos =  1
            iDestPath$   = ReverseString(iDestPath$)
            iDestPath$   = iDestPath$+"\"
            SetGadgetText(DC::#String_002,iDestPath$)
        Else
            iDestPath$   = ReverseString(iDestPath$)
        EndIf
        
        iDrive = _GetDriveType(iDestPath$,2)
        If iDrive = 1
            sLANGUAGE = Windows::Get_Language() 
        
            Request0$ = "Now Look What You've Done" 
            Request1$ =  "Can't create Archive! on Drive: "+iDestPath$                
            Select sLANGUAGE
                Case 407              
                Request2$ = #LF$+"Kann keine Archive auf CD/DVD's erstellen."+#LF$+#LF$+"Bitte anderes Zielverzeichnis mit '..\' wählen."    
                Default
                Request2$ = #LF$+"Can't create archiv on CD/DVD. Please select another destination path." 
            EndSelect
            ;iResult = RequestEX::MSG(Request0$, Request1$, Request2$,1,0,"",1,ProgramFilename()) 
            iResult = Request::MSG(Request0$, Request1$  ,Request2$,1,0,ProgramFilename())
            SetWindowTitle(DC::#_Window_001,CFG::*Config\WindowTitle.s)
            _Disable_Enable_Gadets(0)
            ProcedureReturn
        EndIf
        
          ;/////////////////////////////////////////////////////////////////////////////////////////////////
          ; Check Suffix
            sSuffix$ = GetExtensionPart(iDestPath$+iPacket$)
            If LCase(sSuffix$) = "7z" Or LCase(sSuffix$) = "001" Or LCase(sSuffix$) = "exe" Or LCase(sSuffix$) = "zip" 
                iFullPath$   = Chr(34)+""+iDestPath$+iPacket$+""+Chr(34)
            Else 
                If GetGadgetState(DC::#CheckBox_005) = 0
                    SetGadgetText(DC::#String_001,iPacket$+".7z"):SetGadgetText(DC::#String_005,iPacket$+".7z")
                    iPacket$ = iPacket$+".7z"
                EndIf
                If GetGadgetState(DC::#CheckBox_005) = 1
                    SetGadgetText(DC::#String_001,iPacket$+".exe"):SetGadgetText(DC::#String_005,iPacket$+".exe")
                    iPacket$ = iPacket$+".exe"
                EndIf  
                If GetGadgetState(DC::#CheckBox_005) = 0
                    SetGadgetText(DC::#String_001,iPacket$+".zip"):SetGadgetText(DC::#String_005,iPacket$+".zip")
                    iPacket$ = iPacket$+".zip"
                EndIf                
                iFullPath$   = Chr(34)+""+iDestPath$+iPacket$+Chr(34)
                    
            EndIf        
        
        iExists = FileSize(iDestPath$+iPacket$)
        If  nSizeSplit <> 0
            iSplit$ = GetFilePart(iDestPath$+iPacket$)
            iSplit$ = LCase(ReplaceString(iSplit$,"."+PackFormat$+".001","."+PackFormat$))
            Volume_Check_iExists = FileSize(iDestPath$+iSplit$)
            If Volume_Check_iExists <> -1
                sLANGUAGE = Windows::Get_Language() 
                
                Request0$ = "Now Look What You've Done" 
                Request1$ =  "Can't create a Multivolume Archiv!"             
                Select sLANGUAGE
                    Case 407              
                        Request2$ = #LF$+"Kann kein Multivolume Archiv (.001) erstellen weil ein " +PackFormat$+ "Archiv im Verzeichnis: '"+iDestPath$+"' existiert."
                    Default
                        Request2$ = #LF$+"Try to create a Multivolume .001 Archiv but a Normal "+PackFormat$+" exists IN Directory: "+iDestPath$+#LF$+"Use a other Name."
                EndSelect
                ;iResult = RequestEX::MSG(Request0$, Request1$, Request2$,1,0,"",1,ProgramFilename())   
                iResult = Request::MSG(Request0$, Request1$  ,Request2$,1,0,ProgramFilename())
                 _Disable_Enable_Gadets(0)
                 SetWindowTitle(DC::#_Window_001,CFG::*Config\WindowTitle.s)
                ProcedureReturn
            EndIf
        EndIf
        
        If GetGadgetState(DC::#CheckBox_001) = 1
            iDesktop$    = GetGadgetText(DC::#String_003)
        EndIf            
        
        ;//////////////////////////////////////////////////////////////// 
        If Len(iDesktop$) <> 0 :iDesktop$ = " -p"+iDesktop$ :EndIf      
        iState = GetGadgetState(DC::#CheckBox_001)
        If (iState = 1 )
            Select CFG::*Config\usFormat
                Case 0: iEncrypt$ = " -mhc=on -mhe=on"
                Case 1: iEncrypt$ = " -mem=3"
            EndSelect        
        EndIf
        
        If GetGadgetState(DC::#CheckBox_003) = 1
            iOpenFiles$    = " -ssw"
        EndIf         
        
        
        nSizeDict   = GetGadgetState(DC::#ComboBox_001)
        nSizeWord   = GetGadgetState(DC::#ComboBox_002)       
        nSizeBlock  = GetGadgetState(DC::#ComboBox_003)     
        nSizeMode  = GetGadgetState(DC::#ComboBox_005)  
        
        ;//////////////////////////////////////////////////////////////// BlockSize
        SelectElement(SizeDict(),nSizeDict)        
        If nSizeDict = 0
            iSizeDict$ = ":d"+Str(SizeDict()\iSize)+"b"
        Else
            iSizeDict$ = ":d"+Str(SizeDict()\iSize)+"m"            
        EndIf
                
        ;////////////////////////////////////////////////////////////////  WordSize     
        SelectElement(SizeWord(),nSizeWord)
        iSizeWord$ = ":fb"+Str(SizeWord()\iSize)
        
        If nSizeBlock <> 0
            If nSizeBlock = 19
                iSizeBlock$ = " -ms=on"
                
            ElseIf nSizeBlock = 21
                iSizeBlock$ = " -ms=off"
            Else
                SelectElement(SizeBlock(),nSizeBlock)
                If nSizeWord >=0 And nSizeWord <=9
                    iSizeBlock$ = " -ms="+Str(SizeBlock()\iSize)+"m"
                ElseIf nSizeWord >=10 And nSizeWord <=17
                    iSizeBlock$ = " -ms="+Str(SizeBlock()\iSize)+"g"
                EndIf
            EndIf
        EndIf
        
        ;////////////////////////////////////////////////////////////////
        SelectElement(Compression(),nSizeMode)
        If nSizeMode <> 0
            Select CFG::*Config\usFormat
                Case 0: iCompressMode$ = " -mmt=on -m0=LZMA2" + iSizeDict$ + iSizeWord$ + iSizeBlock$ + iSizeSplit$ + " -mx"+Str(Compression()\iLevel)
                Case 1:
                    ; Zip and MethodID
                    Protected MethodID$
                    Select CFG::*Config\ZipMethodID
                        Case 0: MethodID$ = "Deflate"
                        Case 1: MethodID$ = "Deflate64"
                        Case 2: MethodID$ = "BZip2"
                        Case 3: MethodID$ = "LZMA"
                        Case 4: MethodID$ = "PPMD"
                    EndSelect
                            
                    iCompressMode$ = " -mm="+MethodID$+" -mmt=on -mtc=on -mx"+Str(Compression()\iLevel) + iSizeSplit$
                    ; + 
            EndSelect  

        Else
            iCompressMode$ = " -mmt=on -mx"+Str(Compression()\iLevel)
        EndIf       
       
    TmpPath.s = Space (1000) 
    GetTempPath_(1000,@TmpPath)
    
    iDeltFileist$ = TmpPath+Str(Random(100000))+".txt"
    CreateFile(DC::#_DefaultFile,iDeltFileist$)
    
    iMarked = 0
    iMax  = CountGadgetItems(DC::#ListIcon_001)
    For x = 0 To iMax
           iMarkState = GetGadgetItemState(DC::#ListIcon_001, x)
           If  iMarkState = 3 Or iMarkState = 2
               iMarked = iMarked+1
           EndIf 
    Next  
    
    SetGadgetAttribute(DC::#Progress_001, #PB_ProgressBar_Minimum, 0)
    SetGadgetAttribute(DC::#Progress_001, #PB_ProgressBar_Maximum, iMax)    
    If iMarked >= 1
        SetGadgetAttribute(DC::#Progress_001, #PB_ProgressBar_Maximum, iMarked)
        Debug iMarked
    EndIf
    
    
        For x = 0 To iMax
        
            Path$ = GetGadgetItemText(DC::#ListIcon_001,x,0)              
            File$ = GetGadgetItemText(DC::#ListIcon_001,x,1)
            Care$ = GetGadgetItemText(DC::#ListIcon_001,x,1)
            If Len(Path$) <> 0 
                      
                iDestFileist$ = TmpPath+Str(Random(100000))+".txt"

                CreateFile(DC::#_TempFile,iDestFileist$)
                AllsOK=1:Show7z=0:FMarked=0
                
                If iMarked = 0
                    Debug "All Files"
                    If Len(File$) = 0
                        If FileSize(Path$) <> -2
                            MessageRequester("Now Look, what you've  done!","Missing Directory"+#LF$+
                                                                            "'"+Path$+"' ..Not Found!")
                            SetGadgetState(DC::#Progress_001, x+1)  
                            AllsOK=0
                        Else
                            WriteStringN(DC::#_TempFile, Path$)
                            WriteStringN(DC::#_DefaultFile, Path$)                     
                            File$ = _SetDestination_String(Path$) ;:Debug "File :" +File$
                            Show7z=1:AllsOK=1
                        EndIf
                    Else
                        If FileSize(Path$+File$) = -1
                            MessageRequester("Now Look, what you've  done!","Missing File '"+#LF$+"'"+Path$+File$+"' ..Not Found!")
                            SetGadgetState(DC::#Progress_001, x+1)  
                            AllsOK=0
                        Else
                            WriteStringN(DC::#_DefaultFile, Path$+File$)                       
                            WriteStringN(DC::#_TempFile, Path$+File$)
                            Show7z=0:AllsOK=1
                        EndIf
                    EndIf
                    
                ElseIf iMarked >=1
                    Debug "Single Full Compress: Packing "+iMarked
                    FMarked = FMarked+1
                    
                    If Len(File$) = 0
                        If FileSize(Path$) <> -2
                            MessageRequester("Now Look, what you've  done!","Missing Directory"+#LF$+
                                                                            "'"+Path$+"' ..Not Found!")
                            
                            SetGadgetState(DC::#Progress_001, FMarked+1)  
                            AllsOK=0
                        Else
                            iMarkState = GetGadgetItemState(DC::#ListIcon_001, x)
                            If  iMarkState = 3 Or iMarkState = 2
                                WriteStringN(DC::#_TempFile, Path$)
                                WriteStringN(DC::#_DefaultFile, Path$)                     
                                File$ = _SetDestination_String(Path$) :Debug "File :" +File$
                            EndIf
                            Show7z=1:AllsOK=1
                        EndIf
                    Else
                        If FileSize(Path$+File$) = -1
                            MessageRequester("Now Look, what you've  done!","Missing File '"+#LF$+"'"+Path$+File$+"' ..Not Found!")
                            SetGadgetState(DC::#Progress_001, FMarked+1)  
                            AllsOK=0
                        Else
                            iMarkState = GetGadgetItemState(DC::#ListIcon_001, x)
                            If  iMarkState = 3 Or iMarkState = 2                      
                                WriteStringN(DC::#_DefaultFile, Path$+File$)                       
                                WriteStringN(DC::#_TempFile, Path$+File$) :Debug "File :" +Path$+File$
                            EndIf
                            Show7z=0:AllsOK=1
                        EndIf
                    EndIf                 
                EndIf
                
                CloseFile(DC::#_TempFile)
                
                If AllsOK=1
                    Delay(70)
                    If Len(Care$) = 0
                        FileExName$ = GetFilePart(Path$+File$)
                    Else
                        FileExName$ = GetFilePart(Path$+File$,#PB_FileSystem_NoExtension)
                    EndIf
                    
                    If GetGadgetState(DC::#CheckBox_005) = 0
                        iFullPath$   = Chr(34)+""+iDestPath$+FileExName$+"."+PackFormat$+""+Chr(34)
                    EndIf
                     If GetGadgetState(DC::#CheckBox_005) = 1
                        iFullPath$   = Chr(34)+""+iDestPath$+FileExName$+".exe"+""+Chr(34)
                    EndIf                   
            
                    SetGadgetState(DC::#Progress_001, x+1)         
                    SetGadgetText(DC::#String_001,"Compress: "+GetFilePart(File$,#PB_FileSystem_NoExtension))
                    SetGadgetText(DC::#String_005,"Compress: "+GetFilePart(File$,#PB_FileSystem_NoExtension))
                    
                    iSfxExe$ = ""
                    iState = GetGadgetState(DC::#CheckBox_005)
                    If ( iState = 1 )
                        Select CFG::*Config\usFormat
                                Case 0
                                    iSfxExe$ = "-sfx7z.sfx "
                                Case 1
                                    ; Keine Selbstentpackende ZIP Archive bei 7Zip
                        EndSelect
                    EndIf                    
                    Commandline$ = " a "+iSfxExe$ + iFullPath$+ iCompressMode$ + iEncrypt$ + iDesktop$ +" -ssw @"+iDestFileist$                
                    If Show7z = 0
                        iProcess = RunProgram(i7Z_Execute$,Commandline$,iDestPath$,#PB_Program_Open|#PB_Program_Hide)
                    Else
                        iProcess = RunProgram(i7Z_Execute$,Commandline$,iDestPath$,#PB_Program_Open)
                    EndIf
                    
                    GetExitCodeProcess_(iProcess, @exitCode);:Debug "Exitcode: " + Str(exitCode) 
                    Debug "SingeMode Compress: "+exitCode
                    Select exitCode
                        Case 255,2
                           SetWindowTitle(DC::#_Window_001,CFG::*Config\WindowTitle.s)
                           _Disable_Enable_Gadets(0): ProcedureReturn
                       Default
                    EndSelect
                    Repeat
                        Delay(1)
                        
                    Until ProgramRunning(iProcess)=0 
                    
                    Select exitCode
                        Case 0
                            Quersumme::Create_SHA1_File(iFullPath$,iSizeSplit$) 
                        Default
                    EndSelect
                    
                EndIf
                If x=iMax: Break :EndIf
            EndIf
        Next x
    
    If OpenFile(DC::#_DefaultFile,iDeltFileist$)
        CloseFile(DC::#_DefaultFile)
    EndIf
    
    SetGadgetText(DC::#String_001,iPacket$):SetGadgetText(DC::#String_005,iPacket$)
    Delay(1000)
    If GetGadgetState(DC::#CheckBox_002) = 1
       Path$ = GetGadgetItemText(DC::#ListIcon_001,0,0)   
       If Len(Path$) <> 0
           If GetGadgetState(DC::#CheckBox_005) = 0
               Commandline$ = " t " + "-an -ai!*."+PackFormat$ + " -r"+iDesktop$
           EndIf
           If GetGadgetState(DC::#CheckBox_005) = 1
               Commandline$ = " t " + "-an -ai!*.exe" + " -r"+iDesktop$
           EndIf           
           SetWindowTitle(DC::#_Window_001, DropLang::GetUIText(2) )
           iProcess = RunProgram(i7Z_Execute$,Commandline$,iDestPath$,#PB_Program_Open)
           GetExitCodeProcess_(hProcess, @exitCode);:Debug "Exitcode: " + Str(exitCode)

                If exitCode = 255
                    SetWindowTitle(DC::#_Window_001,CFG::*Config\WindowTitle.s)
                    _Disable_Enable_Gadets(0)
                    ProcedureReturn
                EndIf  
           Repeat :Delay(1) :Until ProgramRunning(iProcess)=0   
       EndIf            
   EndIf
   
  
   
   _Actio_DeleteFiles(iFullPath$,iDeltFileist$,2)
   DeleteFile(iDeltFileist$)
   _SendMailArchive(iFullPath$)
    
   iMax  = CountGadgetItems(DC::#ListIcon_001)
   iMarked = 0
    For x = 0 To iMax
        iMarkState = GetGadgetItemState(DC::#ListIcon_001, x)
        If  iMarkState = 2
            SetGadgetItemState(DC::#ListIcon_001,x,0|2)                 
        EndIf 
    Next    
            
    SetWindowTitle(DC::#_Window_001,CFG::*Config\WindowTitle.s+"")
    _Disable_Enable_Gadets(0)           
  EndIf
EndProcedure

; IDE Options = PureBasic 5.62 (Windows - x64)
; CursorPosition = 367
; FirstLine = 334
; Folding = -
; EnableAsm
; EnableXP
; UseMainFile = ..\Drop7z.pb
; CurrentDirectory = ..\Drop7z\
; EnableUnicode