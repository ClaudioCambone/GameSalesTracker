Rails.application.routes.draw do
  get '/auth/facebook/callback', to: 'users/omniauth_callbacks#facebook'
  root "games#index"
  get '/support', to: 'support#index'

  devise_for :users, controllers: {omniauth_callbacks: 'users/omniauth_callbacks'}
  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'     
  end  

  get 'games/search', to: 'games#search', as: :search_games

  resources :games do
    resources :comments
  end
end
