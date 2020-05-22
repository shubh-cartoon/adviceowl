Rails.application.routes.draw do
  root :to => 'home#index'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/create_table/' => 'home#create_table_for_user'
  post '/add_product' => 'home#create'
end
