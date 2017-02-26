# Create User
users = (1..5).to_a.map do |n|
  User.new(
    username: Faker::Name.name,
    email:    "test#{n}@example.com",
    password: "testtest"
  )
end

users.push(User.new(username: "Test User", email: "test@test.io", password: "testtest"))

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
  "Palace of Fine Arts Theatre" => '3301 Lyon St',
  "San Francisco's Chinatown" => '359 Grant Ave',
  "Alamo Square" => 'Steiner St & Hayes Street',
  "Transamerica Pyramid" => '600 Montgomery St',
  "Lombard Street" => 'Lombard St',
  "Golden Gate Park" => '50 Stow Lake Dr E',
  "Cable Cars" => '1201 Mason St',
  "Alcatraz" => 'Alcaltraz Island Ferry Terminal',
  "Fisherman's Wharf" => '250 Jefferson St',
  "Golden Gate Bridge" => 'Golden Gate Bridge'
}

address_array.each do |name, address|
  Concert.create!(
    title: Faker::Space.planet + " Concert",
    show_date:     Faker::Date.between(1.year.from_now, 2.year.from_now),
    show_time:     Time.now,
    address_1:     address,
    city:          "San Francisco",
    state:         "CA",
    location_name: Faker::Space.planet + " Hall",
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
