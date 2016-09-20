require 'api_constraints'
TodoApi::Application.routes.draw do
  namespace :api do
    scope module: :v1, constraints: ApiConstraints.new(version: 1,default: true) do
      resources :users, only: [:create,:update,:show,:destroy] 
      resources :todos, only: [:index,:create,:update,:destroy]
      resources :sessions, only: [] do
        collection do
          post "sign_in"
          delete 'sign_out'
        end
      end
      get '/search', to: 'search#search' 
    end

    scope module: :v2, constraints: ApiConstraints.new(version: 2) do
      resources :users, only: [:show, :create, :update,:destroy]
    end
  end
end
