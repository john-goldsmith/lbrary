module Lbrary

  module Workers

    class EchoNestArtistWorker < ApplicationWorker

      def perform(artist_attrs)
        artist = Artist.find_by(id: artist_attrs["id"])
        # TODO: What happens when more than 1 result is returned?
        response = Echowrap.artist_search(name: artist.name, bucket: "id:rdio-US", limit: true, results: 1)[0]
        artist.echonest_id = response.id
        # TODO: What happens when more than 1 foreign_id is returned?
        artist.rdio_id = response.foreign_ids[0].foreign_id
        artist.save
      end

    end

  end

end