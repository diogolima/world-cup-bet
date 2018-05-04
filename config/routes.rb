Rails.application.routes.draw do
  root 'tournaments#index'
  devise_for :users
  resources :tournaments
  resources :teams
  resources :games
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
