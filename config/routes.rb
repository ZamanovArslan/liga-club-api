Rails.application.routes.draw do
  mount Raddocs::App => "/docs"

  namespace :v1, defaults: { format: :json } do
    resources :sign_up, only: :create
    resources :sign_in, only: :create
    resource :profile, only: %i[show update destroy]
  end
end
