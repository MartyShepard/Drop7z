

;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
    With DeleteCodes()
        
        AddElement(DeleteCodes()):  \Error_Dec.i = 0  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "NO_ERROR"
                                    \Error_Description.s = "No Error - Success"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 1  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_INVALID_FUNCTION"
                                    \Error_Description.s = "Incorrect function"                                    
        
        AddElement(DeleteCodes()):  \Error_Dec.i = 2  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_FILE_NOT_FOUND"
                                    \Error_Description.s = "The system cannot find the file specified"    
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 3  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_PATH_NOT_FOUND"
                                    \Error_Description.s = "The system cannot find the path specified"    
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 4  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_TOO_MANY_OPEN_FILES"
                                    \Error_Description.s = "The system cannot open the file because too many files are currently open" 
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 5  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_ACCESS_DENIED"
                                    \Error_Description.s = "Access denied"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 6  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_INVALID_HANDLE"
                                    \Error_Description.s = "The handle is invalid"     
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 7  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_ARENA_TRASHED"
                                    \Error_Description.s = "The storage control blocks were destroyed"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 8  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_NOT_ENOUGH_MEMORY"
                                    \Error_Description.s = "Insufficient memory is available to process the command"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 9  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_INVALID_BLOCK"
                                    \Error_Description.s = "The storage control block address is invalid"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 10  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_BAD_ENVIRONMENT"
                                    \Error_Description.s = "The environment is incorrect"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 11  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_BAD_FORMAT"
                                    \Error_Description.s = "An attempt to load a program with an incorrect format was made"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 12  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_INVALID_ACCESS"
                                    \Error_Description.s = "The access code is invalid"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 13  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_INVALID_DATA"
                                    \Error_Description.s = "The data are invalid"                                      
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 14  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_OUTOFMEMORY"
                                    \Error_Description.s = "nsufficient memory is available to complete the operation"                                   
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 15  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_INVALID_DRIVE"
                                    \Error_Description.s = "he system cannot find the drive specified"  
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 16  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_CURRENT_DIRECTORY"
                                    \Error_Description.s = "The directory cannot be removed"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 17  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_NOT_SAME_DEVICE"
                                    \Error_Description.s = "The system cannot move the file to a different disk drive"  
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 18  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_NO_MORE_FILES"
                                    \Error_Description.s = "There are no more files"  
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 19  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_WRITE_PROTECT"
                                    \Error_Description.s = "The disk is write protected"
                                                                        
        AddElement(DeleteCodes()):  \Error_Dec.i = 20  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_BAD_UNIT"
                                    \Error_Description.s = "The system cannot find the device specified"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 21  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_NOT_READY"
                                    \Error_Description.s = "The device is not ready"                                    
        
        AddElement(DeleteCodes()):  \Error_Dec.i = 22  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_BAD_COMMAND"
                                    \Error_Description.s = "The device does not recognize the command"    
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 23  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_CRC"
                                    \Error_Description.s = "Cyclic redundance check (CRC) data error"    
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 24  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_BAD_LENGTH"
                                    \Error_Description.s = "The length of the issued command is incorrect" 
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 25  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_SEEK"
                                    \Error_Description.s = "The drive cannot locate a specific area or track on the disk"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 26  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_NOT_DOS_DISK"
                                    \Error_Description.s = "The specified disk cannot be accessed"     
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 27  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_SECTOR_NOT_FOUND"
                                    \Error_Description.s = "The drive cannot find the sector requested"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 28  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_OUT_OF_PAPER"
                                    \Error_Description.s = "The printer is out of paper"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 29  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_WRITE_FAULT"
                                    \Error_Description.s = "The system cannot write to the specified device"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 30  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_READ_FAULT"
                                    \Error_Description.s = "The system cannot read from the specified device"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 31  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_GEN_FAILURE"
                                    \Error_Description.s = "A device attached to the system is not functioning"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 32  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_SHARING_VIOLATION"
                                    \Error_Description.s = "The file cannot be accessed because it is in use by another process"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 33  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_LOCK_VIOLATION"
                                    \Error_Description.s = "The file cannot be accessed because another process has locked a portion of it"                                      
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 34  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_WRONG_DISK"
                                    \Error_Description.s = "The wrong disk is in the drive"                                   
                                                                        
        AddElement(DeleteCodes()):  \Error_Dec.i = 36  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_SHARING_BUFFER_EXCEEDED"
                                    \Error_Description.s = "Too many files have been opened for sharing"
                                                                        
        AddElement(DeleteCodes()):  \Error_Dec.i = 38  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_HANDLE_EOF"
                                    \Error_Description.s = "The end of file (EOF) has been reached"  
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 39  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_HANDLE_DISK_FULL"
                                    \Error_Description.s = "The disk is full"                                    
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 50  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_NOT_SUPPORTED"
                                    \Error_Description.s = "The network request is not supported"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 51  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_REM_NOT_LIST"
                                    \Error_Description.s = "The remote computer is not available"                                    
        
        AddElement(DeleteCodes()):  \Error_Dec.i = 52  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_DUP_NAME"
                                    \Error_Description.s = "A duplicate name exists on the network"    
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 53  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_BAD_NETPATH"
                                    \Error_Description.s = "The network path was not found"    
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 54  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_NETWORK_BUSY"
                                    \Error_Description.s = "The network is busy" 
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 55  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_DEV_NOT_EXIST"
                                    \Error_Description.s = "The specified network resource or device is not available"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 56  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_TOO_MANY_CMDS"
                                    \Error_Description.s = "he network BIOS command limit has been reached"     
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 57  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_ADAP_HDW_ERR"
                                    \Error_Description.s = "A network adapter hardware error has occured"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 58  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_BAD_NET_RESP"
                                    \Error_Description.s = "The specified server cannot perform the requested operation"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 59  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_UNEXP_NET_ERR"
                                    \Error_Description.s = "An unexpected network error has occured"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 60  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_BAD_REM_ADAP"
                                    \Error_Description.s = "The remote adapter is incompatible"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 61  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_PRINTQ_FULL"
                                    \Error_Description.s = "The printer queue is full"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 62  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_NO_SPOOL_SPACE"
                                    \Error_Description.s = "No space to store the file waiting to be printed is available on the Server"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 63  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_PRINT_CANCELLED"
                                    \Error_Description.s = "The file waiting to be printed was deleted"                                      
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 64  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_NETNAME_DELETED"
                                    \Error_Description.s = "The specified network name is unavailable"                                   
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 65  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_NETWORK_ACCESS_DENIED"
                                    \Error_Description.s = "Network access is denied"  
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 66  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_BAD_DEV_TYPE"
                                    \Error_Description.s = "The network resource type is incorrect"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 67  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_BAD_NET_NAME"
                                    \Error_Description.s = "The network name cannot be found"  
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 68  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_TOO_MANY_NAMES"
                                    \Error_Description.s = "The name limit for the local computer network adapter card was exceeded"  
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 69  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_TOO_MANY_SESS"
                                    \Error_Description.s = "The network BIOS session limit was exceeded"
                                                                        
        AddElement(DeleteCodes()):  \Error_Dec.i = 70  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_SHARING_PAUSED"
                                    \Error_Description.s = "The remote server is paused or is in the process of beig started"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 71  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_REQ_NOT_ACCEP"
                                    \Error_Description.s = "The network request was not accepted"                                    
        
        AddElement(DeleteCodes()):  \Error_Dec.i = 72  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_REDIR_PAUSED"
                                    \Error_Description.s = "The specified printer or disk device is paused"                                                
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 80  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_FILE_EXISTS"
                                    \Error_Description.s = "The file exists"
                                                                         
        AddElement(DeleteCodes()):  \Error_Dec.i = 82  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_CANNOT_MAKE"
                                    \Error_Description.s = "The directory or file cannot be created"    
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 83  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_FAIL_I24"
                                    \Error_Description.s = "Failure on Interrupt 24 (INT 24)"    
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 84  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_OUT_OF_STRUCTURES"
                                    \Error_Description.s = "Storage to process the request is unavailable" 
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 85  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_ALREADY_ASSIGNED"
                                    \Error_Description.s = "The local device name is already in use"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 86  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_INVALID_PASSWORD"
                                    \Error_Description.s = "The specified network password is incorrect"     
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 87  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_INVALID_PARAMETER"
                                    \Error_Description.s = "The parameter is incorrect"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 88  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_NET_WRITE_FAULT"
                                    \Error_Description.s = "A write fault occured on the network"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 89  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_NO_PROC_SLOTS"
                                    \Error_Description.s = "The system cannot start another process at this time"                                    
              
        AddElement(DeleteCodes()):  \Error_Dec.i = 100  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_TOO_MANY_SEMAPHORES"
                                    \Error_Description.s = "The system cannot create another semaphore"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 101  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_EXCL_SEM_ALREADY_OWNED"
                                    \Error_Description.s = "The exclusive semaphore is already owned by another process"                                    
        
        AddElement(DeleteCodes()):  \Error_Dec.i = 102  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_SEM_IS_SET"
                                    \Error_Description.s = "The semaphore is set and cannot be closed"    
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 103  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_TOO_MANY_SEM_REQUESTS"
                                    \Error_Description.s = "The semaphore cannot be set again"    
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 104  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_INVALID_AT_INTERRUPT_TIME"
                                    \Error_Description.s = "he system cannot request exclusive semaphores at interrupt time" 
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 105  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_SEM_OWNER_DIED"
                                    \Error_Description.s = "The previous ownership of this semaphore has ended"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 106  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_SEM_USER_LIMIT"
                                    \Error_Description.s = "The system has reached the semaphore user limit"     
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 107  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_DISK_CHANGE"
                                    \Error_Description.s = "The program stopped because the alternate disk was not inserted"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 108  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_DRIVE_LOCKED"
                                    \Error_Description.s = "The disk is in use or is locked by another process"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 109  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_BROKEN_PIPE"
                                    \Error_Description.s = "The pipe has been ended"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 110  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_OPEN_FAILED"
                                    \Error_Description.s = "The system cannot open the device or file specified"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 111  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_BUFFER_OVERFLOW"
                                    \Error_Description.s = "The file name is too long"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 112  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_DISK_FULL"
                                    \Error_Description.s = "There is insufficient space on the disk"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 113  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_NO_MORE_SEARCH_HANDLES"
                                    \Error_Description.s = "No more file search handles are available"                                      
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 114  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_INVALID_TARGET_HANDLE"
                                    \Error_Description.s = "The target file handle is incorrect"                                   
                                                                        
        AddElement(DeleteCodes()):  \Error_Dec.i = 117  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_INVALID_CATEGORY"
                                    \Error_Description.s = "The IOCTL call made by the program is incorrect"  
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 118  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_INVALID_VERIFY_SWITCH"
                                    \Error_Description.s = "The verify-on-write parameter is incorrect"  
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 119  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_BAD_DRIVER_LEVEL"
                                    \Error_Description.s = "The system does not support the command requested"    
                                                                        
        AddElement(DeleteCodes()):  \Error_Dec.i = 120  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_CALL_NOT_IMPLEMENTED"
                                    \Error_Description.s = "This function is only valid under Windows NT/2000"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 121  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_SEM_TIMEOUT"
                                    \Error_Description.s = "The semaphore timeout experiod has expired"                                    
        
        AddElement(DeleteCodes()):  \Error_Dec.i = 122  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_INSUFFICIENT_BUFFER"
                                    \Error_Description.s = "The data area passed to a system call is too small"    
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 123  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_INVALID_NAME"
                                    \Error_Description.s = "The syntax of the filename, directory name, or volume label is incorrect"    
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 124  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_INVALID_LEVEL"
                                    \Error_Description.s = "The system call level is incorrect" 
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 125  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_NO_VOLUME_LABEL"
                                    \Error_Description.s = "The disk has no volume label"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 126  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_MOD_NOT_FOUND"
                                    \Error_Description.s = "The specified module cannot be found"     
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 127  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_PROC_NOT_FOUND"
                                    \Error_Description.s = "The specified procedure cannot be found"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 128  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_WAIT_NO_CHILDREN"
                                    \Error_Description.s = "There are no child processes to wait for"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 129  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_CHILD_NOT_COMPLETE"
                                    \Error_Description.s = "The program cannot run under Windows NT/2000"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 130  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_DIRECT_ACCESS_HANDLE"
                                    \Error_Description.s = "A file handle or open disk partition was attempted to be used for an operation other than raw disk I/O"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 131  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_NEGATIVE_SEEK"
                                    \Error_Description.s = "An attempt was made to move a file pointer before the beginning of the file"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 132  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_SEEK_ON_DEVICE"
                                    \Error_Description.s = "The file pointer cannot be set on the specified device or file"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 133  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_IS_JOIN_TARGET"
                                    \Error_Description.s = "A JOIN or SUBST command cannot be used for a drive that contains previously joined drives"                                      
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 134  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_IS_JOINED"
                                    \Error_Description.s = "An attempt was made to use a JOIN or SUBST command on a drive that has already been joined" 
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 135  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_IS_SUBSTED"
                                    \Error_Description.s = "An attempt was made to use a JOIN or SUBST command on a drive that has already been substituted"                                    
                                                                        
        AddElement(DeleteCodes()):  \Error_Dec.i = 136  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_NOT_JOINED"
                                    \Error_Description.s = "The system tried to delete the JOIN of a drive that is not joined"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 137  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_NOT_SUBSTED"
                                    \Error_Description.s = "The system tried to delete the SUBST of a drive that is not substituted"  
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 138  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_JOIN_TO_JOIN"
                                    \Error_Description.s = "The system tried to JOIN a drive to a directory on a joined drive"  
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 139  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_SUBST_TO_SUBST"
                                    \Error_Description.s = "The system tried to SUBST a drive to a directory on a substituted drive"                                    
                       
        AddElement(DeleteCodes()):  \Error_Dec.i = 140  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_JOIN_TO_SUBST"
                                    \Error_Description.s = "The system tried to JOIN a drive to a directory on a substituted drive"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 141  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_SUBST_TO_JOIN"
                                    \Error_Description.s = "The system tried to SUBST a drive to a directory on a joined drive"                                    
        
        AddElement(DeleteCodes()):  \Error_Dec.i = 142  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_BUSY_DRIVE"
                                    \Error_Description.s = "The system cannot perform a JOIN or SUBST at this time"    
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 143  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_SAME_DRIVE"
                                    \Error_Description.s = "The system cannot JOIN or SUBST a drive to or for a directory on the same drive"    
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 144  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_DIR_NOT_ROOT"
                                    \Error_Description.s = "The directory is not a subdirectory of the root directory" 
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 145  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_DIR_NOT_EMPTY"
                                    \Error_Description.s = "The directory is not empty"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 146  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_IS_SUBST_PATH"
                                    \Error_Description.s = "The path specified is being used in a SUBST"     
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 147  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_IS_JOIN_PATH"
                                    \Error_Description.s = "The path specified is being used in a JOIN"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 148  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_PATH_BUSY"
                                    \Error_Description.s = "The path specified cannot be used at this time"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 149  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_IS_SUBST_TARGET"
                                    \Error_Description.s = "An attempt was made to JOIN or SUBST a drive for which a directory on the drive is the target of a previous SUBST"
                                       
        AddElement(DeleteCodes()):  \Error_Dec.i = 150  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_SYSTEM_TRACE"
                                    \Error_Description.s = "System trace information was not specified in CONFIG.SYS, or tracing is not allowed"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 151  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_INVALID_EVENT_COUNT"
                                    \Error_Description.s = "The number of specified semaphore events is incorrect"                                    
        
        AddElement(DeleteCodes()):  \Error_Dec.i = 152  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_TOO_MANY_MUXWAITERS"
                                    \Error_Description.s = "DosMuxSemWait did not execute because too many semaphores are already set"    
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 153  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_INVALID_LIST_FORMAT"
                                    \Error_Description.s = "The DosMuxSemWait list is incorrect"    
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 154  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_LABEL_TOO_LONG"
                                    \Error_Description.s = "The volume label specified is too long and was truncated to 11 characters" 
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 155  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_TOO_MANY_TCBS"
                                    \Error_Description.s = "The system cannot create another thread"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 156  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_SIGNAL_REFUSED"
                                    \Error_Description.s = "The recipient process has refused the signal"     
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 157  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_DISCARDED"
                                    \Error_Description.s = "The segment is already discarded and cannot be locked"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 158  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_NOT_LOCKED"
                                    \Error_Description.s = "The segment is already unlocked"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 159  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_BAD_THREADID_ADDR"
                                    \Error_Description.s = "The address for the thread ID is incorrect"
                                                            
        AddElement(DeleteCodes()):  \Error_Dec.i = 160  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_BAD_ARGUMENTS"
                                    \Error_Description.s = "The argument string is incorrect"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 161  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_BAD_PATHNAME"
                                    \Error_Description.s = "The specified path is invalid"                                    
        
        AddElement(DeleteCodes()):  \Error_Dec.i = 162  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_SIGNAL_PENDING"
                                    \Error_Description.s = "A signal is already pending"    
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 164  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_MAX_THRDS_REACHED"
                                    \Error_Description.s = "No more threads can be created in the system"    
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 167  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_LOCK_FAILED"
                                    \Error_Description.s = "The system was unable to lock a region of a file"                                                                    
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 170  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_BUSY"
                                    \Error_Description.s = "The requested resource is in use"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 173  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_CANCEL_VIOLATION"
                                    \Error_Description.s = "A lock request was not outstanding for the supplied cancel region"                                    
        
        AddElement(DeleteCodes()):  \Error_Dec.i = 174  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_ATOMIC_LOCKS_NOT_SUPPORTED"
                                    \Error_Description.s = "The file system does not support atomic changes to the lock type"

        AddElement(DeleteCodes()):  \Error_Dec.i = 180  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_INVALID_SEGMENT_NUMBER"
                                    \Error_Description.s = "The system detected an incorrect segment number"                               
        
        AddElement(DeleteCodes()):  \Error_Dec.i = 182  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_INVALID_ORDINAL"
                                    \Error_Description.s = "The system cannot run something because of an invalid ordinal"    
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 183  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_ALREADY_EXISTS"
                                    \Error_Description.s = "The system cannot create a file when it already exists"    
                                                                       
        AddElement(DeleteCodes()):  \Error_Dec.i = 186  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_INVALID_FLAG_NUMBER"
                                    \Error_Description.s = "An incorrect flag was passed"     
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 187  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_SEM_NOT_FOUND"
                                    \Error_Description.s = "The specified system semaphore name was not found"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 188  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_INVALID_STARTING_CODESEG"
                                    \Error_Description.s = "The system cannot run something because of an invalid starting code segment"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 189  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_INVALID_STACKSEG"
                                    \Error_Description.s = "The system cannot run something because of an invalid stack segment"                                    
                     
        AddElement(DeleteCodes()):  \Error_Dec.i = 190  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_INVALID_MODULETYPE"
                                    \Error_Description.s = "The system cannot run something because of an invalid module type"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 191  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_INVALID_EXE_SIGNATURE"
                                    \Error_Description.s = "The system cannot run something because it cannot run under Windows NT/2000"                                    
        
        AddElement(DeleteCodes()):  \Error_Dec.i = 192  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_EXE_MARKED_INVALID"
                                    \Error_Description.s = "The system cannot run something because the EXE was marked as invalid"    
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 193  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_BAD_EXE_FORMAT"
                                    \Error_Description.s = "The system cannot run something because it is an invalid Windows NT/2000 application"    
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 194  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_ITERATED_DATA_EXCEEDS_64k"
                                    \Error_Description.s = "system cannot run something because the iterated data exceed 64KB" 
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 195  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_INVALID_MINALLOCSIZE"
                                    \Error_Description.s = "The system cannot run something because of an invalid minimum allocation size"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 196  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_DYNLINK_FROM_INVALID_RING"
                                    \Error_Description.s = "The system cannot run something because of a dynalink from an invalid ring"     
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 197  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_IOPL_NOT_ENABLED"
                                    \Error_Description.s = "The system is not presently configured to run this application"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 198  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_INVALID_SEGDPL"
                                    \Error_Description.s = "The system cannot run something because of an invalid segment DPL"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 199  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_AUTODATASEG_EXCEEDS_64k"
                                    \Error_Description.s = "The system cannot run something because the automatic data segment exceeds 64K" 
                                                                                                       
        AddElement(DeleteCodes()):  \Error_Dec.i = 200  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_RING2SEG_MUST_BE_MOVABLE"
                                    \Error_Description.s = "The code segment cannot be greater than or equal to 64KB"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 201  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_RELOC_CHAIN_XEEDS_SEGLIM"
                                    \Error_Description.s = "The system cannot run something because the reallocation chain exceeds the segment limit"                                    
        
        AddElement(DeleteCodes()):  \Error_Dec.i = 202  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_INFLOOP_IN_RELOC_CHAIN"
                                    \Error_Description.s = "The system cannot run something because of an infinite loop in the reallocation chain"    
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 203  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_ENVVAR_NOT_FOUND"
                                    \Error_Description.s = "The system could not find the specified environment variable"    
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 205  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_NO_SIGNAL_SENT"
                                    \Error_Description.s = "No process in the command subtree has a signal handler"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 206  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_FILENAME_EXCED_RANGE"
                                    \Error_Description.s = "The filename or extension is too long"     
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 207  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_RING2_STACK_IN_USE"
                                    \Error_Description.s = "The ring 2 stack is busy"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 208  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_META_EXPANSION_TOO_LONG"
                                    \Error_Description.s = "The global filename characters (or ?) are entered incorrectly, or too many global filename characters are specified"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 209  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_INVALID_SIGNAL_NUMBER"
                                    \Error_Description.s = "The signal being posted is incorrect"
                                                                     
        AddElement(DeleteCodes()):  \Error_Dec.i = 210  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_THREAD_1_INACTIVE"
                                    \Error_Description.s = "he signal handler cannot be set"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 212  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_LOCKED"
                                    \Error_Description.s = "The segment is locked and cannot be reallocated"                                    
        
        AddElement(DeleteCodes()):  \Error_Dec.i = 214  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_TOO_MANY_MODULES"
                                    \Error_Description.s = "Too many dynamic link modules are attacked to this program or module"    
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 215  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_NESTING_NOT_ALLOWED"
                                    \Error_Description.s = "Nesting of calls to LoadModule is not allowed"    
                            
        AddElement(DeleteCodes()):  \Error_Dec.i = 230  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_BAD_PIPE"
                                    \Error_Description.s = "The pipe state is invalid"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 231  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_PIPE_BUSY"
                                    \Error_Description.s = "All pipe instances are busy"                                    
        
        AddElement(DeleteCodes()):  \Error_Dec.i = 232  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_NO_DATA"
                                    \Error_Description.s = "The pipe is being closed"    
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 233  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_PIPE_NOT_CONNECTED"
                                    \Error_Description.s = "No process exists on the other end of the pipe"    
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 234  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_MORE_DATA"
                                    \Error_Description.s = "More data is available"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 240  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_VC_DISCONNECTED"
                                    \Error_Description.s = "The session was cancelled"     
                                                             
        AddElement(DeleteCodes()):  \Error_Dec.i = 254  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_INVALID_EA_NAME"
                                    \Error_Description.s = "he specified extended attribute name was invalid"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 255  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_EA_LIST_INCONSISTENT"
                                    \Error_Description.s = "The extended attributes are inconsistent"                                    
        
        AddElement(DeleteCodes()):  \Error_Dec.i = 259  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_NO_MORE_ITEMS"
                                    \Error_Description.s = "No more data is available"    
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 266  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_CANNOT_COPY"
                                    \Error_Description.s = "The Copy API cannot be used"    
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 267  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_DIRECTORY"
                                    \Error_Description.s = "The directory name is invalid"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 275  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_EAS_DIDNT_FIT"
                                    \Error_Description.s = "The extended attributes did not fit into the buffer"                                       
                      
       AddElement(DeleteCodes()):  \Error_Dec.i = 276  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_EA_FILE_CORRUPT"
                                    \Error_Description.s = "The extended attribute file on the mounted file system is corrupt"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 277  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_EA_TABLE_FULL"
                                    \Error_Description.s = "The extended attribute table file is full"                                    
        
        AddElement(DeleteCodes()):  \Error_Dec.i = 278  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_INVALID_EA_HANDLE"
                                    \Error_Description.s = "The specified extended attribute handle is invalid"    
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 282  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_EAS_NOT_SUPPORTED"
                                    \Error_Description.s = "The mounted file system does not support extended attributes"    
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 288  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_NOT_OWNER"
                                    \Error_Description.s = "The system attempted to release a mutex not owned by the caller"
                       
        AddElement(DeleteCodes()):  \Error_Dec.i = 298  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_TOO_MANY_POSTS"
                                    \Error_Description.s = "Too many posts were made to a semaphore"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 317  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_MR_MID_NOT_FOUND"
                                    \Error_Description.s = "The system cannot find the message for the specified message number in the proper message file"
                                                                     
        AddElement(DeleteCodes()):  \Error_Dec.i = 487  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_INVALID_ADDRESS"
                                    \Error_Description.s = "The system attempted to access an invalid address"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 534  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_ARITHMETIC_OVERFLOW"
                                    \Error_Description.s = "An arithmetic overflow (result > 32 bits) occured"                                    
        
        AddElement(DeleteCodes()):  \Error_Dec.i = 535  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_PIPE_CONNECTED"
                                    \Error_Description.s = "A process already exists on the other end of the pipe"    
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 536  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_PIPE_LISTENING"
                                    \Error_Description.s = "The system is waiting for a process to open on the other end of the pipe"    
                            
        AddElement(DeleteCodes()):  \Error_Dec.i = 994  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_EA_ACCESS_DENIED"
                                    \Error_Description.s = "Access to the extended attribute was denied"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 995  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_OPERATION_ABORTED"
                                    \Error_Description.s = "The I/O operation has been aborted because of either a thread exit or an application request"                                    
        
        AddElement(DeleteCodes()):  \Error_Dec.i = 996  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_IO_INCOMPLETE"
                                    \Error_Description.s = "The overlapped I/O event is not in a signalled state"    
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 997  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_IO_PENDING"
                                    \Error_Description.s = "The overlapped I/O operation is in progress"    
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 998  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_NOACCESS"
                                    \Error_Description.s = "An invalid access to a memory location was attempted"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 999  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_SWAPERROR"
                                    \Error_Description.s = "An error performing an inpage operation occured"     
 
        AddElement(DeleteCodes()):  \Error_Dec.i = 1001  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_STACK_OVERFLOW"
                                    \Error_Description.s = "The stack overflowed because recursion was too deep"                                    
        
        AddElement(DeleteCodes()):  \Error_Dec.i = 1002  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_INVALID_MESSAGE"
                                    \Error_Description.s = "The window cannot act on the sent message"    
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 1003  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_CAN_NOT_COMPLETE"
                                    \Error_Description.s = "The function cannot be completed"    
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 1004  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_INVALID_FLAGS"
                                    \Error_Description.s = "Invalid flags were used" 
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 1005  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_UNRECOGNIZED_VOLUME"
                                    \Error_Description.s = "The disk volume does not contain a recognized file system"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 1006  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_FILE_INVALID"
                                    \Error_Description.s = "The disk volume for a file has been altered such that the opened file is no longer valid"     
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 1007  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_FULLSCREEN_MODE"
                                    \Error_Description.s = "The requested operation cannot be performed in full-screen mode"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 1008  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_NO_TOKEN"
                                    \Error_Description.s = "An attempt to reference a nonexistent token was made"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 1009  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_BADDB"
                                    \Error_Description.s = "The registry database is corrupt"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 1010  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_BADKEY"
                                    \Error_Description.s = "The registry key is invalid"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 1011  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_CANTOPEN"
                                    \Error_Description.s = "The registry key could not be opened"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 1012  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_CANTREAD"
                                    \Error_Description.s = "The registry key could not be read from"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 1013  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_CANTWRITE"
                                    \Error_Description.s = "The registry key could not be written to"                                      
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 1014  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_REGISTRY_RECOVERED"
                                    \Error_Description.s = "One of the registry database files was successfully recovered"                                   
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 1015  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_REGISTRY_CORRUPT"
                                    \Error_Description.s = "The registry is corrupt. The cause could be a corrupted registry database file, a corrupted image in system memory, or a failed attempt to recover the registry because of a missing or corrupted log"   
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 1016  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_REGISTRY_IO_FAILED"
                                    \Error_Description.s = "An I/O operation initiated by the registry failed unrecoverably"  
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 1017  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_NOT_REGISTRY_FILE"
                                    \Error_Description.s = "The system tried to load or restore a file into the registry, but that file is not in the proper file format"  
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 1018  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_KEY_DELETED"
                                    \Error_Description.s = "An illegal operation was attempted on a registry key marked for deletion"  
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 1019  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_NO_LOG_SPACE"
                                    \Error_Description.s = "The system could not allocate the required space in a registry log"    
                                                                        
        AddElement(DeleteCodes()):  \Error_Dec.i = 1020  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_KEY_HAS_CHILDREN"
                                    \Error_Description.s = "A symbolic link in a registry key that already has subkeys or values cannot be created"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 1021  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_CHILD_MUST_BE_VOLATILE"
                                    \Error_Description.s = "A stable subkey cannot be created under a volatile parent key"                                    
        
        AddElement(DeleteCodes()):  \Error_Dec.i = 1022  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_NOTIFY_ENUM_DIR"
                                    \Error_Description.s = "Because a notify change request is being completed and the information is not being returned in the caller's buffer, the caller must now enumerate the files to find the changes"    
                          
        AddElement(DeleteCodes()):  \Error_Dec.i = 1051  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_DEPENDENT_SERVICES_RUNNING"
                                    \Error_Description.s = "A stop control has been sent to a service which other running services are dependent on"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 1052  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_INVALID_SERVICE_CONTROL"
                                    \Error_Description.s = "The requested control is not valid for this service"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 1053  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_SERVICE_REQUEST_TIMEOUT"
                                    \Error_Description.s = "The service did not respond to the start or control request within the timeout period"                                      
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 1054  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_SERVICE_NO_THREAD"
                                    \Error_Description.s = "A thread could not be created for the service"                                   
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 1055  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_SERVICE_DATABASE_LOCKED"
                                    \Error_Description.s = "The service database is locked"   
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 1056  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_SERVICE_ALREADY_RUNNING"
                                    \Error_Description.s = "An instance of the service is already running"  
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 1057  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_INVALID_SERVICE_ACCOUNT"
                                    \Error_Description.s = "The account name for the service is invalid or nonexistent"  
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 1058  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_SERVICE_DISABLED"
                                    \Error_Description.s = "The specified service is disabled and cannot be started"  
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 1059  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_CIRCULAR_DEPENDENCY"
                                    \Error_Description.s = "A circular service dependency was specified"
                             
        AddElement(DeleteCodes()):  \Error_Dec.i = 1060  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_SERVICE_DOES_NOT_EXIST"
                                    \Error_Description.s = "The specified service does not exist"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 1061  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_SERVICE_CANNOT_ACCEPT_CTRL"
                                    \Error_Description.s = "The service cannot accept control messages at this time"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 1062  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_SERVICE_NOT_ACTIVE"
                                    \Error_Description.s = "The service has not been started"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 1063  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_FAILED_SERVICE_CONTROLLER_CONNECT"
                                    \Error_Description.s = "The service process could not connect to the service controller"                                      
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 1064  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_EXCEPTION_IN_SERVICE"
                                    \Error_Description.s = "An exception occured in the service when handling the control request"                                   
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 1065  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_DATABASE_DOES_NOT_EXIST"
                                    \Error_Description.s = "The specified database does not exist"   
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 1066  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_SERVICE_SPECIFIC_ERROR"
                                    \Error_Description.s = "The service has returned a service-specific error code"  
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 1067  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_PROCESS_ABORTED"
                                    \Error_Description.s = "The process terminated unexpectedly"  
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 1068  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_SERVICE_DEPENDENCY_FAIL"
                                    \Error_Description.s = "The dependency service or group failed to start"  
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 1069  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_SERVICE_LOGON_FAILED"
                                    \Error_Description.s = "The service did not start due to a logon failure"
          
        AddElement(DeleteCodes()):  \Error_Dec.i = 1070  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_SERVICE_START_HANG"
                                    \Error_Description.s = "After starting, the service hung in a start-pending state"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 1071  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_INVALID_SERVICE_LOCK"
                                    \Error_Description.s = "The specified service database lock is invalid"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 1072  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_SERVICE_MARKED_FOR_DELETE"
                                    \Error_Description.s = "The specified service has been marked for deletion"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 1073  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_SERVICE_EXISTS"
                                    \Error_Description.s = "The specified service already exists"                                      
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 1074  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_ALREADY_RUNNING_LKG"
                                    \Error_Description.s = "The system is currently running with the last-known-good configuration"                                   
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 1075  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_SERVICE_DEPENDENCY_DELETED"
                                    \Error_Description.s = "The dependency service does not exist or has been marked for deletion"   
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 1076  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_BOOT_ALREADY_ACCEPTED"
                                    \Error_Description.s = "The current boot has already been accepted for use as the last-known-good control set"  
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 1077  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_SERVICE_NEVER_STARTED"
                                    \Error_Description.s = "No attempts to start the service have been made"  
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 1078  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_DUPLICATE_SERVICE_NAME"
                                    \Error_Description.s = "The name is already in use either as a service name or as a service display name"  
                      
        AddElement(DeleteCodes()):  \Error_Dec.i = 1100  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_END_OF_MEDIA"
                                    \Error_Description.s = "The physical end of the tape has been reached"  
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 1101  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_FILEMARK_DETECTED"
                                    \Error_Description.s = "A tape access reached a filemark"                                    
        
        AddElement(DeleteCodes()):  \Error_Dec.i = 1102  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_BEGINNING_OF_MEDIA"
                                    \Error_Description.s = "The beginning of the tape or partition was encountered"    
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 1103  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_SETMARK_DETECTED"
                                    \Error_Description.s = "A tape access reached the end of a set of files"    
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 1104  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_NO_DATA_DETECTED"
                                    \Error_Description.s = "No more data is on the tape" 
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 1105  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_PARTITION_FAILURE"
                                    \Error_Description.s = "The tape could not be partitioned"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 1106  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_INVALID_BLOCK_LENGTH"
                                    \Error_Description.s = "When accessing a new tape of a multivolume partition, the current blocksize is incorrect"     
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 1107  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_DEVICE_NOT_PARTITIONED"
                                    \Error_Description.s = "The tape partition information could not be found"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 1108  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_UNABLE_TO_LOCK_MEDIA"
                                    \Error_Description.s = "The system was unable to lock the media eject mechanism"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 1109  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_UNABLE_TO_UNLOAD_MEDIA"
                                    \Error_Description.s = "The system was unable to unload the media"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 1110  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_MEDIA_CHANGED"
                                    \Error_Description.s = "The media in the drive may have changed"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 1111  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_BUS_RESET"
                                    \Error_Description.s = "The I/O bus was reset"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 1112  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_NO_MEDIA_IN_DRIVE"
                                    \Error_Description.s = "There is no media in the drive"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 1113  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_NO_UNICODE_TRANSLATION"
                                    \Error_Description.s = "No mapping for the Unicode character exists in the target multi-byte code page"                                      
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 1114  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_DLL_INIT_FAILED"
                                    \Error_Description.s = "A dynamic link library initialization routine failed"                                   
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 1115  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_SHUTDOWN_IN_PROGRESS"
                                    \Error_Description.s = "A system shutdown is in progress"   
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 1116  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_NO_SHUTDOWN_IN_PROGRESS"
                                    \Error_Description.s = "The system shutdown could not be aborted because no shutdown is in progress"  
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 1117  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_IO_DEVICE"
                                    \Error_Description.s = "The request could not be performed because of an device I/O error"  
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 1118  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_SERIAL_NO_DEVICE"
                                    \Error_Description.s = "No serial device was successfully initialized; the serial driver will therefore unload"  
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 1119  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_IRQ_BUSY"
                                    \Error_Description.s = "The system was unable to open a device sharing an interrupt request (IRQ) with other device(s) because at least one of those devices is already opened"    
                                                                        
        AddElement(DeleteCodes()):  \Error_Dec.i = 1120  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_MORE_WRITES"
                                    \Error_Description.s = "A serial I/O operation was completed by another write to the serial port"
         
        AddElement(DeleteCodes()):  \Error_Dec.i = 1121  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_COUNTER_TIMEOUT"
                                    \Error_Description.s = "A serial I/O operation completed because the time-out period expired"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 1122  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_FLOPPY_ID_MARK_NOT_FOUND"
                                    \Error_Description.s = "No ID address mark was found on the floppy disk"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 1123  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_FLOPPY_WRONG_CYLINDER"
                                    \Error_Description.s = "A mismatch exists between the floppy disk sector ID field and the floppy disk controller track address"                                      
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 1124  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_FLOPPY_UNKNOWN_ERROR"
                                    \Error_Description.s = "The floppy disk controller reported an unrecognized error"                                   
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 1125  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_FLOPPY_BAD_REGISTERS"
                                    \Error_Description.s = "The floppy disk controller returned inconsistent results in its registers"   
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 1126  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_DISK_RECALIBRATE_FAILED"
                                    \Error_Description.s = "While accessing a hard disk, a recalibrate operation failed, even after retries"  
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 1127  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_DISK_OPERATION_FAILED"
                                    \Error_Description.s = "While accessing a hard disk, a disk operation failed, even after retries"  
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 1128  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_DISK_RESET_FAILED"
                                    \Error_Description.s = "While accessing a hard disk, a disk controller reset was needed, but even that failed"  
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 1129  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_EOM_OVERFLOW"
                                    \Error_Description.s = "An EOM overflow occured"
                                                                        
        AddElement(DeleteCodes()):  \Error_Dec.i = 1130  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_NOT_ENOUGH_SERVER_MEMORY"
                                    \Error_Description.s = "Not enough server storage is available to process this command"
                                    
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 1131  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_POSSIBLE_DEADLOCK"
                                    \Error_Description.s = "A potential deadlock condition has been detected"
                                    
        AddElement(DeleteCodes()):  \Error_Dec.i = 1132  :\Error_Hex = "0x"+Hex(\Error_Dec.i) 
                                    \Error_Intern.s      = "ERROR_MAPPED_ALIGNMENT"
                                    \Error_Description.s = "The base address or the file offset specified does not have the proper alignment"                                    
      EndWith
     
     ResetList(DeleteCodes())
     
        iMax_Delete_List = ListSize(DeleteCodes()) 
        For i = 0 To iMax_Delete_List
            NextElement(DeleteCodes())
            DeleteCodes()\Number = i
        Next

        SortStructuredList(DeleteCodes(), #PB_Sort_Ascending, OffsetOf(DELETE_ERRORCODES\Error_Dec.i), #PB_Integer)
        
;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 

; String function Delete
; Deletes a given lenght of characters in a string from a given position
; Usage: Delete(String$,StartPosition,Lenght)
Procedure$ Delete(S$,P,L)
  If P>0 And L>0
    S$=Left(S$,P-1)+Right(S$,Len(S$)-(P+L-1))
  EndIf
  ProcedureReturn S$
EndProcedure


;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
Procedure _Delete_ErrorCode(FilePath$,ErrorCode.i)
    
    Protected iHexCode$, iErrorResult, iLength.i

    iLength.i = Len(FilePath$)
    iHexCode$ = Hex(ErrorCode.i)
   
    ResetList(DeleteCodes())
    
    While NextElement(DeleteCodes())
        If (DeleteCodes()\Error_Dec.i = ErrorCode.i)
            If iLength.i >= 130 
              FilePath$ = Delete(FilePath$,1,90)     
              FilePath$ = "..."+FilePath$
          EndIf
          
        sLANGUAGE = Windows::Get_Language() 
        
        Request0$ = "Now Look What You've Done" 
        Request1$ = "There was an Error on performing the Action!"                 
        Select sLANGUAGE
                Case 0
            Default
                Request2$ = "Error: "+DeleteCodes()\Error_Description.s+#LFCR$+
                            "Hex  : "+DeleteCodes()\Error_Hex.s+ 
                            "[Code : "+LCase(DeleteCodes()\Error_Intern.s)+"]"+#LFCR$+
                            "Object: "+#LFCR$+iMessageString$+#LFCR$+#LFCR$+
                            "Ignore this Error and continue?"
                ;              
                ;"There was an Error on performing the Action"+#LFCR$+#LFCR$+
                ;"Error: "+DeleteCodes()\Error_Description.s+#LFCR$+
                ;"Hex  : "+DeleteCodes()\Error_Hex.s+#LFCR$+                                      
                ;"Code : "+LCase(DeleteCodes()\Error_Intern.s)+#LFCR$+#LFCR$+
                ;"Object: "+#LFCR$+FilePath$+#LFCR$+#LFCR$+                
        EndSelect
        iResult = Request::MSG(Request0$, Request1$, Request2$,6,0,ProgramFilename(),1)
        Select iResult
                Case 1
                    ProcedureReturn 0
                Case 0
                    ProcedureReturn ErrorCode.i 
            EndSelect
     EndIf       
    Wend
EndProcedure
; IDE Options = PureBasic 5.42 LTS (Windows - x64)
; CursorPosition = 1179
; FirstLine = 1125
; Folding = -
; EnableAsm
; EnableUnicode
; EnableXP
; UseMainFile = ..\7z_Main_Source.pb
; CurrentDirectory = ..\Release\