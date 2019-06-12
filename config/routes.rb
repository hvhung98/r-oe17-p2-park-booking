Rails.application.routes.draw do
  mount RailsAdmin::Engine => "/admin", as: "rails_admin"
  root "homes#index"
  devise_for :users, controllers: {omniauth_callbacks: "users/omniauth_callbacks"}
  resources :users, only: %i(show) do
    resources :orders, only: %i(index)
    resources :parkings, except: %i(index)
  end
  concern :paginatable do
    get "(page/:page)", action: :index, on: :collection, as: ""
  end
  resources :parkings, only: %i(index), concerns: :paginatable
  get "search(/:search)", to: "searches#index", as: :search
  resources :places
  resources :parkings do
    resources :orders, except: %i(show edit)
    resources :reviews, except: %i(index)
  end
  resources :reviews, only: %i(index)
end
