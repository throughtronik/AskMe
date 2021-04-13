module ApplicationHelper
  def user_avatar(user)
    user.avatar_url.presence || asset_pack_path('media/images/user_avatar.jpg')
  end

  def incline
    
  end
end
