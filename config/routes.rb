Rails.application.routes.draw do
  root 'tournaments#index'
  get 'games/per_tournament' => 'games#per_tournament'
  get 'bets/missing_bets' => 'bets#missing_bets'
  post 'bets/create_bets' => 'bets#create_bets'
  devise_for :users
  resources :tournaments
  resources :teams
  resources :games
  resources :bets
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
