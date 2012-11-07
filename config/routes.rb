BabyHouse::Application.routes.draw do
  devise_for :parents, ActiveAdmin::Devise.config

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  resources :pages, only: [:index, :show]
  resources :contact, only: [:new, :create]
  root :to => "pages#index"

  get '/contato', :to => "contact#new", :as => "contato"

  # Retrieve images from database
  mount PostgresqlLoStreamer::Engine => "/image_image"
  mount PostgresqlLoStreamer::Engine => "/banner_image"

  # Pages (have to be in the end of file)
  get '/:id', to: 'pages#show', as: :page
end
