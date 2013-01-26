App.Activities.Show = Backbone.View.extend
  el: 'body'
  events:
    "change .check_photo": "submit"

  initialize: ->
    buy_photos = new App.BuyPhotos.Modals()

  submit: (event)->
    $('.activity_image_id').val($(event.target).data("id"))
    $(event.target).parents('form').submit()

App.Activities.Index = Backbone.View.extend
  el: "body"

  initialize: ->
    new App.BuyPhotos.Modals()
    App.router.route("viewSelected", "index", @viewSelected)

  viewSelected: ->
    $('.viewSelected').click()
