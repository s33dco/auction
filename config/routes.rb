Rails.application.routes.draw do

  
	root "pages#welcome"
  get "welcome" => "pages#welcome", as: 'welcome'
  get "about" => "pages#about", as: 'about'

  resources :bids
  resources :buyers

  resources :sales do
    member do
      post :deactivate
      post :activate
    end
      resources :lots
  end


  resources :houses
  resources :sellers
  resources :categories

  resources :reports

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
