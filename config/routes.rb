Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'top#index'
  get 'top/index'
  post 'top/create'
  post 'top/auth_user'
  post 'top/logout'
  post 'top/add_fav'
  get 'top/grid_view'

  get 'auth/edit'

  Rails.application.routes.draw do
    resources :users
    namespace :top do 
      resources :add_fav, only: :index, defaults: { format: :json }
      resources :json_render, only: :index, defaults: { format: :json }
      resources :grid_view, only: :index, defaults: { format: :json }
    end
  end
  resources :top
end
