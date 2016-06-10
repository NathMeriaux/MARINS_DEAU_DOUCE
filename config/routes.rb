Rails.application.routes.draw do

  get 'reviews/new'

  get 'reviews/create'

  get 'reviews/show'

  get 'reviews/index'

  root to: 'pages#home'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :users, only: [:show, :edit, :update]


  resources :boats do
    collection do
      get 'index_all'
    end
    resources :availabilities
    resources :bookings
    resources :reviews, only: [:new, :create, :show, :index]
  end

  get '/bookings/', to: 'bookings#bookings_user'

end
