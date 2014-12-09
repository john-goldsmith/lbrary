module Lbrary

  module Models

    class Album < ActiveRecord::Base

      belongs_to :artist
      has_many :tracks

    end

  end

end