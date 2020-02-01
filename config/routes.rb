# Rails.application.routes.draw do
#   # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
# end


# config/routes.rb
Rails.application.routes.draw do
  resources :users, param: :_username
  post '/auth/login', to: 'authentication#login'
  get '/me', to: 'application#authorize_request'
  get '/*a', to: 'application#not_found'
end