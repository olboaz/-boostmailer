Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :customers do
    collection { post :import }
  end

  # Csv
  #get '/customer_import_csv' => 'customers#import'

  # For emails
  get "/send_mail" => 'customers#send_mail'
  get '/destroyAll', to: 'customers#destroyAll'
end
