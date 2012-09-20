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
      f.input :body
      f.input :category
    end
    f.buttons
  end

  sidebar :tip, :only => [:edit, :new] do
    "If you want format the body of the page, you may use Markdown.
    <br /><br />
    Read more <a href=\"http://daringfireball.net/projects/markdown/syntax\" target=\"_blank\">here</a>".html_safe
  end
end
