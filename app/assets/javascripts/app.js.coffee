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
