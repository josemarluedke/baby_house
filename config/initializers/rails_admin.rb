# Encoding: utf-8
# RailsAdmin config file. Generated on November 07, 2012 00:18
# See github.com/sferik/rails_admin for more informations

require Rails.root.join('lib', 'rails_admin_photos.rb')

RailsAdmin.config do |config|

  config.authorize_with :cancan, AdminAbility

  ################  Global configuration  ################

  # Set the admin name here (optional second array element will appear in red). For example:
  config.main_app_name = ['Baby House', 'Admin']
  # or for a more dynamic name:
  # config.main_app_name = Proc.new { |controller| [Rails.application.engine_name.titleize, controller.params['action'].titleize] }

  # RailsAdmin may need a way to know who the current user is]
  config.current_user_method { current_admin_user } # auto-generated

  # If you want to track changes on your models:
  # config.audit_with :history, 'AdminUser'

  # Or with a PaperTrail: (you need to install it first)
  # config.audit_with :paper_trail, 'AdminUser'

  # Display empty fields in show views:
  # config.compact_show_view = false

  # Number of default rows per-page:
  # config.default_items_per_page = 20

  # Exclude specific models (keep the others):
  config.excluded_models = ['Parentage', 'Attendance', 'TeamActivity', 'BuyPhoto']

  # Include specific models (exclude the others):
  # config.included_models = ['AdminUser', 'Banner', 'Category', 'Image', 'Page', 'Parent', 'Student']

  # Label methods for model instances:
  # config.label_methods << :description # Default is [:name, :title]


  config.actions do
    # root actions
    dashboard # mandatory
    # collection actions
    index # mandatory
    new do
      except ['AlbumOrder']
    end
    export
    history_index
    bulk_delete
    # member actions
    show
    edit
    delete
    history_show
    show_in_app

    # Set the custom action here
    photos
    import
  end


  ################  Model configuration  ################

  # Each model configuration can alternatively:
  #   - stay here in a `config.model 'ModelName' do ... end` block
  #   - go in the model definition file in a `rails_admin do ... end` block

  # This is your choice to make:
  #   - This initializer is loaded once at startup (modifications will show up when restarting the application) but all RailsAdmin configuration would stay in one place.
  #   - Models are reloaded at each request in development mode (when modified), which may smooth your RailsAdmin development workflow.


  # Now you probably need to tour the wiki a bit: https://github.com/sferik/rails_admin/wiki
  # Anyway, here is how RailsAdmin saw your application's models when you ran the initializer:


   ###  Parent  ###

  config.model Parent do

  #   # You can copy this to a 'rails_admin do ... end' block inside your parent.rb model definition

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

    list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
      field :id
      field :name
      field :code
      field :email
    end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering

    edit do
      field :name, :string
      field :code, :string
      field :relationship, :string
      field :email, :string
      field :password, :password
      field :password_confirmation, :password
      field :students
    end
  end

  config.model Student do

    list do
      field :id
      field :name
      field :code
      field :birthdate
    end
  end

  config.model Team do
    #edit do
      field :name
      field :code
      field :code_year
      field :shift, :enum do
        enum do
          ["Manhã", "Tarde"]
        end
      end
      field :level, :enum do
        enum do
          ["Berçário", "Minimaternal", "Maternal I", "Maternal II", "Jardim I", "Jardim II"]
        end
      end
      field :students
      field :activities
    #end
  end
  config.model AdminUser do
    edit do
      field :email
      field :password
      field :password_confirmation
      field :post_photos
    end
  end

  def link_to_album_zip
    %{<a href="http://www.escolababyhouse.com.br/zip/#{self.filename}">Clique Aqui</a>}.html_safe if self.filename.present?
  end

  def ready_for_export
    self.finished_at.nil? ? 'Não' : 'Sim'
  end

  config.model AlbumOrder do
    list do
      field :id
      field :ready_for_export do
        label 'Pedido finalizado?'
      end
      field :exported
      field :parent
    end
    show do
      field :parent
      field :buy_photos
      field :link_to_album_zip do
        label "Download"
      end
    end
    edit do
      field :exported
    end
  end
end


RailsAdminImport.config do |config|
  logging = true


  config.model Parent do
    excluded_fields do
      [:student, :parentage, :remember_me, :student_ids, :encrypted_password,
       :reset_password_token, :reset_password_sent_at, :remember_created_at,
       :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip,
       :last_sign_in_ip, :confirmation_token, :confirmation_sent_at, :confirmed_at]
    end
    #extra_fields do
      #[:password, :password_confirmation]
    #end
  end

  config.model Student do
    excluded_fields do
      [:parentage, :attendance]
    end
  end

  config.model Team do
    excluded_fields do
      [:attendance, :student, :team_activity, :activity]
    end
  end
end
