module UsersHelper
  def user_avatar(user, size)
    if user.avatar.attached?
      user.avatar.variant(resize_to_limit: [size,size])
    else
      user.gravatar_url(size: size)
    end
  end

  def formatted_birthday(user)
    user.birthday.strftime('%m/%d')
  end
end
