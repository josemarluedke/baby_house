# RailsAdmin config file. Generated on November 07, 2012 00:18
# See github.com/sferik/rails_admin for more informations

require Rails.root.join('lib', 'rails_admin_photos.rb')


require 'open-uri'

module RailsAdminImport
  module Import
    extend ActiveSupport::Concern

    module ClassMethods
      def file_fields
        attrs = []
        if self.methods.include?(:attachment_definitions) && !self.attachment_definitions.nil?
          attrs = self.attachment_definitions.keys
        end
        attrs - RailsAdminImport.config(self).excluded_fields
      end

      def import_fields
        fields = []

        fields = self.new.attributes.keys.collect { |key| key.to_sym }

        self.belongs_to_fields.each do |key|
          fields.delete("#{key}_id".to_sym)
        end

        self.file_fields.each do |key|
          fields.delete("#{key}_file_name".to_sym)
          fields.delete("#{key}_content_type".to_sym)
          fields.delete("#{key}_file_size".to_sym)
          fields.delete("#{key}_updated_at".to_sym)
        end

        excluded_fields = RailsAdminImport.config(self).excluded_fields
        [:id, :created_at, :updated_at, excluded_fields].flatten.each do |key|
          fields.delete(key)
        end

        fields
      end

      def belongs_to_fields
        attrs = self.reflections.select { |k, v| v.macro == :belongs_to }.keys
        attrs - RailsAdminImport.config(self).excluded_fields
      end

      def many_fields
        attrs = []
        self.reflections.each do |k, v|
          if [:has_and_belongs_to_many, :has_many].include?(v.macro)
            attrs << k.to_s.singularize.to_sym
          end
        end

        attrs - RailsAdminImport.config(self).excluded_fields
      end

      def run_import(params)
        begin
          if !params.has_key?(:file)
            return results = { :success => [], :error => ["You must select a file."] }
          end

          if RailsAdminImport.config.logging
            FileUtils.copy(params[:file].tempfile, "#{Rails.root}/log/import/#{Time.now.strftime("%Y-%m-%d-%H-%M-%S")}-import.csv")
            logger = Logger.new("#{Rails.root}/log/import/import.log")
          end

          text = File.read(params[:file].tempfile)
          clean = text.force_encoding('BINARY').encode('UTF-8', :undef => :replace, :replace => '').gsub(/\n$/, '')
          file_check = CSV.new(clean)

          if file_check.readlines.size > RailsAdminImport.config.line_item_limit
            return results = { :success => [], :error => ["Please limit upload file to #{RailsAdminImport.config.line_item_limit} line items."] }
          end

          map = {}

          file = CSV.new(clean)
          file.readline.each_with_index do |key, i|
            if self.many_fields.include?(key.to_sym)
              map[key.to_sym] ||= []
              map[key.to_sym] << i
            else
              map[key.to_sym] = i
            end
          end

          update = params.has_key?(:update_if_exists) && params[:update_if_exists] ? params[:update_lookup].to_sym : nil

          if update && !map.has_key?(params[:update_lookup].to_sym)
            return results = { :success => [], :error => ["Your file must contain a column for the 'Update lookup field' you selected."] }
          end

          results = { :success => [], :error => [] }

          associated_map = {}
          self.belongs_to_fields.flatten.each do |field|
            associated_map[field] = field.to_s.classify.constantize.all.inject({}) { |hash, c| hash[c.send(params[field]).to_s] = c.id; hash }
          end
          self.many_fields.flatten.each do |field|
            associated_map[field] = field.to_s.classify.constantize.all.inject({}) { |hash, c| hash[c.send(params[field]).to_s] = c; hash }
          end

          label_method = RailsAdminImport.config(self).label

          file.each do |row|
            object = self.import_initialize(row, map, update)
            object.import_belongs_to_data(associated_map, row, map)
            object.import_many_data(associated_map, row, map)
            object.before_import_save(row, map)

            object.import_files(row, map)

            verb = object.new_record? ? "Create" : "Update"
            if object.errors.empty?
              if object.save
                logger.info "#{Time.now.to_s}: #{verb}d: #{object.send(label_method)}" if RailsAdminImport.config.logging
                results[:success] << "#{verb}d: #{object.send(label_method)}"
              else
                logger.info "#{Time.now.to_s}: Failed to #{verb}: #{object.send(label_method)}. Errors: #{object.errors.full_messages.join(', ')}." if RailsAdminImport.config.logging
                results[:error] << "Failed to #{verb}: #{object.send(label_method)}. Errors: #{object.errors.full_messages.join(', ')}."
              end
            else
              logger.info "#{Time.now.to_s}: Errors before save: #{object.send(label_method)}. Errors: #{object.errors.full_messages.join(', ')}." if RailsAdminImport.config.logging
              results[:error] << "Errors before save: #{object.send(label_method)}. Errors: #{object.errors.full_messages.join(', ')}."
            end
          end

          results
        rescue Exception => e
          raise e.inspect
          #logger.info "#{Time.now.to_s}: Unknown exception in import: #{e.inspect}"
          return results = { :success => [], :error => ["Could not upload. Unexpected error: #{e.to_s}"] }
        end
      end

      def import_initialize(row, map, update)
        new_attrs = {}
        self.import_fields.each do |key|
          new_attrs[key] = row[map[key]] if map[key]
        end

        item = nil
        if update.present?
          item = self.send("find_by_#{update}", row[map[update]])
        end

        if item.nil?
          item = self.new(new_attrs)
        else
          item.attributes = new_attrs.except(update.to_sym)
          item.save
        end

        item
      end
    end

    def before_import_save(*args)
      # Meant to be overridden to do special actions
    end

    def import_display
      self.id
    end

    def import_files(row, map)
      if self.new_record? && self.valid?
        self.class.file_fields.each do |key|
          if map[key] && !row[map[key]].nil?
            begin
              # Strip file
              row[map[key]] = row[map[key]].gsub(/\s+/, "")
              format = row[map[key]].match(/[a-z0-9]+$/)
              open("#{Rails.root}/tmp/#{self.permalink}.#{format}", 'wb') { |file| file << open(row[map[key]]).read }
              self.send("#{key}=", File.open("#{Rails.root}/tmp/#{self.permalink}.#{format}"))
            rescue Exception => e
              self.errors.add(:base, "Import error: #{e.inspect}")
            end
          end
        end
      end
    end

    def import_belongs_to_data(associated_map, row, map)
      self.class.belongs_to_fields.each do |key|
        if map.has_key?(key) && row[map[key]] != ""
          self.send("#{key}_id=", associated_map[key][row[map[key]]])
        end
      end
    end

    def import_many_data(associated_map, row, map)
      self.class.many_fields.each do |key|
        values = []

        map[key] ||= []
        map[key].each do |pos|
          if row[pos] != "" && associated_map[key][row[pos]]
            values << associated_map[key][row[pos]]
          end
        end

        if values.any?
          self.send("#{key.to_s.pluralize}=", values)
        end
      end
    end
  end
