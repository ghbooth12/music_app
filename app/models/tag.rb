class Tag < ActiveRecord::Base
  has_many :taggings

  has_many :profiles, through: :taggings, source: :taggable, source_type: :Profile
  has_many :concerts, through: :taggings, source: :taggable, source_type: :Concert

  before_save { self.name = name.downcase }

  def self.make_tags(string)
    return Tag.none if string.blank?

    string.split(',').map do |tag|
      Tag.find_or_create_by(name: tag.strip)
    end
  end
end
