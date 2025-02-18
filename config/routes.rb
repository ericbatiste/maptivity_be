Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post "signup", do: "auth#signup"
      post "login", do: "auth#login"
      post "refresh", do: "auth#refresh"
      delete "logout", do: "auth#logout"

      resources :users, only: [ :show, :update, :destroy ]

      resources :activities, only: [ :index, :show, :create, :update, :destroy ]
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
