class ContactController < ApplicationController
  def new
    @contact = ContactForm.new
  end

  def create
    @contact = ContactForm.new params[:contact_form]
    if @contact.deliver
      redirect_to new_contact_path(), notice: "Contato enviado com sucesso!"
    else
      render 'contact/new'
    end
  end
end
