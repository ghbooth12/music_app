# Create User
users = (1..5).to_a.map do |n|
  User.new(
    username: Faker::Name.name + "#{n}",
    email:    "test#{n}@example.com",
    password: "testtest"
  )
end

users.map do |user|
  user.skip_confirmation!
  user.save
end

# Create Genre
genre_array = ['Pop', 'Jazz', 'Classical', 'R&B/Blues', 'Hip-Hop/Rap', 'Country', 'Alternative', 'More'].sort
genres = genre_array.map do |str|
  Genre.create!(
    name: str
  )
end

# Create Profile
social_array = %w(facebook_url twitter_url youtube_url soundcloud_url)

users.each do |user|
  user.profiles.create!(
    social_array.sample.to_sym => "http://www.google.com",
    :body => Faker::Lorem.paragraph,
    :genre => genres.sample
  )
end

# Create Concert
address_array = {
  "Starbucks I" => '180 W Broadway',
  "Starbucks II" => '2140 Broadway',
  "Starbucks III" => '2252 Broadway',
  "Starbucks IV" => '540 Columbus Ave',
  "Starbucks V" => '805 Columbus Ave',
  "Starbucks VI" => '200 Liberty St',
  "Starbucks VII" => '111 Town Square Pl',
  "Starbucks VIII" => '51 Newark St',
  "Starbucks IX" => '130 Fulton St,',
  "Starbucks X" => '229 7th Ave,'
}

address_array.each do |name, address|
  Concert.create!(
    title: name,
    show_date:     Faker::Date.forward(30),
    show_time:     Time.now,
    address_1:     address,
    city:          "New York",
    state:         "NY",
    location_name: name,
    phone_number:  '1230001234',
    location_url:  "http://www.google.com",
    body:          Faker::Lorem.paragraph,
    user:          users.sample,
    genre:         genres.sample
  )
end

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Genre.count} genres created"
puts "#{Profile.count} profiles created"
puts "#{Concert.count} concerts created"
