Rails.application.routes.draw do


  root "games#index"
  get '/user', to: 'user#index'
  get '/support', to: 'support#index'
  get 'games/search', to: 'games#search', as: :search_games
  get 'games/details/:plain', to: 'games#details', as: :details_game
  get 'games/store_lowest_prices', to: 'games#store_lowest_prices'
  get '/collections', to: 'collections#index'
 #  get '/auth/facebook/callback', to: 'users/omniauth_callbacks#facebook'
 


  get '/auth/facebook/callback', to: 'users/omniauth_callbacks#facebook'

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    confirmations: 'users/confirmations',
  }  


  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'     
  end 

  resources :deals

  resources :users, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  resources :games do
    resources :collections, only: [:new, :create], controller: 'game_collections'
  end


  namespace :admins do
    resources :users, only: [:index, :destroy]
    get 'index', to: 'users#index', as: :index
    get 'destroy', to: 'users#destroy', as: :destroy
  end
end
