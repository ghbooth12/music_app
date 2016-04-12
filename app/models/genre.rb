class Genre < ActiveRecord::Base
  has_many :profiles
  has_many :concerts

  before_save { self.name = name.capitalize }

  validates :name, length: { in: 2..30 }, presence: true
end
