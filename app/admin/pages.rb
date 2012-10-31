ActiveAdmin.register Page do
  filter :title
  filter :category
  filter :created_at

  index do
    column :title
    column :slug
    column :category
    column :created_at
    column :updated_at
    default_actions
  end

  form do |f|
    f.inputs do
      f.input :title
      f.input :body, :input_html => { :class => 'mceEditor' }
      f.input :category
    end
    f.buttons
  end

  sidebar :tip, :only => [:edit, :new] do
    "Use full url image. E.g. http://example.com/image/23566.jpg".html_safe
  end
end
