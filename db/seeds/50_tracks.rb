tracks = [
  {
    name: "Cedarwood Roid",
    album_id: Album.first.id
  }
]

tracks.each do |track|
  Track.where(
    name: track[:name],
    slug: track[:name].parameterize,
    album_id: track[:album_id]
  ).first_or_create
end