Rails.application.routes.draw do

  devise_for :users

  root 'live_streams#index'

  resources :live_streams, only: [:new, :create, :show, :index]
  resources :reports, only: [:show, :index]

  post "create_report/:live_stream_id", to: "reports#create", as: :create_report
  post "add_chat_message/:live_stream_id", to: "live_streams#add_chat_message", as: :add_chat_message

  mount ActionCable.server => '/cable'

end
