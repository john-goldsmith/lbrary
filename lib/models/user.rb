module Lbrary

  module Models

    class User < ActiveRecord::Base

      has_many :libraries

    end

  end

end