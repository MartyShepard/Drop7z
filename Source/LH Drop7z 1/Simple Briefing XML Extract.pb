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
#CreatFile  = 999
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

    EndIf
    
    If ( GetXMLNodeName(*CurrentNode) = "ConversationItem.Dialogs")                                              
        WriteStringN(#CreatFile, "==================================================================================================================================" + #CR$) 
        WriteStringN(#CreatFile, Str( Count))

        
    EndIf
    
    If ExamineXMLAttributes(*CurrentNode)
        
        While NextXMLAttribute(*CurrentNode)
            Text$ + " Attribute:" + XMLAttributeName(*CurrentNode) + "=" + Chr(34) + XMLAttributeValue(*CurrentNode) + Chr(34) + " "            
            
        If ( XMLAttributeName(*CurrentNode) = "Text" ) Or 
               ( XMLAttributeName(*CurrentNode) = "Message" ) Or 
               ( XMLAttributeName(*CurrentNode) = "Name" )
            
            
            If Len( XMLAttributeValue(*CurrentNode)) > 1
                
                Count + 1 
                
                
                
                If ( Count >= Start )
                    
                    ; Automatische Übersetzung
                    Select XMLAttributeName(*CurrentNode)
                        Case "Text"
                        Case "Message"                              
                        Case "Name"                                                                                                      
                        Default                              
                    EndSelect                                                                        
                    
                    DialoagTXT$ = XMLAttributeValue(*CurrentNode)                         
                    WriteStringN(#CreatFile, DialoagTXT$)                                                
                        
                    
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
      CreateFile(#CreatFile, "C:\ExtractedText.txt") 
           
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
; CursorPosition = 62
; FirstLine = 60
; Folding = -
; EnableAsm
; EnableXP