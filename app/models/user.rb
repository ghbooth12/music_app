class User < ActiveRecord::Base
  after_initialize :init
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :profiles, dependent: :destroy

  validates :username, length: { minimum: 3, maximum: 30 }, presence: true

  enum role: [:standard, :premium, :admin]

  def init
    self.role ||= :standard if self.has_attribute? :role
  end
end
