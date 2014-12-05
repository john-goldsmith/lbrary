class EchoNestWorker < ApplicationWorker

  def perform(name, count)
    puts 'Doing hard work'
  end

end