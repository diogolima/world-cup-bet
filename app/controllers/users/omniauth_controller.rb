class Users::OmniauthController < ApplicationController

  # facebook callback
  def facebook
    omniauth_register("Facebook")
  end

  # linkedin callback
  def linkedin
    omniauth_register("Linkedin")
  end

  def twitter
    omniauth_register("Twitter")
  end

  def failure
    flash[:error] = 'There was a problem signing you in. Please register or try signing in later.'
    redirect_to new_user_registration_url
  end

  private
  def omniauth_register(social)
    @user = User.create_from_provider_data(request.env['omniauth.auth'])
    if @user.persisted?
      sign_in_and_redirect @user
      flash[:notice] = "Successfully signing you in through #{social}"
    else
      flash[:error] = "There was a problem signing you in through #{social}. Please register or try signing in later."
      redirect_to new_user_registration_url
    end
  end

end
