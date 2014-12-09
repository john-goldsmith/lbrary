require 'rake'
require './boot'
require 'sinatra/activerecord/rake'

include Lbrary::Models
include Lbrary::Workers

Dir["./lib/tasks/**/*.rake"].sort.each { |task| load task }

task default: [:console]