Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :auth, only: [] do
        collection do
          post :signup
          post :login
          post :refresh
          delete :logout
        end
      end

      resources :users, only: [ :show, :update, :destroy ]

      resources :activities, only: [ :index, :show, :create, :update, :destroy ]
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
