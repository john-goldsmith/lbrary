Echowrap.configure do |config|
  config.api_key = ENV["ECHO_NEST_API_KEY"]
  config.consumer_key = ENV["ECHO_NEST_CONSUMER_KEY"]
  config.shared_secret = ENV["ECHO_NEST_CONSUMER_SECRET"]
end