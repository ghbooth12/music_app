class Favorite < ActiveRecord::Base
  belongs_to :user
  belongs_to :profile, counter_cache: true
  belongs_to :concert
end
