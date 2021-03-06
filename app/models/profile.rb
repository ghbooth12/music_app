class Profile < ActiveRecord::Base
  belongs_to :genre
  belongs_to :user
  has_many :taggings, as: :taggable
  has_many :tags, through: :taggings
  has_many :favorites, dependent: :destroy

  mount_uploader :avatar, AvatarUploader

  validates_format_of :facebook_url, :with => /((http|https):\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?/ix, allow_blank: true
  validates_format_of :twitter_url, :with => /((http|https):\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?/ix, allow_blank: true
  validates_format_of :youtube_url, :with => /((http|https):\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?/ix, allow_blank: true
  validates_format_of :soundcloud_url, :with => /((http|https):\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?/ix, allow_blank: true

  validates :genre_id, presence: true

  scope :by_favorites, -> { order('favorites_count DESC') }
end
