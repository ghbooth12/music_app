class Concert < ActiveRecord::Base
  belongs_to :user

  validates :title, presence: true, length: { in: 3..30 }
  validates :show_date, presence: true
  validates :show_time, presence: true
  validates :location_name, presence: true, length: { in: 3..30 }
  validates :address_1, presence: true
  validates :city, presence: true, length: { in: 3..30 }
  validates :state, presence: true

  validates :zipcode, length: { in: 5..10 }
  validates_format_of :zipcode, :with => /\d{5}(-\d{4})?/ix, :message => "Should be in the form 12345 or 12345-1234"

  validates :phone_number, length: { is: 10 }
  validates_format_of :phone_number, :with => /\d{10}/ix, message: "Should be only numbers. A space and - and () are not allowed.", allow_blank: true
  # validates_format_of :location_url, :with => /((http|https):\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?/ix, allow_blank: true

end
