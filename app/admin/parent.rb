ActiveAdmin.register Parent do
  index do
    column :name
    column :email
    column :current_sign_in_at
    column :last_sign_in_at
    column :sign_in_count
    default_actions
  end

  filter :email

  form do |f|
    f.inputs "Parent Details" do
      f.input :name
      f.input :relationship
      f.input :email
      f.input :password
      f.input :password_confirmation

      f.inputs "Existing students" do
        f.input :students, as: :check_boxes, collection: Student.all
      end
      f.has_many :students do |c|
      #if !c.object.id.nil?
        #c.input :_destroy, :as => :boolean, :label => "delete"
      #end
      c.inputs :name, :birthdate
    end
    end
    f.buttons
  end
end
