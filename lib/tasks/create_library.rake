desc "Given a directory, creates a JSON representation of any files and sub-directories"
task :create_library do

  input_dir = ENV["dir"]
  raise "Please specify a directory. For example, rake create_library dir=path/to/library" unless input_file

end