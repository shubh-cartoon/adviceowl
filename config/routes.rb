Rails.application.routes.draw do
  root :to => 'home#index'
  devise_for :users
  resource :home
  post 'import' => 'home#import'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/create_table/' => 'home#create_table_for_user'
  post '/add_product' => 'home#create'
  get '/recommend/:api_key/:website_user_id' => 'home#recommended_products'
end
