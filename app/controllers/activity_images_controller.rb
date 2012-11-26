class ActivityImagesController < ApplicationController
  before_filter :authenticate_admin_user!


  def destroy
    image = ActivityImage.find params[:id]
    image.destroy

    respond_to do |format|
      format.html do
        if request.xhr?
          render :json => { :success => true }
        else
          redirect_to :back
        end
      end
    end
  end

  # Handles image uploads via "ajax"
  def upload
    filename = params[:qqfile]

    if filename.is_a?(String)
      file = File.open(Rails.root + "tmp/#{filename}", "wb")
      str = request.body.read
      file.write(str)
    else
      file = filename
    end

    acitivity_image = ActivityImage.create!(:image => file, :activity_id => params[:activity_id])

    if acitivity_image.valid?
      render :text => "{ 'success': true, 'activityImageId': #{acitivity_image.id}, 'activityImageUrl': '#{acitivity_image.image.url}' }"
    else
      render :text => "{ 'error': 'Ocorreu um erro no upload' }"
    end
  rescue Exception => e
    render :text => "{ 'error': '#{e.message}' }"
  end
end
