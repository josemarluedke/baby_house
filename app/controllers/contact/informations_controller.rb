# Encoding: utf-8
class Contact::InformationsController < ApplicationController
  def new
    @information = InformationForm.new
  end

  def create
    @information = InformationForm.new params[:information_form]
    if @information.deliver
      redirect_to new_contact_information_path(), notice: "Solicitação enviada com sucesso!"
    else
      render :new
    end
  end
end
