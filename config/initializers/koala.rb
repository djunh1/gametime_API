Koala.configure do |config|
  #config.access_token = MY_TOKEN
  #config.app_access_token = MY_APP_ACCESS_TOKEN
  config.app_id = ENV["FB_API_KEY"]
  config.app_secret = ENV["FB_API_SECRET"]

end
