DeclareModule  DropLs
    
    Structure SIZE_DICTIONARY
        Num.i
        sSize.s
        iSize.i
    EndStructure
    
    Structure SIZE_WORD
        Num.i
        sSize.s
        iSize.i
    EndStructure
    
    Structure SIZE_SOLIDBLOCK
        Num.i
        sSize.s
        iSize.i
    EndStructure
    
    Structure SPLIT_SIZE
        Num.i
        sSize.s
        iSize.i
    EndStructure
    
    Structure SIZE_COMPRESS
        Num.i
        sType.s
        iLevel.i
        SizeDict.i
    EndStructure
    
    Structure CONVERT_ARCHIVES
        Num.i
        Suffix.s
        iAsk.i
    EndStructure
    
    Structure DELETE_ERRORCODES
        Number.i
        Error_Dec.i
        Error_Hex.s
        Error_Intern.s
        Error_Description.s
    EndStructure
    
    Global NewList DeleteCodes.DELETE_ERRORCODES()
    
    Global NewList SizeDict.SIZE_DICTIONARY()
    Global NewList SizeWord.SIZE_WORD()
    Global NewList SizeBlock.SIZE_SOLIDBLOCK()
    Global NewList SizeSplit.SPLIT_SIZE()
    Global NewList Compression.SIZE_COMPRESS()
    Global NewList ExoticArcs.CONVERT_ARCHIVES()
    
      Declare CreateStructs()
    
