require './boot'

# run Rack::URLMap.new({
#   "/api/v1/users"       => Backlogg::Api::V1::UsersController
# })

run Sinatra::Application