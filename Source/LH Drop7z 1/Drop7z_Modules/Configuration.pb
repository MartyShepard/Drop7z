DeclareModule CFG
    
    Structure INI_STRUCTURE
            WindowTitle.s{384}
            Autostart.i
            MiniMized.i
            DesktopX.l
            DesktopY.l
            DesktopW.l
            DesktopH.l
            Sticky.i        
            Instanz.i
            DeleteFiles.i
            AutoClearLt.i
            DontAskMe.i
            CreateSHA1.i
            Version.s{128}            
            ConfigPath.s{#MAX_PATH}
            ProfilePath.s{#MAX_PATH}
            HistoryPath.s{#MAX_PATH}
            CRCLastPath.s{#MAX_PATH}
            usFormat.i                  ; Aktuelles Pack Format
            ZipMethodID.i
            CHDszPath.s{#MAX_PATH}      ; Mame's CHDMan Tool
            CHDbClipBoard.i
            CHDbSticky.i
            PinDirectory.i
            szPinCurrent.s
        EndStructure    
        
        *Config.INI_STRUCTURE       = AllocateMemory(SizeOf(INI_STRUCTURE))
        
        Declare ReadConfig(*Config.INI_STRUCTURE)
        Declare WriteConfig(*Config.INI_STRUCTURE)
        Declare Make_Config(*Config.INI_STRUCTURE)
        
        Declare.s MakeHistory(szFileHistory.s,Force=0)
EndDeclareModule 

Module CFG
    
    ;
    ; Akuell Configuration die geschrieben wird
    ;    
    Procedure Make_Config(*Config.INI_STRUCTURE)
        
            CreateFile(DC::#_FileConfig,*Config\ConfigPath.s)
            
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
                WriteStringN(DC::#_FileConfig, "")
                WriteStringN(DC::#_FileConfig, "# Current Pack Format...............")                 
                WriteStringN(DC::#_FileConfig, "usFormat=7z")
                WriteStringN(DC::#_FileConfig, "")
                WriteStringN(DC::#_FileConfig, "# ZIP Options.......................")                 
                WriteStringN(DC::#_FileConfig, "ZipMethodID=0")
                WriteStringN(DC::#_FileConfig, "")
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
    Procedure.s MakeHistory(szFileHistory.s,Force=0)

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
        Protected Size.i
        
        
        *Config\Version.s    = "1.00b FF"
        *Config\WindowTitle.s= "Drop7z v"+ *Config\Version.s +" By Marty Shepard"
        
        *Config\ConfigPath.s = GetPathPart( ProgramFilename() ) + "Drop7z.ini"
        *Config\ProfilePath.s= GetPathPart( ProgramFilename() ) + "Drop7z_Profiles.ini"
        *Config\HistoryPath.s= GetPathPart( ProgramFilename() ) + "Drop7z_History.ini"
        
            Debug ""
            Debug "Drop 7z Home Directory"
            Debug "Home: "+ ProgramFilename()
            Debug "Conf: "+ *Config\ConfigPath.s
            Debug "Prof: "+ *Config\ProfilePath.s
            Debug "Hist: "+ *Config\HistoryPath.s
        
        Size.i = FileSize(*Config\ConfigPath.s)
        Select Size.i
            Case 0,-1
                Make_Config(*Config.INI_STRUCTURE)
        EndSelect        
        
        Size.i = FileSize(*Config\HistoryPath.s)
        Select Size.i
            Case 0,-1
                MakeHistory(*Config\HistoryPath)
        EndSelect       
        
        ;
        ;Ini Values mit String
        Select (UCase( INIValue::Get_s("SETTINGS", "usFormat" ,*Config\ConfigPath.s) ) )
            Case "7Z"   : *Config\usFormat = 0
            Case "ZIP"  : *Config\usFormat = 1
            Case "CHD"  : *Config\usFormat = 2
            Default 
                *Config\usFormat = 0
        EndSelect 
               
        *Config\CRCLastPath = INIValue::Get_S("SETTINGS","Directory0"       ,*Config\ConfigPath.s)
        *Config\CHDszPath	= INIValue::Get_S("SETTINGS","CHDManTool"       ,*Config\ConfigPath.s) 
        *Config\szPinCurrent= INIValue::Get_S("SETTINGS","PinCurrentVZ"     ,*Config\ConfigPath.s)
        ;
        ; Ini Values mit Integer
        *Config\DesktopX    = INIValue::Get_I("SETTINGS","Desktop.X"        ,*Config\ConfigPath.s)
        *Config\DesktopY    = INIValue::Get_I("SETTINGS","Desktop.Y"        ,*Config\ConfigPath.s)
        *Config\ZipMethodID = INIValue::Get_I("SETTINGS","ZipMethodID"      ,*Config\ConfigPath.s)  
        
        ;
        ; Ini Values mit true/false
        *Config\Autostart   = INIValue::Get_Value("SETTINGS","Autostart"    ,*Config\ConfigPath.s)
        *Config\MiniMized   = INIValue::Get_Value("SETTINGS","MiniMized"    ,*Config\ConfigPath.s)
        *Config\Sticky      = INIValue::Get_Value("SETTINGS","Sticky"       ,*Config\ConfigPath.s)
        *Config\DeleteFiles = INIValue::Get_Value("SETTINGS","DeleteFiles"  ,*Config\ConfigPath.s)          
        *Config\Instanz     = INIValue::Get_Value("SETTINGS","SingleInstanz",*Config\ConfigPath.s)
        *Config\AutoClearLt = INIValue::Get_Value("SETTINGS","AutoClearLt"  ,*Config\ConfigPath.s) 
        *Config\DontAskMe   = INIValue::Get_Value("SETTINGS","DontAskMe"    ,*Config\ConfigPath.s)
        *Config\CreateSHA1  = INIValue::Get_Value("SETTINGS","CreateSHA1"   ,*Config\ConfigPath.s)
        *Config\CHDbClipBoard=INIValue::Get_Value("SETTINGS","ClipBoard"    ,*Config\ConfigPath.s)
        *Config\CHDbSticky  = INIValue::Get_Value("SETTINGS","CHDSticky"    ,*Config\ConfigPath.s) 
        *Config\PinDirectory= INIValue::Get_Value("SETTINGS","PinDirectory" ,*Config\ConfigPath.s)
    EndProcedure
    
    ;
    ;
    ;  Schreibe Configuration
    Procedure WriteConfig(*Config.INI_STRUCTURE)   
        ;
        ; Setze Ini Values mit String oder Integer
        Select *Config\usFormat
            Case 0: INIValue::Set("SETTINGS","usFormat","7Z"    ,*Config\ConfigPath.s)
            Case 1: INIValue::Set("SETTINGS","usFormat","ZIP"   ,*Config\ConfigPath.s)
            Case 2: INIValue::Set("SETTINGS","usFormat","CHD"   ,*Config\ConfigPath.s)                
        EndSelect

        INIValue::Set("SETTINGS","ZipMethodID"  ,Str(   *Config\ZipMethodID)    ,*Config\ConfigPath.s)
        INIValue::Set("SETTINGS","Desktop.X"    ,Str(   *Config\DesktopX )      ,*Config\ConfigPath.s)
        INIValue::Set("SETTINGS","Desktop.Y"    ,Str(   *Config\DesktopY )      ,*Config\ConfigPath.s)
        
        ;
        ; Setze Ini Values mit True/False        
        INIValue::Set_Value("SETTINGS","Autostart"      ,*Config\Autostart      ,*Config\ConfigPath.s)
        INIValue::Set_Value("SETTINGS","MiniMized"      ,*Config\MiniMized      ,*Config\ConfigPath.s)
        INIValue::Set_Value("SETTINGS","Sticky"         ,*Config\Sticky         ,*Config\ConfigPath.s)
        INIValue::Set_Value("SETTINGS","SingleInstanz"  ,*Config\Instanz        ,*Config\ConfigPath.s) 
        INIValue::Set_Value("SETTINGS","DeleteFiles"    ,*Config\DeleteFiles    ,*Config\ConfigPath.s)
        INIValue::Set_Value("SETTINGS","AutoClearLt"    ,*Config\AutoClearLt    ,*Config\ConfigPath.s)
        INIValue::Set_Value("SETTINGS","DontAskMe"      ,*Config\DontAskMe      ,*Config\ConfigPath.s)
        INIValue::Set_Value("SETTINGS","ClipBoard"      ,*Config\CHDbClipBoard  ,*Config\ConfigPath.s)
        INIValue::Set_Value("SETTINGS","CHDSticky"      ,*Config\CHDbSticky     ,*Config\ConfigPath.s)        
        INIValue::Set_Value("SETTINGS","CreateSHA1"     ,*Config\CreateSHA1     ,*Config\ConfigPath.s)    
        INIValue::Set_Value("SETTINGS","PinDirectory"   ,*Config\PinDirectory   ,*Config\ConfigPath.s)        
        
    EndProcedure
EndModule
; IDE Options = PureBasic 6.00 LTS (Windows - x64)
; CursorPosition = 113
; FirstLine = 84
; Folding = --
; EnableAsm
; EnableXP
; UseMainFile = ..\Drop7z.pb
; CurrentDirectory = ..\Drop7z\
; EnableUnicode