end

class ActiveRecord::Base
  include RailsAdminImport::Import
end



RailsAdmin.config do |config|


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
  config.excluded_models = ['Parentage', 'Attendance', 'TeamActivity']

  # Include specific models (exclude the others):
  # config.included_models = ['AdminUser', 'Banner', 'Category', 'Image', 'Page', 'Parent', 'Student']

  # Label methods for model instances:
  # config.label_methods << :description # Default is [:name, :title]


  ################  Model configuration  ################

  # Each model configuration can alternatively:
  #   - stay here in a `config.model 'ModelName' do ... end` block
  #   - go in the model definition file in a `rails_admin do ... end` block

  # This is your choice to make:
  #   - This initializer is loaded once at startup (modifications will show up when restarting the application) but all RailsAdmin configuration would stay in one place.
  #   - Models are reloaded at each request in development mode (when modified), which may smooth your RailsAdmin development workflow.


  # Now you probably need to tour the wiki a bit: https://github.com/sferik/rails_admin/wiki
  # Anyway, here is how RailsAdmin saw your application's models when you ran the initializer:



  ###  AdminUser  ###

  # config.model 'AdminUser' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your admin_user.rb model definition

  #   # Found associations:



  #   # Found columns:

  #     configure :id, :integer
  #     configure :email, :string
  #     configure :password, :password         # Hidden
  #     configure :password_confirmation, :password         # Hidden
  #     configure :reset_password_token, :string         # Hidden
  #     configure :reset_password_sent_at, :datetime
  #     configure :remember_created_at, :datetime
  #     configure :sign_in_count, :integer
  #     configure :current_sign_in_at, :datetime
  #     configure :last_sign_in_at, :datetime
  #     configure :current_sign_in_ip, :string
  #     configure :last_sign_in_ip, :string
  #     configure :created_at, :datetime
  #     configure :updated_at, :datetime

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  Banner  ###

  # config.model 'Banner' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your banner.rb model definition

  #   # Found associations:



  #   # Found columns:

  #     configure :id, :integer
  #     configure :title, :string
  #     configure :description, :text
  #     configure :link_text, :string
  #     configure :link_url, :string
  #     configure :visible, :boolean
  #     configure :created_at, :datetime
  #     configure :updated_at, :datetime
  #     configure :image, :carrierwave

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  Category  ###

  # config.model 'Category' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your category.rb model definition

  #   # Found associations:

  #     configure :pages, :has_many_association

  #   # Found columns:

  #     configure :id, :integer
  #     configure :name, :string
  #     configure :created_at, :datetime
  #     configure :updated_at, :datetime

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  Image  ###

  # config.model 'Image' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your image.rb model definition

  #   # Found associations:



  #   # Found columns:

  #     configure :id, :integer
  #     configure :created_at, :datetime
  #     configure :updated_at, :datetime
  #     configure :image, :carrierwave
  #     configure :description, :string

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  Page  ###

  # config.model 'Page' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your page.rb model definition

  #   # Found associations:

  #     configure :category, :belongs_to_association

  #   # Found columns:

  #     configure :id, :integer
  #     configure :title, :string
  #     configure :body, :text
  #     configure :slug, :string
  #     configure :created_at, :datetime
  #     configure :updated_at, :datetime
  #     configure :category_id, :integer         # Hidden

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end


  ###  Parent  ###

  config.model Parent do

  #   # You can copy this to a 'rails_admin do ... end' block inside your parent.rb model definition

  #   # Found columns:

  #     configure :id, :integer
  #     configure :name, :string
  #     configure :relationship, :string
  #     configure :email, :string
  #     configure :password, :password         # Hidden
  #     configure :password_confirmation, :password         # Hidden
  #     configure :reset_password_token, :string         # Hidden
  #     configure :reset_password_sent_at, :datetime
  #     configure :remember_created_at, :datetime
  #     configure :sign_in_count, :integer
  #     configure :current_sign_in_at, :datetime
  #     configure :last_sign_in_at, :datetime
  #     configure :current_sign_in_ip, :string
  #     configure :last_sign_in_ip, :string
  #     configure :confirmation_token, :string
  #     configure :confirmed_at, :datetime
  #     configure :confirmation_sent_at, :datetime
  #     configure :created_at, :datetime
  #     configure :updated_at, :datetime

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
    edit do
      field :name, :string
      field :relationship, :string
      field :email, :string
      field :password, :password
      field :password_confirmation, :password
      field :students
    end
  end


  ###  Student  ###

  # config.model 'Student' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your student.rb model definition

  #   # Found associations:

  #     configure :parents, :has_and_belongs_to_many_association

  #   # Found columns:

  #     configure :id, :integer
  #     configure :name, :string
  #     configure :birthdate, :date
  #     configure :created_at, :datetime
  #     configure :updated_at, :datetime

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end

  #config.actions do
    #photos
  #end
  #
  config.actions do
    # root actions
    dashboard                     # mandatory
    # collection actions
    index                         # mandatory
    new
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

  config.model 'Activity' do
  end
end


RailsAdminImport.config do |config|
  logging = true
  config.model Parent do
    excluded_fields do
      [:student, :parentage, :remember_me, :student_ids, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip, :confirmation_token, :confirmation_sent_at, :confirmed_at]
    end
    #extra_fields do
      #[:password, :password_confirmation]
    #end
  end
end
