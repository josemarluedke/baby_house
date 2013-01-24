App.Activities.Show = Backbone.View.extend
  el: 'body'
  events:
    "change .check_photo": "submit"
    "click .viewSelected": "viewSelected"

  initialize: ->

  submit: (event)->
    $('.activity_image_id').val($(event.target).data("id"))
    $(event.target).parents('form').submit()

  viewSelected:(event) ->
    $.ajax
      url: $(event.target).data('url')
      error: ->
        $('#viewSelected .modal-content').html("404 not found")
      success: (data) ->
        $('#viewSelected .modal-content').html(data)
