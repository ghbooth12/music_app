## Music App

**For listeners,**

* Discover new favorite songs/musicians
* Search and enjoy the local concerts in your neighborhood

**For musicians,**

* Post your songs to public
* Invite new people to your concerts in bars or restaurants


### Profile
Every user has one profile.
```html
<!-- Go to Musician's profile -->
<%= link_to "musician's profile", user_profile_path(@john, @john.profiles.first) %>

<!-- Go to concert's detail page -->
<%= link_to "concerts", user_concert_path(@john, @john.concerts.first) %>
```

### concerts
```ruby
user.concerts # => user's own concerts
concerts = user.bookmarks.map {|b| Concert.find_by(id: b.concert_id) } # => user's liked concerts
```