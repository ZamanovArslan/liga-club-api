Rails.application.routes.draw do
  mount Raddocs::App => "/docs"

  namespace :admin do
    %i[
      users
      codes
      universities
    ].each do |name|
      resources name, only: %i[index show new create edit update destroy]
    end

    root to: "users#index"
  end

  namespace :v1, defaults: { format: :json } do
    post :sign_in, to: "sign_in#create"
    post :sign_up, to: "sign_up#create"
    get :verify_code, to: "verify_code#show"

    resources :universities, only: %i[show index]
    resource :profile, only: %i[show update destroy]
  end
end
