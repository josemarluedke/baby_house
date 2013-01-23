BabyHouse::Application.routes.draw do


  devise_for :admin_users
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
  mount RailsAdminImport::Engine => '/rails_admin_import', :as => 'rails_admin_import'

  devise_for :parents

  resources :parents, only: [:edit, :update]
  resources :activities, only: [:index, :show]
  resources :pages, only: [:index, :show]
  resources :contact, only: [:new, :create]
  resources :apply, only: [:create]
  root :to => "pages#index"

  resources :activity_images, only: [:destroy] do
    collection do
      post :upload
    end
  end

  get "trabalhe", :to => "apply#new", :as => "apply"
  get '/contato', :to => "contact#new", :as => "contato"

  # Retrieve images from database
  mount PostgresqlLoStreamer::Engine => "/image_image"
  mount PostgresqlLoStreamer::Engine => "/activity_cover"
  mount PostgresqlLoStreamer::Engine => "/banner_image"
  mount PostgresqlLoStreamer::Engine => "/activityimage_image"

  # Pages (have to be in the end of file)
  get '/:id', to: 'pages#show', as: :page
end
