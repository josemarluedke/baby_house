App = window.App =
  Common:
    init: ->
      @flash()
      $(document).ready ->
        $("a[rel^='prettyPhoto']").prettyPhoto({social_tools: ""})

    finish: ->

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


App.Pages.Index = Backbone.View.extend
  initialize: ->
    $("#banner .slide").cycle
      fx: "fade"
      speed: "slow"
      timeout: 6000
      next: ".next"
      prev: ".prev"

