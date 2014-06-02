'use strict'

I18n.locale = if chrome.i18n.getUILanguage() is 'ja' then 'ja' else 'en'
service = analytics.getService 'qiita_notifications'
tracker = service.getTracker 'UA-200187-36'
tracker.sendAppView 'Popup'
_ajax = jQuery.ajax

unless jQuery.ajax.__hacked
  jQuery.ajax = (options)->
    options.url = 'http://qiita.com' + options.url
    options.data ||= {}
    options.data.locale = I18n.locale
    _ajax.call jQuery, options
  jQuery.__hacked = yes

Qiita.views.NotificationView.prototype.checkUnreadCount = ->
nv = new Qiita.views.NotificationView el: $ '.js-globalNotification'
nv.isFirstFetch = yes
nv.fetchNotifications()

$('body').on 'click', 'a[href]', ->
  url = $(@).attr 'href'
  chrome.tabs.create url: url
  tracker.sendEvent 'Link', 'Click'
  no

$("[data-i18n-msg]").each ->
  self = $ @
  self.html chrome.i18n.getMessage self.data('i18n-msg')

