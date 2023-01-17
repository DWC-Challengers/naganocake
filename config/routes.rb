Rails.application.routes.draw do
  devise_for :customers
  devise_for :admins

  #会員用ルーティング設定
  namespace :public do
  root to: 'homes#top'
  get "/about" => "homes#about"
  resources :items, only: [:index, :show]
  resources :customers, only: [:show, :edit, :update]
  resources :orders, only: [:new, :index, :show, :create]
  resources :customers, only: [:index, :show, :edit, :update]
  resources :shipping_addresses, only: [:index, :edit, :create, :update, :destroy]
  resources :cart_items, only: [:index, :create, :update, :destroy,]

  end

  #管理者用ルーティング設定
  namespace :admin do
  root to: 'homes#top'
  resources :customers, only: [:index, :show, :edit, :update]
  resources :genres, only: [:index, :create, :edit, :update]
  resources :items, only: [:index, :new, :create, :show, :edit, :update]
  resources :orders, only: [:show, :update]
  resources :order_details, only: [:update]

  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
