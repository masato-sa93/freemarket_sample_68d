Rails.application.routes.draw do
  root 'tops#index'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :tops, only: [:new]
  resources :accounts, except: [:show, :index]
  resources :addresses, only: [:edit, :update, :show]
  resources :users, only: [:show, :index] do
    resources :likes, only: [:index]
  end
  resources :categories, only: [:index, :show] 
  resources :cards, except: [:show,:edit,:update] do
    member do
      get 'check'
      get 'buy'
    end
  end
  resources :items do
    resources :likes, only: [:create, :destroy]
    collection do
      get 'category_children', defaults: { format: 'json' }
      get 'category_grandchildren', defaults: { format: 'json' }
      get 'search'
      get 'draft'
      get 'exhibition'
      get 'exhibition_trading'
      get 'exhibition_completed'
      get 'bought'
      get 'bought_completed'
    end
    resources :trading, only: [:show, :update]
  end
  resources :posts do
    resources :comments, only: [:create]
    
  end
  resources :items do
    resources :comments, only: [:create]
    root to: 'items#index'
    resources :items, only: [:index, :new, :create,  :destroy, :edit]
    
  end
end
