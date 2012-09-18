ActiveAdmin.register Page do
  filter :title
  filter :body
  filter :created_at
  filter :updated_at

  index do
    column :title
    column :slug
    column :created_at
    column :updated_at
    default_actions
  end

  form do |f|
    f.inputs do
      f.input :title
      f.input :body
    end
    f.buttons
  end
end
