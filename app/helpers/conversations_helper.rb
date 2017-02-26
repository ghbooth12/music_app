module ConversationsHelper
  def check_profile(user)
    if profile = user.profiles.first
      html = <<-HTML
        #{link_to user.username, user_profile_path(user, profile)}
      HTML
    else
      html = <<-HTML
        <span>#{user.username}</span>
      HTML
    end
    html.html_safe
  end
end
