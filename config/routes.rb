Rails.application.routes.draw do

  devise_for :users

  resources :live_streams, only: [:new, :create, :show, :index]
  root 'live_streams#index'

end
