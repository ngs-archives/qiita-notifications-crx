'use strict'

loggedIn = no
count = 0
COUNT_URL = 'http://qiita.com/api/notifications/count'
INTERVAL  = 18e4
LOGIN_URL = 'https://qiita.com/'
timeoutId = 0

updateCount = ->
  clearTimeout timeoutId if timeoutId > 0
  updateBadge()
  xhr = new XMLHttpRequest
  xhr.open 'GET', COUNT_URL, yes
  xhr.onreadystatechange = ->
    if xhr.readyState == 4
      try
        res = JSON.parse xhr.responseText
        count = res.count
        loggedIn = yes
        timeoutId = setTimeout updateCount, INTERVAL
      catch e
        loggedIn = no
        count = 0
        timeoutId = 0
      updateBadge()
  xhr.send()

updateBadge = ->
  text = if count > 0 then "#{count}" else ''
  ba = chrome.browserAction
  if loggedIn
    popup = 'popup.html'
    icon  = ''
  else
    popup = ''
    icon  = "-gray"
  ba.setBadgeText text: text
  ba.setPopup popup: popup
  ba.setIcon path:
    '19': "images/icon#{icon}-19.png"
    '38': "images/icon#{icon}-38.png"

openLogin = ->
  chrome.tabs.create url: LOGIN_URL unless loggedIn

filters =
  urls:  ['*://qiita.com/*', '*://*.qiita.com/*']
  types: 'main_frame xmlhttprequest'.split(' ')

infoSpec = ['responseHeaders']

chrome.browserAction.onClicked.addListener openLogin
chrome.webRequest.onCompleted.addListener updateCount, filters, infoSpec
updateCount()
