Rails.application.routes.draw do
  root "pages#home"
  get 'pages/home', to: 'pages#home'
  
  resources :receipts
  
  get '/signup', to: 'chefs#new'
  resources :chefs, except: [:new]
end
