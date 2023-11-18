Rails.application.routes.draw do

  
  root "games#index"
  get 'games/search', to: 'games#search', as: :search_games
  get 'games/details/:plain', to: 'games#details', as: :details_game

  get '/auth/facebook/callback', to: 'users/omniauth_callbacks#facebook'


  get '/support', to: 'support#index'

  get '/profile', to: 'profile#show'


  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    passwords: 'users/passwords',
    registrations: 'users/registrations'
  }

  
  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'     
  end  

  resources :games do
    resources :comments
  end

end
