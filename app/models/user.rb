class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :username, use: :slugged
  
  after_initialize :init
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :profiles, dependent: :destroy
  has_many :concerts, dependent: :destroy
  has_many :songs, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  validates :username, length: { minimum: 3, maximum: 30 }, presence: true

  enum role: [:standard, :premium, :admin]

  acts_as_messageable

  def init
    self.role ||= :standard if self.has_attribute? :role
  end

  def favorite_for(profile)
    self.favorites.find_by(profile_id: profile.id)
  end

  def bookmark_for(concert)
    self.bookmarks.find_by(concert_id: concert.id)
  end

  def mailboxer_name
    self.username
  end

  def mailboxer_email(object)
    self.email
  end
end
