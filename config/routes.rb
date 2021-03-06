Rails.application.routes.draw do
  root 'welcomes#index', as: 'home'

  get 'rank' => 'rank#index'
  get 'scored_bets' => 'rank#scored_bets'
  get 'send_pdf' => 'rank#send_pdf'
  
  resources :users_admin
  resources :tournaments
  resources :teams

  get 'games/per_tournament' => 'games#per_tournament'
  get 'games/round' => 'games#round'
  resources :games

  get 'bets/missing_bets' => 'bets#missing_bets'
  get 'bets/users_bet' => 'bets#show_bet_from_users'
  post 'bets/create_bets' => 'bets#create_bets'
  resources :bets

  get 'contact', to: 'messages#new', as: 'new_message'
  post 'contact', to: 'messages#create', as: 'create_message'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth' }
end
