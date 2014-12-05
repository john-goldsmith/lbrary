library_contents = [
  {
    library_id: Library.first.id,
    artist_id: Artist.first.id
  }
]

library_contents.each do |library_content|
  LibraryContent.where(
    library_id: library_content[:library_id],
    artist_id: library_content[:artist_id]
  ).first_or_create
end