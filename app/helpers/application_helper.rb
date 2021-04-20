module ApplicationHelper
  def user_avatar(user)
    user.avatar_url.presence || asset_pack_path('media/images/user_avatar.jpg')
  end

  def incline(num, single, few, a_lot_of)
      if (11..14).include?(num % 100)
        return a_lot_of
      elsif (2..4).include?(num % 10)
        return few
      elsif (5..9).include?(num % 10) || num % 10 == 0
        return a_lot_of
      else
        return single
      end
  end

  def fa_icon(icon_class)
    content_tag 'span', '', class: "fa fa-#{icon_class}"
  end
end
