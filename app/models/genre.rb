class Genre < ActiveRecord::Base
  has_many :profiles, dependent: :destroy

  validates :name, length: { in: 2..30 }, presence: true
end
