
;################################################################################################################ 
;                                                                                                 Windows ToolTip
     Structure WINDOWS_TOOLTIP
        iPBGD_num.l                 ;PB Gagget ID
        iCLSS_num.l                 ;ToolTips_Class32
     EndStructure
     Global NewList LHTTI.WINDOWS_TOOLTIP()   
     
;################################################################################################################ 
;                                                                                                     Tooltip Set
    Procedure Set_ToolTip_EX(WindowID, Gadget, Text$ , Title$, Icon)
  
        iToolTipEx = CreateWindowEx_(0,"ToolTips_Class32","",#WS_POPUP|#TTS_NOPREFIX|#TTS_BALLOON,0,0,0,0,WindowID,0,GetModuleHandle_(0),0)
   
    
        SendMessage_(iToolTipEx,#TTM_SETTIPTEXTCOLOR,GetSysColor_(#COLOR_INFOTEXT),0)
        SendMessage_(iToolTipEx,#TTM_SETTIPBKCOLOR,GetSysColor_(#COLOR_INFOBK),0)
        SendMessage_(iToolTipEx,#TTM_SETMAXTIPWIDTH,0,200)
    
        Balloon.TOOLINFO\cbSize=SizeOf(TOOLINFO)
    
        Balloon\uFlags  = #TTF_IDISHWND | #TTF_SUBCLASS
        Balloon\hWnd    = GadgetID(Gadget)
        Balloon\uId     = GadgetID(Gadget)
        Balloon\lpszText= @Text$
  
        SendMessage_(iToolTipEx, #TTM_ADDTOOL, 0, Balloon)
        If Title$ > ""
            SendMessage_(iToolTipEx, #TTM_SETTITLE,Icon,@Title$)
        EndIf
    
        AddElement(LHTTI())
            LHTTI()\iCLSS_num = iToolTipEx
            LHTTI()\iPBGD_num = Gadget    
    EndProcedure
    
;################################################################################################################ 
;                                                                                                  Tooltip Change
    Procedure Chg_ToolTip_EX(iGadget,Text$, Title$, Icon,LhToolTipWidth = 200)
   
    ResetList(LHTTI())
    While NextElement(LHTTI())
        If (iGadget = LHTTI()\iPBGD_num)
            
            Balloon.TOOLINFO\cbSize=SizeOf(TOOLINFO)
            
            Balloon\cbSize  = SizeOf(TOOLINFO)
            Balloon\hWnd    = GadgetID(iGadget)
            Balloon\uId     = GadgetID(iGadget)
            Balloon\lpszText= @Text$
            SendMessage_(LHTTI()\iCLSS_num, #TTM_UPDATETIPTEXT, 0, @Balloon)
            SendMessage_(LHTTI()\iCLSS_num, #TTM_SETMAXTIPWIDTH,0, LhToolTipWidth)
            If Title$ > ""
                SendMessage_(LHTTI()\iCLSS_num, #TTM_SETTITLE,Icon,@Title$)
            EndIf
            ProcedureReturn
        EndIf
    Wend
EndProcedure




 
; IDE Options = PureBasic 5.21 LTS (Windows - x64)
; CursorPosition = 39
; FirstLine = 9
; Folding = -
; EnableUnicode
; EnableXP
; UseMainFile = ..\..\LH Game Start GUI\LH_Game_User_Interface.pb
; CurrentDirectory = ..\..\..\! Test Games\Test-Env\