module BookmarksHelper
  def bookmarks_count(user)
    sum = 0
    user.concerts.each {|c| sum += Bookmark.where(concert_id: c.id).count}
    return sum
  end
end
