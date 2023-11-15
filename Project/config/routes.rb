Rails.application.routes.draw do
  get '/auth/facebook/callback', to: 'users/omniauth_callbacks#facebook'
  root "games#index"
  get '/support', to: 'support#index'
  get 'profile/profile_page'

  devise_for :users, controllers: {omniauth_callbacks: 'users/omniauth_callbacks',
  passwords: 'users/passwords'}
  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'     
  end  

  get 'games/search', to: 'games#search', as: :search_games

 

  resources :games do
    resources :comments
  end

  resources :profile, only: [:show, :edit, :update]

end
