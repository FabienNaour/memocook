Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config

  devise_for :users
  ActiveAdmin.routes(self)
  # get 'friends/show'

  root to: 'pages#home'
  resources :receptions, only: [:new , :create ]
  resources :friends, only: [:show , :index , :new , :create, :destroy]

  resources :recipes, only: [:show , :index , :new , :create] do
    get :suggestions, on: :collection
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end








  # devise_for :users do
  #     match '/users/sign_out' => 'sessions#destroy', via: ['get', 'delete']
