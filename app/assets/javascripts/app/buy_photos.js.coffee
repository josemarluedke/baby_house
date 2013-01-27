App.BuyPhotos.viewSelected = Backbone.View.extend
  el: "#viewSelected .modal-content"
  events:
    "click .remove-photo": "removePhoto"

  removePhoto: (event)->
    $(event.target).parent("div").remove()


App.BuyPhotos.Modals = Backbone.View.extend
  el: 'body'
  events:
    "click .viewSelected": "viewSelected"

  viewSelected: (event) ->
    $.ajax
      url: $(event.target).data('url')
      error: ->
        $('#viewSelected .modal-content').html("404 not found")
      success: (data) ->
        $('#viewSelected .modal-content').html(data)
        new App.BuyPhotos.viewSelected()
