/**
 * Just restart Wacom service.
 *
 * @author  l5l@op.pl
 * @date 2018-06-09
 */


; @region Functions
    ; function RunAsAdmin
    RunAsAdmin() {
    global
    Loop, %0%  ; For each parameter:
        params .= A_Space . %A_Index%
    local ShellExecute
    ShellExecute := A_IsUnicode ? "shell32\ShellExecute":"shell32\ShellExecuteA"
    if not A_IsAdmin
        {
          A_IsCompiled
            ? DllCall(ShellExecute, uint, 0, str, "RunAs", str, A_ScriptFullPath, str, params , str, A_WorkingDir, int, 1)
            : DllCall(ShellExecute, uint, 0, str, "RunAs", str, A_AhkPath, str, """" . A_ScriptFullPath . """" . A_Space . params, str, A_WorkingDir, int, 1)
          ExitApp
        }
    }
 ; @endregion


; @region Main
    RunAsAdmin() ; function run as admin to restart services

    RunWait,sc stop "WTabletServicePro", , Hide ; Stop Wacom Professional Service
    If (ErrorLevel != 0)
    {
    	MsgBox, During process start, error %Errorlevel% occurred.
    }

    RunWait,sc start "WTabletServicePro", , Hide ; Start Wacom Professional Service
    If (ErrorLevel != 0)
    {
    	MsgBox, During process start, error %Errorlevel% occurred.
    }
    return
 ; @endregion
