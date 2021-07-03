class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:top, :about]
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_up_path_for(resource)
    if current_user
      flash[:notice] = "Welcome! You have signed up successfully."
      user_path(current_user.id)
    else
      new_user_registration_path
    end
  end

  def after_sign_in_path_for(resource)
    if current_user
      flash[:notice] = "Signed in successfully."
      user_path(current_user.id)
    else
      new_user_session_path
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name,:email])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name,])
  end
end
