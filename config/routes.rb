Rails.application.routes.draw do
  mount Raddocs::App => "/docs"

  namespace :v1, defaults: { format: :json } do
    resources :sign_up, only: :create
    post :sign_in, to: "sign_in#create"
    resource :profile, only: %i[show update destroy]
  end
end
