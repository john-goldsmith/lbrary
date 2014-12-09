require './boot'

run Rack::URLMap.new({
  "/" => Lbrary::Controllers::ApplicationController,
  "/sidekiq" => Sidekiq::Web
})