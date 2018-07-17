Rails.application.routes.draw do

  
	root "pages#welcome"
  get 'sales/filter/:scope', to: "sales#index", as: :filtered_sales
  get 'bids/filter/:scope', to: "bids#index", as: :filtered_bids
  get "welcome", to: "pages#welcome", as: 'welcome'
  get "about", to: "pages#about", as: 'about'
  get 'report_viewer', to: "reports#viewer"
  get "reports", to: "reports#index"
  get "buyers/bidding/:id/:sale", to:"buyers#bidding", as: :buyer_bidding

  resources :bids
  resources :buyers
  
  resources :sales do
    member do
      post :deactivate
      post :activate
    end
  end

  resources :lots
  resources :houses
  resources :sellers
  resources :categories
  resources :reports
  resources :auctioneers
end
