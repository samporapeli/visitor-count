debug = false;

var baseUrl = "https://sampo.website/app/visitor-count/";

if (debug) {
    baseUrl = "http://localhost:4567/"; 
}

const frameSrc = baseUrl + "html/frame.html";
const endpoint = baseUrl + "api/";

window.onload = function() {
    var site;
    const siteNameElement = document.getElementById("site-name");
    if (siteNameElement === null) {
        encodeURI(window.location.href);
        site = site.split("/");
        site.shift();
        site.shift();
        site = site.join("+")
    } else {
        site = siteNameElement.innerHTML;
    }
    const frame = document.createElement("iframe");
    frame.style.display = "none";
    frame.src = frameSrc; 
    document.body.appendChild(frame);

    window.addEventListener("message", function(evt) {
        if (evt.data.request === "getSiteId") {
            frame.contentWindow.postMessage({
                siteId: site,
                ApiEndpoint: endpoint
            }, "*");
        } else {
            updatePage(evt.data);
        }
    });

    function updatePage(data) {
        const element = document.getElementById("visitor-counter");
        const since = new Date(data.since * 1000);
        element.innerHTML = data.amount + (data.amount == 1 ? " sivunlataus " : " sivunlatausta ") + since.toLocaleDateString() + " alkaen.";
    }
}
