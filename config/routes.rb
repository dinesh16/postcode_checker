Rails.application.routes.draw do
  root to: 'delivery_offices#index'
  get 'delivery_offices/search', to: 'delivery_offices#search', as: :search
  resources :delivery_offices
end
