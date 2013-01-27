class BuyPhotosController < ApplicationController
  before_filter :authenticate_parent!
  inherit_resources
  actions :index, :destroy
  respond_to :json
  respond_to :html, :json, only: [:index, :buy]

  def index
    respond_with(collection, :layout => !request.xhr? )
  end

  def create
    item = begin_of_association_chain.buy_photos.where(activity_image_id: params[:activity_image_id])
    if item.any?
      item.first.delete
      render json: "Deleted"
      return
    end

    @buy_photo = begin_of_association_chain.buy_photos.new(activity_image_id: params[:activity_image_id])
    if @buy_photo.save
      render json: @buy_photo
    else
      render json: @buy_photo.errors
    end
  end

  def buy
    collection
    if params[:print]
      render 'buy_photos/buy', layout: 'print'
      collection.destroy_all
    end
  end

  protected
    def begin_of_association_chain
      current_parent
    end

  def collection
    @buy_photos ||= end_of_association_chain.where parent_id: current_parent.id
  end
end
