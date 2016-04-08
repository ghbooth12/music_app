class Genre < ActiveRecord::Base
  has_many :profiles, dependent: :destroy

  before_save { self.name = name.capitalize }

  validates :name, length: { in: 2..30 }, presence: true
end
