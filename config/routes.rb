Rails.application.routes.draw do

  root to: 'pages#home'

  resources :users, only: [:show, :edit, :update, :destroy]

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :boats do
    collection do
      get 'index_all'
    end
    resources :availabilities
    resources :bookings
  end

  get '/bookings/', to: 'bookings#bookings_user'
  get '/booking/:id', to: 'bookings#show'

end
