albums = [
  {
    artist_id: Artist.first.id,
    name: "Songs of Innocence"
  }
]

albums.each do |album|
  Album.where(
    name: album[:name],
    slug: album[:name].parameterize,
    artist_id: album[:artist_id]
  ).first_or_create
end