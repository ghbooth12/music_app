class Concert < ActiveRecord::Base
  belongs_to :genre
  belongs_to :user
  has_many :taggings, as: :taggable
  has_many :tags, through: :taggings
  has_many :bookmarks, dependent: :destroy

  before_save { self.city = city.capitalize }

  geocoded_by :full_address
  after_validation :geocode, if: :full_address_changed?

  validates :title, presence: true, length: { in: 3..30 }
  validates :show_date, presence: true
  validates :show_time, presence: true
  validates :location_name, presence: true, length: { in: 3..30 }
  validates :address_1, presence: true
  validates :city, presence: true, length: { in: 3..30 }
  validates :state, presence: true

  validates :zipcode, length: { in: 5..10 }, allow_blank: true
  validates_format_of :zipcode, :with => /\d{5}(-\d{4})?/ix, :message => "Should be in the form 12345 or 12345-1234", allow_blank: true

  validates :phone_number, length: { is: 10 }, allow_blank: true
  validates_format_of :phone_number, :with => /\d{10}/ix, message: "Should be only numbers. A space and - and () are not allowed.", allow_blank: true
  # validates_format_of :location_url, :with => /((http|https):\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?/ix, allow_blank: true
  validates :genre_id, presence: true

  def full_address
    "#{address_1}, #{city}, #{state}"
  end

  def full_address_changed?
    attrs = %w(address_1 city state)
    attrs.any? {|a| send "#{a}_changed?"}
  end
end
