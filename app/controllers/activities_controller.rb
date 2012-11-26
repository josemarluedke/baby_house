class ActivitiesController < ApplicationController
  inherit_resources
  actions :index, :show
  before_filter :authenticate_parent!

  def show
  	return redirect_to root_url if can_see_activity(current_parent)
  	super
  end
end
