Rails.application.routes.draw do

  mount Attachinary::Engine => "/attachinary"
  devise_for :users, controllers: { registrations: 'registrations' }

  # Different root for authenticated users
  authenticated do
    root 'cookoons#index'
  end
  root 'pages#home'

  resource :users, only: [:edit, :update]
  resources :user_searches, only: :create
  resources :stripe_accounts, only: [:new, :create]

  resources :cookoons do
    resources :reservations, only: [:create]
  end

  resources :reservations, only: [:index, :show] do
    resources :paiements, only: [:new, :create]
  end

  # -------- HOST NAMESPACE ---------
  namespace :host do
    resources :reservations, only: [:index, :edit, :update] do
      resources :inventories, only: [:new, :create]
    end
    resources :inventories, only: [:edit, :update]
  end

  # -------- CUSTOM ROUTES ---------
  get 'setcookies', to: 'pages#setcookies'
end
