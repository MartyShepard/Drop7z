    ;
    ; Include Modules
    ;
        XIncludeFile "Drop7z_Modules\Constants.pb"
        XIncludeFile ".\_INCLUDES\Class_Fonts_Drop7Z.pb" 
    ;
    ; Include Modules, Global Code Modules
    ;   
        XIncludeFile "..\INCLUDES\Class_Process.pb"          
        
        XIncludeFile "..\INCLUDES\Class_Win_Form.pb"
        XIncludeFile "..\INCLUDES\Class_Win_Style.pb"         
        XIncludeFile "..\INCLUDES\Class_Win_Desk.pb"
               
        XIncludeFile "..\INCLUDES\Class_ListIcon_Sort.pb"          
        XIncludeFile "..\INCLUDES\Class_Tooltip.pb"
        
        XIncludeFile "..\Includes\CLASSES_GUI\SplitterGadgetEx.pb"
        XIncludeFile "..\INCLUDES\CLASSES_GUI\ButtonGadgetEX.pb"
        XIncludeFile "..\INCLUDES\CLASSES_GUI\DialogRequestEX.pb" 

;
; ------------------------------------------------------------
;
;   PureBasic - Xml
;
;    (c) Fantaisie Software
;
; ------------------------------------------------------------
;

#Window     = 0
#TreeGadget = 0
#XML        = 0

Global Count.i = 0
Global CntDS.i = 0 ; DialogSettingItem Counter
Global CntDX.i = 0 ; DialogSettingItem Counter für die Dialoge

;======================== Start Dialog Item bei
Global Start.i = 0
;======================== Start Dialog Item bei

Global LastDialog$  = ""
Global NodeAtribt$  = ""
Global bLipSync     = #False

Structure DialogSettingItem
    Position.i
    Background.s
    Delay.s
    Foreground.s
    TextColor.s
EndStructure    

Global NewList DialogSettingItem.DialogSettingItem()


