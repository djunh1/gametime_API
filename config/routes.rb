Rails.application.routes.draw do
  # new 5
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      get '/logout' => 'users#logout'
      post '/facebook' => 'users#facebook'
      post '/payments' => 'users#add_card'

      resources :games
      resources :reservations
    end
  end
end
