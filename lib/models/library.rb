module Lbrary

  module Models

    class Library < ActiveRecord::Base

      belongs_to :user
      has_many :library_contents
      has_many :artists, through: :library_contents

    end

  end

end