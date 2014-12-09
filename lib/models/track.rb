module Lbrary

  module Models

    class Track < ActiveRecord::Base

      belongs_to :album
      has_one :artist, through: :album

    end

  end

end