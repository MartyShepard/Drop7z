; Procedure: Center text in Multiline StringGadget
; ************************************************
Procedure StringGadgetVCenter(gadNum)
  Protected iLineCount, iLinetext$, hdc, eRect.RECT
  ;--> Get line count of StringGadget
  
  iLineCount = SendMessage_(GadgetID(gadNum), #EM_GETLINECOUNT, 0, 0)
  iLinetext$ = GetGadgetText(gadNum)
  
  ;--> Get width and height of text on one line
  hdc = GetDC_(GadgetID(gadNum))
  GetTextExtentPoint32_(hdc, iLinetext$, Len(iLinetext$), @textXY.SIZE)
  ReleaseDC_(GadgetID(gadNum), hdc)
  
  ;--> Set rect coordinates for StringGadget
  eRect.RECT
  eRect\left = 0
  eRect\top = (GadgetHeight(gadNum) - textXY\cy*iLineCount) / 2
  eRect\right = GadgetWidth(gadNum) - (eRect\left * 2)
  eRect\bottom = eRect\top + textXY\cy*iLineCount
  SendMessage_(GadgetID(gadNum), #EM_SETRECT, 0, eRect)
EndProcedure

;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 

 Procedure.s  GetPath_Config(iWhichConfig = 0)
    Protected ProFileConfig$, iDrop7z_Config$, FullFileCurrent$, HistoryLog$
    
    
    FullFileCurrent$ = ProgramFilename()
    FullFileCurrent$ = GetPathPart(FullFileCurrent$)
    
    If (iWhichConfig = 1)
      iDrop7z_Config$ = FullFileCurrent$+"Drop7z.ini"
      ;MessageRequester("",iDrop7z_Config$)
      ProcedureReturn iDrop7z_Config$       
    EndIf
    
    If (iWhichConfig = 2)
      ProFileConfig$ = FullFileCurrent$+"Drop7z_Profiles.ini"
      ;MessageRequester("",ProFileConfig$)
      ProcedureReturn ProFileConfig$      
    EndIf
    
    If (iWhichConfig = 3)
      HistoryLog$ = FullFileCurrent$+"Drop7z_History.ini"
      ;MessageRequester("",ProFileConfig$)
      ProcedureReturn HistoryLog$      
    EndIf
EndProcedure

;/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Procedure _Write_Config_S(Section.s,Key.s,iValue.s,iFile.s)
    WritePrivateProfileString_ (Section, Key, iValue,iFile) 
EndProcedure

;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
Procedure.s _Read_Config_S(Section.s,Key.s,iFile.s) 
     iValue.s = Space(1024) 
     ValueString.l = GetPrivateProfileString_ (Section, Key, '', iValue, Len(iValue), iFile) 
     iValue = Left(iValue, ValueString)  
     ProcedureReturn iValue 
 EndProcedure
 
 
Procedure.s xMessage_Exit_Window()
    Global _Requester_Quit = #True
    StickyWindow(#ReqWindow_01,0): CloseWindow(#ReqWindow_01) 
    ProcedureReturn
EndProcedure     


        Procedure xMessage_Actions(Dlg_ReturnCode.l)
            Protected iDrop7z_Config$
            iDrop7z_Config$ = GetPath_Config(1)
            
            If Dlg_ReturnCode=999 : xMessage_Exit_Window(): EndIf ;Going Quit/OK
            
            If Dlg_ReturnCode=998
                _Write_Config_S("SETTINGS","DeleteFiles","true",iDrop7z_Config$)
                If (iCurrentPopMenu <> 0)
                    SetMenuItemState(iCurrentPopMenu, iMenuID, 1)
                EndIf
                xMessage_Exit_Window() ;Going Quit/OK           
            EndIf
            
            If Dlg_ReturnCode=997
                iResult_DeleteFiles = #True
                xMessage_Exit_Window() ;Going Quit/OK           
            EndIf
            
            If Dlg_ReturnCode=996
                iError_WinFuncResult = #True
                xMessage_Exit_Window() ;Going Quit/OK           
            EndIf
            If Dlg_ReturnCode=995
                iError_WinFuncResult = #False
                xMessage_Exit_Window() ;Going Quit/OK           
            EndIf
               
            If Dlg_ReturnCode=994
                 iResult_ProfileReplace = #True
                xMessage_Exit_Window() ;Going Quit/OK           
            EndIf
            If Dlg_ReturnCode=993
                 iResult_ProfileReplace = #False
                xMessage_Exit_Window() ;Going Quit/OK           
            EndIf
            
            If Dlg_ReturnCode=992
                 iResult_ProfileDelete = #True
                xMessage_Exit_Window() ;Going Quit/OK           
            EndIf
            If Dlg_ReturnCode=991
                 iResult_ProfileDelete = #False
                xMessage_Exit_Window() ;Going Quit/OK           
            EndIf            
            
            If Dlg_ReturnCode=990
                iResult_AutocompleteDelete = #True
                xMessage_Exit_Window() ;Going Quit/OK           
            EndIf 
            
        EndProcedure

;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
;
;   Maximal 5 Zeilen und eine Zeichenlänge "The Important System Subdirectory 'TRHDLOAD' Not Found. Direct"
;   
;
;

    Procedure.s xMessage_Code(Num.l,iMessageString$)
        
        Protected iDrop7z_Config$
        iDrop7z_Config$ = GetPath_Config(1)
                    
        Global Dialog_Message_Top.s = ""
        Global Dialog_Message_Mid.s = ""
        
        Global Dlg_ReturnCodeA.l = 0: Global Dlg_ReturnCodeB.l = 0: Global Dlg_ReturnCodeC.l = 0: Global _Requester_Quit = #False
        
        SetWindowTitle(#ReqWindow_01,"Now Look What You've Done")
        
        ;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// MESSAGE NUMMER 0
            If Num=0: Dialog_Message_Top.s = "": Dialog_Message_Mid.s = "": EndIf

        
        ;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// MESSAGE NUMMER 1 
        If Num=1
            
            Dialog_Message_Top.s = "No Files, No Work, No Compress!"
            
            If (LHGAME_LANGUAGE = 407)     
                Dialog_Message_Mid.s = #LF$+"Keine Dateien oder Verzeichnisse zum Komprimieren. Füge Dateien oder Verzeichnisse"+
                                       " mit Dragn'nDrop in das Drop.7z Fenster"
                                       
            EndIf      
      
            If (LHGAME_LANGUAGE = 409)
                Dialog_Message_Mid.s = #LF$+"There are no Files or Directorys to Compress. Add Files And Directorys with via Drag'n'Drop To the Window"+#LF$+#LF$+"Nothing to do..."
            EndIf
              
            ;ButtonGadgetEx(#ReqButton_1,20, 136, 87, 27, #_BTN_GREY1_1N, #_BTN_GREY1_1H, #_BTN_GREY1_1P,#_BTN_GREY1_1D ,"Ok", "Ok", "Ok",GetSysColor_(#COLOR_3DFACE))
            ButtonGadgetEx(#ReqButton_2,197, 137, 87, 27, #_BTN_GREY1_1N, #_BTN_GREY1_1H, #_BTN_GREY1_1P,#_BTN_GREY1_1D ,"Ok", "Ok", "Ok",GetSysColor_(#COLOR_3DFACE)) 
            ;ButtonGadgetEx(#ReqButton_3,381, 136, 87, 27, #_BTN_GREY1_1N, #_BTN_GREY1_1H, #_BTN_GREY1_1P,#_BTN_GREY1_1D ,"Ok", "Ok", "Ok",GetSysColor_(#COLOR_3DFACE))
   
      
          If (LHGAME_LANGUAGE = 409)
             ;Set_ToolTip_EX(WindowID(#ReqWindow_01),#ReqButton_1,"Default teXt",":..",1)      
           EndIf
            
           ;Dlg_ReturnCodeA.l = 997
            Dlg_ReturnCodeB.l = 999
           ;Dlg_ReturnCodeC.l = 998: ProcedureReturn 
        EndIf
  
        ;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// MESSAGE NUMMER 2
        ;                             
        If Num=2
            
            Dialog_Message_Top.s = "Can't create Archive! on Drive: "+iMessageString$
            
            If (LHGAME_LANGUAGE = 407)     
                Dialog_Message_Mid.s = #LF$+"Kann keine 7z Archive auf CD/DVD's erstellen."+#LF$+#LF$+"Bitte anderes Zielverzeichnis mit '..\' wählen."
                                       
            EndIf      
      
            If (LHGAME_LANGUAGE = 409)
                Dialog_Message_Mid.s = #LF$+"Can't create 7z archiv on CD/DVD. Please select another destination path."
            EndIf
              
            ButtonGadgetEx(#ReqButton_2,197, 137, 87, 27, #_BTN_GREY1_1N, #_BTN_GREY1_1H, #_BTN_GREY1_1P,#_BTN_GREY1_1D ,"Ok", "Ok", "Ok",GetSysColor_(#COLOR_3DFACE)) 
            
            Dlg_ReturnCodeB.l = 999         
        EndIf

        ;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// MESSAGE NUMMER 2
        ;                             
        If Num=3
            Dialog_Message_Top.s = "Can't create a Multivolume Archiv!"
            
            If (LHGAME_LANGUAGE = 407)     
                Dialog_Message_Mid.s = #LF$+"Kann kein Multivolume Archiv (.7z.001) erstellen weil ein 7z Archiv im Verzeichnis: '"+iMessageString$+"' existiert."
                                       
            EndIf      
      
            If (LHGAME_LANGUAGE = 409)
                Dialog_Message_Mid.s = #LF$+"Try to create a Multivolume .7z.001 Archiv but a Normal .7z exists in Directory: "+iMessageString$+#LF$+"Use a other Name."
            EndIf
              
            ButtonGadgetEx(#ReqButton_2,197, 137, 87, 27, #_BTN_GREY1_1N, #_BTN_GREY1_1H, #_BTN_GREY1_1P,#_BTN_GREY1_1D ,"Ok", "Ok", "Ok",GetSysColor_(#COLOR_3DFACE)) 
            
            Dlg_ReturnCodeB.l = 999    
        EndIf 
        ;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// MESSAGE NUMMER 2
        ;                             
        If Num=4
             Dialog_Message_Top.s = "Missing Directory!"
            
            If (LHGAME_LANGUAGE = 407)     
                Dialog_Message_Mid.s = #LF$+"Verzeichnis nicht gefunden:"+#LF$+"'"+iMessageString$+"'"
                                       
            EndIf      
      
            If (LHGAME_LANGUAGE = 409)
                Dialog_Message_Mid.s = #LF$+"Missing Directory"+#LF$+"'"+iMessageString$+"' ..Not Found!"
            EndIf
              
            ButtonGadgetEx(#ReqButton_2,197, 137, 87, 27, #_BTN_GREY1_1N, #_BTN_GREY1_1H, #_BTN_GREY1_1P,#_BTN_GREY1_1D ,"Ok", "Ok", "Ok",GetSysColor_(#COLOR_3DFACE)) 
            
            Dlg_ReturnCodeB.l = 999              
        EndIf                
        ;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// MESSAGE NUMMER 5
        ;
        If Num=5
            Dialog_Message_Top.s = "Missing File!"
            
            If (LHGAME_LANGUAGE = 407)     
                Dialog_Message_Mid.s = #LF$+"Datei nicht gefunden:"+#LF$+"'"+iMessageString$+"'"
                                       
            EndIf      
      
            If (LHGAME_LANGUAGE = 409)
                Dialog_Message_Mid.s = #LF$+"Missing File"+#LF$+"'"+iMessageString$+"' ..Not Found!"
            EndIf
              
            ButtonGadgetEx(#ReqButton_2,197, 137, 87, 27, #_BTN_GREY1_1N, #_BTN_GREY1_1H, #_BTN_GREY1_1P,#_BTN_GREY1_1D ,"Ok", "Ok", "Ok",GetSysColor_(#COLOR_3DFACE)) 
            
            Dlg_ReturnCodeB.l = 999      
        EndIf
       
        ;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// MESSAGE NUMMER 6
        ; 
        If Num=6
            Dialog_Message_Top.s = "Attention!"
            
            If (LHGAME_LANGUAGE = 407)     
                Dialog_Message_Mid.s = #LF$+"Benutze die Option 'Delete Files' auf eigenes Risiko."+#LF$+#LF$+
                                       "Zur Info: Alle gelöschten Dateien liegen im Papierkorb."+#LF$+
                                       "Löschen nach dem Archiveren/Komprimieren der Dateien aktivieren ?"
                                       
            EndIf      
      
            If (LHGAME_LANGUAGE = 409)
                Dialog_Message_Mid.s = #LF$+"Use the Option 'Delete Files' on your own Risk."+#LF$+#LF$+"Info: All Deleted Files got to the Recycle Bin"+#LF$+"Enable 'Delete Files' after Compressing 7z Archive/s ?"
            EndIf
              
            ButtonGadgetEx(#ReqButton_1,20, 136, 87, 27, #_BTN_GREY1_1N, #_BTN_GREY1_1H, #_BTN_GREY1_1P,#_BTN_GREY1_1D ,"Ok", "Ok", "Ok",GetSysColor_(#COLOR_3DFACE))
            ButtonGadgetEx(#ReqButton_3,381, 136, 87, 27, #_BTN_GREY1_1N, #_BTN_GREY1_1H, #_BTN_GREY1_1P,#_BTN_GREY1_1D ,"Cancel", "Cancel", "Cancel",GetSysColor_(#COLOR_3DFACE))
   
            Dlg_ReturnCodeA.l = 998              
            Dlg_ReturnCodeC.l = 999             
        EndIf
        
        ;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// MESSAGE NUMMER 7
        ; 
        If Num=7
            Dialog_Message_Top.s = "7z Not Found!"
            
            If (LHGAME_LANGUAGE = 407)     
                Dialog_Message_Mid.s = #LF$+"7z wurde nicht gefunden:"+#LF$+
                                       "1. Drop 7z Config: "+_Read_Config_S("SETTINGS","Portable",iDrop7z_Config$)+" /Ini)"+#LF$+
                                       "2. Unter HKEY_LOCAL_MACHINE\SOFTWARE\7-Zip"+#LF$+
                                       "3. "+Chr(34)+"C:\Programme (x86)\7-Zip\7zG.exe"+Chr(34)+#LF$+
                                       "4. "+Chr(34)+"c:\Programme\7-Zip\7zG.exe"+Chr(34)+ "Nur 64bit"                    
            EndIf      
      
            If (LHGAME_LANGUAGE = 409)
                Dialog_Message_Mid.s = #LF$+"No 7z Found:"+#LF$+
                                       "1. Drop 7z Config: "+_Read_Config_S("SETTINGS","Portable",iDrop7z_Config$)+" /Ini)"+#LF$+
                                       "2. at HKEY_LOCAL_MACHINE\SOFTWARE\7-Zip"+#LF$+
                                       "3. in "+Chr(34)+"C:\Programme (x86)\7-Zip\7zG.exe"+Chr(34)+#LF$+
                                       "4. in "+Chr(34)+"c:\Programme\7-Zip\7zG.exe"+Chr(34)+ "Nur 64bit" 
            EndIf
              
            ButtonGadgetEx(#ReqButton_2,197, 137, 87, 27, #_BTN_GREY1_1N, #_BTN_GREY1_1H, #_BTN_GREY1_1P,#_BTN_GREY1_1D ,"Ok", "Ok", "Ok",GetSysColor_(#COLOR_3DFACE)) 
            
            Dlg_ReturnCodeB.l = 999                
        EndIf
  
        ;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// MESSAGE NUMMER 8
        ;
        If Num=8
            Dialog_Message_Top.s = "Delete Files ?"
            
            If (LHGAME_LANGUAGE = 407)     
                Dialog_Message_Mid.s = #LF$+#LF$+"Sollen alle Dateien/Verzeichnisse gelöscht werden ?"
                                       
            EndIf      
      
            If (LHGAME_LANGUAGE = 409)
                Dialog_Message_Mid.s = #LF$+#LF$+"Do You want Delete Directories and Files?"
            EndIf
              
            ButtonGadgetEx(#ReqButton_1,20, 136, 87, 27, #_BTN_GREY1_1N, #_BTN_GREY1_1H, #_BTN_GREY1_1P,#_BTN_GREY1_1D ,"Yes", "Yes", "Yes",GetSysColor_(#COLOR_3DFACE))
            ButtonGadgetEx(#ReqButton_3,381, 136, 87, 27, #_BTN_GREY1_1N, #_BTN_GREY1_1H, #_BTN_GREY1_1P,#_BTN_GREY1_1D ,"No", "No", "No",GetSysColor_(#COLOR_3DFACE))
   
            Dlg_ReturnCodeA.l = 997              
            Dlg_ReturnCodeC.l = 999           
            
        EndIf   
           
        ;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// MESSAGE NUMMER 9
        ;            
        If Num=9
            Dialog_Message_Top.s = "Can't Mail Attachment!"
            
            If (LHGAME_LANGUAGE = 407)     
                Dialog_Message_Mid.s = #LF$+"Es ist keine Anwendung mit der erweiterung mailto: verknüpft"
                                       
            EndIf      
      
            If (LHGAME_LANGUAGE = 409)
                Dialog_Message_Mid.s = #LF$+"There is no application associated With the given file name extension:'mailto'"
            EndIf
              
            ButtonGadgetEx(#ReqButton_2,197, 137, 87, 27, #_BTN_GREY1_1N, #_BTN_GREY1_1H, #_BTN_GREY1_1P,#_BTN_GREY1_1D ,"Ok", "Ok", "Ok",GetSysColor_(#COLOR_3DFACE)) 
            
            Dlg_ReturnCodeB.l = 999                       
        EndIf
   
        ;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// MESSAGE NUMMER 10
        ;           
        If Num=10
            
            Dialog_Message_Top.s = "There was an Error on performing the Action!"
            
            If (LHGAME_LANGUAGE)     
                Dialog_Message_Mid.s =  "Error: "+DeleteCodes()\Error_Description.s+#LFCR$+
                                        "Hex  : "+DeleteCodes()\Error_Hex.s+ 
                                        "[Code : "+LCase(DeleteCodes()\Error_Intern.s)+"]"+#LFCR$+
                                        "Object: "+#LFCR$+iMessageString$+#LFCR$+#LFCR$+
                                        "Ignore this Error and continue?"
            EndIf      

              
            ButtonGadgetEx(#ReqButton_1,20, 136, 87, 27, #_BTN_GREY1_1N, #_BTN_GREY1_1H, #_BTN_GREY1_1P,#_BTN_GREY1_1D ,"Yes", "Yes", "Yes",GetSysColor_(#COLOR_3DFACE))
            ButtonGadgetEx(#ReqButton_3,381, 136, 87, 27, #_BTN_GREY1_1N, #_BTN_GREY1_1H, #_BTN_GREY1_1P,#_BTN_GREY1_1D ,"Abort", "Abort", "Abort",GetSysColor_(#COLOR_3DFACE))
      
            Dlg_ReturnCodeA.l = 996              
            Dlg_ReturnCodeC.l = 995                   
        EndIf        
        ;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// MESSAGE NUMMER 11 **
        ;  
        If Num=11            
            Dialog_Message_Top.s = "Replace the Current Profile!"
            
            If (LHGAME_LANGUAGE = 407)     
                Dialog_Message_Mid.s =  #LF$+#LF$+"Das Profil: '" +iMessageString$+ "' Existiert. Mit den eingestellten werten überschreiben ?"

            EndIf      
            
            If (LHGAME_LANGUAGE = 409)     
                Dialog_Message_Mid.s =  #LF$+#LF$+"Profile: '" +iMessageString$+ "' exists. Replace with the current settings ?"

            EndIf              
              
            ButtonGadgetEx(#ReqButton_1,20, 136, 87, 27, #_BTN_GREY1_1N, #_BTN_GREY1_1H, #_BTN_GREY1_1P,#_BTN_GREY1_1D ,"Yes", "Yes", "Yes",GetSysColor_(#COLOR_3DFACE))
            ButtonGadgetEx(#ReqButton_3,381, 136, 87, 27, #_BTN_GREY1_1N, #_BTN_GREY1_1H, #_BTN_GREY1_1P,#_BTN_GREY1_1D ,"No", "No", "No",GetSysColor_(#COLOR_3DFACE))
      
            Dlg_ReturnCodeA.l = 994              
            Dlg_ReturnCodeC.l = 993      
            
        EndIf
  
        ;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// MESSAGE NUMMER 12 **
        ; 
        If Num=12
            Dialog_Message_Top.s = "Delete Profile: "+iMessageString$
            
            If (LHGAME_LANGUAGE = 407)     
                Dialog_Message_Mid.s =  #LF$+#LF$+"Das Profil: '" +iMessageString$+ "' Löschen ?"

            EndIf      
            
            If (LHGAME_LANGUAGE = 409)     
                Dialog_Message_Mid.s =  #LF$+#LF$+"Delete the Profile: '" +iMessageString$+ "' ?"

            EndIf              
              
            ButtonGadgetEx(#ReqButton_1,20, 136, 87, 27, #_BTN_GREY1_1N, #_BTN_GREY1_1H, #_BTN_GREY1_1P,#_BTN_GREY1_1D ,"Yes", "Yes", "Yes",GetSysColor_(#COLOR_3DFACE))
            ButtonGadgetEx(#ReqButton_3,381, 136, 87, 27, #_BTN_GREY1_1N, #_BTN_GREY1_1H, #_BTN_GREY1_1P,#_BTN_GREY1_1D ,"No", "No", "No",GetSysColor_(#COLOR_3DFACE))
      
            Dlg_ReturnCodeA.l = 992              
            Dlg_ReturnCodeC.l = 991 
        EndIf

        ;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// MESSAGE NUMMER 13
        ;            
        If Num=13
            Dialog_Message_Top.s = "Need a Profile Name!"
            
            If (LHGAME_LANGUAGE = 407)     
                Dialog_Message_Mid.s = #LF$+"Kein Profile Namen angegeben für '" +iMessageString$+ "'"
                                       
            EndIf      
      
            If (LHGAME_LANGUAGE = 409)
                Dialog_Message_Mid.s = #LF$+"No Profile Name for '" +iMessageString$+ "'"
            EndIf
              
            ButtonGadgetEx(#ReqButton_2,197, 137, 87, 27, #_BTN_GREY1_1N, #_BTN_GREY1_1H, #_BTN_GREY1_1P,#_BTN_GREY1_1D ,"Ok", "Ok", "Ok",GetSysColor_(#COLOR_3DFACE)) 
            
            Dlg_ReturnCodeB.l = 999               
        EndIf
            
        ;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// MESSAGE NUMMER 14
        ;            
        If Num=14
            Dialog_Message_Top.s = "Missing Settings!"
            
            If (LHGAME_LANGUAGE = 407)     
                Dialog_Message_Mid.s = #LF$+"Für das Profil '" +iMessageString$+ "' fehlen die einstellungen" 
                                       
            EndIf      
      
            If (LHGAME_LANGUAGE = 409)
                Dialog_Message_Mid.s = #LF$+"MIssing Settings for Profile '" +iMessageString$+ "'"
            EndIf
              
            ButtonGadgetEx(#ReqButton_2,197, 137, 87, 27, #_BTN_GREY1_1N, #_BTN_GREY1_1H, #_BTN_GREY1_1P,#_BTN_GREY1_1D ,"Ok", "Ok", "Ok",GetSysColor_(#COLOR_3DFACE)) 
            
            Dlg_ReturnCodeB.l = 999                  
        EndIf

        ;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// MESSAGE NUMMER 15
        ; 
        ;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// MESSAGE NUMMER 6
        ; 
        If Num=15
            Dialog_Message_Top.s = "Cear Autocomplete History"
            
            If (LHGAME_LANGUAGE = 407)     
                Dialog_Message_Mid.s = #LF$+"Damit werdne alle Einträge in der Zielverzeichnis-History gelöscht."+#LF$+#LF$+"Einträge Löschen?"                                      
            EndIf      
      
            If (LHGAME_LANGUAGE = 409)
                Dialog_Message_Mid.s = #LF$+"Clear complet the Autocomplete Destination History?"
            EndIf
              
            ButtonGadgetEx(#ReqButton_1,20, 136, 87, 27, #_BTN_GREY1_1N, #_BTN_GREY1_1H, #_BTN_GREY1_1P,#_BTN_GREY1_1D ,"Ok", "Ok", "Ok",GetSysColor_(#COLOR_3DFACE))
            ButtonGadgetEx(#ReqButton_3,381, 136, 87, 27, #_BTN_GREY1_1N, #_BTN_GREY1_1H, #_BTN_GREY1_1P,#_BTN_GREY1_1D ,"Cancel", "Cancel", "Cancel",GetSysColor_(#COLOR_3DFACE))
   
            Dlg_ReturnCodeA.l = 990              
            Dlg_ReturnCodeC.l = 999             
        EndIf

        ;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// MESSAGE NUMMER 16
        ; 
            If Num=16: EndIf  

        ;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// MESSAGE NUMMER 17 **
        ; 
            If Num=17: EndIf

        ;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// MESSAGE NUMMER 18 **
        ; 
            If Num=18 :EndIf 

        ;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// MESSAGE NUMMER 19
        ; 
            If Num=19: EndIf
    
        ;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// MESSAGE NUMMER 20 **
        ;
            If Num=20: EndIf

        ;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// MESSAGE NUMMER 21
        ;
  
EndProcedure
;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 

Procedure.s Open_Requester(IconStop = 0, IconAttent = 0, IconGame = 0, Dialog_Message_Code = 0, Dialog_Message_String.s = "" ) 
    
    
       
  OpenReqWindow_01()

  If IconStop   = 1: SetGadgetAttribute(#Icon_0,#PB_Button_Image ,ImageID(#_ICO_T01)): EndIf
  If IconAttent = 1: SetGadgetAttribute(#Icon_0,#PB_Button_Image ,ImageID(#_ICO_T01)): EndIf 
  
  If IconGame   = 1: SetGadgetAttribute(#Icon_1,#PB_Button_Image ,ImageID(#_ICO_T00)): EndIf
  If IconGame   = 0: SetGadgetAttribute(#Icon_1,#PB_Button_Image ,ImageID(#_ICO_T00)): EndIf
  
  xMessage_Code(Dialog_Message_Code,Dialog_Message_String.s)
  
  SetGadgetText(#ReqText0,Dialog_Message_Top.s)
  SetGadgetText(#ReqText1,Dialog_Message_Mid.s)

  HideWindow(#ReqWindow_01,0)
  StickyWindow(#ReqWindow_01,1)

    iPosX = WindowX(#ReqWindow_01)
    iPosY = WindowY(#ReqWindow_01)
    
    SetCursorPos_(iPosX+240, iPosY+166)
    
  Repeat    
    _Requester_EventID.l = WaitWindowEvent() 
    
    Select _Requester_EventID 
        
      Case #PB_Event_CloseWindow
        _Requester_Quit = #True
        
      Case #PB_Event_Gadget 
           
    Select EventGadget()
        
            
        ;**********************************************************************************************************************    
        Case #ReqButton_1    
            Select EventGadgetEx(#ReqButton_1)  
                Case #ButtonGadgetEx_Entered:       If GetGadgetStateEx(#ReqButton_1)=0: Else: EndIf
                    
                Case #ButtonGadgetEx_Released
                Case #ButtonGadgetEx_Pressed:       xMessage_Actions(Dlg_ReturnCodeA): ProcedureReturn
            EndSelect  
            
        ;**********************************************************************************************************************    
        Case #ReqButton_2    
            Select EventGadgetEx(#ReqButton_2)  
                Case #ButtonGadgetEx_Entered:       If GetGadgetStateEx(#ReqButton_2)=0: Else: EndIf
                    
                Case #ButtonGadgetEx_Released
                Case #ButtonGadgetEx_Pressed:      xMessage_Actions(Dlg_ReturnCodeB): ProcedureReturn
            EndSelect              
            
            
        ;**********************************************************************************************************************    
        Case #ReqButton_3    
            Select EventGadgetEx(#ReqButton_3)  
                Case #ButtonGadgetEx_Entered:       If GetGadgetStateEx(#ReqButton_3)=0: Else: EndIf
                    
                Case #ButtonGadgetEx_Released
                Case #ButtonGadgetEx_Pressed:      xMessage_Actions(Dlg_ReturnCodeC): ProcedureReturn
            EndSelect               
            
        ;**********************************************************************************************************************    
        
    EndSelect            
    EndSelect
    
  Until _Requester_Quit = #True
  StickyWindow(#ReqWindow_01,0): CloseWindow(#ReqWindow_01)
  
EndProcedure  
; IDE Options = PureBasic 5.30 (Windows - x86)
; CursorPosition = 50
; FirstLine = 1
; Folding = --
; EnableUnicode
; EnableXP
; UseMainFile = ..\7z_Main_Source.pb
; DisableDebugger
; CurrentDirectory = ..\Release\