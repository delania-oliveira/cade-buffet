class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :individual_registration, :role])
  end

  def after_sign_up_path_for(resources)
    if current_user.buffet_owner?
      new_buffet_path
    else
      super
    end
  end

  def after_sign_in_path_for(resources)
    if current_user.buffet_owner? && !current_user.buffet
      new_buffet_path
    elsif current_user.buffet
      buffet_path(current_user.buffet)
    else
      root_path
    end
  end

end
