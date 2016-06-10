module UsersHelper

  def show_avatar(user)
    if current_user.profile_picture?
      image_tag current_user.profile_picture, class: "avatar dropdown-toggle", id: "navbar-wagon-menu", "data-toggle" => "dropdown"
    else
      cl_image_tag("avatar.png", class: "avatar dropdown-toggle", id: "navbar-wagon-menu", "data-toggle" => "dropdown")
    end
  end

  def show_card_avatar(user)
    if current_user.profile_picture?
      image_tag current_user.profile_picture, class:"card-user avatar avatar-large"
    else
      cl_image_tag("avatar.png", class:"card-user avatar avatar-large")
    end
  end

end
