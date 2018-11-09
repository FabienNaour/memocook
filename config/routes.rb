Rails.application.routes.draw do

  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config


  scope '(:locale)', locale: /fr|en/ do
    root to: 'pages#home'

    resources :receptions, only: [:new , :create, :destroy ]
    resources :friends, only: [:show , :index , :new , :create, :destroy]

    resources :recipes, only: [:show , :index , :new , :create, :destroy] do
      post :suggestions, on: :collection
      # post :suggestionchoix, on: :collection
    ActiveAdmin.routes(self)
    end
  end


end








  # devise_for :users do
  #     match '/users/sign_out' => 'sessions#destroy', via: ['get', 'delete']
