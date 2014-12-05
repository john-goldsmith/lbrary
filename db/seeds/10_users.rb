users = [
  {
    name: "John"
  }
]

users.each do |user|
  User.where(
    name: user[:name],
  ).first_or_create
end