class LibraryContent < ActiveRecord::Base

  belongs_to :library
  belongs_to :artist

end