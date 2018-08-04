Rails.application.routes.draw do

  
  devise_for :sellers, path: 'sellers', controllers: { sessions: "sellers/sessions", confirmations: "sellers/confirmations", passwords: "sellers/passwords", unlocks: "sellers/unlocks"}
  devise_for :buyers, path: 'buyers', controllers: { sessions: "buyers/sessions", confirmations: "buyers/confirmations", passwords: "buyers/passwords", unlocks: "buyers/unlocks"}
  devise_for :auctioneers, path: 'auctioneers', controllers: { sessions: "auctioneers/sessions", confirmations: "auctioneers/confirmations", passwords: "auctioneers/passwords", unlocks: "auctioneers/unlocks"}
	
  root "pages#welcome"
  get 'sales/filter/:scope', to: "sales#index", as: :filtered_sales
  get 'bids/filter/:scope', to: "bids#index", as: :filtered_bids
  get "welcome", to: "pages#welcome", as: 'welcome'
  get "about", to: "pages#about", as: 'about'
  get "buyers/bidding/:id/:sale", to: "buyers#bidding", as: :buyer_bidding

  resources :bids
  resources :buyers
  resources :houses
  resources :sellers
  resources :categories
  resources :auctioneers
  
  resources :sales do
    member do
      post :deactivate
      post :activate
    end
  end

  resources :lots do
    member do
      delete :delete_pictures
      delete :delete_image
      delete :delete_main_image
      post :reset_bids_and_fees
    end
  end

  delete 'lots/:id/:image_id', to: 'lots#delete_one_attached_picture', as: :delete_one_attached_picture
  get 'lots/:id/:image_id', to: 'lots#edit'
end
