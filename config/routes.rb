Rails.application.routes.draw do
  mount Raddocs::App => "/docs"

  namespace :v1, defaults: { format: :json } do
    post :sign_in, to: "sign_in#create"
    get :verify_code, to: "verify_code#show"

    resources :sign_up, only: :create
    resource :profile, only: %i[show update destroy]
  end
end
