'use strict'

loggedIn = no
count = 0
COUNT_URL  = 'http://qiita.com/api/notifications/count'
LOGIN_URL  = 'https://qiita.com/login'
ALARM_NAME = 'alerm_update_count'

window.updateCount = updateCount = (alarm)->
  return if alarm?.name && alarm.name != ALARM_NAME
  xhr = new XMLHttpRequest
  xhr.open 'GET', COUNT_URL, yes
  xhr.onreadystatechange = ->
    if xhr.readyState == 4
      try
        res = JSON.parse xhr.responseText
        count = res.count
        loggedIn = yes
      catch e
        loggedIn = no
        count = 0
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

chrome.browserAction.onClicked.addListener openLogin
chrome.tabs.onActivated.addListener updateCount
chrome.tabs.onUpdated.addListener updateCount
chrome.alarms.onAlarm.addListener updateCount
chrome.alarms.create ALARM_NAME, periodInMinutes: 1
updateBadge()
updateCount()
