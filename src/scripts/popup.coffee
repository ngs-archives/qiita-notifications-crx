'use strict'

_ajax = jQuery.ajax

I18n.locale = if chrome.i18n.getUILanguage() is 'ja' then 'ja' else 'en'

unless jQuery.ajax.__hacked
  jQuery.ajax = (options)->
    options.url = 'http://qiita.com' + options.url
    _ajax.call jQuery, options
  jQuery.__hacked = yes

Qiita.views.NotificationView.prototype.checkUnreadCount = ->
nv = new Qiita.views.NotificationView el: $ '.js-globalNotification'
nv.isFirstFetch = yes
nv.fetchNotifications()

$('body').on 'click', 'a[href]', ->
  chrome.tabs.create url: $(@).attr 'href'
  no

$("[data-i18n-msg]").each ->
  self = $ @
  self.html chrome.i18n.getMessage self.data('i18n-msg')
