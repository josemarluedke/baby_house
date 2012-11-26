# Encoding: utf-8
class ActivitiesController < ApplicationController
  inherit_resources
  actions :index, :show
  before_filter :authenticate_parent!

  def show
  	return redirect_to(root_url, :alert => "Você não tem direito para ver esta atividade.") unless resource.can_see_activity(current_parent)
  	super
  end

  protected
    def collection
      @activities ||= Activity.order('created_at DESC').parent_activities(current_parent)
    end
end
