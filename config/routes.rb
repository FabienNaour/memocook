Rails.application.routes.draw do

  # get 'friends/show'
  devise_for :users
  root to: 'pages#home'
  resources :friends, only: [:show , :index , :new , :create, :destroy]
  resources :recipes, only: [:show , :index , :new , :create] do
    get :suggestions, on: :collection
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
