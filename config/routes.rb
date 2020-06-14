Rails.application.routes.draw do
  resources :participations
  resources :badges
  mount Raddocs::App => "/docs"

  namespace :admin do
    %i[
      users
      participations
      badges
      universities
      rarities
      levels
      codes
      universities
    ].each do |name|
      resources name, only: %i[index show new create edit update destroy]
    end

    root to: "users#index"
  end

  namespace :v1, defaults: { format: :json } do
    namespace :my do
      resources :levels, only: %i[index]
      resource :profile, only: %i[show update destroy]
    end

    post :sign_in, to: "sign_in#create"
    post :sign_up, to: "sign_up#create"
    get :verify_code, to: "verify_code#show"

    resources :users, only: %i[show index]
    resources :levels, only: %i[show index]
    resources :rarities, only: %i[show index]
    resources :universities, only: %i[show index]
  end
end
