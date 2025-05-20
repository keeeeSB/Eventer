Rails.application.routes.draw do
  root "static_pages#home"
  devise_for :users
  resources :users, only: [ :show ] do
    resources :events, only: [ :new, :create, :show, :edit, :update, :destroy ]
  end
  resources :events, only: [ :index ]
end
