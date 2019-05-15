Rails.application.routes.draw do
  mount RailsAdmin::Engine => "/admin", as: "rails_admin"
  root "homes#index"
  devise_for :users, controllers: {omniauth_callbacks: "users/omniauth_callbacks"}
  resources :users, only: %i(show) do
    resources :parkings, except: %i(index)
  end
  concern :paginatable do
    get "(page/:page)", action: :index, on: :collection, as: ""
  end
  resources :parkings, only: %i(index), concerns: :paginatable
  get "search(/:search)", to: "searches#index", as: :search
  resources :places
end
