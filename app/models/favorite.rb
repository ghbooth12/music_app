class Favorite < ActiveRecord::Base
  belongs_to :user
  belongs_to :profile
  belongs_to :concert
end
