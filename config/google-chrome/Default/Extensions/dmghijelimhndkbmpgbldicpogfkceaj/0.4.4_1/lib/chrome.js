var app = {};

app.error = function () {
  return chrome.runtime.lastError;
};

app.options = {
  "port": null,
  "message": {},
  "receive": function (id, callback) {
    if (id) {
      app.options.message[id] = callback;
    }
  },
  "send": function (id, data) {
    if (id) {
      chrome.runtime.sendMessage({"data": data, "method": id, "path": "background-to-options"}, app.error);
    }
  },
  "post": function (id, data) {
    if (id) {
      if (app.options.port) {
        app.options.port.postMessage({"data": data, "method": id, "path": "background-to-options"});
      }
    }
  }
};

app.contextmenu = {
  "create": function (options, callback) {
    if (chrome.contextMenus) {
      chrome.contextMenus.create(options, function (e) {
        if (callback) callback(e);
      });
    }
  },
  "on": {
    "clicked": function (callback) {
      if (chrome.contextMenus) {
        chrome.contextMenus.onClicked.addListener(function (info, tab) {
          app.storage.load(function () {
            callback(info, tab);
          });
        });
      }
    }
  }
};

app.tab = {
  "query": {
    "index": function (callback) {
      chrome.tabs.query({"active": true, "currentWindow": true}, function (tabs) {
        var tmp = chrome.runtime.lastError;
        if (tabs && tabs.length) {
          callback(tabs[0].index);
        } else callback(undefined);
      });
    }
  },
  "open": function (url, index, active, callback) {
    var properties = {
      "url": url, 
      "active": active !== undefined ? active : true
    };
    /*  */
    if (index !== undefined) {
      if (typeof index === "number") {
        properties.index = index + 1;
      }
    }
    /*  */
    chrome.tabs.create(properties, function (tab) {
      if (callback) callback(tab);
    }); 
  }
};

app.on = {
  "management": function (callback) {
    chrome.management.getSelf(callback);
  },
  "uninstalled": function (url) {
    chrome.runtime.setUninstallURL(url, function () {});
  },
  "installed": function (callback) {
    chrome.runtime.onInstalled.addListener(function (e) {
      app.storage.load(function () {
        callback(e);
      });
    });
  },
  "startup": function (callback) {
    chrome.runtime.onStartup.addListener(function (e) {
      app.storage.load(function () {
        callback(e);
      });
    });
  },
  "connect": function (callback) {
    chrome.runtime.onConnect.addListener(function (e) {
      app.storage.load(function () {
        if (callback) callback(e);
      });
    });
  },
  "message": function (callback) {
    chrome.runtime.onMessage.addListener(function (request, sender, sendResponse) {
      app.storage.load(function () {
        callback(request, sender, sendResponse);
      });
      /*  */
      return true;
    });
  }
};

app.button = {
  "title": function (tabId, title, callback) {
    if (title) {
      var options = {"title": title};
      if (tabId) options["tabId"] = tabId;
      chrome.action.setTitle(options, function (e) {
        if (callback) callback(e);
      });
    }
  },
  "on": {
    "clicked": function (callback) {
      chrome.action.onClicked.addListener(function (e) {
        app.storage.load(function () {
          callback(e);
        }); 
      });
    }
  },
  "icon": function (tabId, path, imageData, callback) {
    if (path && typeof path === "object") {
      var options = {"path": path};
      if (tabId) options["tabId"] = tabId;
      chrome.action.setIcon(options, function (e) {
        if (callback) callback(e);
      });
    } else if (imageData && typeof imageData === "object") {
      var options = {"imageData": imageData};
      if (tabId) options["tabId"] = tabId;
      chrome.action.setIcon(options, function (e) {
        if (callback) callback(e);
      });
    } else {
      var options = {
        "path": {
          "16": "../data/icons/" + (path ? path + '/' : '') + "16.png",
          "32": "../data/icons/" + (path ? path + '/' : '') + "32.png",
          "48": "../data/icons/" + (path ? path + '/' : '') + "48.png",
          "64": "../data/icons/" + (path ? path + '/' : '') + "64.png"
        }
      };
      /*  */
      if (tabId) options["tabId"] = tabId;
      chrome.action.setIcon(options, function (e) {
        if (callback) callback(e);
      }); 
    }
  }
};

app.page = {
  "port": null,
  "sender": {
    "port": {}
  },
  "message": {},
  "receive": function (id, callback) {
    if (id) {
      app.page.message[id] = callback;
    }
  },
  "post": function (id, data, tabId) {
    if (id) {
      if (tabId) {
        if (app.page.sender.port[tabId]) {
          app.page.sender.port[tabId].postMessage({"data": data, "method": id, "path": "background-to-page"});
        }
      } else if (app.page.port) {
        app.page.port.postMessage({"data": data, "method": id, "path": "background-to-page"});
      }
    }
  },
  "send": function (id, data, tabId, frameId) {
    if (id) {
      chrome.tabs.query({}, function (tabs) {
        var tmp = chrome.runtime.lastError;
        if (tabs && tabs.length) {
          var message = {
            "method": id, 
            "data": data ? data : {}, 
            "path": "background-to-page"
          };
          /*  */
          tabs.forEach(function (tab) {
            if (tab) {
              message.data.tabId = tab.id;
              message.data.top = tab.url ? tab.url : '';
              message.data.title = tab.title ? tab.title : '';
              /*  */
              if (tabId !== null && tabId !== undefined) {
                if (tabId === tab.id) {
                  if (frameId !== null && frameId !== undefined) {
                    chrome.tabs.sendMessage(tab.id, message, {"frameId": frameId}, app.error);
                  } else {
                    chrome.tabs.sendMessage(tab.id, message, app.error);
                  }
                }
              } else {
                chrome.tabs.sendMessage(tab.id, message, app.error);
              }
            }
          });
        }
      });
    }
  }
};

app.storage = (function () {
  chrome.storage.onChanged.addListener(function () {
    if (app.session) app.session.load();
    /*  */
    chrome.storage.local.get(null, function (e) {
      app.storage.local = e;
      if (app.storage.callback) {
        if (typeof app.storage.callback === "function") {
          app.storage.callback(e);
        }
      }
    });
  });
  /*  */
  return {
    "local": {},
    "callback": null,
    "read": function (id) {
      return app.storage.local[id];
    },
    "on": {
      "changed": function (callback) {
        if (callback) {
          app.storage.callback = callback;
        }
      }
    },
    "write": function (id, data, callback) {
      var tmp = {};
      tmp[id] = data;
      app.storage.local[id] = data;
      chrome.storage.local.set(tmp, function (e) {
        if (callback) {
          callback(e);
        }
      });
    },
    "load": function (callback) {
      var keys = Object.keys(app.storage.local);
      if (keys && keys.length) {
        if (callback) {
          callback("cache");
        }
      } else {
        if (app.session) app.session.load();
        /*  */
        chrome.storage.local.get(null, function (e) {
          app.storage.local = e;
          if (callback) {
            callback("disk");
          }
        });
      }
    }
  }
})();