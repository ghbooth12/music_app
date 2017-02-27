# Create User
users = (1..5).to_a.map do |n|
  User.new(
    username: Faker::Name.name,
    email:    "test#{n}@example.com",
    password: "testtest"
  )
end

# Test User is for a sample account for first time user.
users.push(User.new(username: "Test User", email: "test@test.io", password: "testtest"))

# John Doe is a sample musician who has songs and concerts and is linked via buttons from the main page.
users.push(User.new(username: "John Doe", email: "test0@example.com", password: "testtest"))

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

# Create Tag
tags = %w(energetic enthusiastic amazing excellent outstanding peaceful bouncy fun bubbly calm relaxed cheerful  happy	hopeful	inspirational delightful joyful uplifting dynamic lively wonderful lovely)
tags.each do |tag|
  Tag.create!(name: tag)
end

t_ids = Tag.all.map(&:id)


# Create Profile
social_array = %w(facebook_url twitter_url youtube_url soundcloud_url)

users.each do |user|
  user.profiles.create!(
    social_array.sample.to_sym => "http://www.google.com",
    :body  => Faker::Lorem.paragraph,
    :genre => genres.sample,
    :tags  => Tag.where(id: t_ids.sample(3))
  )
end


# Special users
tester = User.find_by(username: "Test User")
john = User.find_by(username: "John Doe")

tester.premium!
john.premium!


# Add songs to special users
tester_sound_url = "https://soundcloud.com/243874338-68724361"
tester_songs = ["https://soundcloud.com/243874338-68724361/rooibos", "https://soundcloud.com/243874338-68724361/friday-night"]

tester.profiles.first.update_attribute(:soundcloud_url, tester_sound_url)
tester_songs.each do |song|
  tester.songs.create!(song_url: song)
end


john_sound_url = "https://soundcloud.com/481217332-1592122"
john_songs = ["https://soundcloud.com/481217332-1592122/evergreen-light", "https://soundcloud.com/481217332-1592122/piano-road"]

john.profiles.first.update_attribute(:soundcloud_url, john_sound_url)
john_songs.each do |song|
  john.songs.create!(song_url: song)
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
    title:         Faker::Space.moon + " Concert",
    show_date:     Faker::Date.between(1.year.from_now, 2.year.from_now),
    show_time:     Time.now,
    address_1:     address,
    city:          "San Francisco",
    state:         "CA",
    location_name: Faker::Space.planet + " Hall",
    phone_number:  '1230001234',
    location_url:  "http://www.google.com",
    body:          Faker::Lorem.paragraph(3),
    user:          users.sample,
    genre:         genres.sample,
    tags:          Tag.where(id: t_ids.sample(7))
  )
end

# Special user(John Doe) must have concerts for demonstration.
addresses = {
  "Palace of Fine Arts Theatre" => '3301 Lyon St',
  "San Francisco's Chinatown" => '359 Grant Ave',
  "Alamo Square" => 'Steiner St & Hayes Street',
  "Transamerica Pyramid" => '600 Montgomery St',
}

addresses.each do |name, address|
  Concert.create!(
    title:         Faker::Space.constellation + " Concert",
    show_date:     Faker::Date.between(1.year.from_now, 2.year.from_now),
    show_time:     Time.now,
    address_1:     address,
    city:          "San Francisco",
    state:         "CA",
    location_name: Faker::Space.planet + " Hall",
    phone_number:  '1230001234',
    location_url:  "http://www.google.com",
    body:          Faker::Lorem.paragraph,
    user:          john,
    genre:         genres.sample,
    tags:          Tag.where(id: t_ids.sample(7))
  )
end


puts "Seed finished"
puts "#{User.count} users created"
puts "#{Genre.count} genres created"
puts "#{Profile.count} profiles created"
puts "#{Concert.count} concerts created"
puts "#{Tag.count} tags created"
