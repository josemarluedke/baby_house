class ActivitiesController < ApplicationController
  inherit_resources
  actions :index, :show
  before_filter :authenticate_parent!
end
