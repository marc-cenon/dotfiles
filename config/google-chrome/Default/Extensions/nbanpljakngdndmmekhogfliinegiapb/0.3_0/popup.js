
var info = [];

chrome.tabs.query({active:true, windowId:chrome.windows.WINDOW_ID_CURRENT}, function (tabs){
    var ourTab = tabs[0];
    if(ourTab.url.indexOf("http")===0||ourTab.url.indexOf("https")===0){
        var host = getHost(ourTab.url);
        var SslCheckerForm = {
            "SslCheckerForm[url]":host,
            "SslCheckerForm[port]":443,
            "yt0":""
        };

        $.ajax({
            type: "POST",
            url: "https://www.sslchecker.com/sslchecker",
            data: SslCheckerForm,
            success: function(data){
                var parser = new DOMParser();
                var doc = parser.parseFromString(data, "text/html");
                extractInfoFromDoc(doc);

            },
            dataType: "html"
        });

    }
    else{
        $("#spinner").hide();
        $("#spinner").after( "<h3>This tab don't have a valid domain url!</h3>" );
    }



});

function extractInfoFromDoc(doc){
    var $doc=$(doc);
    var mainContent = $doc.find("div.mainContent")[0];
    var qus = $(mainContent).find(".qu");

    $(qus).each(function (index, qu) {
        if (index != 10 && index != 15) {
            var key = $.trim($(qu).parent().text());
            var value = $.trim($(qu).parent().parent().text());
            value = value.replace(/\s+/g, ' ');
            value = value.replace(key, "");
            info.push({key: key, value: value});
        }
    });

    var table = $("#infoTable");
    $("#spinner").hide();
    info.forEach(function(i){
        var valueToBeAppended ='<tr><td>'+ i.key+'</td><td>'+ i.value+'</td></tr>';
        table.append($(valueToBeAppended));
    });


}

function  getHost(href) {
    var l = document.createElement("a");
    l.href = href;
    return l.hostname;
};