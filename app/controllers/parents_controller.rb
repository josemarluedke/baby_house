class ParentsController < ApplicationController
  before_filter :authenticate_parent!
  def edit
    @parent = current_parent
  end

  def update
    @parent = Parent.find(current_parent.id)
    if @parent.update_attributes(params[:parent])
      # Sign in the user by passing validation in case his password changed
      sign_in @parent, :bypass => true
      redirect_to root_path
    else
      render "edit"
    end
  end
end
