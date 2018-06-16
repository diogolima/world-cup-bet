Rails.application.routes.draw do
  root 'tournaments#index'
  get 'games/per_tournament' => 'games#per_tournament'
  get 'bets/missing_bets' => 'bets#missing_bets'
  post 'bets/create_bets' => 'bets#create_bets'
  get 'rank' => 'rank#index'
  get 'scored_bets' => 'rank#scored_bets'
  get 'send_pdf' => 'rank#send_pdf'
  resources :users_admin
  resources :tournaments
  resources :teams
  get 'games/round' => 'games#round'
  resources :games
  resources :bets
  get 'contact', to: 'messages#new', as: 'new_message'
  post 'contact', to: 'messages#create', as: 'create_message'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth' }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
