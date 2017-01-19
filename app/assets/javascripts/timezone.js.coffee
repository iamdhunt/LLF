window.BrowserTZone ||= {}
BrowserTZone.setCookie = ->
  Cookies.set "browser.timezone", jstz.determine().name(), { expires: 365, path: '/' }

jQuery ->
  BrowserTZone.setCookie()