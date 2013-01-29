App = window.App =
  Common:
    initPage: ->

    init: ->
      @flash()
      $(document).ready ->
        $("a[rel^='prettyPhoto']").prettyPhoto({social_tools: ""})
      App.router = new App.Router()

    finish: ->
      if Backbone.history && not Backbone.history.started?
        Backbone.history.start()
        Backbone.history.started = true

    flash: ->
      setTimeout (->
        $(".flash").slideDown "slow"
      ), 100
      unless $(".flash a").length
        setTimeout (->
          $(".flash").slideUp "slow"
        ), 10000
      $(window).click ->
        $(".flash").slideUp()

  Router: Backbone.Router.extend
    initialize: (options)->

  Pages: {}
  Apply: {}
  Activities: {}
  BuyPhotos: {}
