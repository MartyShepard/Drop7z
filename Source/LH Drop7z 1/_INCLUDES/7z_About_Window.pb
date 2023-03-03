Procedure.s Open_About() 
    
    Protected nTxtMessageHeight.i = 3400
    
    OpenWindow002()
    
    HideWindow(#Window002, 1)
    
    TextGadget(DC::#Text_010, 9, 11, 394, 259, "")
    SetGadgetColor(DC::#Text_010, #PB_Gadget_BackColor,RGB(218,218,218))
    
    FrameGadget(DC::#Frame_001, 6, 8, 400, 264, "", #PB_Frame_Flat)

    ScrollAreaGadget(DC::#ScrollArea_001, 90, 14, 306, 246, 282, nTxtMessageHeight, 1, #PB_ScrollArea_BorderLess)
    SetGadgetColor(DC::#ScrollArea_001, #PB_Gadget_BackColor,RGB(218,218,218))    
    
    
    TextGadget(DC::#Text_011, 0, 10, 320, nTxtMessageHeight, DropCode::szMsgAboutText() )
        SetGadgetColor(DC::#Text_011, #PB_Gadget_BackColor,RGB(218,218,218))
        SetGadgetFont(DC::#Text_011, FontID(Fonts::#_FIXPLAIN7_12)) 
    
    CloseGadgetList()          
        
        
    ImageGadget(DC::#ImageGadget_001 , 18, 20, 50, 50, ImageID(#_ICO_T02))
    
    Protected  nCurrentFontID.l = Fonts::#_DROIDSANS_10
    
    ButtonEX::Add(DC::#Button_009, 44, 275,83, 20,  
   	              DC::#_BTN_GREY4_0N, 
    	              DC::#_BTN_GREY4_0H, 
    	              DC::#_BTN_GREY4_0P,
    	              DC::#_BTN_GREY4_0D, "Send Mail", "Send Mail", "Close!",GetSysColor_(#COLOR_3DFACE),0,nCurrentFontID)
    
    ButtonEX::Add(DC::#Button_008,164, 275, 83, 20, 
   	              DC::#_BTN_GREY4_0N, 
    	              DC::#_BTN_GREY4_0H, 
    	              DC::#_BTN_GREY4_0P,
    	              DC::#_BTN_GREY4_0D, "Dann..", "Dann.." , "Close!",GetSysColor_(#COLOR_3DFACE),0,nCurrentFontID)
    
    ButtonEX::Add(DC::#Button_010,280, 275,83, 20, 
   	              DC::#_BTN_GREY4_0N, 
    	              DC::#_BTN_GREY4_0H, 
    	              DC::#_BTN_GREY4_0P,
    	              DC::#_BTN_GREY4_0D, "Homepage", "Is Closed", "Close!",GetSysColor_(#COLOR_3DFACE),0,nCurrentFontID)
    
    
    EnableWindow_(WindowID(#Window002), #True)
    SetActiveWindow(#Window002)    
    
    HideWindow(#Window002,0)
    StickyWindow(#Window002,1)
    
    _AboutQuit = #False 
    
    Repeat    
        _About_EventID.l = WaitWindowEvent() 
        Select _About_EventID 
                
            Case #PB_Event_CloseWindow 
                _AboutQuit = #True 
                
            Case #PB_Event_Gadget 
                ;GadgetEx_EventResult = Event_GadgetEx_Events_About()
                
                Select EventGadget()
                        
                        ;**********************************************************************************************************************    
                    Case DC::#Button_008    
                        Select ButtonEX::ButtonExEvent(DC::#Button_008)  
                            Case ButtonEX::#ButtonGadgetEx_Entered:  
                                
                            Case ButtonEX::#ButtonGadgetEx_Released
                            Case ButtonEX::#ButtonGadgetEx_Pressed:       _AboutQuit = #True
                        EndSelect
                        
                        ;**********************************************************************************************************************    
                    Case DC::#Button_009    
                        Select ButtonEX::ButtonExEvent(DC::#Button_009)  
                            Case ButtonEX::#ButtonGadgetEx_Entered:
                                
                            Case ButtonEX::#ButtonGadgetEx_Released
                            Case ButtonEX::#ButtonGadgetEx_Pressed:                              
                                
                                iResult = ShellExecute_(Handle,"open","mailto:marty.schaefer@gmx.de&Subject="+"DropSevenZip "+ CFG::*Config\WindowTitle.s +" Feedback", nil, nil, SW_SHOWNORMAL)
                                If iResult = 31                                                                          
                                    
                                    sLANGUAGE = Windows::Get_Language() 
                                    Request0$ = "Now Look What You've Done" 
                                    Request1$ = "There was an Error on performing the Action!"                 
                                    Select sLANGUAGE
                                        Case 407
                                            Request2$ = #LF$+"Es ist keine Anwendung mit der erweiterung mailto: verknüpft"
                                        Default
                                            Request2$ = #LF$+"There is no application associated With the given file name extension:'mailto'"            
                                    EndSelect
                                    iResult = Request::MSG(Request0$, Request1$, Request2$,6,0,ProgramFilename(),1)                                        
                                    
                                EndIf
                                _AboutQuit = #True
                        EndSelect
                        
                        ;**********************************************************************************************************************    
                    Case DC::#Button_010    
                        Select ButtonEX::ButtonExEvent(DC::#Button_010)  
                            Case ButtonEX::#ButtonGadgetEx_Entered:
                                
                            Case ButtonEX::#ButtonGadgetEx_Released
                            Case ButtonEX::#ButtonGadgetEx_Pressed:       
                                iResult = ShellExecute_(Handle,"open","http://aeronextedit.wordpress.com", nil, nil, SW_SHOWNORMAL)
                                _AboutQuit = #True
                        EndSelect                            
                EndSelect                    
        EndSelect 
    Until _AboutQuit = #True
    
    StickyWindow(#Window002,0): EnableWindow_(WindowID(DC::#_Window_001), #True) :SetActiveWindow(DC::#_Window_001): CloseWindow(#Window002) 
    
EndProcedure  
; IDE Options = PureBasic 5.73 LTS (Windows - x64)
; CursorPosition = 2
; Folding = -
; EnableAsm
; EnableXP
; UseMainFile = ..\Drop7z.pb
; CurrentDirectory = ..\Drop7z\
; EnableUnicode