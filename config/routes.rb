Rails.application.routes.draw do
  get 'search', to: 'search#index'

  resources :rooms do
    resources :messages
  end
  root 'pages#home'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get 'user/:id', to: 'users#show', as: 'user'

  # Defines the root path route ("/")
  # root "articles#index"
end
