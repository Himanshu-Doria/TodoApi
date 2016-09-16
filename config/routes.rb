require 'api_constraints'
TodoApi::Application.routes.draw do
  namespace :api do
    scope module: :v1, constraints: ApiConstraints.new(version: 1,default: true) do
      resources :users, only: [:create] do
        collection do
          get 'show_user'
          post 'update_user'
          delete 'delete_user'
        end
      end

      resources :sessions, only: [] do
        collection do
          post "sign_in"
          delete 'sign_out'
        end
      end
    end

    scope module: :v2, constraints: ApiConstraints.new(version: 2) do
      resources :users, only: [:show, :create, :update,:destroy]
    end
  end
end
