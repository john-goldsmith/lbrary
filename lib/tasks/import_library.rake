desc "Given a file and library name, imports an existing JSON library"
task :import_library do

  input_file = ENV["file"]
  raise "Please specify a file to import. For example, rake import_library file=path/to/library.json library='Demo Library'" unless input_file

  target_library_name = ENV["library"]
  raise "Please specify a target library name. For example, rake import_library file=path/to/library.json library='Demo Library'" unless target_library_name

  target_library = Library.find_by name: target_library_name
  raise "Couldn't find a library with name '#{target_library_name}'." unless target_library

  file = File.read(input_file)
  entries = JSON.parse(file)
  album_entries = 0
  track_entries = 0
  imported_artists = 0
  imported_albums = 0
  imported_tracks = 0

  puts "#{entries.size} entries found"
  entries.each do |entry|
    entry["albums"].each do |album|
      album_entries+=1
      album["tracks"].each do |track|
        track_entries+=1
      end
    end
  end
  puts "#{album_entries} albums found"
  puts "#{track_entries} tracks found"
  puts "-"*20

  begin
    entries.each do |entry|
      artist = Artist.where(name: entry["artist"], slug: entry["artist"].parameterize).first_or_create!
      lc = LibraryContent.where(library: target_library, artist: artist).first_or_create!
      EchoNestArtistWorker.perform_in(30.seconds, {id: artist.id})
      puts "Imported #{artist.name} into #{lc.library.name}"
      imported_artists+=1

      entry["albums"].each do |album|
        inserted_album = Album.where(artist: artist, name: album["name"], slug: album["name"].parameterize).first_or_create!
        puts "Imported #{inserted_album.name} by #{artist.name}"
        imported_albums+=1

        album["tracks"].each do |track|
          inserted_track = Track.where(album: inserted_album, name: track, slug: track.parameterize).first_or_create!
          puts "Imported #{inserted_track.name} on album #{inserted_album.name}"
          imported_tracks+=1
        end

      end

    end
  rescue => e
    puts "Failed to import library."
    puts e
  end

  puts "-"*20
  puts "Imported #{imported_artists} of #{entries.size} artists"
  puts "Imported #{imported_albums} of #{album_entries} albums"
  puts "Imported #{imported_tracks} of #{track_entries} tracks"
  puts "Done"

end