Rails.application.routes.draw do
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
      cities
      news
      partners
      universities
    ].each do |name|
      resources name, only: %i[index show new create edit update destroy]
    end

    root to: "users#index"
  end

  namespace :v1, defaults: { format: :json } do
    namespace :my do
      resource :level, only: %i[show]
      resource :profile, only: %i[show update destroy]
      resources :badges, only: %i[index]
    end

    resources :users, only: %i[show index]
    resources :badges, only: %i[show index]
    resources :levels, only: %i[show index]
    resources :rarities, only: %i[show index]
    resources :participations, only: %i[create]
    resources :universities, only: %i[show index]
    resources :news, only: %i[index]
    resources :partners, only: %i[index]
    resources :cities, only: %i[index]

    post :sign_in, to: "sign_in#create"
    post :sign_up, to: "sign_up#create"
    get :verify_code, to: "verify_code#show"
  end
end
