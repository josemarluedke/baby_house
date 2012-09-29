ActiveAdmin.register Image do
  index do
    column :description
    column :image
    column :created_at
    default_actions
  end
end
