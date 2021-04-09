module ApplicationHelper
  def user_avatar(user)

    if user.avatar_url.present?
      user.avatar_url
    else
      asset_path 'user_avatar.jpg'
    end
  end
end
