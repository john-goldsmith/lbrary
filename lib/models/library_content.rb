module Lbrary

  module Models

    class LibraryContent < ActiveRecord::Base

      belongs_to :library
      belongs_to :artist

    end

  end

end