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
    item = begin_of_association_chain.buy_photos.where(activity_image_id: params[:activity_image_id], album_order_id: current_album.id)
    if item = item.first
      item.delete
      return render json: "Deleted"
    end

    @buy_photo = begin_of_association_chain.buy_photos.new(activity_image_id: params[:activity_image_id])
    @buy_photo.album_order = current_album
    if @buy_photo.save
      render json: @buy_photo
    else
      render json: @buy_photo.errors
    end
  end

  def buy
    if params[:print]
      AlbumOrderWorker.perform_async(current_album.id)
      render 'buy_photos/buy', layout: 'print'
    end
  end

  protected
    def begin_of_association_chain
      current_parent
    end

  def collection
    @buy_photos ||= current_album.buy_photos
  end

  def current_album
    @current_album ||= begin_of_association_chain.album_orders.find_or_create_by_finished_at(nil)
  end
end
