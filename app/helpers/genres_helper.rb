module GenresHelper
  def genre_list
    list = Genre.all.map {|genre| [genre.name, genre.id] }

    [['Select Genre', '']].concat(list)
  end
end
