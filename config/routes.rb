Rails.application.routes.draw do
  root "homes#index"
  get "search(/:search)", to: "searches#index", as: :search
  devise_for :users, controllers: {omniauth_callbacks: "users/omniauth_callbacks"}
  resources :users, only: %i(show)
  resources :users do
    resources :parkings, excepts: %i(index)
  end
    resources :parkings, only: %i(index)
end
