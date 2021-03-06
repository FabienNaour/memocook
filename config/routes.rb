Rails.application.routes.draw do
  #devise_for :users  NAOUR
  # devise_for :admin_users, ActiveAdmin::Devise.config NAOUR

  scope '(:locale)', locale: /fr|en/ do
    root to: 'pages#home'
    get '/mentions' => 'pages#mentions'

    resources :receptions, only: [:new , :create, :destroy ]
    resources :friends, only: [:show , :index , :new , :create, :destroy]

    resources :recipes, only: [:show , :index , :new , :create, :destroy] do
      get :search, on: :collection
      post :suggestions, on: :collection
      post :showsuggestion, on: :collection
    end
  end

  devise_for :users
  devise_scope :user do
  get '/users/sign_out' => 'devise/sessions#destroy'
  end

  ActiveAdmin.routes(self)

end



