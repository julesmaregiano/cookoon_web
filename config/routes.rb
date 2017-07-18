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
    resources :reservations, only: [:new, :create]
  end
  resources :user_searches, only: :create
end
