class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_tournaments


  private
  def set_tournaments
    @tournaments = Tournament.all
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  def check_admin(redirect_path)
    (current_user && current_user.admin)?
      true : respond_to do |format| format.html { redirect_to redirect_path, alert: 'This action is only allowed for the admin.' }
    end
  end
end
