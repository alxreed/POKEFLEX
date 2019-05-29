Rails.application.routes.draw do
  devise_for :users
  root to: 'pokemons#index'
  resources :users
  resources :rentals, except: [:new, :create, :destroy]
  resources :pokemons do
    resources :reviews
    resources :rentals, only: [:new, :create]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end