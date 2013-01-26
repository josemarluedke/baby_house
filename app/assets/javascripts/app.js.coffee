App = window.App =
  Common:
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
  Pages: {}
  Apply: {}
  Activities: {}
  BuyPhotos: {}
  Router: Backbone.Router.extend
    initialize: (options)->


App.Pages.Index = Backbone.View.extend
  initialize: ->
    $("#banner .slide").cycle
      fx: "fade"
      speed: "slow"
      timeout: 6000
      next: ".next"
      prev: ".prev"

