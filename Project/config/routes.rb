Rails.application.routes.draw do
  root "games#index"
resources :games do
  resources :comments
end
devise_for :users, controllers: {
  sessions: 'users/sessions'
}
end
