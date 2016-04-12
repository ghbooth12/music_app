module TagsHelper
  def visibile_tags
    Tag.select {|t| t.profiles.any? || t.concerts.any?}
  end
end
