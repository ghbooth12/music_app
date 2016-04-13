module GenresHelper
  def genre_list
    list = Genre.all.map {|genre| [genre.name, genre.id] }

    [['Select', '']].concat(list)
  end

  def visibile_genres
    Genre.select {|g| g.profiles.any? || g.concerts.any?}
  end
end