EndDeclareModule
Module DropLs
    
    
    Procedure CreateStructs()
        AddElement(ExoticArcs()): ExoticArcs()\Num =  0  :ExoticArcs()\Suffix = "ARJ"       :ExoticArcs()\iAsk = 0
        AddElement(ExoticArcs()): ExoticArcs()\Num =  1  :ExoticArcs()\Suffix = "CAB"       :ExoticArcs()\iAsk = 0
        AddElement(ExoticArcs()): ExoticArcs()\Num =  2  :ExoticArcs()\Suffix = "CHM"       :ExoticArcs()\iAsk = 1
        AddElement(ExoticArcs()): ExoticArcs()\Num =  3  :ExoticArcs()\Suffix = "CPIO"      :ExoticArcs()\iAsk = 1
        AddElement(ExoticArcs()): ExoticArcs()\Num =  4  :ExoticArcs()\Suffix = "CRAMFS"    :ExoticArcs()\iAsk = 1
        AddElement(ExoticArcs()): ExoticArcs()\Num =  5  :ExoticArcs()\Suffix = "DEB"       :ExoticArcs()\iAsk = 0
        AddElement(ExoticArcs()): ExoticArcs()\Num =  6  :ExoticArcs()\Suffix = "DMG"       :ExoticArcs()\iAsk = 1
        AddElement(ExoticArcs()): ExoticArcs()\Num =  7  :ExoticArcs()\Suffix = "FAT"       :ExoticArcs()\iAsk = 1
        AddElement(ExoticArcs()): ExoticArcs()\Num =  8  :ExoticArcs()\Suffix = "HFS"       :ExoticArcs()\iAsk = 1
        AddElement(ExoticArcs()): ExoticArcs()\Num =  9  :ExoticArcs()\Suffix = "ISO"       :ExoticArcs()\iAsk = 1
        AddElement(ExoticArcs()): ExoticArcs()\Num = 10  :ExoticArcs()\Suffix = "LZH"       :ExoticArcs()\iAsk = 0
        AddElement(ExoticArcs()): ExoticArcs()\Num = 11  :ExoticArcs()\Suffix = "LZMA"      :ExoticArcs()\iAsk = 0
        AddElement(ExoticArcs()): ExoticArcs()\Num = 12  :ExoticArcs()\Suffix = "MBR"       :ExoticArcs()\iAsk = 1
        AddElement(ExoticArcs()): ExoticArcs()\Num = 13  :ExoticArcs()\Suffix = "MSI"       :ExoticArcs()\iAsk = 1
        AddElement(ExoticArcs()): ExoticArcs()\Num = 14  :ExoticArcs()\Suffix = "NSIS"      :ExoticArcs()\iAsk = 1
        AddElement(ExoticArcs()): ExoticArcs()\Num = 15  :ExoticArcs()\Suffix = "NTFS"      :ExoticArcs()\iAsk = 1
        AddElement(ExoticArcs()): ExoticArcs()\Num = 16  :ExoticArcs()\Suffix = "RAR"       :ExoticArcs()\iAsk = 0
        AddElement(ExoticArcs()): ExoticArcs()\Num = 17  :ExoticArcs()\Suffix = "RPM"       :ExoticArcs()\iAsk = 0
        AddElement(ExoticArcs()): ExoticArcs()\Num = 18  :ExoticArcs()\Suffix = "SQUASHFS"  :ExoticArcs()\iAsk = 1
        AddElement(ExoticArcs()): ExoticArcs()\Num = 19  :ExoticArcs()\Suffix = "UDF"       :ExoticArcs()\iAsk = 1
        AddElement(ExoticArcs()): ExoticArcs()\Num = 20  :ExoticArcs()\Suffix = "VHD"       :ExoticArcs()\iAsk = 1
        AddElement(ExoticArcs()): ExoticArcs()\Num = 21  :ExoticArcs()\Suffix = "WIM"       :ExoticArcs()\iAsk = 1
        AddElement(ExoticArcs()): ExoticArcs()\Num = 22  :ExoticArcs()\Suffix = "XAR"       :ExoticArcs()\iAsk = 0
        AddElement(ExoticArcs()): ExoticArcs()\Num = 23  :ExoticArcs()\Suffix = "Z"         :ExoticArcs()\iAsk = 0
        AddElement(ExoticArcs()): ExoticArcs()\Num = 24  :ExoticArcs()\Suffix = "ZIP"       :ExoticArcs()\iAsk = 0
        
        AddElement(SizeDict()): SizeDict()\Num = 0  :SizeDict()\iSize = 64   :SizeDict()\sSize = "0064 KB"
        AddElement(SizeDict()): SizeDict()\Num = 1  :SizeDict()\iSize = 1    :SizeDict()\sSize = "0001 MB"
        AddElement(SizeDict()): SizeDict()\Num = 2  :SizeDict()\iSize = 2    :SizeDict()\sSize = "0002 MB"
        AddElement(SizeDict()): SizeDict()\Num = 3  :SizeDict()\iSize = 3    :SizeDict()\sSize = "0003 MB"
        AddElement(SizeDict()): SizeDict()\Num = 4  :SizeDict()\iSize = 4    :SizeDict()\sSize = "0004 MB"
        AddElement(SizeDict()): SizeDict()\Num = 5  :SizeDict()\iSize = 6    :SizeDict()\sSize = "0006 MB"
        AddElement(SizeDict()): SizeDict()\Num = 6  :SizeDict()\iSize = 8    :SizeDict()\sSize = "0008 MB"
        AddElement(SizeDict()): SizeDict()\Num = 7  :SizeDict()\iSize = 12   :SizeDict()\sSize = "0012 MB"
        AddElement(SizeDict()): SizeDict()\Num = 8  :SizeDict()\iSize = 16   :SizeDict()\sSize = "0016 MB"
        AddElement(SizeDict()): SizeDict()\Num = 9  :SizeDict()\iSize = 24   :SizeDict()\sSize = "0024 MB"
        AddElement(SizeDict()): SizeDict()\Num =10  :SizeDict()\iSize = 32   :SizeDict()\sSize = "0032 MB"
        AddElement(SizeDict()): SizeDict()\Num =11  :SizeDict()\iSize = 48   :SizeDict()\sSize = "0048 MB"
        AddElement(SizeDict()): SizeDict()\Num =12  :SizeDict()\iSize = 64   :SizeDict()\sSize = "0064 MB"
        AddElement(SizeDict()): SizeDict()\Num =13  :SizeDict()\iSize = 96   :SizeDict()\sSize = "0096 MB"
        AddElement(SizeDict()): SizeDict()\Num =14  :SizeDict()\iSize = 128  :SizeDict()\sSize = "0128 MB"
        AddElement(SizeDict()): SizeDict()\Num =15  :SizeDict()\iSize = 192  :SizeDict()\sSize = "0192 MB"
        AddElement(SizeDict()): SizeDict()\Num =16  :SizeDict()\iSize = 256  :SizeDict()\sSize = "0256 MB"
        AddElement(SizeDict()): SizeDict()\Num =17  :SizeDict()\iSize = 384  :SizeDict()\sSize = "0384 MB"
        AddElement(SizeDict()): SizeDict()\Num =18  :SizeDict()\iSize = 512  :SizeDict()\sSize = "0512 MB"
        AddElement(SizeDict()): SizeDict()\Num =19  :SizeDict()\iSize = 768  :SizeDict()\sSize = "0768 MB"
        AddElement(SizeDict()): SizeDict()\Num =20  :SizeDict()\iSize = 1024 :SizeDict()\sSize = "1024 MB"
        AddElement(SizeDict()): SizeDict()\Num =21  :SizeDict()\iSize = 0    :SizeDict()\sSize = "-------"
        
        AddElement(SizeWord()): SizeWord()\Num = 0  :SizeWord()\iSize = 8   :SizeWord()\sSize = "0008"
        AddElement(SizeWord()): SizeWord()\Num = 1  :SizeWord()\iSize = 12  :SizeWord()\sSize = "0012"
        AddElement(SizeWord()): SizeWord()\Num = 2  :SizeWord()\iSize = 16  :SizeWord()\sSize = "0016"
        AddElement(SizeWord()): SizeWord()\Num = 3  :SizeWord()\iSize = 24  :SizeWord()\sSize = "0024"
        AddElement(SizeWord()): SizeWord()\Num = 4  :SizeWord()\iSize = 32  :SizeWord()\sSize = "0032"
        AddElement(SizeWord()): SizeWord()\Num = 5  :SizeWord()\iSize = 48  :SizeWord()\sSize = "0048"
        AddElement(SizeWord()): SizeWord()\Num = 6  :SizeWord()\iSize = 64  :SizeWord()\sSize = "0064"
        AddElement(SizeWord()): SizeWord()\Num = 7  :SizeWord()\iSize = 96  :SizeWord()\sSize = "0096"
        AddElement(SizeWord()): SizeWord()\Num = 8  :SizeWord()\iSize = 128 :SizeWord()\sSize = "0128"
        AddElement(SizeWord()): SizeWord()\Num = 9  :SizeWord()\iSize = 192 :SizeWord()\sSize = "0192"
        AddElement(SizeWord()): SizeWord()\Num = 10 :SizeWord()\iSize = 256 :SizeWord()\sSize = "0256"
        AddElement(SizeWord()): SizeWord()\Num = 11 :SizeWord()\iSize = 273 :SizeWord()\sSize = "0273"
        AddElement(SizeWord()): SizeWord()\Num = 12 :SizeWord()\iSize = 0   :SizeWord()\sSize = "----"
        
        
        AddElement(SizeBlock()): SizeBlock()\Num = 0  :SizeBlock()\iSize = 1    :SizeBlock()\sSize = "001 MB"
        AddElement(SizeBlock()): SizeBlock()\Num = 1  :SizeBlock()\iSize = 2    :SizeBlock()\sSize = "002 MB"
        AddElement(SizeBlock()): SizeBlock()\Num = 2  :SizeBlock()\iSize = 4    :SizeBlock()\sSize = "004 MB"
        AddElement(SizeBlock()): SizeBlock()\Num = 3  :SizeBlock()\iSize = 8    :SizeBlock()\sSize = "008 MB"
        AddElement(SizeBlock()): SizeBlock()\Num = 4  :SizeBlock()\iSize = 16   :SizeBlock()\sSize = "016 MB"
        AddElement(SizeBlock()): SizeBlock()\Num = 5  :SizeBlock()\iSize = 32   :SizeBlock()\sSize = "032 MB"
        AddElement(SizeBlock()): SizeBlock()\Num = 6  :SizeBlock()\iSize = 64   :SizeBlock()\sSize = "064 MB"
        AddElement(SizeBlock()): SizeBlock()\Num = 7  :SizeBlock()\iSize = 128  :SizeBlock()\sSize = "128 MB"
        AddElement(SizeBlock()): SizeBlock()\Num = 8  :SizeBlock()\iSize = 256  :SizeBlock()\sSize = "256 MB"
        AddElement(SizeBlock()): SizeBlock()\Num = 09 :SizeBlock()\iSize = 512  :SizeBlock()\sSize = "512 MB"
        AddElement(SizeBlock()): SizeBlock()\Num = 10 :SizeBlock()\iSize = 0    :SizeBlock()\sSize = "---------"
        AddElement(SizeBlock()): SizeBlock()\Num = 11 :SizeBlock()\iSize = 1024 :SizeBlock()\sSize = "01 GB"
        AddElement(SizeBlock()): SizeBlock()\Num = 12 :SizeBlock()\iSize = 2048 :SizeBlock()\sSize = "02 GB"
        AddElement(SizeBlock()): SizeBlock()\Num = 13 :SizeBlock()\iSize = 4096 :SizeBlock()\sSize = "04 GB"
        AddElement(SizeBlock()): SizeBlock()\Num = 14 :SizeBlock()\iSize = 8192 :SizeBlock()\sSize = "08 GB"
        AddElement(SizeBlock()): SizeBlock()\Num = 15 :SizeBlock()\iSize = 16384:SizeBlock()\sSize = "16 GB"
        AddElement(SizeBlock()): SizeBlock()\Num = 16 :SizeBlock()\iSize = 32768:SizeBlock()\sSize = "32 GB"
        AddElement(SizeBlock()): SizeBlock()\Num = 17 :SizeBlock()\iSize = 65536:SizeBlock()\sSize = "64 GB"
        AddElement(SizeBlock()): SizeBlock()\Num = 18 :SizeBlock()\iSize = 0    :SizeBlock()\sSize = "---------"
        AddElement(SizeBlock()): SizeBlock()\Num = 19 :SizeBlock()\iSize = 99   :SizeBlock()\sSize = "Solid"
        AddElement(SizeBlock()): SizeBlock()\Num = 20 :SizeBlock()\iSize = 0    :SizeBlock()\sSize = "---------"
        AddElement(SizeBlock()): SizeBlock()\Num = 21 :SizeBlock()\iSize = 98   :SizeBlock()\sSize = "Non-Solid"
        
        AddElement(SizeSplit()): SizeSplit()\Num = 0  :SizeSplit()\iSize = 0    :SizeSplit()\sSize = "No Split"
        AddElement(SizeSplit()): SizeSplit()\Num = 1  :SizeSplit()\iSize = 0    :SizeSplit()\sSize = "---------"
        AddElement(SizeSplit()): SizeSplit()\Num = 2  :SizeSplit()\iSize = 25   :SizeSplit()\sSize = "25MB"
        AddElement(SizeSplit()): SizeSplit()\Num = 3  :SizeSplit()\iSize = 50   :SizeSplit()\sSize = "50MB"
        AddElement(SizeSplit()): SizeSplit()\Num = 4  :SizeSplit()\iSize = 100  :SizeSplit()\sSize = "100MB"
        AddElement(SizeSplit()): SizeSplit()\Num = 5  :SizeSplit()\iSize = 150  :SizeSplit()\sSize = "150MB"
        AddElement(SizeSplit()): SizeSplit()\Num = 6  :SizeSplit()\iSize = 200  :SizeSplit()\sSize = "200MB"
        AddElement(SizeSplit()): SizeSplit()\Num = 7  :SizeSplit()\iSize = 250  :SizeSplit()\sSize = "250MB"
        AddElement(SizeSplit()): SizeSplit()\Num = 8  :SizeSplit()\iSize = 500  :SizeSplit()\sSize = "500MB"
        AddElement(SizeSplit()): SizeSplit()\Num = 9  :SizeSplit()\iSize = 650  :SizeSplit()\sSize = "650MB"
        AddElement(SizeSplit()): SizeSplit()\Num = 10  :SizeSplit()\iSize = 0   :SizeSplit()\sSize = "---------"
        AddElement(SizeSplit()): SizeSplit()\Num = 11  :SizeSplit()\iSize = 1024:SizeSplit()\sSize = "1 GB"
        AddElement(SizeSplit()): SizeSplit()\Num = 12  :SizeSplit()\iSize = 2048:SizeSplit()\sSize = "2 GB"
        
        AddElement(Compression()): Compression()\Num = 0  :Compression()\iLevel =0 :Compression()\SizeDict =0  :Compression()\sType = "No"
        AddElement(Compression()): Compression()\Num = 1  :Compression()\iLevel =1 :Compression()\SizeDict =64 :Compression()\sType = "Fastest"
        AddElement(Compression()): Compression()\Num = 2  :Compression()\iLevel =3 :Compression()\SizeDict =1  :Compression()\sType = "Fast"
        AddElement(Compression()): Compression()\Num = 3  :Compression()\iLevel =5 :Compression()\SizeDict =16 :Compression()\sType = "Normal"
        AddElement(Compression()): Compression()\Num = 4  :Compression()\iLevel =7 :Compression()\SizeDict =32 :Compression()\sType = "Maximum"
        AddElement(Compression()): Compression()\Num = 5  :Compression()\iLevel =9 :Compression()\SizeDict =64 :Compression()\sType = "Ultra"
    EndProcedure
EndModule
; IDE Options = PureBasic 5.62 (Windows - x64)
; CursorPosition = 55
; Folding = -
; EnableAsm
; EnableXP
; UseMainFile = ..\Drop7z.pb
; EnableUnicode