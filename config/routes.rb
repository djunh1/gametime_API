Rails.application.routes.draw do
  # new 5
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      get '/logout' => 'users#logout'
      post '/facebook' => 'users#facebook'

      resources :games
    end
  end
end
