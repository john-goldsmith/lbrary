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

  ActiveRecord::Base.transaction do
    begin
      entries.each do |entry|
        artist = Artist.create! name: entry["artist"], slug: entry["artist"].parameterize
        LibraryContent.create! library: target_library, artist: artist

        entry["albums"].each do |album|
          inserted_album = Album.create! artist: artist, name: album["name"], slug: album["name"].parameterize

          album["tracks"].each do |track|
            Track.create! album: inserted_album, name: track, slug: track.parameterize
          end

        end

      end
    rescue => e
      puts "Failed to import library."
      puts e
    end

  end

end