Rails.application.routes.draw do
  root "games#index"
<<<<<<< HEAD
    get '/user', to: 'user#index'
  get 'games/search', to: 'games#search', as: :search_games
  get 'games/details/:plain', to: 'games#details', as: :details_game
  get 'games/store_lowest_prices', to: 'games#store_lowest_prices'
 #  get '/auth/facebook/callback', to: 'users/omniauth_callbacks#facebook'

=======
>>>>>>> 20f798f1f89b11f88d8ec960c5d2c22338e06360

  get '/user', to: 'user#index'
  get '/support', to: 'support#index'

  get 'games/search', to: 'games#search', as: :search_games
  get 'games/details/:plain', to: 'games#details', as: :details_game

  get '/auth/facebook/callback', to: 'users/omniauth_callbacks#facebook'

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    confirmations: 'users/confirmations'
  }
<<<<<<< HEAD
  
=======

>>>>>>> 20f798f1f89b11f88d8ec960c5d2c22338e06360
  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'     
  end  

  resources :games do
    resources :comments
  end

  resources :deals
end
