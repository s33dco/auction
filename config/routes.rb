Rails.application.routes.draw do

	root "pages#welcome"

  resources :bids
  resources :buyers
  resources :sales
  resources :houses
  resources :sellers
  resources :categories
  resources :products
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
