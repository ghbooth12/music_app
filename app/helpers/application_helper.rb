module ApplicationHelper
  def flash_class(level)
    case level.to_sym
      when :notice then "alert-success"
      when :info then "alert-info"
      when :alert then "alert-danger"
      when :warning then "alert-warning"
    end
  end

  def user_profile
    current_user.profiles.first
  end

  def user_is_admin?
    current_user && current_user.admin?
  end

  def user_is_authorized?(instance)
    current_user && (current_user == instance.user || current_user.admin?)
  end

  def premium_or_admin?(user)
    (current_user == user && current_user.premium?) || (current_user && current_user.admin?)
  end

  def active_page(active_page)
    @active == active_page ? "active" : ""
  end
end
