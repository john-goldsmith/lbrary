require './boot'

run Rack::URLMap.new({
  # "/api/v1/users"       => Lbrary::Api::V1::UsersController
  "/" => Sinatra::Application,
  "/sidekiq" => Sidekiq::Web
})