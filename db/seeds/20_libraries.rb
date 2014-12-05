libraries = [
  {
    name: "Demo Library",
    user_id: User.first.id
  }
]

libraries.each do |library|
  Library.where(
    name: library[:name],
    slug: library[:name].parameterize,
    user_id: library[:user_id]
  ).first_or_create
end