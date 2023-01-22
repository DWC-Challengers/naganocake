Rails.application.routes.draw do
devise_for :admins, controllers: {
  sessions:      'admins/sessions',
  passwords:     'admins/passwords',
  registrations: 'admins/registrations'
}
devise_for :customers, controllers: {
  sessions:      'customers/sessions',
  passwords:     'customers/passwords',
  registrations: 'customers/registrations'
}

  #会員用ルーティング設定
  scope module: :public do
  root to: 'homes#top'
  get "/about" => "homes#about"
  resources :items, only: [:index, :show]
  get 'customers/information/edit' => 'customers#edit'
 
 resources :customers,only: [:show,:edit] do
     collection do
       get 'quit'
       patch 'out'
     end
   end
  patch 'customers/:id' => 'customers#update'
  resources :orders, only: [:new, :index, :show, :create ,:thanx]
  resources :shipping_addresses, only: [:index, :edit, :create, :update, :destroy]
  resources :cart_items, only: [:index, :create, :update, :destroy]

  end

  #管理者用ルーティング設定
  namespace :admin do
  root to: 'homes#top'
  resources :customers, only: [:index, :show, :edit, :update] do
    resources :orders, only: [:index]
  end
  resources :genres, only: [:index, :create, :edit, :update]
  resources :items, only: [:index, :new, :create, :show, :edit, :update]
  resources :orders, only: [:show, :update]
  resources :order_details, only: [:update]

  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
