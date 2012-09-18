BabyHouse::Application.routes.draw do
  root :to => "pages#index"

  get '/contato', :to => "pages#contact"
end
