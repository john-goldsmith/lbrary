artists = [
  {
    name: "U2"
  }
]

artists.each do |artist|
  Artist.where(
    name: artist[:name],
    slug: artist[:name].parameterize,
  ).first_or_create
end