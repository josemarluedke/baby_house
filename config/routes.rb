BabyHouse::Application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  resources :pages, only: [:index, :show]
  root :to => "pages#index"

  # Pages (have to be in the end of file)
  get '/:id', to: 'pages#show', as: :page
end
