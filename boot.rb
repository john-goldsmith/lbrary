require "dotenv"
Dotenv.load

require "rack"
require "rack/contrib"
require "rubygems"
require "bundler"
require "json"
require "active_record"
require "active_model_serializers"
require "active_support"
require "protected_attributes"
require "sinatra/base"
require "sinatra/activerecord"
require "sinatra/config_file"
require "sinatra/json"
require "sinatra/respond_with"
require "sinatra-initializers"
require "sidekiq"
require "sidekiq/web"
require "./config/environments"
require "echowrap"
require "./lib/oauth_mini"
require "./lib/rdio"

module Lbrary
  APP_ROOT = File.dirname(__FILE__)
  CONFIG = YAML.load_file(File.join(APP_ROOT, "config", "config.yml"))
end

Dir[Lbrary::APP_ROOT + "/config/initializers/*.rb"].each { |initializer| require initializer }
Dir[Lbrary::APP_ROOT + "/lib/models/*.rb"].each { |model| require model }
Dir[Lbrary::APP_ROOT + "/lib/controllers/*_controller.rb"].each { |controller| require controller }
Dir[Lbrary::APP_ROOT + "/lib/workers/*_worker.rb"].each { |worker| require worker }