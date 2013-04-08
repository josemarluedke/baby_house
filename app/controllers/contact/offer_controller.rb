class Contact::OfferController < ApplicationController
  def new
    @offer = OfferForm.new
  end

  def create
    @offer = OfferForm.new params[:offer_form]
    if @offer.deliver
      redirect_to new_contact_offer_path(), notice: "Oferta enviada com sucesso!"
    else
      render :new
    end
  end
end
