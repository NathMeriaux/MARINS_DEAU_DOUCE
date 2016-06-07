Rails.application.routes.draw do
  root to: 'pages#home'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :boats do
    collection do
      get 'index_all'
    end
    resources :availabilities
    resources :bookings
  end

end
