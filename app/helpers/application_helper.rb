module ApplicationHelper
  def user_profile
    current_user.profiles.first
  end

  def user_is_admin?
    current_user && current_user.admin?
  end

  def user_is_authorized?(instance)
    current_user && (current_user == instance.user || current_user.admin?)
  end
end
