Rails.application.routes.draw do
  mount Attachinary::Engine => "/attachinary"

  devise_for :users, controllers: { registrations: 'registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Different root for authenticated users
  authenticated do
    root 'cookoons#index'
  end
  root 'pages#home'

  resources :cookoons do
    resources :reservations, only: [:create]
  end
  resources :reservations, only: [:index, :show]
  resources :user_searches, only: :create

  namespace :host do
    resources :reservations, only: [:index, :edit, :update] do
      resources :inventories, :only: [:new, :create, :edit, :update]
    end
  end
end
