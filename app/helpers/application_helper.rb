module ApplicationHelper
  def user_profile
    current_user.profiles.first
  end
end
