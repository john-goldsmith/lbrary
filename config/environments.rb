Sinatra::Base.configure :production, :development do
  db = URI.parse(ENV["DATABASE_URL"] || "postgres://localhost/lbrary")

  ActiveRecord::Base.establish_connection(
    :adapter  => db.scheme == "postgres" ? "postgresql" : db.scheme,
    :host     => db.host,
    :username => db.user,
    :password => db.password,
    :database => db.path[1..-1],
    :encoding => "utf8"
  )
  # ActiveRecord::Base.establish_connection(ENV["DATABASE_URL"] || "postgres://localhost/lbrary")
end