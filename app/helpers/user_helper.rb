module UserHelper

  def user_admin
    !current_user.blank? && current_user.admin
  end
  
end