; This procedure fills our TreeGadget, by adding the current node
; and then exploring all childnodes by recursively calling itself.
;
Procedure FillTree(*CurrentNode, CurrentSublevel, FileName$)

  ; Ignore anything except normal nodes. See the manual for
  ; XMLNodeType() for an explanation of the other node types.
  ;
  If XMLNodeType(*CurrentNode) = #PB_XML_Normal
  
    ; Add this node to the tree. Add name and attributes
    ;
    Text$ = GetXMLNodeName(*CurrentNode) + ": "
    ; Debug Text$
    
    ; BriefingFile: 
    ; ConversationBlock: 
    ; ConversationBlock.Items: 
    ; ConversationItem: 
    ; ConversationItem.DialogSettings: 
    ; DialogSettingItem: 
    ; DialogSettingItem: 
    ; ConversationItem.Dialogs: 
    ; DialogItem:     
    If ( GetXMLNodeName(*CurrentNode) = "ConversationItem.DialogSettings")       
        CntDS = 0
        If ( ListSize( DialogSettingItem() )>= 1 )
            ClearList( DialogSettingItem() )
        EndIf    
    EndIf
    
    If ( GetXMLNodeName(*CurrentNode) = "ConversationItem.Dialogs") 
        CntDX = 0 
    EndIf
    
    If ExamineXMLAttributes(*CurrentNode)
        
        While NextXMLAttribute(*CurrentNode)
            Text$ + " Attribute:" + XMLAttributeName(*CurrentNode) + "=" + Chr(34) + XMLAttributeValue(*CurrentNode) + Chr(34) + " "
           Debug Text$

            
            If ( XMLAttributeName(*CurrentNode) = "Background" ) Or
               ( XMLAttributeName(*CurrentNode) = "Delay" ) Or
               ( XMLAttributeName(*CurrentNode) = "Foreground" ) Or              
               ( XMLAttributeName(*CurrentNode) = "TextColor" )
                
                
                
                Select XMLAttributeName(*CurrentNode)
                    Case "Background"   : AddElement( DialogSettingItem() ): 
                                          DialogSettingItem()\Background = XMLAttributeValue(*CurrentNode)
                        
                    Case "Delay"        : DialogSettingItem()\Delay      = XMLAttributeValue(*CurrentNode)
                    Case "Foreground"   : DialogSettingItem()\Foreground = XMLAttributeValue(*CurrentNode) 
                    Case "TextColor"    : DialogSettingItem()\TextColor  = XMLAttributeValue(*CurrentNode):
                                          CntDS+1: DialogSettingItem()\Position   = CntDS
                EndSelect                  
                
            ElseIf ( XMLAttributeName(*CurrentNode) = "LipSyncText" )
                If ( Len( XMLAttributeValue(*CurrentNode) ) > 1)
                    bLipSync = #True
                Else
                    bLipSync = #False
                EndIf
                
            ElseIf ( XMLAttributeName(*CurrentNode) = "Text" ) Or 
                   ( XMLAttributeName(*CurrentNode) = "Message" ) Or 
                   ( XMLAttributeName(*CurrentNode) = "Name" )
                    
                    CntDX + 1
                
                If Len( XMLAttributeValue(*CurrentNode)) > 1

                    Count + 1 
                    
                   
                    
                    If ( Count >= Start )
                        
                        ; Automatische Übersetzung
                        Select XMLAttributeName(*CurrentNode)
                            Case "Text"
                                sMaxLen$ = "131" ; Module 59                                                                 
                                
                                Select XMLAttributeValue(*CurrentNode)
                                    Case "Proceed to Nav 1 "             : Request::*MsgEx\Return_String = "Zu Nav 1 fliegen "                                        
                                    Case "Proceed to Nav 1"             : Request::*MsgEx\Return_String = "Zu Nav 1 fliegen"
                                    Case "Proceed to Nav 2"             : Request::*MsgEx\Return_String = "Zu Nav 2 fliegen"
                                    Case "Proceed to Nav 3"             : Request::*MsgEx\Return_String = "Zu Nav 3 fliegen"
                                    Case "Proceed to Nav 4"             : Request::*MsgEx\Return_String = "Zu Nav 4 fliegen"                                          
                                    Case "Proceed to Nav 5"             : Request::*MsgEx\Return_String = "Zu Nav 5 fliegen"                                         
                                    Case "Return To Tiger's Claw "      : Request::*MsgEx\Return_String = "Rückkehr zur Tiger's Claw "                                         
                                    Case "Return to Tiger's Claw"       : Request::*MsgEx\Return_String = "Rückkehr zur Tiger's Claw"  
                                    Case "Rendezvous With Tiger's Claw" : Request::*MsgEx\Return_String = "Treffen mit Tiger's Claw"  
                                    Case "Dismissed."                   : Request::*MsgEx\Return_String = "Weggetreten."
                                    Case "Dismissed!"                   : Request::*MsgEx\Return_String = "Weggetreten!"
                                    Case "Mission Debriefing -- $T, $D.": Request::*MsgEx\Return_String = "Einsatzauswertung. $T Uhr, $D."
                                    Case "Proceed To Rendezvous at Nav 1":Request::*MsgEx\Return_String = "Zum Treffen nach Nav 1 fliegen"
                                    Case "Proceed To Rendezvous at Nav 2":Request::*MsgEx\Return_String = "Zum Treffen nach Nav 2 fliegen"
                                    Case "Proceed To Rendezvous at Nav 3":Request::*MsgEx\Return_String = "Zum Treffen nach Nav 3 fliegen"                                        
                                    Default
                                    Request::*MsgEx\Return_String = XMLAttributeValue(*CurrentNode)    
                                        
                                EndSelect
                            Case "Message"
                                sMaxLen$ = "N/A"
                                Request::*MsgEx\Return_String = XMLAttributeValue(*CurrentNode)   
                            Case "Name"
                                sMaxLen$ = "N/A"
                                Select XMLAttributeValue(*CurrentNode)
                                    Case "Brave Fighter"                : Request::*MsgEx\Return_String = "Mutige Kämpfer"
                                        
                                    Case "Couple o' Nasties"            : Request::*MsgEx\Return_String = "Ein Paar fiese Kerle"
                                        
                                    Case "Daring Duo"                   : Request::*MsgEx\Return_String = "Mutiges Duo"                                         
                                        
                                    Case "Encounter 1"                  : Request::*MsgEx\Return_String = "Begegnung 1"
                                    Case "Encounter 2"                  : Request::*MsgEx\Return_String = "Begegnung 2" 
                                        
                                    Case "Fantastic Four"               : Request::*MsgEx\Return_String = "Die fantastischen Vier"                                        
                                    Case "Fear the Four"                : Request::*MsgEx\Return_String = "Fürchte die Vier"
                                        
                                    Case "Gratha Leader"                : Request::*MsgEx\Return_String = "Gratha-Führer" 
                                    Case "Good Odds"                    : Request::*MsgEx\Return_String = "Gute Chancen" 
                                        
                                    Case "Kilrathi Base"                : Request::*MsgEx\Return_String = "Kilrathi-Basis"                                        
                                    Case "Kilrathi Squad"               : Request::*MsgEx\Return_String = "Kilrathi-Staffel"
                                    Case "Kilrathi Wingmen"             : Request::*MsgEx\Return_String = "Kilrathi-Rotten"                                         
                                        
                                    Case "Nav 1"                        : Request::*MsgEx\Return_String = "Nav 1" 
                                    Case "Nav 2"                        : Request::*MsgEx\Return_String = "Nav 2" 
                                    Case "Nav 3"                        : Request::*MsgEx\Return_String = "Nav 3"                                         
                                    Case "Nav 4"                        : Request::*MsgEx\Return_String = "Nav 4"                                        
                                    Case "Not So Good Odds"             : Request::*MsgEx\Return_String = "Keine guten Chancen" 
                                        
                                    Case "Rendezvous"                   : Request::*MsgEx\Return_String = "Treffen" 
                                        
                                    Case "Set Up (Sting)"               : Request::*MsgEx\Return_String = "Set Up (Sting)"                                         
                                    Case "Solo Flight"                  : Request::*MsgEx\Return_String = "Soloflug" 
                                    Case "Still Good Odds"              : Request::*MsgEx\Return_String = "Noch gute Chancen" 
                                        
                                    Case "Tiger's Claw"                 : Request::*MsgEx\Return_String = "Tiger's Claw"
                                    Case "Tigger's Claw"                : Request::*MsgEx\Return_String = "Tiger's Claw"                                        
                                    Case "Tigers's Claw"                : Request::*MsgEx\Return_String = "Tiger's Claw"                                       
                                    Case "Triplet Terror"               : Request::*MsgEx\Return_String = "Dreifacher Terror"
                                    Case "Triple Terror"                : Request::*MsgEx\Return_String = "Dreifacher Terror"                                         
                                    Case "Triple Threat"                : Request::*MsgEx\Return_String = "Dreifache Gefahr"   

                                    Case ".Ambush"                      : Request::*MsgEx\Return_String = ".Hinterhalt"
                                    Case ".Asteroids"                   : Request::*MsgEx\Return_String = ".Asteroiden"                                         
                                    Case ".Asteroid Field"              : Request::*MsgEx\Return_String = ".Asteroidenschwarm"
                                        
                                    Case ".Chase 1"                     : Request::*MsgEx\Return_String = ".Jagd 1" 
                                    Case ".Chase 2"                     : Request::*MsgEx\Return_String = ".Jagd 2" 
                                    Case ".Chase 3"                     : Request::*MsgEx\Return_String = ".Jagd 3"  
                                        
                                    Case ".Encoutner 1"                 : Request::*MsgEx\Return_String = "Begegnung 1"                                         
                                    Case ".Encounter"                   : Request::*MsgEx\Return_String = ".Begegnung"
                                    Case ".Encounter A"                 : Request::*MsgEx\Return_String = ".Begegnung A"                                      
                                    Case ".Encounter B"                 : Request::*MsgEx\Return_String = ".Begegnung B"   
                                        
                                    Case ".Kilrathi Base"               : Request::*MsgEx\Return_String = ".Kilrathi-Basis" 
                                        
                                    Case ".More Mines"                  : Request::*MsgEx\Return_String = ".Mehr Minen"
                                    Case ".More Asteroids"              : Request::*MsgEx\Return_String = ".Mehr Asteroiden"                                        
                                    Case ".Mines"                       : Request::*MsgEx\Return_String = ".Minen"
                                    Case ".Mines1"                      : Request::*MsgEx\Return_String = ".Minen 1"
                                    Case ".Mines2"                      : Request::*MsgEx\Return_String = ".Minen 2"
                                    Case ".Mines3"                      : Request::*MsgEx\Return_String = ".Minen 3"
                                    Case ".Mines4"                      : Request::*MsgEx\Return_String = ".Minen 4"                                        
                                    Case ".Mines (4000)"                : Request::*MsgEx\Return_String = ".Minen (4000)"
                                    Case ".Mines (5000(a))"             : Request::*MsgEx\Return_String = ".Minen (5000 (a))"
                                    Case ".Mines (5000(b))"             : Request::*MsgEx\Return_String = ".Minen (5000 (b))"                                        
                                    Case ".Mines (6000)"                : Request::*MsgEx\Return_String = ".Minen (6000)"
                                    Case ".Mines (7500)"                : Request::*MsgEx\Return_String = ".Minen (7500)" 
                                    Case ".Minefield"                   : Request::*MsgEx\Return_String = ".Minenfeld" 
                                    Case ".MineFields"                  : Request::*MsgEx\Return_String = ".Minenfelder"
                                    Case ".Mine Fields"                 : Request::*MsgEx\Return_String = ".Minenfelder"                                        
                                    Case ".Mid1"                        : Request::*MsgEx\Return_String = ".Mitte 1"
                                    Case ".Mid2"                        : Request::*MsgEx\Return_String = ".Mitte 2"
                                    Case ".Return Encount"              : Request::*MsgEx\Return_String = ".Rückkehr & Begegnung"
                                        
                                    Case ".Stroids"                     : Request::*MsgEx\Return_String = ".Asteroiden"
                                    Case ".Stroids 1"                   : Request::*MsgEx\Return_String = ".Asteroiden 1"
                                    Case ".Stroids 2"                   : Request::*MsgEx\Return_String = ".Asteroiden 2"
                                    Case ".Stroids 3"                   : Request::*MsgEx\Return_String = ".Asteroiden 3"
                                    Case ".Stroids 4"                   : Request::*MsgEx\Return_String = ".Asteroiden 4"
                                    Case ".Stroids 5"                   : Request::*MsgEx\Return_String = ".Asteroiden 5"
                                    Case ".STUPID"                      : Request::*MsgEx\Return_String = ".DUMM"
                                        
                                    Case ".TC wave"                     : Request::*MsgEx\Return_String = ".TC-Welle" 
                                    Case ".TigerClaw"                   : Request::*MsgEx\Return_String = ".Tiger's Claw"                                           
                                    Case ".Tiger's Claw"                : Request::*MsgEx\Return_String = ".Tiger's Claw"
                                    Case ".Tigger's Claw"               : Request::*MsgEx\Return_String = ".Tiger's Claw"                                        
                                    Case ".Tigers's Claw"               : Request::*MsgEx\Return_String = ".Tiger's Claw"                                        
                                        
                                    Case ".Wave1"                       : Request::*MsgEx\Return_String = ".Welle 1"
                                    Case ".Wave 1"                      : Request::*MsgEx\Return_String = ".Welle 1"                                           
                                    Case ".Wave2"                       : Request::*MsgEx\Return_String = ".Welle 2"
                                    Case ".Wave 2"                      : Request::*MsgEx\Return_String = ".Welle 2"                                          
                                    Case ".Wave3"                       : Request::*MsgEx\Return_String = ".Welle 3"
                                    Case ".Wave 3"                      : Request::*MsgEx\Return_String = ".Welle 3"
                                    Case ".Wave4"                       : Request::*MsgEx\Return_String = ".Welle 4"
                                    Case ".Wave 4"                      : Request::*MsgEx\Return_String = ".Welle 4" 
                                    ;Case ""                : Request::*MsgEx\Return_String = ""                                        
                                    Default                                
                                        Request::*MsgEx\Return_String = XMLAttributeValue(*CurrentNode)   
                                EndSelect                                        
                            Default
                                sMaxLen$ = ""
                            Request::*MsgEx\Return_String = XMLAttributeValue(*CurrentNode)                                
                        EndSelect                                                                        

                      
                        Request::*MsgEx\User_BtnTextL = "Save/ Next"
                        Request::*MsgEx\User_BtnTextM = "Quit"
                        Request::*MsgEx\User_BtnTextR = "Cancel next"      
                        
                        DialogMessage$=""
                        
                        If ( Len( LastDialog$ ) > 1 )
                            DialogMessage$ + #CR$ + #CR$ + "- Letzter Geänderter Dialog " + #CR$ 
                            
                            If ( Len( LastDialog$ ) > Val(sMaxLen$) ) And ( sMaxLen$ = "131" )
                                DialogMessage$ + "[ ist Lang " + Str( Len(LastDialog$) ) + "]" + #CR$ + #CR$  
                                Beep_(523,500)
                            EndIf   
                            
                            DialogMessage$+ " ["+ Str(Count-1) +"] " + Chr(34) + LastDialog$ + Chr(34) + #CR$ + #CR$                                                            
                        EndIf
                        
                      
                        DialogMessage$ + " ["+ Str(Count) +"] " + Chr(34) + XMLAttributeValue(*CurrentNode) + Chr(34)  + #CR$ + #CR$                     
                        ResetList( DialogSettingItem() )
                        While NextElement( DialogSettingItem() )
                            If ( DialogSettingItem()\Position = CntDX)
                                   DialogMessage$ + "[Background= "+  DialogSettingItem()\Background + "] " + #TAB$
                                   DialogMessage$ + "[Delay     = "+  DialogSettingItem()\Delay      + "] " + #TAB$
                                   DialogMessage$ + "[Foreground= "+  DialogSettingItem()\Foreground + "] " + #TAB$
                                   DialogMessage$ + "[TextColor = "+  DialogSettingItem()\TextColor  + "] "
                                   Break;
                            EndIf
                        Wend
                                                                  
                        
                        DialogMessage$ + #CR$
                        If ( bLipSync = #True )
                            NewDelayLenght = Len( Request::*MsgEx\Return_String) *2 + 20
                        Else
                            NewDelayLenght = 300 + Len( Request::*MsgEx\Return_String)*2
                        EndIf    
                        
                        r = Request::MSG( " Max: " + sMaxLen$ + " " + GetFilePart( FileName$ ), "< Dialog Item Nr."+ Str(Count) +" > " + "Rec. Delay :" + Str( NewDelayLenght ) ,DialogMessage$,16,0,"",0,1,0,#True) 
                        If ( r = 0 )       

                            Select XMLAttributeName(*CurrentNode)
                                Case "Text":   
                                    SetXMLAttribute(*CurrentNode, "Text", Request::*MsgEx\Return_String)                                    
                                Case "Message"
                                    SetXMLAttribute(*CurrentNode, "Message", Request::*MsgEx\Return_String)
                                Case "Name"
                                    SetXMLAttribute(*CurrentNode, "Name", Request::*MsgEx\Return_String)                                    
                            EndSelect    
                            
                            SetFileName$ = GetFilePart( FileName$ )
                            SetPathName$ = GetPathPart( FileName$ )

                            Debug "- Neuer String:     " + Request::*MsgEx\Return_String                                                                                    
                            Debug "- Neuer XML Inhalt: " + XMLAttributeValue(*CurrentNode)
                            
                            SaveXML(#XML, SetPathName$ + SetFileName$ )
                            Debug "- Saved to       :  " + SetPathName$ + SetFileName$
                            
                            LastDialog$ = Request::*MsgEx\Return_String
                            
                        EndIf
                        If ( r = 2 )  
                            SaveXML(#XML,FileName$ )
                            Debug "- Saved to (Quit):  " + FileName$
                            Request::MSG("Simple XML Briefing Tool", "< Dialog Item Nr."+ Str(Count) +" >"     ,"Letzte Dialog Item Nummer: " + Str(Count) ,2,1) ; Attention
                            End
                        EndIf    
                    EndIf    
                EndIf    
            EndIf    
        Wend
    EndIf
    
    Text$+ " " + GetXMLNodeText(*CurrentNode)
 
    
    ;AddGadgetItem(#TreeGadget, -1, Text$, 0, CurrentSublevel)
        
        
    ; Now get the first child node (if any)
    ;    
    *ChildNode = ChildXMLNode(*CurrentNode)

    ; Loop through all available child nodes and call this procedure again
    ;
    While *ChildNode <> 0
        FillTree(*ChildNode, CurrentSublevel + 1,FileName$)
        
        
        *ChildNode = NextXMLNode(*ChildNode)
    Wend        
  
  EndIf

EndProcedure

FileName$ = OpenFileRequester("Choose XML file...", "", "XML files (*.xml)|*.xml|All files (*.*)|*.*", 0)
If FileName$ <> ""

  If LoadXML(#XML, FileName$)

    ; Note: 
    ;   The LoadXML() succeed if the file could be read. This does not mean that
    ;   there was no error in the XML though. To check this, XMLStatus() can be
    ;   used.
    ;
    ; Display an error message if there was a markup error
    ;
    If XMLStatus(#XML) <> #PB_XML_Success
      Message$ = "Error in the XML file:" + Chr(13)
      Message$ + "Message: " + XMLError(#XML) + Chr(13)
      Message$ + "Line: " + Str(XMLErrorLine(#XML)) + "   Character: " + Str(XMLErrorPosition(#XML))
      MessageRequester("Error", Message$)
    EndIf
    
    ; Note:
    ;   Even if there was an error in the XML, all nodes before the error position
    ;   are still accessible, so open the window and show the tree anyway.
    ;
    If OpenWindow(#Window, 0, 0, 5, 52, "XML Example", #PB_Window_SystemMenu)
       HideWindow( #Window, 1 )
     ; TreeGadget(#TreeGadget, 10, 10, 480, 480)
       
       Request::*MsgEx\Return_String = Str(0)
       Request::*MsgEx\User_BtnTextL = "Go ..."
       Request::*MsgEx\User_BtnTextM = "Quit"
       Request::*MsgEx\User_BtnTextR = "From 0"        
       r = Request::MSG("Simple XML Briefing Tool", "Jump to Dialog Nr,"  ,"",16,0,"",0,1) 
       If ( r = 0 ) 
           Start.i = Val( Request::*MsgEx\Return_String )
       EndIf
       If ( r = 2 )  
           End
       EndIf
       If ( r = 1 ) 
           Start.i = 1
       EndIf       
      ; Get the main XML node, and call the FillTree() procedure with it
      ;
      *MainNode = MainXMLNode(#XML)      
      If *MainNode
          FillTree(*MainNode, 0, FileName$)
          
          ;SaveXML(#XML,FileName$ )
           Debug "- Saved to (Quit):  " + FileName$
           Request::MSG("Simple XML Briefing Tool", "End Of File"     ,"Das Wars .... fertig",2,1) ; Attention          
          End
      EndIf
      
      ; Expand all nodes for a nicer view
      ;
      ;For i = 0 To CountGadgetItems(#TreeGadget) - 1
      ;  SetGadgetItemState(#TreeGadget, i, #PB_Tree_Expanded)
      ;Next i
      
      ; Wait for the window close event.
      ;
      Repeat
        Event = WaitWindowEvent()
      Until Event = #PB_Event_CloseWindow
    EndIf
        
  Else
    MessageRequester("Error", "The file cannot be opened.")
  EndIf

EndIf


; IDE Options = PureBasic 5.73 LTS (Windows - x64)
; CursorPosition = 154
; FirstLine = 120
; Folding = -
; EnableAsm
; EnableXP
; DPIAware
; Executable = Simple Briefing XML Editor.exe