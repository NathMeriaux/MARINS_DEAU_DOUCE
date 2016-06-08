Rails.application.routes.draw do

  root to: 'pages#home'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :users, only: [:show, :edit, :update]


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
