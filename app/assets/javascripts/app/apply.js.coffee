App.Apply.New = App.Apply.Create = Backbone.View.extend
  el: 'body'
  events:
    "click #apply_form_already_sent_sim": "showAlreadySentYear"
    "click #apply_form_already_apply_sim": "showAlreadyApplyYear"
    "click #apply_form_already_sent_no": "hideAlreadySentYear"
    "click #apply_form_already_apply_no": "hideAlreadyApplyYear"
    "change #apply_form_role": "applyFormRole"

  initialize: ->

  applyFormRole: (event)->
    val = $(event.target).val()

    if val == "Professor especializado"
      $('.specialist_teacher').show()
      $('.role_other').hide()
    else if val == "Outros"
      $('.role_other').show()
      $('.specialist_teacher').hide()
    else
      $('.specialist_teacher').hide()
      $('.role_other').hide()



  showAlreadySentYear: ->
    $('.already_sent_year').show()

  showAlreadyApplyYear: ->
    $('.already_apply_year').show()

  hideAlreadySentYear: ->
    $('.already_sent_year').hide()

  hideAlreadyApplyYear: ->
    $('.already_apply_year').hide()
