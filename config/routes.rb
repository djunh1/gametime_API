Rails.application.routes.draw do
  # new 5
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      get '/logout' => 'users#logout'
      post '/facebook' => 'users#facebook'
      post '/payments' => 'users#add_card'
      get "/listings" => 'games#your_listings'

      resources :games do
        #new 13
        member do
          get '/reservations' => 'reservations#reservations_by_game'
        end
      end
      resources :reservations
    end
  end
end
