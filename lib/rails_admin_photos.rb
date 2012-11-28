#require 'rails_admin/config/actions'
#require 'rails_admin/config/actions/base'

module RailsAdminPhotos
end

module RailsAdmin
  module Config
    module Actions
      class Photos < RailsAdmin::Config::Actions::Base
        RailsAdmin::Config::Actions.register(self)

        register_instance_option :member do
          true
        end

        register_instance_option :http_methods do
          [:get]
        end

        register_instance_option :authorized? do
          bindings[:abstract_model].model_name == "Activity" rescue false
        end

        register_instance_option :controller do
          Proc.new do
            respond_to do |format|
              format.html { render @action.template_name }
              format.js   { render @action.template_name, :layout => false }
            end
          end
        end

        register_instance_option :link_icon do
          'icon-camera'
        end
      end
    end
  end
end
