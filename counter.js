var site = encodeURI(window.location.href);
site = site.split("/");
site.shift();
site.shift();
site = site.join("+")
fetch("/app/visitor-count/api/site/" + site)
    .then(response => response.json())
    .then(data => updatePage(data));


function updatePage(data) {
    const element = document.getElementById("visitor-counter");
    const since = new Date(data.since);
    element.innerHTML = data.amount + " sivunlatausta " + since.toLocaleDateString + " alkaen.";
}
