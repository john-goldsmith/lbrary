require 'rake'
require './boot'
require 'sinatra/activerecord/rake'
Dir["./lib/tasks/**/*.rake"].sort.each { |task| load task }

task default: [:console]