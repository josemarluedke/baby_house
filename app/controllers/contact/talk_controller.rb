# Encoding: utf-8
class Contact::TalkController < ApplicationController
  def new
    @talk = TalkForm.new
  end

  def create
    @talk = TalkForm.new params[:talk_form]
    if @talk.deliver
      redirect_to new_contact_talk_path(), notice: "Solicitação enviada com sucesso!"
    else
      render :new
    end
  end
end
