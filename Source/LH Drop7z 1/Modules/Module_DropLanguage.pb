;
;
;   Drop7z Language Module (Support, En, De)

DeclareModule DropLang
    
    Declare.i   GetLngSysUI(Option.i = 0)
    Declare.s   GetUIText  (oElememnt.i = 0, DebugInfo = 0)
    
    
EndDeclareModule

Module DropLang
    
    Global NewList LocaleTable.s()       
    ;
    ;
    ;
    Procedure    LanguageTable_CreateDE()
        
        NewList TableDE.s()
        
        ;
        ; Füge Inhalt Hinzu
        ; 00        
        AddElement(TableDE()): TableDE() =  ""                                              ; Poistion 0
        ; 01 - 05
        AddElement(TableDE()): TableDE() = "Bitte Warten. 7z Komprimiert die Daten.."  
        AddElement(TableDE()): TableDE() = "Bitte Warten. 7z Überprüft das Archiv"
        AddElement(TableDE()): TableDE() = "Bitte Warten. 7z Überprüft das Archiv"          ; Wird zur zeit nicht benutzt
        AddElement(TableDE()): TableDE() = "Bitte Warten. Erstelle SH1 Quersumme: "         
        AddElement(TableDE()): TableDE() = "Zielverzeichnis  "        
        ; 06 - 10
        AddElement(TableDE()): TableDE() = "Angabe von Multivolume Grösse in MB/GB (wie 30MB/15GB). Keine Angabe ist immer MB" 
        AddElement(TableDE()): TableDE() = "Aktviere die Passwort Option um das Archiv zu verschlüsseln"  
        AddElement(TableDE()): TableDE() = "Überprüft das Archiv Automatisch nach dem Komprimieren"
        AddElement(TableDE()): TableDE() = "Komprimiert Dateien die von anderen Prozessen geöffent sind"
        AddElement(TableDE()): TableDE() = "Öffent nach dem Komprimieren das Mail Programm und fügt das Archiv als Dateianhang hinzu"        
        ; 11 - 15        
        AddElement(TableDE()): TableDE() = "Wenn markiert wird ein Selbst entpackendes Archiv erstellt (SFX)"
        AddElement(TableDE()): TableDE() = "Größe: "
        AddElement(TableDE()): TableDE() = "Aktuell "
        AddElement(TableDE()): TableDE() = "Aktuelles Profil: "
        AddElement(TableDE()): TableDE() = "Verzeichnis"
        ; 16 - 20          
        AddElement(TableDE()): TableDE() = "Datei"
        AddElement(TableDE()): TableDE() = "Ziehe Datei(en) oder Verzeichnis(se) in dieses Fenster"
        AddElement(TableDE()): TableDE() = "Größe: ...Berechne"
        AddElement(TableDE()): TableDE() = "      Item(s): "
        AddElement(TableDE()): TableDE() = "Now Look What You've Done"
        ; 21 - 25        
        AddElement(TableDE()): TableDE() = "No Files, No Work, No Compress!"
        AddElement(TableDE()): TableDE() = "Nichts zu tun!" +#CR$+ "Füge Dateien oder Verzeichnisse mit Dragn'nDrop in das Fenster"
        AddElement(TableDE()): TableDE() = " wurde nicht gefunden!"
        AddElement(TableDE()): TableDE() = "7z wurde nicht gefunden. Weder in den System Pfaden, in der" + #CR$ + "Registry noch im Programm Ordner wo sich Drop7z aufhält."
        AddElement(TableDE()): TableDE() = "Ziel Verzeichnis nicht gefunden" 
        ; 26 - 30         
        AddElement(TableDE()): TableDE() = "Verzeichnis nicht gefunden:"
        AddElement(TableDE()): TableDE() = "Can't create Archive! on Drive: "        
        AddElement(TableDE()): TableDE() = "Kann das Archiv nicht auf CD/DVD Laufwerk erstellen."+ #CR$ + "Bitte anderes Zielverzeichnis wählen."
        AddElement(TableDE()): TableDE() = "<- ERR0R ->"
        AddElement(TableDE()): TableDE() = "Listindex is NULL. Data Mismatch"   
        ; 31 - 35
        AddElement(TableDE()): TableDE() = "Kann das Multivolume Archiv nbicht Erstellen!"
        AddElement(TableDE()): TableDE() = "Datei Existiert"
        AddElement(TableDE()): TableDE() = "Überschreiben oder Aktulasieren?"
        AddElement(TableDE()): TableDE() = "Überschreiben"
        AddElement(TableDE()): TableDE() = "Aktualisieren"          
        ; 36 - 40        
        AddElement(TableDE()): TableDE() = "Abbruch" 
        AddElement(TableDE()): TableDE() = "Erfolgreich beendet"
        AddElement(TableDE()): TableDE() = "Alle Dateien wurden Erfolfgreich Komprimiert"
        AddElement(TableDE()): TableDE() = "Es wurden nicht alle Dateien Komprimiert."          
        ;
        ; Kopiere die List
        CopyList( TableDE.s(), LocaleTable.s() ): FreeList( TableDE.s() )        
        
    EndProcedure
    ;
    ;
    ;
    Procedure    LanguageTable_CreateEN()
        
        NewList TableEN.s()
        
        ;
        ; Füge Inhalt Hinzu
        ; 00
        AddElement(TableEN()): TableEN() =  ""                                              ; Poistion 0            
        ; 01 - 05        
        AddElement(TableEN()): TableEN() = "Please WAIT. 7z Compressed Data.."  
        AddElement(TableEN()): TableEN() = "Please Wait. 7z Verify Compressed Data"         
        AddElement(TableEN()): TableEN() = "Please WAIT. 7z Verify Extract Data"            ; Wird zur zeit nicht benutzt
        AddElement(TableEN()): TableEN() = "Please Wait. Create SH1 Checksum: " 
        AddElement(TableEN()): TableEN() = "Destination Path   "        
        ; 06 - 10
        AddElement(TableEN()): TableEN() = "Edit Multi Volumes Size in MB/GB (eq: 30MB/15GB). w/o Size Default is MB"        
        AddElement(TableEN()): TableEN() = "Enable and add a Password to Encrypt the Archive(s)"        
        AddElement(TableEN()): TableEN() = "Verify the archiv automatic after compression"
        AddElement(TableEN()): TableEN() = "Compressed Files are in used and Open from other Processes"
        AddElement(TableEN()): TableEN() = "Opens after Compression your default Mail Program and add the Archiv to the Mail Attachment"
        ; 11 - 15
        AddElement(TableEN()): TableEN() = "If enabled it create a self extracted archiv (SFX)."
        AddElement(TableEN()): TableEN() = "Size: "
        AddElement(TableEN()): TableEN() = "Current "
        AddElement(TableEN()): TableEN() = "Current Profil: "
        AddElement(TableEN()): TableEN() = "Directory"
        ; 16 - 20
        AddElement(TableEN()): TableEN() = "Files"
        AddElement(TableEN()): TableEN() = "Drag'n'Drop File(s) or Folder(s) in this Window"
        AddElement(TableEN()): TableEN() = "Size: ...Calculate"
        AddElement(TableEN()): TableEN() = "      Item(s): "
        AddElement(TableEN()): TableEN() = "Now Look What You've Done"
        ; 21 - 25        
        AddElement(TableEN()): TableEN() = "No Files, No Work, No Compress!"
        AddElement(TableEN()): TableEN() = "Nothing to do!" +#CR$+ "Add File's and or Directory's via Drag'n'Drop to the Window."    
        AddElement(TableEN()): TableEN() = " was Not found!"
        AddElement(TableEN()): TableEN() = "7z was not found. Neither in the system paths, in the " + #CR$ + " registry nor IN the program folder where Drop7z is located."
        AddElement(TableEN()): TableEN() = "Destination directory Not found!"
        ; 26 - 30         
        AddElement(TableEN()): TableEN() = "Directory not found:"
        AddElement(TableEN()): TableEN() = "Can't create Archive! on Drive: "
        AddElement(TableEN()): TableEN() = "Can't create archiv on CD/DVD. Please select another destination path."
        AddElement(TableEN()): TableEN() = "<- ERR0R ->"
        AddElement(TableEN()): TableEN() = "Listindex is NULL. Data Mismatch"  
        ; 31 - 35
        AddElement(TableEN()): TableEN() = "Can't create a Multivolume Archiv!"       
        AddElement(TableEN()): TableEN() = "File Exists!"
        AddElement(TableEN()): TableEN() = "overwrite or Update"
        AddElement(TableEN()): TableEN() = "Overwrite"
        AddElement(TableEN()): TableEN() = "Update"          
        ; 36 - 40        
        AddElement(TableEN()): TableEN() = "Abort"
        AddElement(TableEN()): TableEN() = "Successfully finished"
        AddElement(TableEN()): TableEN() = "All files were successfully compressed"
        AddElement(TableEN()): TableEN() = "Not all files were compressed."         
        ;
        ; Kopiere die List
        CopyList( TableEN.s(), LocaleTable.s() ): FreeList( TableEN.s() )
        
    EndProcedure    
    ;
    ;
    ;
    Procedure.s   GetUIText  (oElememnt.i = 0, DebugInfo.i = 0)
        
        ResetList( LocaleTable() )
        
        If ( ListSize( LocaleTable() ) >= 0 )
            
            SelectElement( LocaleTable(), oElememnt )
            
            If ( DebugInfo = 1 )
                Debug ""
                Debug "Language: " + Str( GetUserDefaultLangID_() & $0003FF ) + " / Code: " + Str( GetLngSysUI(-1) )
                Debug "ListNum : " + Str( oElememnt )
                Debug "Content : " + Chr(34) + LocaleTable() + Chr(34)
            EndIf
            
            ProcedureReturn LocaleTable()
        EndIf    
        
        ProcedureReturn "LANGUAGE ERROR (" + Str(oElememnt) + ")"
        
    EndProcedure    
    ;
    ;
    ; -1 Kombatibilitäs Modus
    ; 
    Procedure.i GetLngSysUI(Option.i = 0)
                
        Protected DropLanguageCode.i = -1
                       
        Select ( GetUserDefaultLangID_() & $0003FF )                
            Case #LANG_GERMAN
                DropLanguageCode = 407
                
                If ( Option = 0 )                     
                    LanguageTable_CreateDE()
                EndIf
                
            Case #LANG_ENGLISH, #LANG_FRENCH, #LANG_RUSSIAN, #LANG_SPANISH                 
                DropLanguageCode = 409
                
                If ( Option = 0 )                     
                    LanguageTable_CreateEN()
                EndIf                
                                
            Default             
                DropLanguageCode = 409
                
                If ( Option = 0 )                     
                    LanguageTable_CreateEN()
                EndIf                
                
        EndSelect        
        
    If ( Option = -1 )    
        ProcedureReturn DropLanguageCode
    EndIf        
    EndProcedure              
EndModule
; IDE Options = PureBasic 5.73 LTS (Windows - x64)
; CursorPosition = 48
; FirstLine = 22
; Folding = --
; EnableAsm
; EnableXP
; UseMainFile = ..\Drop7z.pb
; Compiler = PureBasic 5.62 (Windows - x64)