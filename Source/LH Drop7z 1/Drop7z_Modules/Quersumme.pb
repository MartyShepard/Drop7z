DeclareModule Quersumme
    
    Declare Ceate(FileMode=0,FilePath$="",QuersummenFormat=0)
    Declare Create_SHA1_File(iFullPath$,iSizeSplit$) 
EndDeclareModule

Module Quersumme
    
    Structure SUM_STRUCTURE
        FilePath.s{1024}
        Format.i
        MultiMode.i
        MaxFiles.i
        CurrentIndex.i
    EndStructure    
    
    Structure FILE_NAME
        FileIndexID.l
        FileName.s
        Attributes.s
        DateCreated.s
        DateAccessed.s
        DateModified.s
    EndStructure            
    
    ;********************************************************************************************************************
    ;
    ;____________________________________________________________________________________________________________________
     Procedure Checksum_Thread(*Checksum.SUM_STRUCTURE)
            
         Debug "Erzeuge Checksumme: "+ *Checksum\FilePath

         Protected TextFile$, SUMFILE$, SUMSUME$, Max, CollectFile$, Size.i, Request0$, Request1$, Request2$
         
         Select *Checksum\MultiMode
             Case 0
                 TextFile$ = GetPathPart(*Checksum\FilePath)+GetFilePart(*Checksum\FilePath,#PB_FileSystem_NoExtension)
                 
             Case 1
                 ;
                 ; Alle Dateien in einer Checksum Datei sammeln
                 ;
                 TextFile$ = GetPathPart(*Checksum\FilePath)
                 Max = CountString(TextFile$,Chr(92))
                 
                 CollectFile$ = Mid(TextFile$,4,Len(TextFile$))
                 
                 Select Len(CollectFile$)
                     Case 0
                         TextFile$ = Left(TextFile$,3) + "ChecksumFiles-Root"
                     Default
                         TextFile$ = TextFile$ + ReplaceString(CollectFile$,Chr(92),"_",0,4,Max)
                 EndSelect            
                 
         EndSelect
             
             
         Select *Checksum\Format
             Case 0
                 TextFile$ = TextFile$ + ".sha"
                 SetGadgetText(DC::#Text_019,"Drop7z: Create CRC: SHA1 (File "+Str(*Checksum\CurrentIndex)+"/ "+Str(*Checksum\MaxFiles)+")")
             Case 1
                 TextFile$ = TextFile$ + ".md5"
             Case 2
                 TextFile$ = TextFile$ + ".crc"
         EndSelect
         ;
         ; Info Block
         SetGadgetText(DC::#String_001,"CRC: "+GetFilePart(TextFile$))              
         SetGadgetItemText(DC::#ListIcon_002, 0, GetFilePart(*Checksum\FilePath)) 
         SetGadgetItemText(DC::#ListIcon_002, 1, "CRC File: "+GetFilePart(TextFile$))          
         
         Select *Checksum\MultiMode
             Case 0
                 CreateFile(DC::#_TempFile,TextFile$)  
             Case 1                
                 Select *Checksum\CurrentIndex
                     Case 1
                         CreateFile(DC::#_TempFile,TextFile$)  
                     Default 
                 EndSelect
                 SetWindowTitle(DC::#_Window_001,"Erzeuge CRC: "+ Str(*Checksum\CurrentIndex) + " von "+Str(*Checksum\MaxFiles))  
                 Select *Checksum\MaxFiles
                     Case 1
                     Default    
                         SetGadgetState(DC::#Progress_001,*Checksum\CurrentIndex)
                  EndSelect
         EndSelect
         
         
         
         
         Select *Checksum\Format
             Case 0
                 ;
                 ;    SHA1                                 
                 SUMFILE$ = GetFilePart(*Checksum\FilePath)
                 SUMSUME$ = FileFingerprint(*Checksum\FilePath, #PB_Cipher_SHA1): Delay(100)
                 
                 If Not Len(SUMSUME$) = 40
                     Debug "FEHELR: "+*Checksum\FilePath +" Keine 40 Zeichen"
                 EndIf    
             Case 1
                 ;
                 ;    MD5                 
             Case 2 
                 ;
                 ;    CRC32
             Default
         EndSelect  
         
         Select *Checksum\MultiMode
             Case 0  
                 WriteString(DC::#_TempFile, SUMSUME$+" *"+SUMFILE$,#PB_Ascii)
             Case 1
                 WriteStringN(DC::#_TempFile, SUMSUME$+" *"+SUMFILE$,#PB_Ascii)
         EndSelect
         
         Select *Checksum\MultiMode
             Case 0         
                 CloseFile(DC::#_TempFile): Delay(5000)
                 
             Case 1
                 Select *Checksum\MaxFiles
                     Case *Checksum\CurrentIndex
                         CloseFile(DC::#_TempFile): Delay(5000)
                 EndSelect
           
         EndSelect
         ProcedureReturn
          
      EndProcedure
    ;********************************************************************************************************************
    ;
    ;
    ; Filemode
    ; 0 = Single Auswahl (Es öffnet sich ein Datei Reuqester oder übergabe eines File + Path)
    ; 
    ; QuersummenFormat
    ; 0 = sha1
    ;____________________________________________________________________________________________________________________       
    Procedure Ceate(FileMode=0,FilePath$="",QuersummenFormat=0)
        
        Protected DoCheckSum, FilePathSize = 0, Defaultfile$, Stringtext$, CountFiles.i, sLANGUAGE, Request0$, Request1$
                
        *Checksum.SUM_STRUCTURE       = AllocateMemory(SizeOf(SUM_STRUCTURE))
        
        Select FileMode
            Case 0 ; SHA1
                
                Select Len(FilePath$)
                    Case 0
                        
                        If Len(CFG::*Config\CRCLastPath) = 0
                            CFG::*Config\CRCLastPath = "C:\"
                        EndIf
                        
                        Defaultfile$ = FFH::GetFilePBRQ("Select File",CFG::*Config\CRCLastPath, #False,"Alle Dateien (*.*)|*.*;",0,#True)                        
  
                        FilePathSize = FileSize(Defaultfile$)
                    Default                        
                EndSelect
            Default
        EndSelect
        
        
        Select  FilePathSize
            Case 0
            Case -1
            Case -2
            Default
                
                GUI04::ConsoleWindow()
                SetWindowTitle(DC::#_Window_001,"Erzeuge CRC") :Stringtext$ = GetGadgetText(DC::#String_001)  
                
                AddGadgetItem(DC::#ListIcon_002,-1,"")
                AddGadgetItem(DC::#ListIcon_002,-1,"")
                
                SendMessage_(GadgetID(DC::#ListIcon_002),#LVM_SETIMAGELIST,#LVSIL_SMALL,ImageList_Create_(1,17,#ILC_COLORDDB,0,0))
                HideWindow(DC::#_Window_004,0): SetForegroundWindow_(WindowID(DC::#_Window_004))
                StickyWindow(DC::#_Window_004,1)
                
                SetGadgetText(DC::#Text_019,"Drop7z: Create CRC")
                                
                NewList FullFileSource.FILE_NAME()
                
                CFG::*Config\CRCLastPath = GetPathPart(Defaultfile$)
                INIValue::Set("SETTINGS","Directory0",CFG::*Config\CRCLastPath,CFG::*Config\ConfigPath.s)
                
                While Defaultfile$ 
                    CountFiles.i = CountFiles.i + 1
                    AddElement(FullFileSource())    
                    FullFileSource()\FileIndexID = CountFiles.i
                    FullFileSource()\FileName    = Defaultfile$
                    Defaultfile$ = NextSelectedFileName() 
                Wend
                
                
                Select CountFiles
                    Case 1
                        *Checksum\MultiMode = 0
                    Default
                        sLANGUAGE = Windows::Get_Language() 
                        
                        Request0$ = "Now Look What You've Done" 
                        Request1$ =  "Create Checksum File"                 
                        Select sLANGUAGE
                            Case 407              
                                Request2$ = #LF$+"Alle " +Str(CountFiles)+ " Dateien sammeln und in einer einzelnen Prüfdatei erzeugen"
                            Default
                                Request2$ = #LF$+"" 
                        EndSelect
                        iResult = Request::MSG(Request0$, Request1$, Request2$,6,0,ProgramFilename(),1,0) 
                        Select iResult
                            Case 0
                                *Checksum\MultiMode = 0
                            Case 1
                                *Checksum\MultiMode = 1
                        EndSelect
                        
                        SetGadgetState(DC::#Progress_001,0)
                        SetGadgetAttribute(DC::#Progress_001,#PB_ProgressBar_Maximum,CountFiles.i) 
                        
                EndSelect
                
            ResetList(FullFileSource())
            While NextElement(FullFileSource())
                             

                
                *Checksum\FilePath       = FullFileSource()\FileName
                *Checksum\Format         = QuersummenFormat
                *Checksum\MaxFiles       = CountFiles.i
                *Checksum\CurrentIndex.i = FullFileSource()\FileIndexID
                
                DoCheckSum = CreateThread(@ Checksum_Thread(),*Checksum)
                While IsThread(DoCheckSum)
                    Delay(10)
                    While WindowEvent():Wend
                Wend 
                                                
                Defaultfile$ = NextSelectedFileName() 
            Wend 
            
            SetGadgetText(DC::#Text_019,"Drop7z: Create CRC: Finished")
            Delay(3500)
            
            SetGadgetText(DC::#String_001,Stringtext$)
            SetWindowTitle(DC::#_Window_001,CFG::*Config\WindowTitle.s): SetGadgetState(DC::#Progress_001,0)           
            
            HideWindow(DC::#_Window_004,1): SetForegroundWindow_(WindowID(DC::#_Window_001))
            StickyWindow(DC::#_Window_004,0): CloseWindow(DC::#_Window_004) 
       EndSelect                        
    EndProcedure
    
    
    
    
  Procedure Create_SHA1_File(iFullPath$,iSizeSplit$) 
         Protected  State$, FileList$, SHAFILE$, SHASUME$, iResult, Name$, ExSH$, f.WIN32_FIND_DATA, StringGadgetFile$, PartNum, PartExt$
              
                 
         FileList$ = GetPathPart(iFullPath$)+GetFilePart(iFullPath$,#PB_FileSystem_NoExtension)+".sha"
         
         State$ = LCase(INIValue::Get_S("SETTINGS","CreateSHA1",CFG::*Config\ConfigPath.s)) 
         If (State$ = "true")
             
             ;GUI04::ConsoleWindow()
                
                SetGadgetText(DC::#Text_019,"Drop7z: Create CRC")               
                AddGadgetItem(DC::#ListIcon_002,-1,"")
                AddGadgetItem(DC::#ListIcon_002,-1,"")
                
                SendMessage_(GadgetID(DC::#ListIcon_002),#LVM_SETIMAGELIST,#LVSIL_SMALL,ImageList_Create_(1,17,#ILC_COLORDDB,0,0))
                HideWindow(DC::#_Window_004,0): SetForegroundWindow_(WindowID(DC::#_Window_004))
                StickyWindow(DC::#_Window_004,1)
                
                
            Select Len(iSizeSplit$)
              Case 0                 
                  CreateFile(DC::#_TempFile,FileList$)
                  SetWindowTitle(DC::#_Window_001, DropLang::GetUIText(4) )
                  
                  SHACOUNT = CountString(iFullPath$,Chr(34))
                  For i = 0 To SHACOUNT
                    iFullPath$ = ReplaceString(iFullPath$,Chr(34),"",0,1)
                  Next   
                  
                  SetGadgetItemText(DC::#ListIcon_002, 0, GetFilePart(iFullPath$)) 
                  SetGadgetItemText(DC::#ListIcon_002, 1, "CRC File: "+GetFilePart(FileList$))                    
                  
                  SHAFILE$ = GetFilePart(iFullPath$)
                  SHASUME$ = FileFingerprint(iFullPath$,  #PB_Cipher_SHA1): Delay(100)
                  SetGadgetText(DC::#String_005,"SHA1: "+SHAFILE$)
                  
                  WriteStringN(DC::#_TempFile, SHASUME$+" *"+SHAFILE$,#PB_Ascii)
                  CloseFile(DC::#_TempFile): SetWindowTitle(DC::#_Window_001,CFG::*Config\WindowTitle): Delay(100)
                  
                  SetGadgetText(DC::#Text_019,"Drop7z: Create CRC: Finished")
                  Delay(3500)
            
                  HideWindow(DC::#_Window_004,1): SetForegroundWindow_(WindowID(DC::#_Window_001))
                  StickyWindow(DC::#_Window_004,0): CloseWindow(DC::#_Window_004)  
                  
                  ProcedureReturn
                  
              Default
                  CreateFile(DC::#_TempFile,FileList$)                     
                  
                  iResult = FindFirstFile_(GetPathPart(iFullPath$)+"*.7z.*", f)
                  Select iResult
                      Case #INVALID_HANDLE_VALUE
                          Debug "#INVALID_HANDLE_VALUE"
                      Default
                          
                          SetWindowTitle(DC::#_Window_001,DropLang::GetUIText(4) )
                          Name$ = PeekS(@f\cFileName[0])
                          ExSH$ = LCase(GetExtensionPart(Name$))
                          
                          Select ExSH$
                              Case "sha"
                              Case "7z"    
                              Default
                                  
                                  PartNum = ValF(ExSH$)
                                  Select PartNum
                                      Case 0
                                      Default
                                          
                                          SetGadgetItemText(DC::#ListIcon_002, 0, Name$) 
                                          SetGadgetItemText(DC::#ListIcon_002, 1, "CRC File: "+GetFilePart(FileList$))                                             
                                          
                                          SHAFILE$ = Name$
                                          SHASUME$ = FileFingerprint(GetPathPart(iFullPath$)+Name$,  #PB_Cipher_SHA1): Delay(100)
                                          SetGadgetText(DC::#String_005,"SHA1: "+SHAFILE$)
                                          WriteStringN(DC::#_TempFile, SHASUME$+" *"+SHAFILE$,#PB_Ascii) 
                                  EndSelect
                                  
                          EndSelect
                          
                          While FindNextFile_(iResult, f)
                              If iResult
                                  
                                  Name$ = PeekS(@f\cFileName[0])
                                  ExSH$ = LCase(GetExtensionPart(Name$))
                                  Select ExSH$
                                      Case "sha"
                                      Case "7z"
                                      Default
                                          
                                          PartNum = ValF(ExSH$)
                                          Select PartNum
                                              Case 0
                                              Default      
                                                  
                                                  SetGadgetItemText(DC::#ListIcon_002, 0, Name$) 
                                                  SetGadgetItemText(DC::#ListIcon_002, 1, "CRC File: "+GetFilePart(FileList$))                                                   
                                                  
                                                  SHAFILE$ = Name$
                                                  SHASUME$ = FileFingerprint(GetPathPart(iFullPath$)+Name$, #PB_Cipher_SHA1): Delay(100)  
                                                  WriteStringN(DC::#_TempFile, SHASUME$+" *"+SHAFILE$,#PB_Ascii)
                                                  SetGadgetText(DC::#String_005,"SHA1: "+SHAFILE$)
                                          EndSelect    
                                  EndSelect                         
                              EndIf     
                          Wend                  
                          
                  EndSelect
                  CloseFile(DC::#_TempFile) : SetWindowTitle(DC::#_Window_001,CFG::*Config\WindowTitle.s):  Delay(100)
                  
                  SetGadgetText(DC::#Text_019,"Drop7z: Create CRC: Finished")
                  Delay(3500)
            
                
                  ProcedureReturn 
          EndSelect
      EndIf
  EndProcedure    
EndModule
; IDE Options = PureBasic 5.62 (Windows - x64)
; CursorPosition = 315
; FirstLine = 312
; Folding = -
; EnableAsm
; EnableXP
; UseMainFile = ..\Drop7z.pb
; DisableDebugger
; CurrentDirectory = ..\Drop7z\
; EnableUnicode