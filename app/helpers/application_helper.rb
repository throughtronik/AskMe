module ApplicationHelper
  def user_avatar(user)
    user.avatar_url.presence || asset_pack_path('media/images/user_avatar.jpg')
  end

  def incline(num, single, few, a_lot_of)
    case num % 100
    when 11..14 then a_lot_of
    end

    case num % 10
    when 0, *(5..9) then a_lot_of
    when 2..4 then few
    else single
    end
  end

  def fa_icon(icon_class)
    content_tag 'span', '', class: "fa fa-#{icon_class}"
  end
end
