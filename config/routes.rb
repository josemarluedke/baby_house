BabyHouse::Application.routes.draw do
  devise_for :admin_users
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  devise_for :parents

  resources :activities, only: [:index, :show]
  resources :pages, only: [:index, :show]
  resources :contact, only: [:new, :create]
  root :to => "pages#index"

  resources :activity_images, only: [:destroy] do
    collection do
      post :upload
    end
  end

  get '/contato', :to => "contact#new", :as => "contato"

  # Retrieve images from database
  mount PostgresqlLoStreamer::Engine => "/image_image"
  mount PostgresqlLoStreamer::Engine => "/activity_cover"
  mount PostgresqlLoStreamer::Engine => "/banner_image"
  mount PostgresqlLoStreamer::Engine => "/activityimage_image"

  # Pages (have to be in the end of file)
  get '/:id', to: 'pages#show', as: :page
end
