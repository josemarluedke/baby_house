App.Pages.Index = Backbone.View.extend
  initialize: ->
    $("#banner .slide").cycle
      fx: "fade"
      speed: "slow"
      timeout: 6000
      next: ".next"
      prev: ".prev"

