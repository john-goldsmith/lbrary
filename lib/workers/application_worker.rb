module Lbrary

  module Workers

    class ApplicationWorker

      include Sidekiq::Worker
      include Lbrary::Models

    end

  end

end