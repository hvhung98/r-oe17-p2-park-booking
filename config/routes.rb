Rails.application.routes.draw do
  root "homes#index"
  devise_for :users, controllers: {omniauth_callbacks: "users/omniauth_callbacks"}
  resources :users, only: %i(show)
  resources :users do
    resources :parkings
  end
end
