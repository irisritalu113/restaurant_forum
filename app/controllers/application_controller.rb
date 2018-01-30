class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # 客製化 Devise 的註冊程序
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  private
  def authenticate_admin
    unless current_user.admin? 
      flash[:alert] = "Not allow!"
      redirect_to root_path
    end
  end

  protected
  # Devise 客製化屬性的使用說明：  https://github.com/plataformatec/devise#strong-parameters
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

end
